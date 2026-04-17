---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 04/17/2026
PlatyPS schema version: 2024-05-01
title: Save-WarpArtifact
---

# Save-WarpArtifact

## SYNOPSIS

Downloads a Warp artifact file to the local filesystem.

## SYNTAX

### Default

```
Save-WarpArtifact [-Uid] <string> [[-Path] <string>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function invokes the Warp CLI to download an artifact file by UID. If -Path is provided, the file is written to that location; otherwise the CLI chooses a default filename in the current directory.

## EXAMPLES

### EXAMPLE 1

Save-WarpArtifact -Uid "art-abc123" -Path ./report.pdf

### EXAMPLE 2

Get-WarpRun -TaskId "task-xyz" | Select-Object -ExpandProperty artifacts | Save-WarpArtifact

## PARAMETERS

### -Uid

Required.
The UID of the artifact to download.
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

### -Path

Optional.
Destination file path. Maps to the CLI's `-o / --out` option.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases:
- OutFile
- Destination
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
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
