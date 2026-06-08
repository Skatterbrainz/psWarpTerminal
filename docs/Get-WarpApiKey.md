---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 06/08/2026
PlatyPS schema version: 2024-05-01
title: Get-WarpApiKey
---

# Get-WarpApiKey

## SYNOPSIS

Lists active Oz API keys.

## SYNTAX

### __AllParameterSets

```
Get-WarpApiKey [[-SortBy] <string>] [[-SortOrder] <string>] [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to list active API keys.

## EXAMPLES

### EXAMPLE 1

Get-WarpApiKey

### EXAMPLE 2

Get-WarpApiKey -SortBy created-at -SortOrder desc

## PARAMETERS

### -SortBy

Optional. Sort field.

### -SortOrder

Optional. Sort direction.
