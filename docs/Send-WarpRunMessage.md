---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: Send-WarpRunMessage
---

# Send-WarpRunMessage

## SYNOPSIS

Sends a message from one run to one or more recipient runs.

## SYNTAX

```powershell
Send-WarpRunMessage -To <string[]> -Subject <string> -Body <string> -SenderRunId <string> [<CommonParameters>]
```

## DESCRIPTION

Wraps `run message send`.

## EXAMPLES

### EXAMPLE 1

```powershell
Send-WarpRunMessage -SenderRunId "run_sender" -To "run_recipient" -Subject "status" -Body "tests passed"
```
