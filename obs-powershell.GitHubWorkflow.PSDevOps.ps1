
#requires -Module PSDevOps
#requires -Module obs-powershell
#requires -Module GitPub

Import-BuildStep -Module obs-powershell

Push-Location $PSScriptRoot

New-GitHubWorkflow -Job PowerShellStaticAnalysis, TestPowerShellOnLinux, TagReleaseAndPublish, BuildOBSPowerShell -OutputPath @'
.\.github\workflows\build-obs-powershell.yml
'@ -Name "Build, Test, and Release obs-powershell" -On Push, PullRequest

Import-BuildStep -ModuleName GitPub

New-GitHubWorkflow -On Issue, Demand -Job RunGitPub -Name GitPub -OutputPath @'
.\.github\workflows\GitPub.yml
'@

Pop-Location

