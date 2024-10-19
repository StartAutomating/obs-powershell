
#requires -Module PSDevOps
#requires -Module obs-powershell

Import-BuildStep -Module obs-powershell

Push-Location $PSScriptRoot

New-GitHubWorkflow -Job PowerShellStaticAnalysis, TestPowerShellOnLinux, TagReleaseAndPublish, BuildOBSPowerShell -OutputPath @'
.\.github\workflows\build-obs-powershell.yml
'@ -Name "Build, Test, and Release obs-powershell" -On Push, PullRequest

Pop-Location

