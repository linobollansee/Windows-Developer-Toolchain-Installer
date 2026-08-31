# Windows Developer Toolchain Installer

A PowerShell bootstrap script for setting up a broad **programming and software-development environment on Windows**.

The installer uses **Windows Package Manager (`winget`)** to install compilers, runtimes, SDKs, IDEs, developer utilities, databases, container tooling, cloud CLIs, and common command-line tools.

> **Warning:** This script installs a large number of development tools. Some packages may require significant disk space, administrator privileges, or a system restart.

## Features

The installer attempts to set up toolchains and utilities for:

* C / C++
* Rust
* Go
* Java / JVM
* .NET
* Python
* JavaScript / TypeScript
* Node.js
* Ruby
* PHP
* Dart / Flutter
* Julia
* Lua
* Zig
* Haskell
* Elixir / Erlang
* Perl
* Swift
* SQL and NoSQL databases
* Docker
* Kubernetes
* Terraform
* Cloud development
* Git / GitHub
* CMake / Ninja / LLVM
* VS Code / Visual Studio
* PowerShell / Windows Terminal
* Developer CLI utilities
* API testing
* Networking and debugging

## Requirements

### Operating system

* Windows 10 or later
* Windows 11 recommended

### Required

* Administrator privileges
* Windows Package Manager (`winget`)
* Internet connection
* Sufficient disk space

`winget` is normally provided through Microsoft's **App Installer** package.

Verify that it is available:

```powershell
winget --version
```

## Installation

### 1. Download the script

Clone the repository:

```powershell
git clone <repository-url>
cd <repository-directory>
```

Or download `install-dev-toolchains.ps1` directly.

### 2. Open PowerShell as Administrator

Right-click PowerShell and select:

**Run as administrator**

### 3. Allow the script to run

