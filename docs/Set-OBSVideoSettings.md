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
#### **fpsNumerator**

Numerator of the fractional FPS value



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **fpsDenominator**

Denominator of the fractional FPS value



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **baseWidth**

Width of the base (canvas) resolution in pixels



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **baseHeight**

Height of the base (canvas) resolution in pixels



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
#### **outputWidth**

Width of the output resolution in pixels



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 5

> **PipelineInput**:true (ByPropertyName)



---
#### **outputHeight**

Height of the output resolution in pixels



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 6

> **PipelineInput**:true (ByPropertyName)



---
#### **PassThru**

> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Set-OBSVideoSettings [[-fpsNumerator] <Double>] [[-fpsDenominator] <Double>] [[-baseWidth] <Double>] [[-baseHeight] <Double>] [[-outputWidth] <Double>] [[-outputHeight] <Double>] [-PassThru] [<CommonParameters>]
```
---
