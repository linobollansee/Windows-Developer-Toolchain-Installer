# ============================================================
# HOW TO USE
# ============================================================
#
# 1. Open PowerShell as Administrator.
#
# 2. Allow this script to run for this session:
#
#    Set-ExecutionPolicy -Scope Process Bypass
#
# 3. Run the script:
#
#    .\install-dev-toolchains.ps1
#
# 4. Restart PowerShell/Windows Terminal when finished.
#
# Check installed packages:
#
#    winget list
#
# ============================================================

$ErrorActionPreference = "Continue"

Write-Host "=============================================" -ForegroundColor Cyan
Write-Host " Windows Programmer Toolchain Installer"
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""

# ------------------------------------------------------------
# Check winget
# ------------------------------------------------------------

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: winget is not installed." -ForegroundColor Red
    Write-Host "Install/update 'App Installer' from the Microsoft Store, then retry."
    exit 1
}

winget source update

# ------------------------------------------------------------
# Helper
# ------------------------------------------------------------

function Install-WingetPackage {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Id
    )

    Write-Host ""
    Write-Host ">>> Installing $Id" -ForegroundColor Yellow

    winget install `
        --id $Id `
        --exact `
        --source winget `
        --accept-source-agreements `
        --accept-package-agreements `
        --silent

    if ($LASTEXITCODE -eq 0) {
        Write-Host "OK: $Id" -ForegroundColor Green
    }
    else {
        Write-Host "SKIPPED/FAILED: $Id" -ForegroundColor DarkYellow
    }
}

# ------------------------------------------------------------
# Windows developer essentials
# ------------------------------------------------------------

$packages = @(

    # -------------------------
    # Editors / IDEs
    # -------------------------
    "Microsoft.VisualStudioCode"
    "Microsoft.VisualStudio.2022.Community"
    "JetBrains.Toolbox"

    # -------------------------
    # Git / version control
    # -------------------------
    "Git.Git"
    "GitHub.cli"
    "GitHub.GitLFS"

    # -------------------------
    # C / C++
    # -------------------------
    "Microsoft.VisualStudio.2022.Community"
    "Kitware.CMake"
    "Ninja-build.Ninja"
    "LLVM.LLVM"
    "MSYS2.MSYS2"

    # -------------------------
    # Rust
    # -------------------------
    "Rustlang.Rustup"

    # -------------------------
    # Go
    # -------------------------
    "GoLang.Go"

    # -------------------------
    # Java / JVM
    # -------------------------
    "EclipseAdoptium.Temurin.21.JDK"
    "Apache.Maven"
    "Gradle.Gradle"

    # -------------------------
    # .NET
    # -------------------------
    "Microsoft.DotNet.SDK.8"
    "Microsoft.DotNet.SDK.9"

    # -------------------------
    # Python
    # -------------------------
    "Python.Python.3.12"
    "Python.Python.3.13"
    "astral-sh.uv"

    # -------------------------
    # JavaScript / TypeScript
    # -------------------------
    "OpenJS.NodeJS.LTS"
    "CoreyButler.NVMforWindows"

    # -------------------------
    # Ruby
    # -------------------------
    "RubyInstallerTeam.RubyWithDevKit.3.3"

    # -------------------------
    # PHP
    # -------------------------
    "PHP.PHP"

    # -------------------------
    # Dart / Flutter
    # -------------------------
    "Google.Dart"
    "Google.Flutter"

    # -------------------------
    # Julia
    # -------------------------
    "Julialang.Julia"

    # -------------------------
    # Lua
    # -------------------------
    "DEVCOM.Lua"

    # -------------------------
    # Zig
    # -------------------------
    "zig.zig"

    # -------------------------
    # Haskell
    # -------------------------
    "Haskell.GHCup"

    # -------------------------
    # Elixir / Erlang
    # -------------------------
    "Erlang.ErlangOTP"
    "Elixir.Elixir"

    # -------------------------
    # Perl
    # -------------------------
    "StrawberryPerl.StrawberryPerl"

    # -------------------------
    # Swift
    # -------------------------
    "Swift.Toolchain"

    # -------------------------
    # Pascal
    # -------------------------
    "Embarcadero.Dev-C++"

    # -------------------------
    # Databases
    # -------------------------
    "PostgreSQL.PostgreSQL"
    "MySQL.MySQL"
    "MariaDB.Server"
    "SQLite.SQLite"
    "Redis.Redis"
    "MongoDB.Server"

    # -------------------------
    # Containers
    # -------------------------
    "Docker.DockerDesktop"

    # -------------------------
    # Kubernetes
    # -------------------------
    "Kubernetes.kubectl"
    "Helm.Helm"
    "Kubernetes.minikube"

    # -------------------------
    # Infrastructure
    # -------------------------
    "Hashicorp.Terraform"
    "Hashicorp.Vagrant"

    # -------------------------
    # Cloud CLIs
    # -------------------------
    "Amazon.AWSCLI"
    "Microsoft.AzureCLI"
    "Google.CloudSDK"

    # -------------------------
    # API / HTTP tools
    # -------------------------
    "Postman.Postman"
    "Insomnia.Insomnia"

    # -------------------------
    # Shell / CLI
    # -------------------------
    "Microsoft.PowerShell"
    "sharkdp.fd"
    "BurntSushi.ripgrep.MSVC"
    "jqlang.jq"
    "eza-community.eza"
    "junegunn.fzf"
    "ajeetdsouza.zoxide"
    "cURL.cURL"
    "GnuWin32.Make"
    "7zip.7zip"

    # -------------------------
    # Terminal
    # -------------------------
    "Microsoft.WindowsTerminal"

    # -------------------------
    # Documentation / productivity
    # -------------------------
    "Microsoft.PowerToys"

    # -------------------------
    # JSON / YAML
    # -------------------------
    "MikeFarah.yq"

    # -------------------------
    # Networking / debugging
    # -------------------------
    "WiresharkFoundation.Wireshark"
    "PuTTY.PuTTY"

    # -------------------------
    # Virtualization
    # -------------------------
    "Oracle.VirtualBox"

)

