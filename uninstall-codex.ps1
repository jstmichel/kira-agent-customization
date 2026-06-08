#Requires -Version 5.1
# KIRA Codex uninstall script — Windows (PowerShell)
# Run from the root of the kira-agent-customization repository:
#   .\uninstall-codex.ps1
$ErrorActionPreference = 'Stop'

$CodexHome = if ($env:KIRA_CODEX_HOME) { $env:KIRA_CODEX_HOME } elseif ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $env:USERPROFILE '.codex' }
$AgentsHome = if ($env:KIRA_AGENTS_HOME) { $env:KIRA_AGENTS_HOME } else { Join-Path $env:USERPROFILE '.agents' }
$AgentsDst = Join-Path $CodexHome 'agents'
$SkillsDst = Join-Path $AgentsHome 'skills'
$GuidanceDst = Join-Path $CodexHome 'AGENTS.md'
$GuidanceFallbackDst = Join-Path $CodexHome 'AGENTS.kira.md'

function Remove-EmptyDirectory {
    param([Parameter(Mandatory = $true)][string]$Path)

    if (-not (Test-Path -LiteralPath $Path -PathType Container)) {
        return $false
    }

    if ($null -ne (Get-ChildItem -LiteralPath $Path -Force | Select-Object -First 1)) {
        return $false
    }

    Remove-Item -LiteralPath $Path -Force
    return $true
}

function Remove-FileIfPresent {
    param([Parameter(Mandatory = $true)][string]$Path)

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        return $false
    }

    Remove-Item -LiteralPath $Path -Force
    return $true
}

function Remove-DirectoryIfPresent {
    param([Parameter(Mandatory = $true)][string]$Path)

    if (-not (Test-Path -LiteralPath $Path -PathType Container)) {
        return $false
    }

    Remove-Item -LiteralPath $Path -Recurse -Force
    return $true
}

Write-Host 'Removing KIRA Codex files...'

$agentCount = 0
$skillCount = 0
$guidanceCount = 0
$cleanedCount = 0

if (Test-Path -LiteralPath $AgentsDst -PathType Container) {
    @(Get-ChildItem -LiteralPath $AgentsDst -File | Where-Object {
        $_.Name -eq 'kira.toml' -or
        $_.Name -like 'kira-*.toml'
    }) | ForEach-Object {
        if (Remove-FileIfPresent -Path $_.FullName) {
            $agentCount++
        }
    }
}

if (Test-Path -LiteralPath $SkillsDst -PathType Container) {
    @(Get-ChildItem -LiteralPath $SkillsDst -Directory | Where-Object {
        $_.Name -like 'kira-*' -or
        $_.Name -in @('Architecture', 'Codex', 'Draft', 'Intake')
    }) | ForEach-Object {
        if (Remove-DirectoryIfPresent -Path $_.FullName) {
            $skillCount++
        }
    }
}

foreach ($guidancePath in @($GuidanceDst, $GuidanceFallbackDst)) {
    if ((Test-Path -LiteralPath $guidancePath -PathType Leaf) -and ((Get-Content -LiteralPath $guidancePath -Raw) -match 'KIRA-CODEX-MANAGED')) {
        if (Remove-FileIfPresent -Path $guidancePath) {
            $guidanceCount++
        }
    }
}

foreach ($path in @($AgentsDst, $CodexHome, $SkillsDst, $AgentsHome)) {
    if (Remove-EmptyDirectory -Path $path) {
        $cleanedCount++
    }
}

Write-Host ''
Write-Host 'KIRA Codex uninstall complete'
Write-Host "  Agents removed   : $agentCount files"
Write-Host "  Skills removed   : $skillCount folders"
Write-Host "  Guidance removed : $guidanceCount files"
Write-Host "  Empty dirs pruned: $cleanedCount"

if (($agentCount + $skillCount + $guidanceCount) -eq 0) {
    Write-Host '  No KIRA Codex files or folders were found.'
}
