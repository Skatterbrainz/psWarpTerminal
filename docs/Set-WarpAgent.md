---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 06/08/2026
PlatyPS schema version: 2024-05-01
title: Set-WarpAgent
---

# Set-WarpAgent

## SYNOPSIS

Updates an existing reusable Warp agent.

## SYNTAX

### __AllParameterSets

```
Set-WarpAgent [-Id] <string> [[-Name] <string>] [[-Description] <string>] [-RemoveDescription] [[-AddSecret] <string[]>] [[-RemoveSecret] <string[]>] [-RemoveAllSecrets] [[-AddSkill] <string[]>] [[-RemoveSkill] <string[]>] [-RemoveAllSkills] [[-BaseModel] <string>] [-RemoveBaseModel] [[-Environment] <string>] [-RemoveEnvironment] [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to update a reusable agent definition.

## EXAMPLES

### EXAMPLE 1

Set-WarpAgent -Id "ag_abc123" -AddSkill "myorg/backend:code-review"

## PARAMETERS

### -Id

Required. The UID of the agent to update.

### -Name

Optional. New name for the agent.

### -Description

Optional. Replacement description for the agent.

### -RemoveDescription

Remove the agent description.

### -AddSecret

Optional. One or more secret names to add.

### -RemoveSecret

Optional. One or more secret names to remove.

### -RemoveAllSecrets

Remove all attached secrets.

### -AddSkill

Optional. One or more skills to add.

### -RemoveSkill

Optional. One or more skills to remove.

### -RemoveAllSkills

Remove all attached skills.

### -BaseModel

Optional. Replacement base model.

### -RemoveBaseModel

Remove the base model.

### -Environment

Optional. Replacement default cloud environment.

### -RemoveEnvironment

Remove the default environment.
