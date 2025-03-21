
#requires -Module PSDevOps
#requires -Module obs-powershell
Import-BuildStep -SourcePath (
    Join-Path $PSScriptRoot 'GitHub'
) -BuildSystem GitHubWorkflow

Push-Location ($PSScriptRoot | Split-Path)

New-GitHubWorkflow -Job PowerShellStaticAnalysis, TestPowerShellOnLinux, TagReleaseAndPublish, BuildOBSPowerShell -OutputPath @'
.\.github\workflows\build-obs-powershell.yml
'@ -Name "Build, Test, and Release obs-powershell" -On Push, PullRequest

Pop-Location

