#requires -Module PSSVG

$obsLogoSvg = irm https://upload.wikimedia.org/wikipedia/commons/d/d3/OBS_Studio_Logo.svg
$powerShellChevron = irm https://pssvg.start-automating.com/Examples/PowerShellChevron.svg

$assetsPath = Join-Path $PSScriptRoot Assets

if (-not (Test-Path $assetsPath)) {
    $null = New-Item -ItemType Directory -Path $assetsPath
}

=<svg> @(
    =<svg.symbol> -ViewBox $obsLogoSvg.svg.viewBox -Content $obsLogoSvg.svg.InnerXml -Id 'obslogo'    
    =<svg.symbol> -ViewBox $powerShellChevron.svg.viewBox -Content $powerShellChevron.svg.InnerXml -Id 'pschevron'
    =<svg.symbol> -ViewBox 1000, 1000 -Content @(
        =<svg.use> -Href '#obslogo'
        =<svg.use> -Href '#psChevron' -Fill 'white' -Height 33% -Y 7.5%
        =<svg.use> -Href '#psChevron' -Fill 'white' -Height 33% -X -25% -Y 45%
        =<svg.use> -Href '#psChevron' -Fill 'white' -Height 33% -X 25% -Y 45%
    ) -Id 'obspowershell'        
    =<svg.use> -Href 'obspowershell' 
) -ViewBox 1000,1000 -OutputPath (Join-Path $assetsPath obs-powershell.svg)