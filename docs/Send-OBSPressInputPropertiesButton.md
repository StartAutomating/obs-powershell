Send-OBSPressInputPropertiesButton
----------------------------------
### Synopsis
Send-OBSPressInputPropertiesButton : PressInputPropertiesButton

---
### Description

Presses a button in the properties of an input.

Some known `propertyName` values are:

- `refreshnocache` - Browser source reload button

Note: Use this in cases where there is a button in the properties of an input that cannot be accessed in any other way. For example, browser sources, where there is a refresh button.


Send-OBSPressInputPropertiesButton calls the OBS WebSocket with a request of type PressInputPropertiesButton.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#pressinputpropertiesbutton](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#pressinputpropertiesbutton)



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

Name of the button property to press



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
Send-OBSPressInputPropertiesButton [-InputName] <String> [-PropertyName] <String> [-PassThru] [<CommonParameters>]
```
---
