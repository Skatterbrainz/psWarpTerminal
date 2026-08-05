---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 02/26/2026
PlatyPS schema version: 2024-05-01
title: Remove-WarpSchedule
---

# Remove-WarpSchedule

## SYNOPSIS

Deletes a Warp scheduled agent.

## SYNTAX

### Default

```
Remove-WarpSchedule [-Id] <string> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to delete a scheduled agent.
Supports -WhatIf and -Confirm.

## EXAMPLES

### EXAMPLE 1

Remove-WarpSchedule -Id "sched-abc123"

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.


### -Id

Required.
The ID of the schedule to delete.
May be piped from another command.


### -WhatIf

Runs the command in a mode that only reports what would happen without performing the actions.

