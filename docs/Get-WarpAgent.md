---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: Get-WarpAgent
---

# Get-WarpAgent

## SYNOPSIS

Retrieves Warp reusable agents.

## SYNTAX

### List (Default)

```powershell
Get-WarpAgent [-SortBy <string>] [-SortOrder <string>] [<CommonParameters>]
```

### ById

```powershell
Get-WarpAgent -Id <string> [<CommonParameters>]
```

## DESCRIPTION

Lists agents or gets one by UID.

## PARAMETERS

### -SortBy

Optional sort field for list mode. Accepted values: `name`, `created-at`.

### -SortOrder

Optional sort direction for list mode. Accepted values: `asc`, `desc`.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-WarpAgent -SortBy created-at -SortOrder desc
```
