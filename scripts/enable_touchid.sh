#!/bin/bash

# Script to enable TouchID for sudo on macOS

# Check if running as root, if not, rerun with sudo
if [ "$EUID" -ne 0 ]; then
  echo "Requesting sudo permissions to modify /etc/pam.d/sudo..."
  sudo "$0" "$@"
  exit
fi

PAM_FILE="/etc/pam.d/sudo"
MODULE="pam_tid.so"

if grep -q "$MODULE" "$PAM_FILE"; then
  echo "TouchID for sudo is already enabled."
else
  # Create a backup
  cp "$PAM_FILE" "${PAM_FILE}.bak"
  
  # Insert the module line at the top (under the first comment usually, or just as the 2nd line)
  # We use sed to insert it at line 2.
  sed -i '' '2i\
auth       sufficient     pam_tid.so
' "$PAM_FILE"
  
  echo "TouchID for sudo has been enabled!"
fi
