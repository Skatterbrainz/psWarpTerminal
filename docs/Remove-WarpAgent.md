---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 06/08/2026
PlatyPS schema version: 2024-05-01
title: Remove-WarpAgent
---

# Remove-WarpAgent

## SYNOPSIS

Deletes a reusable Warp agent.

## SYNTAX

### Default

```
Remove-WarpAgent [-Id] <string> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to delete a reusable agent.

## EXAMPLES

### EXAMPLE 1

Remove-WarpAgent -Id "ag_abc123"

## PARAMETERS

### -Id

Required. The UID of the agent to delete.
