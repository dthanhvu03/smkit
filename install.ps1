#Requires -Version 5.1
<#
.SYNOPSIS
  Install SMKit into a target project directory.

.DESCRIPTION
  Idempotent: existing files are never overwritten (warn + skip).
  No external dependencies.

.EXAMPLE
  .\install.ps1
  .\install.ps1 -TargetDir C:\Projects\my-app -Mode full -NonInteractive
#>
[CmdletBinding()]
param(
    [string]$TargetDir = "",
    [ValidateSet("lightweight", "full", "")]
    [string]$Mode = "",
    [switch]$NonInteractive
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$SourceDir = $PSScriptRoot
if ([string]::IsNullOrWhiteSpace($SourceDir)) {
    $SourceDir = Split-Path -Parent $MyInvocation.MyCommand.Path
}

function Write-Info([string]$Message) { Write-Host $Message -ForegroundColor Cyan }
function Write-Warn([string]$Message) { Write-Host "WARN: $Message" -ForegroundColor Yellow }
function Write-Ok([string]$Message) { Write-Host "OK:   $Message" -ForegroundColor Green }

function Initialize-SmkitSource {
    param([string]$CurrentSource)

    if (-not [string]::IsNullOrWhiteSpace($CurrentSource) -and (Test-Path (Join-Path $CurrentSource "smkit\rules\00-core.md"))) {
        return $CurrentSource
    }

    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Error @"
SMKit source not found at '$CurrentSource'.
Run install.ps1 from a cloned SMKit repo, or install git for remote bootstrap.
"@
    }

    $repoUrl = if ($env:SMKIT_REPO_URL) { $env:SMKIT_REPO_URL } else { "https://github.com/dthanhvu03/smkit.git" }
    $cloneDir = Join-Path $env:TEMP ("smkit-src-" + [guid]::NewGuid().ToString("n").Substring(0, 8))

    Write-Info "Cloning SMKit from $repoUrl ..."
    git clone --depth 1 $repoUrl $cloneDir | Out-Null
    if (-not (Test-Path (Join-Path $cloneDir "smkit\rules\00-core.md"))) {
        Write-Error "Clone succeeded but SMKit source layout not found in '$cloneDir'."
    }

    Write-Ok "SMKit source ready at $cloneDir"
    return $cloneDir
}

$SourceDir = Initialize-SmkitSource -CurrentSource $SourceDir

function Read-Choice {
    param(
        [string]$Prompt,
        [string[]]$Valid,
        [string]$Default
    )
    while ($true) {
        $input = Read-Host $Prompt
        if ([string]::IsNullOrWhiteSpace($input)) { return $Default }
        $normalized = $input.Trim().ToLower()
        if ($Valid -contains $normalized) { return $normalized }
        Write-Warn "Invalid choice. Valid: $($Valid -join ', ')"
    }
}

function Resolve-TargetDirectory {
    param([string]$InputPath)
    if ([string]::IsNullOrWhiteSpace($InputPath)) {
        return (Get-Location).Path
    }
    return (Resolve-Path -LiteralPath $InputPath).Path
}

