---
name: help
description: Display help information for commands
category: system
author: 00reaper
version: 2.0
permissions: [basic]
inputs:
  - name: command
    type: string
    required: false
    description: Command to get help for
outputs:
  - name: help
    type: object
    description: Help information
---

# Process: help

USE WHEN you want to execute help

## Execution

This process executes the following tool calls:

1. If no command is specified, use list_dir to enumerate all commands in /00os/processes/system and /00os/processes/00reaper.
2. If a command is specified, use read_file to show details for that command from the appropriate directory.

## Examples

> help
✅ Lists all available system and 00reaper commands

> help reaper-sync
✅ Shows help for the reaper-sync command 