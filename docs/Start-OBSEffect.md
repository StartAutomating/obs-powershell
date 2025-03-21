Start-OBSEffect
---------------

### Synopsis
Starts obs-powershell effects.

---

### Description

Starts an effect in OBS PowerShell.

An effect is either a series of messages or a command that can produce a series of messages.

---

### Related Links
* [Get-OBSEffect](Get-OBSEffect.md)

---

### Parameters
#### **EffectName**
The name of the effect.

|Type        |Required|Position|PipelineInput|
|------------|--------|--------|-------------|
|`[String[]]`|true    |named   |false        |

#### **Duration**
The duration of the effect.
If provided, all effects should use this duration.
If not provided, each effect should use it's own duration.

|Type        |Required|Position|PipelineInput|
|------------|--------|--------|-------------|
|`[TimeSpan]`|false   |named   |false        |

#### **EffectParameter**
The parameters passed to the effect.

|Type           |Required|Position|PipelineInput        |Aliases         |
|---------------|--------|--------|---------------------|----------------|
|`[IDictionary]`|false   |named   |true (ByPropertyName)|EffectParameters|

#### **EffectArgument**
The arguments passed to the effect.

|Type          |Required|Position|PipelineInput|Aliases        |
|--------------|--------|--------|-------------|---------------|
|`[PSObject[]]`|false   |named   |false        |EffectArguments|

#### **Step**
If provided, will step thru running

|Type     |Required|Position|PipelineInput        |Aliases|
|---------|--------|--------|---------------------|-------|
|`[Int32]`|false   |named   |true (ByPropertyName)|ticks  |

#### **SceneItemID**
The SceneItemID.  If this is provided, the effect will be given a target.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |named   |true (ByPropertyName)|

#### **SceneName**
The SceneName.  If this is provided with a -SceneItemID or -SourceName, the effect will be given a target.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|

#### **FilterName**
The Filter Name.  If this is provided with a -SourceName, the effect will be given a target.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|

#### **SourceName**
The Source Name.  If this is provided with a -FitlerName -or -SceneName, the effect will be given a target.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |named   |true (ByPropertyName)|

#### **Loop**
If set, will loop the effect.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **LoopCount**
If provided, will loop the effect a number of times.

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[Int32]`|false   |named   |false        |

#### **Bounce**
If set, will bounce the effect (flip it / reverse it)

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **Reverse**
If set, will reverse an effect.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

---

### Syntax
```PowerShell
Start-OBSEffect -EffectName <String[]> [-Duration <TimeSpan>] [-EffectParameter <IDictionary>] [-EffectArgument <PSObject[]>] [-Step <Int32>] [-SceneItemID <Int32>] [-SceneName <String>] [-FilterName <String>] [-SourceName <String>] [-Loop] [-LoopCount <Int32>] [-Bounce] [-Reverse] [<CommonParameters>]
```