function Copy-TreeNoOverwrite {
    param(
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Destination,
        [string[]]$ExcludePatterns = @(),
        [ref]$CopiedRef,
        [ref]$SkippedRef
    )

    if (-not (Test-Path $Source)) {
        Write-Warn "Source missing, skip: $Source"
        return
    }

    $sourceRoot = (Resolve-Path $Source).Path

    Get-ChildItem -Path $sourceRoot -Recurse -File | ForEach-Object {
        $relative = $_.FullName.Substring($sourceRoot.Length).TrimStart('\', '/')
        foreach ($pattern in $ExcludePatterns) {
            if ($relative -like $pattern) { return }
        }

        $destFile = Join-Path $Destination $relative
        $destParent = Split-Path $destFile -Parent
        if (-not (Test-Path $destParent)) {
            New-Item -ItemType Directory -Path $destParent -Force | Out-Null
        }

        if (Test-Path $destFile) {
            Write-Warn "SKIP (exists): $relative"
            if ($null -ne $SkippedRef) { $SkippedRef.Value++ }
        }
        else {
            Copy-Item -LiteralPath $_.FullName -Destination $destFile
            Write-Ok "COPY: $relative"
            if ($null -ne $CopiedRef) { $CopiedRef.Value++ }
        }
    }
}

function Set-ProjectMode {
    param(
        [string]$ProjectFile,
        [string]$SelectedMode,
        [bool]$WasCopied
    )

    if (-not $WasCopied) {
        Write-Warn "memory/project.md already exists - set Mode manually if needed."
        return
    }

    if (-not (Test-Path $ProjectFile)) { return }

    $content = Get-Content -LiteralPath $ProjectFile -Raw
    $capMode = $SelectedMode.Substring(0, 1).ToUpper() + $SelectedMode.Substring(1)
    $replacement = '| Mode | ' + $capMode + ' |'
    $updated = $content -replace '\|\s*Mode\s*\|\s*Lightweight\s*/\s*Full\s*\|', $replacement
    if ($updated -ne $content) {
        Set-Content -LiteralPath $ProjectFile -Value $updated -NoNewline
        Write-Ok "Set memory/project.md Mode = $SelectedMode"
    }
}

function Write-InstallManifest {
    param(
        [string]$Target,
        [string]$SelectedMode
    )

    $manifestDir = Join-Path $Target ".smkit"
    if (-not (Test-Path $manifestDir)) {
        New-Item -ItemType Directory -Path $manifestDir -Force | Out-Null
    }

    $manifestPath = Join-Path $manifestDir "install.json"
    if (Test-Path $manifestPath) {
        Write-Warn "SKIP (exists): .smkit/install.json"
        return
    }

    $manifest = @{
        mode        = $SelectedMode
        version     = "2.1"
        installedAt = (Get-Date).ToString("o")
        source      = "smkit-installer"
    } | ConvertTo-Json -Depth 3

    Set-Content -LiteralPath $manifestPath -Value $manifest
    Write-Ok "CREATE: .smkit/install.json"
}

function Setup-ClaudeIntegration {
    param(
        [string]$Source,
        [string]$Target
    )

    $claudeSource = Join-Path $Source ".claude"
    if (-not (Test-Path $claudeSource)) {
        Write-Warn ".claude source not found - skip Claude Code integration."
        return
    }

    Write-Info "Setting up .claude/ (slash command pointers)..."
    $claudeCopied = 0
    $claudeSkipped = 0
    Copy-TreeNoOverwrite -Source $claudeSource -Destination (Join-Path $Target ".claude") -CopiedRef ([ref]$claudeCopied) -SkippedRef ([ref]$claudeSkipped)
}

function Setup-CursorIntegration {
    param(
        [string]$Source,
        [string]$Target
    )

    $cursorSource = Join-Path $Source ".cursor"
    if (-not (Test-Path $cursorSource)) {
        Write-Warn ".cursor source not found - skip Cursor integration."
        return
    }

    Write-Info "Setting up .cursor/ (loader + skill pointers)..."
    $cursorCopied = 0
    $cursorSkipped = 0
    Copy-TreeNoOverwrite -Source $cursorSource -Destination (Join-Path $Target ".cursor") -CopiedRef ([ref]$cursorCopied) -SkippedRef ([ref]$cursorSkipped)

    $junctionPath = Join-Path $Target ".cursor\smkit-rules"
    $junctionTarget = Join-Path $Target "smkit\rules"

    if (-not (Test-Path $junctionTarget)) {
        Write-Warn "smkit/rules not in target - skip junction .cursor/smkit-rules"
        return
    }

    if (Test-Path $junctionPath) {
        Write-Warn "SKIP (exists): .cursor/smkit-rules junction"
        return
    }

    try {
        New-Item -ItemType Junction -Path $junctionPath -Target $junctionTarget | Out-Null
        Write-Ok "JUNCTION: .cursor/smkit-rules -> smkit/rules"
    }
    catch {
        Write-Warn "Could not create junction .cursor/smkit-rules ($($_.Exception.Message)). Loader + pointers still work."
    }
}

function Test-GitRepository {
    param([string]$Path)
    return Test-Path (Join-Path $Path ".git")
}

# --- Prompts ---
Write-Host ""
Write-Info "SMKit Installer (Windows)"
Write-Host "Source: $SourceDir"
Write-Host ""

if (-not $NonInteractive) {
    if ([string]::IsNullOrWhiteSpace($TargetDir)) {
        $defaultTarget = (Get-Location).Path
        $inputTarget = Read-Host "Target directory? [$defaultTarget]"
        $TargetDir = if ([string]::IsNullOrWhiteSpace($inputTarget)) { $defaultTarget } else { $inputTarget }
    }
    if ([string]::IsNullOrWhiteSpace($Mode)) {
        $Mode = Read-Choice -Prompt "Mode? (lightweight/full) [lightweight]" -Valid @("lightweight", "full") -Default "lightweight"
    }
}
else {
    if ([string]::IsNullOrWhiteSpace($TargetDir)) {
        $TargetDir = (Get-Location).Path
    }
    if ([string]::IsNullOrWhiteSpace($Mode)) {
        $Mode = "lightweight"
    }
}

$TargetDir = Resolve-TargetDirectory -InputPath $TargetDir
if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
    Write-Ok "Created target directory: $TargetDir"
}

