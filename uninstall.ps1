#Requires -Version 5.1
# KIRA uninstall script — Windows (PowerShell)
# Run from the root of the kira-agent-customization repository:
#   .\uninstall.ps1
$ErrorActionPreference = 'Stop'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$AgentsSrc = Join-Path $ScriptRoot 'copilot\agents'
$SkillsSrc = Join-Path $ScriptRoot 'copilot\skills'
$PromptsSrc = Join-Path $ScriptRoot 'copilot\prompts'
$InstructionsSrc = Join-Path $ScriptRoot 'copilot\instructions'

$PromptCleanupNames = @(
    'design-with-kira.prompt.md',
    'document-pr-with-kira.prompt.md',
    'draft-commit-with-kira.prompt.md',
    'implement-with-kira.prompt.md',
    'plan-with-kira.prompt.md',
    'review-with-kira.prompt.md',
    'architecture.prompt.md',
    'draft-commit.prompt.md',
    'implement.prompt.md',
    'plan.prompt.md',
    'review.prompt.md',
    'adr.prompt.md',
    'design-review.prompt.md',
    'draft-squash.prompt.md',
    'kira.prompt.md',
    'plan-change.prompt.md',
    'plan-ticket.prompt.md',
    'review-branch.prompt.md',
    'review-pr.prompt.md'
)

$KiraHome = if ($env:KIRA_HOME) { $env:KIRA_HOME } else { Join-Path $env:USERPROFILE '.copilot' }
$AgentsDst = Join-Path $KiraHome 'agents'
$SkillsDst = Join-Path $KiraHome 'skills'
$InstructionsDst = Join-Path $KiraHome 'instructions'

# VS Code reads .prompt.md files from the platform User prompts directory
$PromptsDst = if ($env:VSCODE_PROMPTS_DIR) { $env:VSCODE_PROMPTS_DIR } else { Join-Path $env:APPDATA 'Code\User\prompts' }

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

function Remove-FileIfPresent {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        return $false
    }

    Remove-Item -LiteralPath $Path -Force
    return $true
}

function Remove-DirectoryIfPresent {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (-not (Test-Path -LiteralPath $Path -PathType Container)) {
        return $false
    }

    Remove-Item -LiteralPath $Path -Recurse -Force
    return $true
}

Write-Host "Removing KIRA files from $KiraHome..."

$agentCount = 0
$skillCount = 0
$promptCount = 0
$instructionCount = 0
$cleanedCount = 0

if (Test-Path -LiteralPath $AgentsDst -PathType Container) {
    if (Test-Path -LiteralPath $AgentsSrc -PathType Container) {
        Get-ChildItem -LiteralPath $AgentsSrc -File -Filter '*.agent.md' |
            ForEach-Object {
                if (Remove-FileIfPresent -Path (Join-Path $AgentsDst $_.Name)) {
                    $agentCount++
                }
            }
    }

    foreach ($legacyAgent in @('kira-aura.agent.md', 'kira-companion.agent.md', 'mila.agent.md')) {
        if (Remove-FileIfPresent -Path (Join-Path $AgentsDst $legacyAgent)) {
            $agentCount++
        }
    }

    @(Get-ChildItem -LiteralPath $AgentsDst -File | Where-Object {
        $_.Name -eq 'kira.agent.md' -or
        $_.Name -like 'kira-*.agent.md'
    }) | ForEach-Object {
        if (Remove-FileIfPresent -Path $_.FullName) {
            $agentCount++
        }
    }
}

if (Test-Path -LiteralPath $SkillsDst -PathType Container) {
    if (Test-Path -LiteralPath $SkillsSrc -PathType Container) {
        Get-ChildItem -LiteralPath $SkillsSrc -Directory |
            ForEach-Object {
                $skillFile = Join-Path $_.FullName 'SKILL.md'
                if ((Test-Path -LiteralPath $skillFile -PathType Leaf) -and (Remove-DirectoryIfPresent -Path (Join-Path $SkillsDst $_.Name))) {
                    $skillCount++
                }
            }
    }

    @(Get-ChildItem -LiteralPath $SkillsDst -Directory | Where-Object {
        $_.Name -like 'kira-*'
    }) | ForEach-Object {
        if (Remove-DirectoryIfPresent -Path $_.FullName) {
            $skillCount++
        }
    }
}

if (Test-Path -LiteralPath $PromptsDst -PathType Container) {
    foreach ($promptName in $PromptCleanupNames) {
        if (Remove-FileIfPresent -Path (Join-Path $PromptsDst $promptName)) {
            $promptCount++
        }
    }

    @(Get-ChildItem -LiteralPath $PromptsDst -File -Filter 'kira-*.prompt.md') | ForEach-Object {
        if (Remove-FileIfPresent -Path $_.FullName) {
            $promptCount++
        }
    }
}

if (Test-Path -LiteralPath $InstructionsDst -PathType Container) {
    if (Test-Path -LiteralPath $InstructionsSrc -PathType Container) {
        Get-ChildItem -LiteralPath $InstructionsSrc -File -Filter '*.instructions.md' |
            ForEach-Object {
                if (Remove-FileIfPresent -Path (Join-Path $InstructionsDst $_.Name)) {
                    $instructionCount++
                }
            }
    }

    @(Get-ChildItem -LiteralPath $InstructionsDst -File -Filter 'kira*.instructions.md') | ForEach-Object {
        if (Remove-FileIfPresent -Path $_.FullName) {
            $instructionCount++
        }
    }
}

foreach ($path in @($AgentsDst, $SkillsDst, $InstructionsDst, $KiraHome)) {
    if (Remove-EmptyDirectory -Path $path) {
        $cleanedCount++
    }
}

Write-Host ''
Write-Host 'KIRA uninstall complete'
Write-Host "  Agents removed  : $agentCount files"
Write-Host "  Skills removed  : $skillCount folders"
Write-Host "  Prompts removed : $promptCount files"
Write-Host "  Instructions removed : $instructionCount files"
Write-Host "  Empty dirs pruned: $cleanedCount"

if (($agentCount + $skillCount + $promptCount + $instructionCount) -eq 0) {
    Write-Host '  No KIRA files or folders were found.'
}