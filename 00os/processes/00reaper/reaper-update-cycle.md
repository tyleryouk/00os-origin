---
name: reaper-update-cycle
description: Update 00reaper/cycle-status.md based on current context and latest changes in the cycle.
version: 1.1.0
author: 00reaper
permissions: [basic, file-read, file-write]
inputs: []
outputs: []
---

# Process: reaper-update-cycle

// This process updates 00reaper/cycle-status.md based on the current context and latest changes in the cycle.
// It reads the current cycle-status.md, determines what updates are needed, and writes the updated status back.

## Execution
```javascript
// Step 1: Read the current cycle status
const cycleStatus = await tools.call('read_file', {
  target_file: '00reaper/cycle-status.md',
  should_read_entire_file: true,
  explanation: 'Read the current cycle status for 00reaper.'
});

// Step 2: (Optional) Read additional context files if needed
// const activeRequest = await tools.call('read_file', {
//   target_file: '00reaper/planning/active-request.md',
//   should_read_entire_file: true,
//   explanation: 'Read the active request for 00reaper.'
// });

// Step 3: Update the cycle status file with new status, progress, or notes
const updatedStatus = /* logic to update cycleStatus based on context */;
await tools.call('edit_file', {
  target_file: '00reaper/cycle-status.md',
  instructions: 'Update the cycle status based on the latest context and changes.',
  code_edit: updatedStatus
});
```

## Examples
> reaper-update-cycle 