---
name: dev-update-cycle
description: Update 1000xdev/cycle-status.md based on current context and latest changes in the cycle. Uses chunking if the file is large.
version: 1.2.0
author: 00reaper
permissions: [basic, file-read, file-write]
inputs: []
outputs: []
---

# Process: dev-update-cycle

// This process updates 1000xdev/cycle-status.md based on the current context and latest changes in the cycle.
// If the file is large, it reads the file in chunks and concatenates the results before processing.

## Execution
```javascript
// Step 1: Read the current cycle status, using chunking if the file is large
const CHUNK_SIZE = 200;
let cycleStatus = '';
let start = 1;
let end = CHUNK_SIZE;
let more = true;

while (more) {
  const chunk = await tools.call('read_file', {
    target_file: '1000xdev/cycle-status.md',
    should_read_entire_file: false,
    start_line_one_indexed: start,
    end_line_one_indexed_inclusive: end,
    explanation: `Read lines ${start}-${end} of cycle-status.md for chunked reading.`
  });
  if (chunk && chunk.content) {
    cycleStatus += chunk.content;
    // If fewer lines returned than requested, we've reached the end
    if (chunk.content.split('\n').length < CHUNK_SIZE) {
      more = false;
    } else {
      start += CHUNK_SIZE;
      end += CHUNK_SIZE;
    }
  } else {
    more = false;
  }
}

// Step 2: (Optional) Read additional context files if needed
// const activeRequest = await tools.call('read_file', {
//   target_file: '1000xdev/planning/active-request.md',
//   should_read_entire_file: true,
//   explanation: 'Read the active request for 1000xdev.'
// });

// Step 3: Update the cycle status file with new status, progress, or notes
const updatedStatus = /* logic to update cycleStatus based on context */;
await tools.call('edit_file', {
  target_file: '1000xdev/cycle-status.md',
  instructions: 'Update the cycle status based on the latest context and changes.',
  code_edit: updatedStatus
});
```

## Examples
> dev-update-cycle 