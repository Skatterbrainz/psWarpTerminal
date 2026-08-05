---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 02/26/2026
PlatyPS schema version: 2024-05-01
title: Resume-WarpSchedule
---

# Resume-WarpSchedule

## SYNOPSIS

Resumes a paused Warp scheduled agent.

## SYNTAX

### Default

```
Resume-WarpSchedule [-Id] <string> [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to unpause a scheduled agent so it resumes running on its cron schedule.

## EXAMPLES

### EXAMPLE 1

Resume-WarpSchedule -Id "sched-abc123"

## PARAMETERS

### -Id

Required.
The ID of the schedule to resume.
May be piped from another command.

