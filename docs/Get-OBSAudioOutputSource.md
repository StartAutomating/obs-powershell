Set-OBSAudioOutputSource
------------------------

### Synopsis
Adds or sets an audio output source

---

### Description

Adds or sets an audio output source in OBS.  This captures the audio that is being sent to an output device.

---

### Examples
> EXAMPLE 1

```PowerShell
Add-OBSAudioOutputSource
```
> EXAMPLE 2

```PowerShell
Set-OBSAudioOutputSource -AudioDevice Speakers
```

---

### Parameters
#### **AudioDevice**
The name of the audio device.    
This name or device ID of the audio device that should be captured.

|Type      |Required|Position|PipelineInput        |Aliases                            |
|----------|--------|--------|---------------------|-----------------------------------|
|`[String]`|false   |1       |true (ByPropertyName)|ItemValue<br/>ItemName<br/>DeviceID|

#### **Scene**
The name of the scene.    
If no scene name is provided, the current program scene will be used.

|Type      |Required|Position|PipelineInput        |Aliases  |
|----------|--------|--------|---------------------|---------|
|`[String]`|false   |2       |true (ByPropertyName)|SceneName|

#### **Name**
The name of the input.    
If no name is provided, "AudioOutput$($AudioDevice)" will be the input source name.

|Type      |Required|Position|PipelineInput        |Aliases                 |
|----------|--------|--------|---------------------|------------------------|
|`[String]`|false   |3       |true (ByPropertyName)|InputName<br/>SourceName|

#### **Force**
If set, will check if the source exists in the scene before creating it and removing any existing sources found.    
If not set, you will get an error if a source with the same name exists.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

---

### Notes
This command currently only supports capturing default audio on Windows.    
To add support for other operating systems, file an issue or open a pull request.

---

### Syntax
```PowerShell
Set-OBSAudioOutputSource [[-AudioDevice] <String>] [[-Scene] <String>] [[-Name] <String>] [-Force] [<CommonParameters>]
```
