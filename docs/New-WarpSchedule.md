---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 05/05/2026
PlatyPS schema version: 2024-05-01
title: New-WarpSchedule
---

# New-WarpSchedule

## SYNOPSIS

Creates a new Warp scheduled agent.

## SYNTAX

### ByPrompt (Default)

```
New-WarpSchedule [-Name] <string> [-Cron] <string> [-Prompt] <string> [-Skill <string>]
 [-Model <string>] [-Environment <string>] [-NoEnvironment] [-Mcp <string[]>]
 [-ConfigFile <string>] [-WorkerID <string>] [-Team] [-Personal] [<CommonParameters>]
```

### BySkill

```
New-WarpSchedule [-Name] <string> [-Cron] <string> [-Skill] <string> [-Prompt <string>]
 [-Model <string>] [-Environment <string>] [-NoEnvironment] [-Mcp <string[]>]
 [-ConfigFile <string>] [-WorkerID <string>] [-Team] [-Personal] [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to create a scheduled agent that runs periodically according to a cron expression.
Either -Prompt or -Skill (or both) must be provided.

## EXAMPLES

### EXAMPLE 1

New-WarpSchedule -Name "daily-review" -Cron "0 9 * * *" -Prompt "Review open PRs" -Environment "env-id"

### EXAMPLE 2

New-WarpSchedule -Name "nightly-deps" -Cron "0 2 * * *" -Skill "myorg/infra:dep-update"

### EXAMPLE 3

New-WarpSchedule -Name "weekly-audit" -Cron "0 9 * * 1" -Skill "myorg/backend:security-review" -Prompt "Focus on auth modules"

## PARAMETERS

### -ConfigFile

Optional.
Path to a YAML or JSON configuration file.


### -Cron

Required.
Cron schedule expression (e.g.
"0 9 * * 1" for 9 AM every Monday).


### -Environment

Optional.
Cloud environment ID to run in.


### -WorkerID

Optional.
Where the job should be hosted. Use "warp" for Warp infrastructure, or a self-hosted worker name.


### -Mcp

Optional.
One or more MCP server specs.


### -Model

Optional.
Override the base model.


### -Name

Required.
Name of the scheduled agent.


### -Personal

Create as private to your account.


### -NoEnvironment

Do not run the agent in an environment.


### -Prompt

Prompt for what the scheduled agent should do. Required unless -Skill is specified.
When used with -Skill, the skill provides the base context and the prompt is the task.


### -Skill

Skill spec to automate on a schedule (e.g. "repo:skill_name" or "org/repo:skill_name").
Required unless -Prompt is specified.


### -Team

Create at the team level.

