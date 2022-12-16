#requires -Module PSSVG

$powerShellChevron = Invoke-RestMethod https://pssvg.start-automating.com/Examples/PowerShellChevron.svg

$assetsPath = Join-Path $PSScriptRoot Assets

if (-not (Test-Path $assetsPath)) {
    $null = New-Item -ItemType Directory -Path $assetsPath
}

=<svg> @(    
    =<svg.symbol> -ViewBox $powerShellChevron.svg.viewBox -Content $powerShellChevron.svg.symbol.InnerXml -Id psChevron
    =<svg.symbol> -ViewBox 500, 250 -Content @(
        =<svg.circle> -Cx 50% -Cy 50% -R 10% -Fill '#4488ff'
        =<svg.circle> -Cx 50% -Cy 50% -R 9.5% -Fill 'white'
        =<svg.circle> -Cx 50% -Cy 50% -R 9% -Fill '#4488ff'        
        =<svg.use> -Href '#psChevron' -Fill 'white' -Height 20% -Y 40% -X 0%
    ) -Id 'combinedLogo'        
    =<svg.use> -Href '#combinedLogo'    
    =<svg.text> -Content "OBS" -Fill '#4488ff' -TextAnchor 'end' -X 40% -y 50% -FontSize 72 -AlignmentBaseline 'middle' -FontFamily 'sans-serif'
    =<svg.text> -Content "PowerShell" -Fill '#4488ff' -TextAnchor 'start' -X 60% -y 50% -FontSize 72 -AlignmentBaseline 'middle' -FontFamily 'sans-serif'
) -ViewBox 1000,1000 -OutputPath (Join-Path $assetsPath obs-powershell.svg)