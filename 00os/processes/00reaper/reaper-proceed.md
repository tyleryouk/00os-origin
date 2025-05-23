---
name: reaper-proceed
category: 00reaper
version: 1.0.0
author: 00reaper
description: Advance the cyclical workflow to the next step, or continue the current step if not yet complete. Always logs status and next actions.
permissions: [basic]
inputs: []
outputs:
  - name: result
    type: string
    description: Status message
---

# Process: reaper-proceed

USE WHEN you want to execute reaper-proceed

## Execution

1. Read cycle-status.md to determine the current step and completion status.
2. If the current step is complete, advance to the next step and log the transition in cycle-status.md.
3. If the current step is not complete, remain in the current step and provide a status update with next actions.
4. Always return a clear status message indicating the current workflow state and what will happen next.

## Examples

> reaper-proceed 