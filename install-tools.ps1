# Cryptverse Studio Installer (PowerShell Version)
Clear-Host
Write-Host ""
Write-Host "_________                        __                                       _________ __            .___.__        "
Write-Host "\_   ___ \_______ ___.__._______/  |____  __ ___________  ______ ____    /   _____//  |_ __ __  __| _/|__| ____  "
Write-Host "/    \  \/\_  __ <   |  |\____ \   __\  \/ // __ \_  __ \/  ___// __ \   \_____  \\   __\  |  \/ __ | |  |/  _ \ "
Write-Host "\     \____|  | \/\___  ||  |_> >  |  \   /\  ___/|  | \/\___ \\  ___/   /        \|  | |  |  / /_/ | |  (  <_> )"
Write-Host " \______  /|__|   / ____||   __/|__|   \_/  \___  >__|  /____  >\___  > /_______  /|__| |____/\____ | |__|\____/ "
Write-Host "        \/        \/     |__|                   \/           \/     \/          \/                 \/            "
Write-Host ""
Write-Host "                  Cryptverse Studio Environment Installer"
Write-Host "──────────────────────────────────────────────────────────────"
Write-Host ""

# ┌───────────────┐
# │ Internet Check│
# └───────────────┘
Write-Host "Checking internet connection..."
try {
    $null = Invoke-WebRequest -Uri "https://www.google.com" -UseBasicParsing -TimeoutSec 5
    Write-Host "Internet OK"
} catch {
    Write-Host "No internet connection. Please connect and try again."
    exit
}

# ┌──────────────┐
# │ Confirmation │
# └──────────────┘
$confirm = Read-Host "This will install all tools for Argon/Roblox dev. Continue? (y/n)"
if ($confirm -ne "y") {
    Write-Host "Cancelled."
    exit
}

# ┌─────────────────────┐
# │ Install Chocolatey  │
# └─────────────────────┘
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
} else {
    Write-Host "Chocolatey already installed."
}

# ┌────────────────────────────────────┐
# │ Install Dependencies via Chocolatey│
# └────────────────────────────────────┘
choco install nodejs-lts git wget unzip rust -y

# ┌────────────┐
# │ roblox-ts  │
# └────────────┘
npm install -g roblox-ts

# ┌────────────┐
# │ Argon CLI  │
# └────────────┘
Write-Host "Installing Argon CLI..."
Invoke-WebRequest -Uri "https://github.com/argon-rbx/argon/releases/download/2.0.24/argon-2.0.24-windows-x86_64.zip" -OutFile "argon.zip"
Expand-Archive -Path "argon.zip" -DestinationPath "argon-unpacked" -Force
Move-Item "argon-unpacked\argon.exe" "C:\ProgramData\chocolatey\bin\argon.exe" -Force
Remove-Item "argon.zip", "argon-unpacked" -Recurse -Force

# ┌────────────┐
# │ Wally Tool │
# └────────────┘
Write-Host "Installing Wally..."
Invoke-WebRequest -Uri "https://github.com/UpliftGames/wally/releases/download/v0.3.2/wally-v0.3.2-win64.zip" -OutFile "wally.zip"
Expand-Archive -Path "wally.zip" -DestinationPath "wally-unpacked" -Force
Move-Item "wally-unpacked\wally.exe" "C:\ProgramData\chocolatey\bin\wally.exe" -Force
Remove-Item "wally.zip", "wally-unpacked" -Recurse -Force

# ┌────────────┐
# │ Selene     │
# └────────────┘
# Write-Host "Installing Selene Lua linter..."
# cargo install selene

# ┌──────────────┐
# │ Linting Tools│
# └──────────────┘
npm install -g eslint prettier

# ┌────────────────────────┐
# │ VSCode Extensions (opt)│
# └────────────────────────┘
if (Get-Command code -ErrorAction SilentlyContinue) {
    Write-Host "Installing VS Code extensions..."
    code --install-extension roblox-ts.vscode-roblox-ts
    code --install-extension dbaeumer.vscode-eslint
    code --install-extension esbenp.prettier-vscode
    code --install-extension Kampfkarren.selene-vscode
} else {
    Write-Host "VS Code CLI not found. Please install these extensions manually:"
    Write-Host "  • roblox-ts.vscode-roblox-ts"
    Write-Host "  • dbaeumer.vscode-eslint"
    Write-Host "  • esbenp.prettier-vscode"
    Write-Host "  • yoavbls.selene-vscode"
}

Write-Host "All tools installed. You're ready!"
