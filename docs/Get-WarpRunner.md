---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: Get-WarpRunner
---

# Get-WarpRunner

## SYNOPSIS

Lists cloud runners.

## SYNTAX

```powershell
Get-WarpRunner [-SortBy <string>] [<CommonParameters>]
```

## DESCRIPTION

Lists available cloud runners using `runner list`.

## PARAMETERS

### -SortBy

Optional sort field. Accepted values: `name`, `last-updated`.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-WarpRunner
```

### EXAMPLE 2

```powershell
Get-WarpRunner -SortBy name
```
