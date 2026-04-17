---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 04/17/2026
PlatyPS schema version: 2024-05-01
title: Get-WarpArtifact
---

# Get-WarpArtifact

## SYNOPSIS

Retrieves metadata for a Warp artifact by UID.

## SYNTAX

### Default

```
Get-WarpArtifact [-Uid] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function invokes the Warp CLI to fetch metadata for a single artifact produced by an agent run.

## EXAMPLES

### EXAMPLE 1

Get-WarpArtifact -Uid "art-abc123"

### EXAMPLE 2

Get-WarpRun -TaskId "task-xyz" | Select-Object -ExpandProperty artifacts | Get-WarpArtifact

## PARAMETERS

### -Uid

Required.
The UID of the artifact to retrieve.
May be piped from another command that outputs an object with a 'Uid' property.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- ArtifactUid
- Id
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: true
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

## NOTES

## RELATED LINKS

{{ Fill in the related links here }}
