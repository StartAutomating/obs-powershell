function Show-OBS {
    <#
    .SYNOPSIS
        Shows content in OBS
    .DESCRIPTION
        Shows content in Open Broadcasting Studio
    .EXAMPLE
        '<svg viewBox="0 0 1 1" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg">
            <polygon points="0 0 0 1 1 1 1 0" fill="blue" />
        </svg>' | Set-Content .\BlueRect.svg
        Show-OBS -FilePath .\BlueRect.svg
    .EXAMPLE
        Show-OBS -FilePath *excited* -RootPath $home\Pictures\Gif
    #>
    param(    
    # The path or URI to show in OBS.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [Alias('FullName','Src', 'Uri','FileName')]
    [string]
    $FilePath,

    # The name of the source in OBS.
    # If this is not provided, it will be derived from the -FilePath.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Name,

    # A root path.
    # If not provided, this will be the root of the -FilePath (if it is a filepath).
    # If the file path was a URI, the root path will be ignored.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $RootPath,

    # The name of the scene.
    # If no scene name is provided, the current program scene will be used.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Scene,

    # The opacity to use for the input.
    # If not provided, will default to 2/3rds.
    # Will only be used when showing a browser source with a -FilePath
    [Parameter(ValueFromPipelineByPropertyName)]
    [double]
    $Opacity = (2/3),

    # Any parameters to pass to the source command.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Collections.IDictionary]
    $SourceParameter = [ordered]@{},

    # If set, will check if the source exists in the scene before creating it and removing any existing sources found.
    # If not set, you will get an error if a source with the same name exists.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $Force
    )

    process {
        # If we had a -RootPath
        if ($RootPath) {
            # Look in the root path
            $imageFiles = @(Get-ChildItem $RootPath -Recurse -File| 
                # For files like this keyword
                Where-Object FullName -like "*$filePath*" |
                # that are extensions we could show
                Where-Object Extension -in '.html', '.jpg', '.jpeg', '.gif', '.apng', '.png'
            )
            if ($imageFiles.Count) {
                $FilePath = ($imageFiles | Get-Random).FullName
            }                        
        }



        # Determine if the thing we are showing will be a ffmpeg source.
        $IsMediaSource = 
            # If it's an http path, it's not
            if ($FilePath -like 'http*') {
                $false
            } elseif (
                # If it's an HTML-friendly path, it's not
                $FilePath -match '.(?>html?|gif|jpe?g|a?png|svg)$'
            ) {
                $false
            } else {
                # Otherwise, let's give it a try.
                $true
            }

        if (-not $RootPath -and $filePath -notlike 'http*') {
            $RootPath = "$($FilePath | Split-Path)"
        }

        # If we provided a scene
        if ($Scene) {
            # pass it down.
            $SourceParameter.Scene = $Scene
        }

        # If we want to use -Force
        if ($Force) {
            # pass it down
            $SourceParameter.Force = $Force
        }

        if (-not $IsMediaSource) {
            # Create a browser source
            $SourceParameter.Uri = $FilePath
            if ($RootPath -and $FilePath -notmatch '\.html{0,1}$') {
                # Make a minimal frame in a .html file
                $relativePath = $FilePath.Substring($RootPath.Length + 1)
                $htmlFrame = "<html>
                <body style='width:100%;height:100%'>
                <img src='$relativePath' style='width:100%;height:100%' />'
                <body>
                </html>"
                
                $leafPath = $filePath | Split-Path -Leaf
                $htmlPath = Join-Path $RootPath "$($leafPath).html"

                $htmlFrame | Set-Content -Path $htmlPath
                # And set up the CSS for that frame.
                $css = "
                body { 
                    background-color: rgba(0, 0, 0, 0); margin: 0px auto; overflow: hidden;                    
                }
                img {
                    width: 100%
                    height: 100%;
                    opacity: $opacity;
                }
                "
                $SourceParameter.Uri = $htmlPath
                $SourceParameter.CSS = $css
                Add-OBSBrowserSource @SourceParameter    
            } else {
                Add-OBSBrowserSource @SourceParameter    
            }

        } else {
            $SourceParameter.FilePath = $FilePath
            Add-OBSMediaSource @SourceParameter
        }
    }
}