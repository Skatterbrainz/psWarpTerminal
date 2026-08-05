---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: Get-WarpRunMessage
---

# Get-WarpRunMessage

## SYNOPSIS

Lists run inbox messages or reads a specific message.

## SYNTAX

### List (Default)

```powershell
Get-WarpRunMessage -RunId <string> [-Unread] [-Since <string>] [-Limit <int>] [<CommonParameters>]
```

### Read

```powershell
Get-WarpRunMessage -MessageId <string> [<CommonParameters>]
```

## DESCRIPTION

Wraps `run message list` and `run message read`.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-WarpRunMessage -RunId "run_abc123" -Unread
```
