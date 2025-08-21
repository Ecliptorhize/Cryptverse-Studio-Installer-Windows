# 🔧 Cryptverse Studio Installer

Scripts for bootstrapping the Cryptverse Studio development environment on Windows and macOS.

## Windows

Run the installer from an elevated PowerShell prompt:

```powershell
iwr -useb https://raw.githubusercontent.com/Ecliptorhize/Cryptverse-Studio-Installer-Windows/refs/heads/main/install-tools.ps1 | iex
```

Non‑interactive usage:

```powershell
./install-tools.ps1 -Yes
```

## macOS

Ensure [Homebrew](https://brew.sh/) is installed, then execute:

```bash
curl -fsSL https://raw.githubusercontent.com/Ecliptorhize/Cryptverse-Studio-Installer-Windows/refs/heads/main/install-tools.sh | bash
```

Or run the script locally:

```bash
chmod +x install-tools.sh
./install-tools.sh --yes
```

## Docker

A basic development image is available:

```bash
docker build -t cryptverse-env .
```

## Development

Recommended editor settings and extensions are provided in the `.vscode` directory. Continuous integration tests run on Windows and macOS via GitHub Actions.
