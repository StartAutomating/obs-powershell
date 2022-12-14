Set-OBSVideoSettings
--------------------
### Synopsis
Set-OBSVideoSettings : SetVideoSettings

---
### Description

Sets the current video settings.

Note: Fields must be specified in pairs. For example, you cannot set only `baseWidth` without needing to specify `baseHeight`.


Set-OBSVideoSettings calls the OBS WebSocket with a request of type SetVideoSettings.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setvideosettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setvideosettings)



---
### Parameters
#### **FpsNumerator**

Numerator of the fractional FPS value



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **FpsDenominator**

Denominator of the fractional FPS value



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **BaseWidth**

Width of the base (canvas) resolution in pixels



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **BaseHeight**

Height of the base (canvas) resolution in pixels



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
#### **OutputWidth**

Width of the output resolution in pixels



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 5

> **PipelineInput**:true (ByPropertyName)



---
#### **OutputHeight**

Height of the output resolution in pixels



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 6

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
Set-OBSVideoSettings [[-FpsNumerator] <Double>] [[-FpsDenominator] <Double>] [[-BaseWidth] <Double>] [[-BaseHeight] <Double>] [[-OutputWidth] <Double>] [[-OutputHeight] <Double>] [-PassThru] [<CommonParameters>]
```
---
