Set-OBSMarkdownSource
---------------------

### Synopsis
Sets a markdown source

---

### Description

Adds or changes a markdown source in OBS.

---

### Parameters
#### **Markdown**
The markdown text, or the path to a markdown file

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **Width**
The width of the browser source.    
If none is provided, this will be the output width of the video settings.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |2       |true (ByPropertyName)|

#### **Height**
The width of the browser source.    
If none is provided, this will be the output height of the video settings.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |3       |true (ByPropertyName)|

#### **CSS**
The css style used to render the markdown.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |4       |true (ByPropertyName)|

#### **Scene**
The name of the scene.    
If no scene name is provided, the current program scene will be used.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |5       |true (ByPropertyName)|

#### **Name**
The name of the input.    
If no name is provided, the last segment of the URI or file path will be the input name.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |6       |true (ByPropertyName)|

#### **Force**
If set, will check if the source exists in the scene before creating it and removing any existing sources found.    
If not set, you will get an error if a source with the same name exists.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

---

### Syntax
```PowerShell
Set-OBSMarkdownSource [[-Markdown] <String>] [[-Width] <Int32>] [[-Height] <Int32>] [[-CSS] <String>] [[-Scene] <String>] [[-Name] <String>] [-Force] [<CommonParameters>]
```
