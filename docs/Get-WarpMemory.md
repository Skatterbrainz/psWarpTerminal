---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: Get-WarpMemory
---

# Get-WarpMemory

## SYNOPSIS

Lists memories in a store, or lists versions for a memory.

## SYNTAX

### List (Default)

```powershell
Get-WarpMemory -StoreId <string> [<CommonParameters>]
```

### Versions

```powershell
Get-WarpMemory -StoreId <string> -MemoryId <string> -Versions [<CommonParameters>]
```

## DESCRIPTION

Wraps `memory list` and `memory versions`.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-WarpMemory -StoreId "store_abc123"
```

### EXAMPLE 2

```powershell
Get-WarpMemory -StoreId "store_abc123" -MemoryId "mem_abc123" -Versions
```
