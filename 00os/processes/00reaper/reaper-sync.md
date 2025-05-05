---
name: reaper-sync
description: Synchronize 00OS contents to .cursor/rules
category: 00reaper
author: 00reaper
version: 2.1
---

# Process: reaper-sync

USE WHEN you want to execute reaper-sync

## Execution

This process executes a single tool call to synchronize the 00OS contents to the .cursor/rules directory using the PowerShell script:

1. Run the sync script directly:

```javascript
await tools.call('run_terminal_cmd', {
  command: 'powershell -ExecutionPolicy Bypass -File 00reaper/00scripts/Sync-00OS-Complete.ps1',
  is_background: false,
  explanation: 'Synchronize 00OS contents to .cursor/rules using PowerShell script'
});
```

## Examples

> reaper-sync
✅ 00OS contents synchronized to .cursor/rules

> reaper-sync --dry-run
✅ Dry run: No changes made, sync actions listed
