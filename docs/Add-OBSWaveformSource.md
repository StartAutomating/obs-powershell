Set-OBSWaveformSource
---------------------

### Synopsis
OBS Waveform Source

---

### Description

Gets, Sets, or Adds a waveform source in OBS.    
Waveform sources require the [Waveform Plugin](https://obsproject.com/forum/resources/waveform.1423/)

---

### Examples
> EXAMPLE 1

```PowerShell
Add-OBSWaveformSource -Name "SpeakerWaveform"
```

---

### Parameters
#### **Width**
The width of the browser source.    
If none is provided, this will be the output width of the video settings.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |1       |true (ByPropertyName)|

#### **Height**
The width of the browser source.    
If none is provided, this will be the output height of the video settings.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |2       |true (ByPropertyName)|

#### **AudioSource**
The audio source for the waveform.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |3       |true (ByPropertyName)|

#### **DisplayMode**
The display mode for the waveform.
Valid Values:

* curve
* bars
* stepped_bars
* level_meter
* stepped_level_meter

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |4       |true (ByPropertyName)|

#### **RenderMode**
The render mode for the waveform.
Valid Values:

* line
* solid
* gradient

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |5       |true (ByPropertyName)|

#### **WindowMode**
The windowing mode for the waveform.    
This is the mathematical function used to determine the current "window" of audio data.
Valid Values:

* hann
* hamming
* blackman
* blackman_harris
* none

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |6       |true (ByPropertyName)|

#### **Color**
The color used for the waveform.

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|false   |7       |true (ByPropertyName)|

#### **CrestColor**
The crest color used for the waveform.    
This will be ignored if the render mode is not "gradient".

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|false   |8       |true (ByPropertyName)|

#### **ChannelMode**
The channel mode for the waveform.    
This can be either mono or stereo.
Valid Values:

* mono
* stereo

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |9       |true (ByPropertyName)|

#### **ChannelSpacing**
The number of pixels between each channel in stereo mode

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |10      |true (ByPropertyName)|

#### **RadialLayout**
If set, will use a radial layout for the waveform    
Radial layouts will ignore the desired height of the source and instead create a square.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **InvertRadialDirection**
If set, will invert the direction for a radial waveform.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **NoramlizeVolume**
If set, will normalize the volume displayed in the waveform.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **AutoFftSize**
If set, will automatically declare an FFTSize

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **FastPeak**
If set, will attempt to make audio peaks render faster.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **BarWidth**
The width of the waveform bar.    
This is only valid when -DisplayMode is 'bars' or 'stepped_bars'

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |11      |true (ByPropertyName)|

#### **BarGap**
The gap between waveform bars.    
This is only valid when -DisplayMode is 'bars' or 'stepped_bars'

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |12      |true (ByPropertyName)|

#### **StepWidth**
The width of waveform bar step.    
This is only valid when -DisplayMode is 'stepped_bars'

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |13      |true (ByPropertyName)|

#### **StepGap**
The gap between waveform bar steps.    
This is only valid when -DisplayMode is 'stepped_bars'

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |14      |true (ByPropertyName)|

#### **LowCutoff**
The low-frequency cutoff of the waveform.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |15      |true (ByPropertyName)|

#### **HighCutoff**
The high-frequency cutoff of the waveform.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |16      |true (ByPropertyName)|

#### **Floor**
The floor of the waveform.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |17      |true (ByPropertyName)|

#### **Ceiling**
The ceiling of the waveform.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |18      |true (ByPropertyName)|

#### **Slope**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |19      |true (ByPropertyName)|

#### **RollOffOctave**

|Type      |Required|Position|PipelineInput        |Aliases       |
|----------|--------|--------|---------------------|--------------|
|`[Double]`|false   |20      |true (ByPropertyName)|RollOffOctaves|

#### **RollOffRate**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |21      |true (ByPropertyName)|

#### **GradientRatio**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |22      |true (ByPropertyName)|

#### **Deadzone**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |23      |true (ByPropertyName)|

#### **TemporalSmoothing**

Valid Values:

* none
* exp_moving_avg

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |24      |true (ByPropertyName)|

#### **Scene**
The name of the scene.    
If no scene name is provided, the current program scene will be used.

|Type      |Required|Position|PipelineInput        |Aliases  |
|----------|--------|--------|---------------------|---------|
|`[String]`|false   |25      |true (ByPropertyName)|SceneName|

#### **Name**
The name of the input.    
If no name is provided, the last segment of the URI or file path will be the input name.

|Type      |Required|Position|PipelineInput        |Aliases  |
|----------|--------|--------|---------------------|---------|
|`[String]`|false   |26      |true (ByPropertyName)|InputName|

#### **Force**
If set, will check if the source exists in the scene before creating it and removing any existing sources found.    
If not set, you will get an error if a source with the same name exists.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

---

### Syntax
```PowerShell
Set-OBSWaveformSource [[-Width] <Int32>] [[-Height] <Int32>] [[-AudioSource] <String>] [[-DisplayMode] <String>] [[-RenderMode] <String>] [[-WindowMode] <String>] [[-Color] <PSObject>] [[-CrestColor] <PSObject>] [[-ChannelMode] <String>] [[-ChannelSpacing] <Int32>] [-RadialLayout] [-InvertRadialDirection] [-NoramlizeVolume] [-AutoFftSize] [-FastPeak] [[-BarWidth] <Int32>] [[-BarGap] <Int32>] [[-StepWidth] <Int32>] [[-StepGap] <Int32>] [[-LowCutoff] <Int32>] [[-HighCutoff] <Int32>] [[-Floor] <Int32>] [[-Ceiling] <Int32>] [[-Slope] <Double>] [[-RollOffOctave] <Double>] [[-RollOffRate] <Double>] [[-GradientRatio] <Double>] [[-Deadzone] <Double>] [[-TemporalSmoothing] <String>] [[-Scene] <String>] [[-Name] <String>] [-Force] [<CommonParameters>]
```
