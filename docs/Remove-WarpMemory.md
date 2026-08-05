---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: Remove-WarpMemory
---

# Remove-WarpMemory

## SYNOPSIS

Deletes a memory from a memory store.

## SYNTAX

```powershell
Remove-WarpMemory -MemoryId <string> -StoreId <string> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Wraps `memory delete`.

## EXAMPLES

### EXAMPLE 1

```powershell
Remove-WarpMemory -MemoryId "mem_abc123" -StoreId "store_abc123"
```
