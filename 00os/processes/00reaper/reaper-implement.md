---
name: reaper-implement
category: 00reaper
version: 1.0.0
author: 00reaper
description: Initiate Step 2 of the cyclical workflow (Read Relevant Context & Begin Implementation).
permissions: [basic]
inputs: []
outputs:
  - name: result
    type: string
    description: Status message
---

# Process: reaper-implement

USE WHEN you want to execute reaper-implement

## Execution

1. Check cycle-status.md for confirmation that reaper-plan is complete.
2. If confirmed, review all relevant context and documentation (log this in cycle-status.md).
3. Prepare and log the implementation plan in cycle-status.md.
4. Return a success message.
5. If reaper-plan is not complete, return an error message instructing the user to complete planning first.

## Examples

> reaper-implement 