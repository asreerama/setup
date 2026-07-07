# Personal Setup

This repository contains my personal setup scripts for new machines.

## Usage

### The "Pro" Way (Recommended)

Run this one-liner on any new machine:

```bash
curl -fsSL setup.asreerama.me | bash
```

> The `-L` is required: `setup.asreerama.me` is served over GitHub Pages, which
> redirects `http` → `https`. Without `-L`, curl pipes the redirect page (not the
> script) into bash. `-fsS` makes curl fail loudly on errors instead of piping an
> error page to your shell.

### The Manual Way

1.  Clone this repository:
    ```bash
    git clone https://github.com/asreerama/setup.git ~/.personal-setup
    ```

2.  Run the install script (it's a bash script despite the `.html` name):
    ```bash
    cd ~/.personal-setup
    bash index.html
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