Write-Host ""
Write-Info "Target: $TargetDir"
Write-Info "Mode:   $Mode"
Write-Host ""

if (-not (Test-GitRepository -Path $TargetDir)) {
    Write-Warn "Target is not a git repository. Consider: git init"
}

# --- Core copy ---
$coreItems = @(
    @{ Source = "smkit"; Dest = "smkit" },
    @{ Source = "memory"; Dest = "memory" },
    @{ Source = "project-docs"; Dest = "project-docs" },
    @{ Source = "AGENTS.md"; Dest = "AGENTS.md"; IsFile = $true },
    @{ Source = "CLAUDE.md"; Dest = "CLAUDE.md"; IsFile = $true }
)

$totalCopied = 0
$totalSkipped = 0
$projectMdPath = Join-Path $TargetDir "memory\project.md"
$projectMdExistedBefore = Test-Path $projectMdPath

foreach ($item in $coreItems) {
    $src = Join-Path $SourceDir $item.Source
    $dst = Join-Path $TargetDir $item.Dest

    $isFile = $false
    if ($item.ContainsKey('IsFile')) { $isFile = [bool]$item.IsFile }

    if ($isFile) {
        if (-not (Test-Path $src)) {
            Write-Warn "Source missing, skip: $($item.Source)"
            continue
        }
        if (Test-Path $dst) {
            Write-Warn "SKIP (exists): $($item.Dest)"
            $totalSkipped++
        }
        else {
            Copy-Item -LiteralPath $src -Destination $dst
            Write-Ok "COPY: $($item.Dest)"
            $totalCopied++
        }
        continue
    }

    Copy-TreeNoOverwrite -Source $src -Destination $dst -CopiedRef ([ref]$totalCopied) -SkippedRef ([ref]$totalSkipped)
}

$projectMdCopied = (-not $projectMdExistedBefore) -and (Test-Path $projectMdPath)

# --- Full mode extras ---
if ($Mode -eq "full") {
    Write-Info "Full mode: installing artifacts/ and docs/..."
    Copy-TreeNoOverwrite -Source (Join-Path $SourceDir "artifacts") -Destination (Join-Path $TargetDir "artifacts") -CopiedRef ([ref]$totalCopied) -SkippedRef ([ref]$totalSkipped)
    Copy-TreeNoOverwrite -Source (Join-Path $SourceDir "docs") -Destination (Join-Path $TargetDir "docs") -CopiedRef ([ref]$totalCopied) -SkippedRef ([ref]$totalSkipped)

    $artifactsKeep = Join-Path $TargetDir "artifacts\.gitkeep"
    if (-not (Test-Path $artifactsKeep)) {
        New-Item -ItemType Directory -Path (Split-Path $artifactsKeep) -Force | Out-Null
        Set-Content -LiteralPath $artifactsKeep -Value ""
        Write-Ok "CREATE: artifacts/.gitkeep"
        $totalCopied++
    }
}
else {
    Write-Info "Lightweight mode: skipping artifacts/ and docs/ (core framework only)."
}

Set-ProjectMode -ProjectFile $projectMdPath -SelectedMode $Mode -WasCopied $projectMdCopied
Write-InstallManifest -Target $TargetDir -SelectedMode $Mode
Setup-CursorIntegration -Source $SourceDir -Target $TargetDir
Setup-ClaudeIntegration -Source $SourceDir -Target $TargetDir

Write-Host ""
Write-Info "Install summary: copied=$totalCopied skipped=$totalSkipped"
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Green
Write-Host "  1. cd `"$TargetDir`""
Write-Host "  2. Edit memory/project.md - dien ten du an, business context"
Write-Host "  3. Mo Cursor hoac chay: claude"
Write-Host "  4. Prompt dau tien: Doc AGENTS.md va memory/project.md"
Write-Host "  5. Claude Code: /sm-help | Cursor: @sm-backend, @sm-discovery..."
Write-Host ""
if ($Mode -eq "full") {
    Write-Host "  Full mode: xem docs/getting-started.md"
}
else {
    Write-Host "  Lightweight mode: bat dau voi Discovery skill"
}
Write-Host ""
