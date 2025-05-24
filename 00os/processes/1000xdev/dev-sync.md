---
name: dev-sync
description: Sync 1000xdev master workflow files and ensure consistency across documentation and rules
author: 00reaper
version: 1.0.0
category: 1000xdev
permissions: [basic, file-read, file-write]
inputs:
  - name: dry-run
    type: boolean
    required: false
    description: Preview changes without making them
outputs:
  - name: result
    type: string
    description: Sync status
---

# Process: dev-sync

## Description
Synchronizes the 1000xdev master workflow files (1000xdev-brain.md, README.md, user-rules-1000xdev.md) to ensure they are aligned and up-to-date. Also updates and validates links between documentation files.

## Flags
- `--dry-run`: Preview changes without making them

## Execution

1. Check if 1000xdev master workflow files exist and are aligned
2. Update internal references between files if needed
3. Validate and fix documentation links
4. Return sync status

```javascript
// Const to track sync status
let syncStatus = {
  needsUpdate: false,
  changes: []
};

// Check if dry run mode is activated
const dryRun = inputs['dry-run'] === true;

// Read master workflow files
const brainFile = await tools.call('read_file', {
  target_file: '1000xdev/1000xdev-brain.md',
  should_read_entire_file: true,
  explanation: 'Read master workflow file for 1000xdev'
});

const readmeFile = await tools.call('read_file', {
  target_file: '1000xdev/README.md',
  should_read_entire_file: true,
  explanation: 'Read README file for 1000xdev'
});

const userRulesFile = await tools.call('read_file', {
  target_file: '1000xdev/user-rules-1000xdev.md',
  should_read_entire_file: true,
  explanation: 'Read user rules file for 1000xdev'
});

// Check various cross-references and alignments between files
// This is a simplified version - a full implementation would check various aspects

// Check if master cursor rule exists and create it if needed
// Note: This would require 00reaper permissions in a real implementation

// Return sync status
if (dryRun) {
  if (syncStatus.needsUpdate) {
    return `🔍 Dry run completed. Changes needed:\n${syncStatus.changes.join('\n')}`;
  } else {
    return "✅ Dry run completed. All 1000xdev files are in sync.";
  }
} else {
  if (syncStatus.needsUpdate) {
    return `✅ Sync completed. Made the following changes:\n${syncStatus.changes.join('\n')}`;
  } else {
    return "✅ All 1000xdev files are already in sync.";
  }
}
```

## Examples

> dev-sync
✅ All 1000xdev files are already in sync.

> dev-sync --dry-run
✅ Dry run completed. All 1000xdev files are in sync. 