For the current PowerShell session only:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
```

This does not permanently change the system execution policy.

### 4. Run the installer

```powershell
.\install-dev-toolchains.ps1
```

The script will continue installing packages even if an individual package fails.

## What Gets Installed

### C / C++

The installer includes tools such as:

* Visual Studio
* LLVM/Clang
* CMake
* Ninja
* MSYS2
* Make

Typical commands:

```powershell
cl
clang
cmake
ninja
```

### Rust

Rustup is installed and configured with:

* Stable Rust
* Cargo
* rustfmt
* Clippy

Verify:

```powershell
rustc --version
cargo --version
```

### Go

Verify:

```powershell
go version
```

### Java

The installer provides a JDK along with:

* Maven
* Gradle

Verify:

```powershell
java --version
mvn --version
gradle --version
```

### .NET

The .NET SDK is installed along with useful global tools such as:

* Entity Framework Core CLI
* `dotnet-format`
* `dotnet-outdated`
* ReportGenerator

Verify:

```powershell
dotnet --info
```

### Python

Python and common development tooling are installed.

Additional tools include:

* pip
* virtualenv
* uv
* Poetry
* Ruff
* Black
* mypy
* pytest
* IPython
* Jupyter
* pre-commit
* Hatch

Verify:

```powershell
py --version
python --version
pip --version
```

### JavaScript / TypeScript

Node.js is installed together with common developer tools:

* TypeScript
* tsx
* ESLint
* Prettier
* pnpm
* Yarn
* Vite
* Nodemon
* npm-check-updates
* http-server

Verify:

```powershell
node --version
npm --version
tsc --version
```

### Other Languages

The installer also attempts to install environments for:

| Language | Toolchain              |
| -------- | ---------------------- |
| Ruby     | RubyInstaller + DevKit |
| PHP      | PHP                    |
| Dart     | Dart SDK               |
| Flutter  | Flutter SDK            |
| Julia    | Julia                  |
| Lua      | Lua                    |
| Zig      | Zig                    |
| Haskell  | GHCup                  |
| Elixir   | Elixir                 |
| Erlang   | Erlang/OTP             |
| Perl     | Strawberry Perl        |
| Swift    | Swift toolchain        |

Individual package availability can vary depending on the current `winget` catalog.

## Databases

The installer attempts to install:

* PostgreSQL
* MySQL
* MariaDB
* SQLite
* Redis
* MongoDB

Database services may require additional configuration after installation.

## Containers & Kubernetes

Container and orchestration tools include:

* Docker Desktop
* kubectl
* Helm
* Minikube

Verify:

```powershell
docker --version
kubectl version --client
helm version
minikube version
```

Docker Desktop may require virtualization features to be enabled.

## Cloud Development

The script installs command-line tools for:

* Amazon Web Services
* Microsoft Azure
* Google Cloud

Typical commands:

```powershell
aws --version
az --version
gcloud --version
```

You will need to authenticate separately with each cloud provider.

## Git

Git-related tools include:

* Git
* GitHub CLI
* Git LFS

The script also configures Git to use `main` as the default initial branch.

Verify:

```powershell
git --version
gh --version
git lfs version
```

## Editors & IDEs

The installer attempts to install:

* Visual Studio Code
* Visual Studio
* JetBrains Toolbox
* Windows Terminal

JetBrains Toolbox can subsequently be used to install IDEs such as IntelliJ IDEA, PyCharm, CLion, GoLand, Rider, and WebStorm.

## Command-Line Utilities

The environment includes several useful CLI tools:

* PowerShell
* Windows Terminal
* ripgrep
* fd
* jq
* yq
* fzf
* zoxide
* eza
* curl
* GNU Make
* 7-Zip

These tools are useful for scripting, searching source trees, processing JSON/YAML, navigating projects, and general development work.

## API & Networking Tools

The installer includes:

* Postman
* Insomnia
* Wireshark
* PuTTY

These are useful for API development, network debugging, SSH connections, and protocol analysis.

## Developer Directories

The script creates several directories in your user profile:

```text
%USERPROFILE%\src
%USERPROFILE%\dev
%USERPROFILE%\projects
%USERPROFILE%\repos
%USERPROFILE%\tools
%USERPROFILE%\bin
```

You can use these for source code, repositories, locally installed tools, and projects.

## After Installation

### Restart your terminal

Close and reopen PowerShell or Windows Terminal.

Some installers modify the `PATH` environment variable, and existing terminal sessions may not see those changes.

### Verify installed packages

Run:

```powershell
winget list
```

You can also check individual tools:

```powershell
git --version
python --version
node --version
go version
rustc --version
java --version
dotnet --info
cmake --version
docker --version
```

## Troubleshooting

### `winget` is not recognized

Install or update **App Installer** from the Microsoft Store, then open a new PowerShell window.

Check:

```powershell
winget --version
```

### A package fails to install

This does not necessarily mean the entire installation failed.

The script intentionally continues after individual package failures.

Try:

```powershell
winget search <package-name>
```

Then install the package manually:

```powershell
winget install <package-id>
```

### A command is not recognized after installation

Restart PowerShell or Windows Terminal.

If it still does not work, inspect your PATH:

```powershell
$env:Path -split ';'
```

You can also restart Windows if an installer requires it.

### Docker does not start

Make sure hardware virtualization and the required Windows virtualization features are enabled.

A reboot may also be required after Docker Desktop installation.

### Python packages fail

Try upgrading pip:

```powershell
py -m pip install --upgrade pip
```

For isolated Python CLI applications, consider using `pipx` or `uv`.

## Idempotency

The script is designed to be reasonably safe to run multiple times.

`winget` generally detects packages that are already installed and avoids reinstalling them unnecessarily.

Some language-specific commands, such as global package installations, may behave differently depending on the installed version.

## Philosophy

This project aims to provide a **general-purpose Windows programming workstation in one command**.

It favors widely used and actively maintained tools rather than attempting to install every package available for every programming language.

The installer is intentionally broad, but it is **not a replacement for project-specific setup**.

Individual projects may still require:

* Specific compiler versions
* SDK versions
* Virtual environments
* Package managers
* Environment variables
* Database configuration
* Cloud credentials
* Project-specific dependencies

For reproducible development environments, consider using tools such as:

* Dev Containers
* Docker
* WSL2
* Nix
* mise
* language-specific version managers

## Security

Review the installer before executing it on a production or sensitive machine.

The script installs software from external package repositories and runs installers with administrator privileges.

For important systems, inspect the package list and remove anything you do not need before running the script.

## Contributing

Contributions are welcome.

When adding a new tool:

1. Prefer a well-maintained package available through `winget`.
2. Use the exact `winget` package ID.
3. Avoid unnecessary duplication.
4. Make sure installation failures do not prevent other tools from being installed.
5. Update this README when adding a significant toolchain.

## License

Choose an appropriate license for your project. For example:

```text
MIT License
```

If this repository contains only the installer script and documentation, the MIT License is a reasonable permissive choice.
