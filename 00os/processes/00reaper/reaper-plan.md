---
name: reaper-plan
category: 00reaper
version: 2.0.0
author: 00reaper
description: Step 1 of the cyclical workflow: AI-driven collaborative planning. 00reaper drafts and iterates on active-request.md based on backlog.md and final-goal.md, with user review and feedback until approval.
permissions: [basic]
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

## Execution

```javascript
// Step 1: Read backlog and final-goal
const backlog = await tools.call('read_file', { target_file: '00reaper/planning/backlog.md', should_read_entire_file: true, explanation: 'Review backlog of future or candidate requests' });
const finalGoal = await tools.call('read_file', { target_file: '00reaper/planning/final-goal.md', should_read_entire_file: true, explanation: 'Review final goal and long-term vision' });

// Step 2: Draft or update active-request.md based on backlog and final-goal
const draft = await tools.call('edit_file', {
  target_file: '00reaper/planning/active-request.md',
  instructions: 'Draft or update the active request for the next cycle based on backlog and final-goal. This is an AI-driven, iterative draft.',
  code_edit: `# Active Request\n\n<!--\nThis file is drafted and updated by 00reaper based on backlog.md and final-goal.md. The user reviews and provides feedback; 00reaper iterates until approved.\n--->\n\n## Proposed Requirements for Next Cycle\n\n// ... 00reaper will fill this section based on backlog and final-goal ...\n`
});

// Step 3: Present the draft to the user for review and feedback (handled by the system)

// Step 4: On user feedback, iterate on active-request.md and log each iteration in cycle-status.md
// (This loop continues until the user sends > reaper-implement to approve the draft)

// Step 5: Log the planning iteration in cycle-status.md
await tools.call('edit_file', {
  target_file: '00reaper/cycle-status.md',
  instructions: 'Log planning iteration for this cycle',
  code_edit: `| ${new Date().toISOString()} | reaper-plan | Drafted/updated active-request.md for user review | | |\n// ... existing code ...`
});

return { success: true, result: 'Drafted/updated active-request.md for user review. Awaiting feedback or approval.' };
```

## Examples

> reaper-plan 