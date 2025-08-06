---
name: reaper-plan
category: 00reaper
version: 2.1.0
author: 00reaper
description: Step 1 of the cyclical workflow - AI-driven collaborative planning. With --backlog flag, drafts from backlog.md and final-goal.md. Without flags, asks user for plan explanation and drafts accordingly.
permissions: [basic]
inputs:
  - name: backlog
    type: boolean
    description: Plan using requests from backlog.md and final-goal.md
    required: false
outputs:
  - name: result
    type: string
    description: Status message
---

# Process: reaper-plan

// Canonical Planning Files (as of 2025-05-23)
// - 00reaper/planning/active-request.md
// - 00reaper/planning/backlog.md
// - 00reaper/planning/final-goal.md

USE WHEN you want to execute reaper-plan

## Supported Flags
- `--backlog`: Plan using requests from backlog.md and final-goal.md (traditional workflow)
- No flags: Ask user for plan explanation and draft accordingly

## Execution

```javascript
// Check for --backlog flag
if (flags.backlog) {
  // Traditional workflow: Plan from backlog and final-goal
  const backlog = await tools.call('read_file', { target_file: '00reaper/planning/backlog.md', should_read_entire_file: true, explanation: 'Review backlog of future or candidate requests' });
  const finalGoal = await tools.call('read_file', { target_file: '00reaper/planning/final-goal.md', should_read_entire_file: true, explanation: 'Review final goal and long-term vision' });

  // Draft or update active-request.md based on backlog and final-goal
  // Only the highest-priority or next request is written. Never include more than one request.
  const draft = await tools.call('edit_file', {
    target_file: '00reaper/planning/active-request.md',
    instructions: 'Draft or update the active request for the next cycle based on backlog and final-goal. Only include one request, never more.',
    code_edit: `# Active Request

<!--
This file is drafted and updated by 00reaper based on backlog.md and final-goal.md. The user reviews and provides feedback; 00reaper iterates until approved. Only one request is ever present.
-->

## Requirements: [Request Title from Backlog]

[Request details from backlog/final-goal here]

## Context References
- **Key Files:**
  - cycle-status.md
  - 00reaper-brain.md
  - 1000xdev-brain.md
  - 00reaper/planning/templates/
  - 00reaper/documentation/
  - 00reaper/planning/backlog.md
  - 00reaper/planning/final-goal.md
- **Related Requests:**
  - [Request ID/Title from backlog]
`
  });

  return { success: true, result: 'Drafted active-request.md from backlog for user review. Awaiting feedback or approval via > reaper-implement.' };
} else {
  // Default behavior: Ask user for plan explanation
  return { 
    success: true, 
    result: 'Planning mode activated. Please explain what you would like to plan for the next cycle, and I will draft the active-request.md accordingly. Once you provide the explanation, I will create the draft for your review and iteration.' 
  };
}
```

## Examples

> reaper-plan --backlog
✅ Plans next cycle from backlog.md and final-goal.md

> reaper-plan  
✅ Asks user for plan explanation, then drafts accordingly 