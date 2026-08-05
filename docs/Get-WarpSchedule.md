---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 02/26/2026
PlatyPS schema version: 2024-05-01
title: Get-WarpSchedule
---

# Get-WarpSchedule

## SYNOPSIS

Retrieves a list of Warp scheduled agents.

## SYNTAX

### List (Default)

```
Get-WarpSchedule [<CommonParameters>]
```

### ById

```
Get-WarpSchedule [-Id] <string> [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to list all scheduled agents or get a specific schedule by ID.

## EXAMPLES

### EXAMPLE 1

Get-WarpSchedule

### EXAMPLE 2

Get-WarpSchedule -Id "sched-abc123"

## PARAMETERS

### -Id

Optional.
The ID of a specific schedule to retrieve.
If not provided, all schedules will be listed.
May be piped from another command that outputs an object with an 'Id' property.

