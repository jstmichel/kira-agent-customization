#Requires -Version 5.1
# KIRA Codex install script — Windows (PowerShell)
# Run from the root of the kira-agent-customization repository:
#   .\install-codex.ps1
$ErrorActionPreference = 'Stop'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$AgentsSrc = Join-Path $ScriptRoot 'codex\agents'
$SkillsSrc = Join-Path $ScriptRoot 'codex\skills'
$GuidanceSrc = Join-Path $ScriptRoot 'codex\AGENTS.md'

$CodexHome = if ($env:KIRA_CODEX_HOME) { $env:KIRA_CODEX_HOME } elseif ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $env:USERPROFILE '.codex' }
$AgentsHome = if ($env:KIRA_AGENTS_HOME) { $env:KIRA_AGENTS_HOME } else { Join-Path $env:USERPROFILE '.agents' }
$AgentsDst = Join-Path $CodexHome 'agents'
$SkillsDst = Join-Path $AgentsHome 'skills'
$GuidanceDst = Join-Path $CodexHome 'AGENTS.md'
$GuidanceFallbackDst = Join-Path $CodexHome 'AGENTS.kira.md'

Write-Host 'Removing existing KIRA Codex files...'

if (Test-Path -LiteralPath $AgentsDst -PathType Container) {
    Get-ChildItem -Path $AgentsDst -File |
        Where-Object {
            $_.Name -eq 'kira.toml' -or
            $_.Name -like 'kira-*.toml'
        } |
        Remove-Item -Force
}

if (Test-Path -LiteralPath $SkillsDst -PathType Container) {
    Get-ChildItem -Path $SkillsDst -Directory |
        Where-Object { $_.Name -like 'kira-*' } |
        Remove-Item -Recurse -Force
}

$agentCount = 0
$skillCount = 0
$guidanceStatus = 'not installed'

Write-Host 'Installing KIRA Codex user agents...'
if (Test-Path -LiteralPath $AgentsSrc -PathType Container) {
    New-Item -ItemType Directory -Force -Path $AgentsDst | Out-Null
    Get-ChildItem -LiteralPath $AgentsSrc -File -Filter '*.toml' |
        ForEach-Object {
            Copy-Item -LiteralPath $_.FullName -Destination $AgentsDst
            $agentCount++
        }
}

Write-Host 'Installing KIRA Codex skills...'
if (Test-Path -LiteralPath $SkillsSrc -PathType Container) {
    Get-ChildItem -LiteralPath $SkillsSrc -Directory |
        ForEach-Object {
            $skillFile = Join-Path $_.FullName 'SKILL.md'
            if (Test-Path -LiteralPath $skillFile -PathType Leaf) {
                $dest = Join-Path $SkillsDst $_.Name
                New-Item -ItemType Directory -Force -Path $dest | Out-Null
                Copy-Item -LiteralPath $skillFile -Destination $dest
                $skillCount++
            }
        }
}

Write-Host 'Installing KIRA Codex guidance...'
New-Item -ItemType Directory -Force -Path $CodexHome | Out-Null
$managedGuidance = "<!-- KIRA-CODEX-MANAGED -->`n" + (Get-Content -LiteralPath $GuidanceSrc -Raw)
if ((-not (Test-Path -LiteralPath $GuidanceDst -PathType Leaf)) -or ((Get-Content -LiteralPath $GuidanceDst -Raw) -match 'KIRA-CODEX-MANAGED')) {
    Set-Content -LiteralPath $GuidanceDst -Value $managedGuidance -NoNewline
    $guidanceStatus = $GuidanceDst
} else {
    Set-Content -LiteralPath $GuidanceFallbackDst -Value $managedGuidance -NoNewline
    $guidanceStatus = "$GuidanceFallbackDst (existing AGENTS.md preserved)"
}

Write-Host ''
Write-Host 'KIRA Codex installed'
Write-Host "  Codex home : $CodexHome"
Write-Host "  Agents     : $agentCount files -> $AgentsDst"
Write-Host "  Skills     : $skillCount folders -> $SkillsDst"
Write-Host "  Guidance   : $guidanceStatus"
