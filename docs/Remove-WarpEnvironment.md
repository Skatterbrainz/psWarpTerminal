---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 02/26/2026
PlatyPS schema version: 2024-05-01
title: Remove-WarpEnvironment
---

# Remove-WarpEnvironment

## SYNOPSIS

Deletes a Warp cloud environment.

## SYNTAX

### Default

```
Remove-WarpEnvironment [-Id] <string> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to delete a cloud environment.
Supports -WhatIf and -Confirm.

## EXAMPLES

### EXAMPLE 1

Remove-WarpEnvironment -Id "env-abc123"

### EXAMPLE 2

Get-WarpEnvironment | Where-Object name -eq "old-env" | Remove-WarpEnvironment

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.


### -Id

Required.
The ID of the environment to delete.
May be piped from another command.


### -WhatIf

Runs the command in a mode that only reports what would happen without performing the actions.

