#Requires -Version 5.1
# KIRA uninstall script — Windows (PowerShell)
# Run from the root of the kira-agent-customization repository:
#   .\uninstall.ps1
$ErrorActionPreference = 'Stop'

$KiraHome = Join-Path $env:USERPROFILE '.copilot'
$AgentsDst = Join-Path $KiraHome 'agents'
$SkillsDst = Join-Path $KiraHome 'skills'
$PromptsDst = Join-Path $KiraHome 'prompts'

function Remove-EmptyDirectory {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (-not (Test-Path -LiteralPath $Path -PathType Container)) {
        return $false
    }

    if ($null -ne (Get-ChildItem -LiteralPath $Path -Force | Select-Object -First 1)) {
        return $false
    }

    Remove-Item -LiteralPath $Path -Force
    return $true
}

Write-Host "Removing KIRA files from $KiraHome..."

$agentItems = @()
$skillItems = @()
$promptItems = @()
$cleanedCount = 0

if (Test-Path -LiteralPath $AgentsDst -PathType Container) {
    $agentItems = @(Get-ChildItem -LiteralPath $AgentsDst -File | Where-Object {
        $_.Name -eq 'kira.agent.md' -or
        $_.Name -like 'kira-*.agent.md' -or
        $_.Name -eq 'kira-aura.agent.md' -or
        $_.Name -eq 'kira-companion.agent.md' -or
        $_.Name -eq 'mila.agent.md'
    })

    if ($agentItems.Count -gt 0) {
        $agentItems | Remove-Item -Force
    }
}

if (Test-Path -LiteralPath $SkillsDst -PathType Container) {
    $skillItems = @(Get-ChildItem -LiteralPath $SkillsDst -Directory | Where-Object {
        $_.Name -like 'kira-*'
    })

    if ($skillItems.Count -gt 0) {
        $skillItems | Remove-Item -Recurse -Force
    }
}

if (Test-Path -LiteralPath $PromptsDst -PathType Container) {
    $promptItems = @(Get-ChildItem -LiteralPath $PromptsDst -File -Filter 'kira-*.prompt.md')

    if ($promptItems.Count -gt 0) {
        $promptItems | Remove-Item -Force
    }
}

foreach ($path in @($AgentsDst, $SkillsDst, $PromptsDst, $KiraHome)) {
    if (Remove-EmptyDirectory -Path $path) {
        $cleanedCount++
    }
}

Write-Host ''
Write-Host 'KIRA uninstall complete'
Write-Host "  Agents removed  : $($agentItems.Count) files"
Write-Host "  Skills removed  : $($skillItems.Count) folders"
Write-Host "  Prompts removed : $($promptItems.Count) files"
Write-Host "  Empty dirs pruned: $cleanedCount"

if (($agentItems.Count + $skillItems.Count + $promptItems.Count) -eq 0) {
    Write-Host '  No KIRA files or folders were found.'
}