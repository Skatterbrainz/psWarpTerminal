---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 06/08/2026
PlatyPS schema version: 2024-05-01
title: New-WarpAgent
---

# New-WarpAgent

## SYNOPSIS

Creates a new reusable Warp agent.

## SYNTAX

### __AllParameterSets

```
New-WarpAgent [-Name] <string> [[-Description] <string>] [[-Secret] <string[]>] [[-Skill] <string[]>] [[-BaseModel] <string>] [[-Environment] <string>] [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to create a reusable agent definition.

## EXAMPLES

### EXAMPLE 1

New-WarpAgent -Name "Nightly Triage" -Skill "myorg/backend:issue-triage"

## PARAMETERS

### -Name

Required. Name of the agent.

### -Description

Optional. Description of the agent.

### -Secret

Optional. One or more secret names to attach.

### -Skill

Optional. One or more skills to attach.

### -BaseModel

Optional. Base model for runs executed by this agent.

### -Environment

Optional. Default cloud environment ID for runs executed by this agent.
