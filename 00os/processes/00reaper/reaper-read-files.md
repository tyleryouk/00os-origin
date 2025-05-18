---
name: reaper-read-files
description: Read all files in a specified directory
category: 00reaper
author: 00reaper
version: 2.0
permissions: [basic, file-read]
inputs:
  - name: path
    type: string
    required: true
    description: Path to directory to read files from
  - name: recursive
    type: boolean
    required: false
    default: false
    description: Whether to read files in subdirectories
outputs:
  - name: result
    type: string
    description: List of file names and their contents
---

# Process: reaper-read-files

USE WHEN you want to execute reaper-read-files

## Execution

This process executes the following tool calls:

1. Use list_dir to list all files in the specified directory (and subdirectories if recursive is true).
2. For each file, use read_file to read its contents.
3. Return a list of file names and their contents.

## Examples

> reaper-read-files /00os/processes/system
✅ Returns the names and contents of all files in /00os/processes/system

> reaper-read-files /00os/processes/00reaper --recursive
✅ Returns the names and contents of all files in /00os/processes/00reaper and its subdirectories