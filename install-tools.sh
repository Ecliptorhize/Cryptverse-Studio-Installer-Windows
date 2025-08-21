#!/usr/bin/env bash
set -euo pipefail

# Cryptverse Studio Installer (macOS/Linux Version)

printf '\nChecking internet connection...\n'
if ! curl -s --head https://www.google.com >/dev/null; then
  echo "No internet connection. Please connect and try again."
  exit 1
fi
printf 'Internet OK\n'

if [[ "${1:-}" != "--yes" ]]; then
  read -rp "This will install all tools for Argon/Roblox dev. Continue? (y/n) " confirm
  if [[ $confirm != "y" ]]; then
    echo "Cancelled."
    exit 0
  fi
fi

if ! command -v brew >/dev/null; then
  echo "Homebrew is required. Install it from https://brew.sh/ and re-run."
  exit 1
fi

brew install node git wget unzip rust

npm install -g roblox-ts

printf 'Installing Argon CLI...\n'
curl -L https://github.com/argon-rbx/argon/releases/download/2.0.25/argon-2.0.25-macos-x86_64.zip -o argon.zip
unzip -o argon.zip >/dev/null
sudo mv argon /usr/local/bin/argon
rm -f argon.zip

printf 'Installing Wally...\n'
curl -L https://github.com/UpliftGames/wally/releases/download/v0.3.2/wally-v0.3.2-macos.zip -o wally.zip
unzip -o wally.zip >/dev/null
sudo mv wally /usr/local/bin/wally
rm -f wally.zip

npm install -g eslint prettier

echo "All tools installed. You're ready!"
