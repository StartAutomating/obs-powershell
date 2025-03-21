Set-OBSColorSource
------------------

### Synopsis
Adds a color source

---

### Description

Adds a color source to OBS.  This displays a single 32-bit color (RGBA).

---

### Related Links
* [Add-OBSInput](Add-OBSInput.md)

* [Set-OBSInputSettings](Set-OBSInputSettings.md)

---

### Parameters
#### **Scene**
The name of the scene.    
If no scene name is provided, the current program scene will be used.

|Type      |Required|Position|PipelineInput        |Aliases  |
|----------|--------|--------|---------------------|---------|
|`[String]`|false   |1       |true (ByPropertyName)|SceneName|

#### **Name**
The name of the input.    
If no name is provided, "Display $($Monitor + 1)" will be the input source name.

|Type      |Required|Position|PipelineInput        |Aliases  |
|----------|--------|--------|---------------------|---------|
|`[String]`|false   |2       |true (ByPropertyName)|InputName|

#### **Color**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |3       |true (ByPropertyName)|

#### **Force**
If set, will check if the source exists in the scene before creating it and removing any existing sources found.    
If not set, you will get an error if a source with the same name exists.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

---

### Syntax
```PowerShell
Set-OBSColorSource [[-Scene] <String>] [[-Name] <String>] [[-Color] <String>] [-Force] [<CommonParameters>]
```
