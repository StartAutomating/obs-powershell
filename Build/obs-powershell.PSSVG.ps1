#requires -Module PSSVG

$powerShellChevron = Invoke-RestMethod https://pssvg.start-automating.com/Examples/PowerShellChevron.svg

$assetsPath = Join-Path ($PSScriptRoot | Split-Path) Assets

if (-not (Test-Path $assetsPath)) {
    $null = New-Item -ItemType Directory -Path $assetsPath
}

svg @(    
    svg.symbol -ViewBox $powerShellChevron.svg.viewBox -Content $powerShellChevron.svg.symbol.InnerXml -Id psChevron

    svg.symbol -ViewBox 500, 250 -Content @(
        svg.circle -Cx 50% -Cy 50% -R 10% -Fill '#4488ff'
        svg.circle -Cx 50% -Cy 50% -R 9.5% -Fill 'white'
        svg.circle -Cx 50% -Cy 50% -R 9% -Fill '#4488ff'        
        svg.use -Href '#psChevron' -Fill 'black' -Height 20% -Y 40% -X 0% -Transform "rotate(30)"
    ) -Id 'combinedLogo'
    SVG.mask -Id "psChevronMask" -Content @(
        SVG.rect -X 400 -Y 400 -Height 200 -Width 200 -Fill white
        SVG.circle -Cx 500 -Cy 500 -R 90 -Fill black
    
        svg.use -Href '#psChevron' -Fill 'white' -Height 75 -Y 42.5% -X 0 -Transform "rotate(0, 500, 500)" 
        svg.use -Href '#psChevron' -Fill 'white' -Height 75 -Y 42.5% -X 0 -Transform "rotate(120, 500, 500)"
        svg.use -Href '#psChevron' -Fill 'white' -Height 75 -Y 42.5% -X 0 -Transform "rotate(240, 500, 500)"        
    ) 
    
    SVG.circle -Fill '#4488ff' -Cx 500 -Cy 500 -R 100  -Mask 'url(#psChevronMask)' @(
        svg.animatetransform -AttributeName transform -From "0 500 500"  -To "360 500 500" -dur "5s" -RepeatCount indefinite -AttributeType xml -type rotate
    )
    svg.text -Content "obs-powershell" -Fill '#4488ff' -TextAnchor 'middle' -X 50% -y 65% -FontSize 72 -AlignmentBaseline 'middle' -FontFamily 'sans-serif'
) -ViewBox 1000,1000 -OutputPath (Join-Path $assetsPath obs-powershell.svg)

foreach ($variant in 'icon','animated-icon','text-and-animated-icon','text-and-icon') {

    svg @(
        svg.symbol -ViewBox $powerShellChevron.svg.viewBox -Content $powerShellChevron.svg.symbol.InnerXml -Id psChevron
        
        SVG.mask -Id "psChevronMask" -Content @(
            SVG.rect -X 150 -Y 150 -Height 200 -Width 200 -Fill white
            SVG.circle -Cx 250 -Cy 250 -R 90 -Fill black
        
            svg.use -Href '#psChevron' -Fill 'white' -Height 75 -Y 35% -X 0 -Transform "rotate(0, 250, 250)" 
            svg.use -Href '#psChevron' -Fill 'white' -Height 75 -Y 35% -X 0 -Transform "rotate(120, 250, 250)"
            svg.use -Href '#psChevron' -Fill 'white' -Height 75 -Y 35% -X 0 -Transform "rotate(240, 250, 250)"        
        ) 
        
        SVG.circle -Fill '#4488ff' -Cx 250 -Cy 250 -R 100  -Mask 'url(#psChevronMask)' @(
            if ($variant -like '*animated*') {
                svg.animatetransform -AttributeName transform -From "0 250 250"  -To "360 250 250" -dur "5s" -RepeatCount indefinite -AttributeType xml -type rotate
            }
        )
        if ($variant -like '*text*') {
            svg.text -Content "obs-powershell" -Fill '#4488ff' -TextAnchor 'middle' -X 50% -y 75% -FontSize 1.75em -AlignmentBaseline 'middle' -FontFamily 'sans-serif'
        }
    ) -ViewBox 500,500 -OutputPath (Join-Path $assetsPath "obs-powershell-$variant.svg")
}