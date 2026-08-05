---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 02/26/2026
PlatyPS schema version: 2024-05-01
title: Suspend-WarpSchedule
---

# Suspend-WarpSchedule

## SYNOPSIS

Pauses a Warp scheduled agent.

## SYNTAX

### Default

```
Suspend-WarpSchedule [-Id] <string> [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to pause a scheduled agent so it stops running on its cron schedule.

## EXAMPLES

### EXAMPLE 1

Suspend-WarpSchedule -Id "sched-abc123"

## PARAMETERS

### -Id

Required.
The ID of the schedule to pause.
May be piped from another command.

