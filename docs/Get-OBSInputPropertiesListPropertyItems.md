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



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **PropertyName**

Name of the list property to get the items of



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Get-OBSInputPropertiesListPropertyItems [-InputName] <String> [-PropertyName] <String> [-PassThru] [<CommonParameters>]
```
---
