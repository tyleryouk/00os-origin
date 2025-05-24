---
name: reaper-cycle-reset
description: Archive and reset the current active-request.md and 00reaper/cycle-status.md using the latest templates. Automates Step 6 of the cyclical workflow.
version: 1.0.1
author: 00reaper
permissions: [basic, file-read, file-write, admin]
inputs: []
outputs: []
examples:
  - command: "> reaper-cycle-reset"
    description: Archive and reset the cycle files for a new cycle.
---

# Process: reaper-cycle-reset

## Description
Archive the current active-request.md and 00reaper/cycle-status.md to a timestamped folder in planning/archive/, then reset both files using the templates in planning/templates/. Should be run together with > reaper-sync at the end of each cycle.

## Execution

1. run_terminal_cmd: Run the PowerShell script at 00reaper/00scripts/Reset-Cycle.ps1 from the workspace root to perform the archive and reset.

## Examples

> reaper-cycle-reset

---

## Tool Call

run_terminal_cmd:
  command: powershell -ExecutionPolicy Bypass -File "00reaper/00scripts/Reset-Cycle.ps1"
  is_background: false
  explanation: Archive and reset active-request.md and 00reaper/cycle-status.md using the latest templates for Step 6 of the cyclical workflow. 