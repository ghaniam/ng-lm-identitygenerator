# NG.LM.IdentityGenerator

A library module for generating unique identities.

## Installation

This package is published to GitHub Packages and requires authentication.

### Step 1: Authenticate to GitHub Packages

**Option A: Using dotnet CLI (Recommended)**

```bash
dotnet nuget add source https://nuget.pkg.github.com/ghaniam/index.json \
  --name github \
  --username YOUR-GITHUB-USERNAME \
  --password YOUR-GITHUB-TOKEN \
  --store-password-in-clear-text
```

**Option B: Using Environment Variables**

```powershell
# Windows PowerShell
$env:GITHUB_USERNAME = "your-github-username"
$env:GITHUB_TOKEN = "your-personal-access-token"
```

```bash
# Linux/macOS
export GITHUB_USERNAME=your-github-username
export GITHUB_TOKEN=your-personal-access-token
```

**Creating a GitHub Token:**
1. Go to GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Generate new token with `read:packages` scope
3. Copy the token and use it in the commands above

### Step 2: Install the Package

```bash
dotnet add package WormDev-github.NG.LM.IdentityGenerator.Core
```

Or add to your `.csproj`:

```xml
<PackageReference Include="WormDev-github.NG.LM.IdentityGenerator.Core" Version="1.0.0" />
```

## Usage

```csharp
using NG.LM.IdentityGenerator.Core;

// Example usage will be documented here
```

## Building from Source

```bash
# Restore dependencies
dotnet restore

# Build
dotnet build --configuration Release

# Run tests
dotnet test

# Pack
dotnet pack --configuration Release
```

## Publishing to GitHub Packages

The package is automatically published to GitHub Packages when:
- Code is pushed to the main/master branch
- A new release is published
- Manually triggered via workflow dispatch

## License

Copyright © NG 2026
