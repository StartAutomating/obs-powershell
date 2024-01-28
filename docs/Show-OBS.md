Show-OBS
--------

### Synopsis
Shows content in OBS

---

### Description

Shows content in Open Broadcasting Studio

---

### Examples
> EXAMPLE 1

<polygon points="0 0 0 1 1 1 1 0" fill="blue" />
</svg>' | Set-Content .\BlueRect.svg
Show-OBS -FilePath .\BlueRect.svg
> EXAMPLE 2

```PowerShell
Show-OBS -FilePath *excited* -RootPath $home\Pictures\Gif
```

---

### Parameters
#### **FilePath**
The path or URI to show in OBS.

|Type      |Required|Position|PipelineInput        |Aliases                              |
|----------|--------|--------|---------------------|-------------------------------------|
|`[String]`|true    |1       |true (ByPropertyName)|FullName<br/>Src<br/>Uri<br/>FileName|

#### **Name**
The name of the source in OBS.
If this is not provided, it will be derived from the -FilePath.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **RootPath**
A root path.
If not provided, this will be the root of the -FilePath (if it is a filepath).
If the file path was a URI, the root path will be ignored.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |3       |true (ByPropertyName)|

#### **Scene**
The name of the scene.
If no scene name is provided, the current program scene will be used.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |4       |true (ByPropertyName)|

#### **Opacity**
The opacity to use for the input.
If not provided, will default to 2/3rds.
Will only be used when showing a browser source with a -FilePath

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |5       |true (ByPropertyName)|

#### **SourceParameter**
Any parameters to pass to the source command.

|Type           |Required|Position|PipelineInput        |
|---------------|--------|--------|---------------------|
|`[IDictionary]`|false   |6       |true (ByPropertyName)|

#### **Force**
If set, will check if the source exists in the scene before creating it and removing any existing sources found.
If not set, you will get an error if a source with the same name exists.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **FitToScreen**
If set, will make the input become the size of the screen.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

---

### Syntax
```PowerShell
Show-OBS [-FilePath] <String> [[-Name] <String>] [[-RootPath] <String>] [[-Scene] <String>] [[-Opacity] <Double>] [[-SourceParameter] <IDictionary>] [-Force] [-FitToScreen] [<CommonParameters>]
```
