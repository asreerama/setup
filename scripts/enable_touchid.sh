#!/bin/bash
# Enable Touch ID for sudo on macOS.
#
#   macOS 14+ (Sonoma/Sequoia/Tahoe): write /etc/pam.d/sudo_local, which is
#     included by /etc/pam.d/sudo and SURVIVES macOS updates.
#   Older releases: fall back to editing /etc/pam.d/sudo directly.
#
# NOTE: On macOS 26 "Tahoe" and later, /etc/pam.d is protected by System
# Integrity Protection (SIP) — the write fails with "Operation not permitted"
# even as root. This script detects that and tells you how to proceed.
set -euo pipefail

# Re-run as root if needed.
if [ "$EUID" -ne 0 ]; then
  echo "🔐 Requesting admin rights to enable Touch ID for sudo..."
  exec sudo "$0" "$@"
fi

PAM_LINE='auth       sufficient     pam_tid.so'
MAJOR="$(sw_vers -productVersion | cut -d. -f1)"

if [ "$MAJOR" -ge 14 ]; then
  TARGET=/etc/pam.d/sudo_local
else
  TARGET=/etc/pam.d/sudo
fi

# Already enabled?
if grep -Eqs '^[[:space:]]*auth[[:space:]]+sufficient[[:space:]]+pam_tid\.so' "$TARGET"; then
  echo "✅ Touch ID for sudo is already enabled ($TARGET)."
  exit 0
fi

# Try to enable: uncomment an existing commented line, else append the line.
if { [ -f "$TARGET" ] && grep -Eqs '^[[:space:]]*#.*pam_tid\.so' "$TARGET" \
       && sed -i '' 's/^#\(.*pam_tid\.so.*\)/\1/' "$TARGET"; } \
   || printf '%s\n' "$PAM_LINE" >> "$TARGET" 2>/dev/null; then
  echo "✅ Touch ID for sudo enabled ($TARGET)."
  echo "   Open a NEW terminal and run 'sudo -v' — you should get a Touch ID prompt."
else
  cat <<'EOF'
⚠️  Could not write /etc/pam.d/sudo_local — it is protected by System Integrity
    Protection (the default on macOS 26 "Tahoe" and later).

    To enable Touch ID for sudo you must temporarily disable SIP:
      1. Shut down. On Apple Silicon, hold the power button until you see
         "Loading startup options", then click Options → Continue (Recovery).
      2. Utilities → Terminal, run:   csrutil disable    then restart.
      3. Re-run this script — the write will now succeed.
      4. Recommended: return to Recovery and run:  csrutil enable
         The sudo_local file persists after SIP is re-enabled.
EOF
  exit 1
fi
