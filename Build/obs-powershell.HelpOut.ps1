#requires -Module HelpOut
Push-Location ($PSScriptRoot | Split-Path)
Import-Module .\obs-powershell.psd1
Save-MarkdownHelp -Module obs-powershell -PassThru
Install-Maml -Module obs-powershell -PassThru -NoComment
Pop-Location
