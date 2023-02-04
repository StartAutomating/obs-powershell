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






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |1       |true (ByPropertyName)|



---
#### **FpsDenominator**

Denominator of the fractional FPS value






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |2       |true (ByPropertyName)|



---
#### **BaseWidth**

Width of the base (canvas) resolution in pixels






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |3       |true (ByPropertyName)|



---
#### **BaseHeight**

Height of the base (canvas) resolution in pixels






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |4       |true (ByPropertyName)|



---
#### **OutputWidth**

Width of the output resolution in pixels






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |5       |true (ByPropertyName)|



---
#### **OutputHeight**

Height of the output resolution in pixels






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |6       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Set-OBSVideoSettings [[-FpsNumerator] <Double>] [[-FpsDenominator] <Double>] [[-BaseWidth] <Double>] [[-BaseHeight] <Double>] [[-OutputWidth] <Double>] [[-OutputHeight] <Double>] [-PassThru] [<CommonParameters>]
```
---
