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
$OpenCodeSrc = Join-Path $ScriptRoot 'opencode'

# No hard-coded legacy prompt names. Uninstall will remove files that match
# the names present in the repository source directories to avoid brittle
# pattern-based deletions.

$KiraHome = if ($env:KIRA_HOME) { $env:KIRA_HOME } else { Join-Path $env:USERPROFILE '.copilot' }
$AgentsDst = Join-Path $KiraHome 'agents'
$SkillsDst = Join-Path $KiraHome 'skills'
$InstructionsDst = Join-Path $KiraHome 'instructions'
$OpenCodeHome = if ($env:OPENCODE_HOME) { $env:OPENCODE_HOME } else { Join-Path $env:USERPROFILE '.config\opencode' }
$OpenCodeCommandsDst = Join-Path $OpenCodeHome 'commands'
$OpenCodeAgentsDst = Join-Path $OpenCodeHome 'agents'

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
$openCodeCommandCount = 0
$openCodeAgentCount = 0
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
}

if (Test-Path -LiteralPath $PromptsDst -PathType Container) {
    # Remove prompt files that were copied from the repository prompts folder.
    if (Test-Path -LiteralPath $PromptsSrc -PathType Container) {
        Get-ChildItem -LiteralPath $PromptsSrc -File -Filter '*.prompt.md' |
            ForEach-Object {
                if (Remove-FileIfPresent -Path (Join-Path $PromptsDst $_.Name)) {
                    $promptCount++
                }
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
}

$openCodeCommandsSrc = Join-Path $OpenCodeSrc 'commands'
if (Test-Path -LiteralPath $OpenCodeCommandsDst -PathType Container -and Test-Path -LiteralPath $openCodeCommandsSrc -PathType Container) {
    Get-ChildItem -LiteralPath $openCodeCommandsSrc -File -Filter '*.md' |
        ForEach-Object {
            if (Remove-FileIfPresent -Path (Join-Path $OpenCodeCommandsDst $_.Name)) {
                $openCodeCommandCount++
            }
        }
}

$openCodeAgentsSrc = Join-Path $OpenCodeSrc 'agents'
if (Test-Path -LiteralPath $OpenCodeAgentsDst -PathType Container -and Test-Path -LiteralPath $openCodeAgentsSrc -PathType Container) {
    Get-ChildItem -LiteralPath $openCodeAgentsSrc -File -Filter '*.md' |
        ForEach-Object {
            if (Remove-FileIfPresent -Path (Join-Path $OpenCodeAgentsDst $_.Name)) {
                $openCodeAgentCount++
            }
        }
}

foreach ($path in @($AgentsDst, $SkillsDst, $InstructionsDst, $KiraHome, $OpenCodeCommandsDst, $OpenCodeAgentsDst, $OpenCodeHome)) {
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
Write-Host "  OpenCode commands removed : $openCodeCommandCount files"
Write-Host "  OpenCode agents removed   : $openCodeAgentCount files"
Write-Host "  Empty dirs pruned: $cleanedCount"

if (($agentCount + $skillCount + $promptCount + $instructionCount + $openCodeCommandCount + $openCodeAgentCount) -eq 0) {
    Write-Host '  No KIRA files or folders were found.'
}
