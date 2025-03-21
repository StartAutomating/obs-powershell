Set-OBSMediaInputCursor
-----------------------

### Synopsis
Set-OBSMediaInputCursor : SetMediaInputCursor

---

### Description

Sets the cursor position of a media input.

This request does not perform bounds checking of the cursor position.

Set-OBSMediaInputCursor calls the OBS WebSocket with a request of type SetMediaInputCursor.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setmediainputcursor](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setmediainputcursor)

---

### Parameters
#### **InputName**
Name of the media input

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **InputUuid**
UUID of the media input

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **MediaCursor**
New cursor position to set

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|true    |3       |true (ByPropertyName)|

#### **PassThru**
If set, will return the information that would otherwise be sent to OBS.

|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputRequest<br/>OutputInput|

#### **NoResponse**
If set, will not attempt to receive a response from OBS.
This can increase performance, and also silently ignore critical errors

|Type      |Required|Position|PipelineInput        |Aliases                                                                |
|----------|--------|--------|---------------------|-----------------------------------------------------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|NoReceive<br/>IgnoreResponse<br/>IgnoreReceive<br/>DoNotReceiveResponse|

---

### Syntax
```PowerShell
Set-OBSMediaInputCursor [[-InputName] <String>] [[-InputUuid] <String>] [-MediaCursor] <Double> [-PassThru] [-NoResponse] [<CommonParameters>]
```
