<#
.SYNOPSIS
    Gets an input's scene items
.DESCRIPTION
    Gets the scene items associated with an input.
#>
Get-obsscene | 
    Select-Object -ExpandProperty Scenes | 
    Get-OBSSceneItem |    
    Where-Object SourceName -EQ $this.InputName |
    Where-Object InputKind -EQ $this.InputKind