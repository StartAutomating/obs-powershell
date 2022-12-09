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
#### **inputName**

Name of the input



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **propertyName**

Name of the button property to press



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Send-OBSPressInputPropertiesButton [-inputName] <String> [-propertyName] <String> [<CommonParameters>]
```
---
