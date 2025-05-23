---
name: reaper-plan
category: 00reaper
version: 1.0.0
author: 00reaper
description: Initiate Step 1 of the cyclical workflow (Collaborative Planning). Prompts for review and confirmation of the active request.
permissions: [basic]
inputs:
  - name: confirm
    type: boolean
    required: true
    description: Confirm that the active request is clear and ready to proceed
outputs:
  - name: result
    type: string
    description: Status message
---

# Process: reaper-plan

USE WHEN you want to execute reaper-plan

## Execution

1. Read and display the contents of planning/active-request.md for review.
2. Prompt the user: "Is the active request clear and ready to proceed? (confirm=true to continue)"
3. If confirm is true, log the confirmation in cycle-status.md and return success.
4. If confirm is false, return a message to clarify or update the active request before proceeding.

## Examples

> reaper-plan --confirm=true 