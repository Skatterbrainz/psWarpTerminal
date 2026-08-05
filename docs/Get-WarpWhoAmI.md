---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 04/17/2026
PlatyPS schema version: 2024-05-01
title: Get-WarpWhoAmI
---

# Get-WarpWhoAmI

## SYNOPSIS

Returns information about the currently logged-in Warp user.

## SYNTAX

### Default

```
Get-WarpWhoAmI [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI `whoami` command and returns the parsed JSON response describing the authenticated user (email, team, etc.).

## EXAMPLES

### EXAMPLE 1

Get-WarpWhoAmI

### EXAMPLE 2

(Get-WarpWhoAmI).email

## PARAMETERS
