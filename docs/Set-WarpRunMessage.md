---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: Set-WarpRunMessage
---

# Set-WarpRunMessage

## SYNOPSIS

Marks a run message as delivered.

## SYNTAX

```powershell
Set-WarpRunMessage -MessageId <string> [<CommonParameters>]
```

## DESCRIPTION

Wraps `run message mark-delivered`.

## EXAMPLES

### EXAMPLE 1

```powershell
Set-WarpRunMessage -MessageId "msg_abc123"
```
