---
name: reaper-sync
description: Synchronize 00OS contents to .cursor/rules
category: 00reaper
author: 00reaper
version: 2.3
---

# Process: reaper-sync

USE WHEN you want to execute reaper-sync

## Execution

This process executes a single tool call to synchronize the 00OS contents to the .cursor/rules directory using the PowerShell script. **Note: Only one flag can be used per invocation.**

Supported flags (use only one at a time):

- `--dry-run` or `-DryRun`: Simulate sync, no changes made
- `--detect-orphans` or `-DetectOrphans`: Detect orphaned .mdc files in .cursor/rules
- `--remove-orphans` or `-RemoveOrphans`: Remove orphaned .mdc files in .cursor/rules
- `--verbose` or `-Verbose`: Show detailed sync information

**Tool Call Example:**

```javascript
await tools.call('run_terminal_cmd', {
  command: 'powershell -ExecutionPolicy Bypass -File 00reaper/00scripts/Sync-00OS-Complete.ps1 [flag]',
  is_background: false,
  explanation: 'Synchronize 00OS contents to .cursor/rules using PowerShell script with a single flag'
});
```
Replace `[flag]` with one of `-DryRun`, `-DetectOrphans`, `-RemoveOrphans`, or `-Verbose` as needed.

## Examples

> reaper-sync
✅ 00OS contents synchronized to .cursor/rules

> reaper-sync --dry-run
✅ Dry run: No changes made, sync actions listed

> reaper-sync --detect-orphans
✅ Orphaned rules detected and reported

> reaper-sync --remove-orphans
✅ Orphaned rules removed

> reaper-sync --verbose
✅ Detailed output shown for sync process
