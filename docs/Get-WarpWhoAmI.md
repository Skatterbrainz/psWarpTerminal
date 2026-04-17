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

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function invokes the Warp CLI `whoami` command and returns the parsed JSON response describing the authenticated user (email, team, etc.).

## EXAMPLES

### EXAMPLE 1

Get-WarpWhoAmI

### EXAMPLE 2

(Get-WarpWhoAmI).email

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}
