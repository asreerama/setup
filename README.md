# Personal Setup

This repository contains my personal setup scripts for new machines.

## Usage

### The "Pro" Way (Recommended)

Run this one-liner on any new machine:

```bash
curl setup.asreerama.me | bash
```

### The Manual Way

1.  Clone this repository:
    ```bash
    git clone https://github.com/asreerama/setup.git ~/.personal-setup
    ```

2.  Run the install script:
    ```bash
    cd ~/.personal-setup
    ./index.html
    ```

## Setup Instructions (One-time)

To enable the `setup.asreerama.me` shortcut:

1.  **Push this repo** to GitHub: `https://github.com/asreerama/setup`
2.  **Enable GitHub Pages**:
    *   Go to Repo Settings -> Pages.
    *   Source: `Deploy from a branch`.
    *   Branch: `main` / `root`.
    *   **Custom Domain**: Enter `setup.asreerama.me`.
    *   (GitHub will handle the DNS check and HTTPS certificate automatically).

3.  **DNS**:
    *   Ensure your DNS provider has a CNAME record for `setup` pointing to `asreerama.github.io`.

## Scripts

*   `scripts/enable_touchid.sh`: Enables TouchID for `sudo` commands.