# ------------------------------------------------------------
# Install packages
# ------------------------------------------------------------

$packages = $packages | Sort-Object -Unique

$total = $packages.Count
$count = 0

foreach ($package in $packages) {
    $count++

    Write-Host ""
    Write-Host "[$count/$total]" -ForegroundColor Cyan

    Install-WingetPackage $package
}

# ------------------------------------------------------------
# Rust components
# ------------------------------------------------------------

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host " Configuring Rust"
Write-Host "=============================================" -ForegroundColor Cyan

if (Get-Command rustup -ErrorAction SilentlyContinue) {
    rustup default stable
    rustup component add rustfmt
    rustup component add clippy
}

# ------------------------------------------------------------
# Python tooling
# ------------------------------------------------------------

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host " Configuring Python"
Write-Host "=============================================" -ForegroundColor Cyan

if (Get-Command py -ErrorAction SilentlyContinue) {
    py -m pip install --upgrade pip setuptools wheel

    py -m pip install `
        virtualenv `
        pipx `
        poetry `
        ruff `
        black `
        mypy `
        pytest `
        ipython `
        jupyter `
        pre-commit `
        hatch
}

# ------------------------------------------------------------
# Node global developer tools
# ------------------------------------------------------------

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host " Configuring Node.js"
Write-Host "=============================================" -ForegroundColor Cyan

if (Get-Command npm -ErrorAction SilentlyContinue) {

    npm install -g `
        typescript `
        tsx `
        eslint `
        prettier `
        npm-check-updates `
        pnpm `
        yarn `
        vite `
        nodemon `
        http-server
}

# ------------------------------------------------------------
# .NET global tools
# ------------------------------------------------------------

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host " Configuring .NET"
Write-Host "=============================================" -ForegroundColor Cyan

if (Get-Command dotnet -ErrorAction SilentlyContinue) {

    dotnet tool install --global dotnet-ef
    dotnet tool install --global dotnet-format
    dotnet tool install --global dotnet-outdated-tool
    dotnet tool install --global dotnet-reportgenerator-globaltool
}

# ------------------------------------------------------------
# Git configuration helpers
# ------------------------------------------------------------

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host " Git setup"
Write-Host "=============================================" -ForegroundColor Cyan

if (Get-Command git -ErrorAction SilentlyContinue) {
    git config --global init.defaultBranch main
    git config --global core.autocrlf true
}

# ------------------------------------------------------------
# Create useful developer directories
# ------------------------------------------------------------

$directories = @(
    "$HOME\src",
    "$HOME\dev",
    "$HOME\projects",
    "$HOME\repos",
    "$HOME\tools",
    "$HOME\bin"
)

foreach ($dir in $directories) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
}

# ------------------------------------------------------------
# Refresh PATH for this PowerShell session
# ------------------------------------------------------------

$machinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
$userPath    = [Environment]::GetEnvironmentVariable("Path", "User")

$env:Path = "$machinePath;$userPath"

# ------------------------------------------------------------
# Summary
# ------------------------------------------------------------

Write-Host ""
Write-Host "=============================================" -ForegroundColor Green
Write-Host " Installation complete"
Write-Host "=============================================" -ForegroundColor Green
Write-Host ""

Write-Host "Installed/configured categories:" -ForegroundColor Cyan
Write-Host ""
Write-Host "  C / C++ / LLVM / CMake / Ninja"
Write-Host "  Rust / Cargo / Clippy / rustfmt"
Write-Host "  Go"
Write-Host "  Java / Maven / Gradle"
Write-Host "  .NET"
Write-Host "  Python / pip / uv"
Write-Host "  Node.js / TypeScript / npm / pnpm"
Write-Host "  Ruby"
Write-Host "  PHP"
Write-Host "  Dart / Flutter"
Write-Host "  Julia"
Write-Host "  Lua"
Write-Host "  Zig"
Write-Host "  Haskell"
Write-Host "  Elixir / Erlang"
Write-Host "  Perl"
Write-Host "  Swift"
Write-Host "  PostgreSQL / MySQL / MariaDB / SQLite"
Write-Host "  Redis / MongoDB"
Write-Host "  Docker"
Write-Host "  Kubernetes / Helm / Minikube"
Write-Host "  Terraform / Vagrant"
Write-Host "  AWS / Azure / Google Cloud CLIs"
Write-Host "  Git / GitHub CLI / Git LFS"
Write-Host "  VS Code / Visual Studio / JetBrains Toolbox"
Write-Host "  PowerShell / Windows Terminal"
Write-Host "  ripgrep / fd / jq / yq / fzf / zoxide"
Write-Host "  Wireshark / PuTTY"
Write-Host ""

Write-Host "IMPORTANT: Restart PowerShell/Windows Terminal so all PATH changes take effect." -ForegroundColor Yellow
Write-Host ""
Write-Host "Run 'winget list' to inspect installed packages." -ForegroundColor Cyan
