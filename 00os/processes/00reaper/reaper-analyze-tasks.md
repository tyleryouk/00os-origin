---
name: reaper-analyze-tasks
description: Analyze current tasks and generate action plan
category: 00reaper
author: 00reaper
version: 2.1
permissions: [basic, file-read]
outputs:
  - name: analysis
    type: string
    description: Summary of current tasks and action plan
---

# Process: reaper-analyze-tasks

USE WHEN you want to execute reaper-analyze-tasks

## Execution

This process executes the following tool calls:

1. Use read_file to read the contents of user_requests.md.
2. Return a summary of the current tasks and any action items found in the file.

## Examples

> reaper-analyze-tasks
✅ Returns a summary of current tasks and action plan from user_requests.md 