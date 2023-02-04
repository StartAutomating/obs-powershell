Get-OBSInputPropertiesListPropertyItems
---------------------------------------
### Synopsis
Get-OBSInputPropertiesListPropertyItems : GetInputPropertiesListPropertyItems

---
### Description

Gets the items of a list property from an input's properties.

Note: Use this in cases where an input provides a dynamic, selectable list of items. For example, display capture, where it provides a list of available displays.


Get-OBSInputPropertiesListPropertyItems calls the OBS WebSocket with a request of type GetInputPropertiesListPropertyItems.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputpropertieslistpropertyitems](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputpropertieslistpropertyitems)



---
### Parameters
#### **InputName**

Name of the input






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **PropertyName**

Name of the list property to get the items of






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |2       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Get-OBSInputPropertiesListPropertyItems [-InputName] <String> [-PropertyName] <String> [-PassThru] [<CommonParameters>]
```
---
