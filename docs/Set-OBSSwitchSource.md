Set-OBSSwitchSource
-------------------

### Synopsis
Adds a VLC playlist source

---

### Description

Adds or sets VLC playlist sources to OBS.    
VLC must be installed for this to work.

---

### Related Links
* [Add-OBSInput](Add-OBSInput.md)

* [Set-OBSInputSettings](Set-OBSInputSettings.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Set-OBSVLCSource -FilePath .\*.mp3 # Creates a playlist of all MP3s in the current directory
```

---

### Parameters
#### **SourceList**
The path to the media file.

|Type        |Required|Position|PipelineInput        |Aliases|
|------------|--------|--------|---------------------|-------|
|`[String[]]`|false   |1       |true (ByPropertyName)|Sources|

#### **Select**
What to select in the playlist.    
If a number is provided, this will select an index.    
If a string is provided, this will select the whole name or last part of a name, accepting wildcards.

|Type      |Required|Position|PipelineInput        |Aliases                   |
|----------|--------|--------|---------------------|--------------------------|
|`[Object]`|false   |2       |true (ByPropertyName)|SelectIndex<br/>SelectName|

#### **Loop**
If set, the list of sources will loop.

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[Switch]`|false   |named   |true (ByPropertyName)|Looping|

#### **TimeSwitch**
If set, will switch between sources.    
Sources will be displayed for a -Duration.    
No source wil be displayed for an -Interval.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **Interval**
The interval between sources

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[TimeSpan]`|false   |3       |true (ByPropertyName)|

#### **Duration**
The duration between sources that are switching at a time.

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[TimeSpan]`|false   |4       |true (ByPropertyName)|

#### **TimeSwitchTo**
The item that will be switched in a TimeSwitch, after -Duration and -Interval.
Valid Values:

* None
* Next
* Previous
* First
* Last
* Random

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |5       |true (ByPropertyName)|

#### **MediaStateSwitch**
If set, will switch on the underlying source's media state events.    
Sources will be displayed for a -Duration.    
No source wil be displayed for an -Interval.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **MediaStateChange**
The change in media state that should trigger a switch
Valid Values:

* Playing
* Opening
* Buffering
* Paused
* Stopped
* Ended
* Error
* Playing
* NotOpening
* NotBuffering
* NotPaused
* NotStopped
* NotEnded
* NotError

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Object]`|false   |6       |true (ByPropertyName)|

#### **MediaSwitchTo**
When the source switcher is trigger by media end, this determines the next source that will be switched to.
Valid Values:

* None
* Next
* Previous
* First
* Last
* Random

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |7       |true (ByPropertyName)|

#### **TransitionName**
The name of the transition between sources.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |8       |true (ByPropertyName)|

#### **TransitionProperty**
The properties sent to the transition.    
Notice: this current requires confirmation in the UI.

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|false   |9       |true (ByPropertyName)|

#### **ShowTransition**
The name of the transition used to show a source.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |10      |true (ByPropertyName)|

#### **ShowTransitionProperty**
The properties sent to the show transition.    
Notice: this current requires confirmation in the UI.

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|false   |11      |true (ByPropertyName)|

#### **HideTransition**
The transition used to hide a source.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |12      |true (ByPropertyName)|

#### **HideTransitionProperty**
The properties sent to the hide transition.    
Notice: this current requires confirmation in the UI.

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|false   |13      |true (ByPropertyName)|

#### **Scene**
The name of the scene.    
If no scene name is provided, the current program scene will be used.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |14      |true (ByPropertyName)|

#### **Name**
The name of the input.    
If no name is provided, the last segment of the URI or file path will be the input name.

|Type      |Required|Position|PipelineInput        |Aliases                 |
|----------|--------|--------|---------------------|------------------------|
|`[String]`|false   |15      |true (ByPropertyName)|InputName<br/>SourceName|

#### **Force**
If set, will check if the source exists in the scene before creating it and removing any existing sources found.    
If not set, you will get an error if a source with the same name exists.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **FitToScreen**
If set, will fit the input to the screen.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

---

### Syntax
```PowerShell
Set-OBSSwitchSource [[-SourceList] <String[]>] [[-Select] <Object>] [-Loop] [-TimeSwitch] [[-Interval] <TimeSpan>] [[-Duration] <TimeSpan>] [[-TimeSwitchTo] <String>] [-MediaStateSwitch] [[-MediaStateChange] <Object>] [[-MediaSwitchTo] <String>] [[-TransitionName] <String>] [[-TransitionProperty] <PSObject>] [[-ShowTransition] <String>] [[-ShowTransitionProperty] <PSObject>] [[-HideTransition] <String>] [[-HideTransitionProperty] <PSObject>] [[-Scene] <String>] [[-Name] <String>] [-Force] [-FitToScreen] [<CommonParameters>]
```
