Start-OBS
---------

### Synopsis
Start OBS

---

### Description

Starts OBS

Without any parameters, will attempt to start the obs process.

If OBS is already running, will output the current obs process.

* If `-Recording` is passed, will start recording
* If `-Streaming` is passed, will start streaming
* If `-StudioMode` is passed, will start studio mode
* If `-VirtualCamera` is passed, will start the virtual camera

If additional arguments are passed, will pass them thru to a new obs process.

---

### Related Links
* [Stop-OBS](Stop-OBS.md)

* [Start-OBSRecord](Start-OBSRecord.md)

* [Start-OBSStream](Start-OBSStream.md)

* [Start-OBSVirtualCam](Start-OBSVirtualCam.md)

---

### Parameters
#### **ArgumentList**
A list of arguments.  These will be passed to a new obs process.

|Type          |Required|Position|PipelineInput|Aliases                        |
|--------------|--------|--------|-------------|-------------------------------|
|`[PSObject[]]`|false   |named   |false        |Arguments<br/>Argument<br/>Args|

#### **InputObject**
Any input object.  This will currently be ignored.

|Type          |Required|Position|PipelineInput |
|--------------|--------|--------|--------------|
|`[PSObject[]]`|false   |named   |true (ByValue)|

#### **Recording**
If set, will start recording.

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[Switch]`|false   |named   |false        |Record |

#### **Streaming**
If set, will start streaming.

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[Switch]`|false   |named   |false        |Stream |

#### **StudioMode**
If set, will start studio mode.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **VirtualCamera**
If set, will start the virtual camera

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[Switch]`|false   |named   |false        |VirtualCam|

#### **WhatIf**
-WhatIf is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-WhatIf is used to see what would happen, or return operations without executing them
#### **Confirm**
-Confirm is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-Confirm is used to -Confirm each operation.

If you pass ```-Confirm:$false``` you will not be prompted.

If the command sets a ```[ConfirmImpact("Medium")]``` which is lower than ```$confirmImpactPreference```, you will not be prompted unless -Confirm is passed.

---

### Syntax
```PowerShell
Start-OBS [-ArgumentList <PSObject[]>] [-InputObject <PSObject[]>] [-Recording] [-Streaming] [-StudioMode] [-VirtualCamera] [-WhatIf] [-Confirm] [<CommonParameters>]
```
