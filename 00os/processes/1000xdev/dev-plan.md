---
name: dev-plan
category: 1000xdev
version: 1.0.0
author: 1000xdev
description: Step 1 of the cyclical workflow for 1000xdev: AI-driven collaborative planning. 1000xdev drafts and iterates on active-request.md based on backlog.md and final-goals.md, with user review and feedback until approval. Only one request is ever written in active-request.md.
permissions: [basic]
outputs:
  - name: result
    type: string
    description: Status message
---

# Process: dev-plan

// Canonical Planning Files (as of 2025-05-24)
// - 1000xdev/planning/active-request.md
// - 1000xdev/planning/backlog.md
// - 1000xdev/planning/final-goals.md

USE WHEN you want to execute dev-plan

## Execution

```javascript
// Step 1: Read backlog and final-goals
const backlog = await tools.call('read_file', { target_file: '1000xdev/planning/backlog.md', should_read_entire_file: true, explanation: 'Review backlog of future or candidate requests for 1000xdev' });
const finalGoals = await tools.call('read_file', { target_file: '1000xdev/planning/final-goals.md', should_read_entire_file: true, explanation: 'Review final goals and long-term vision for 1000xdev' });

// Step 2: Draft or update active-request.md based on backlog and final-goals
// Only the highest-priority or next request is written. Never include more than one request.
const nextRequest = /* logic to select the single next request from backlog/finalGoals */;
const draft = await tools.call('edit_file', {
  target_file: '1000xdev/planning/active-request.md',
  instructions: 'Draft or update the active request for the next cycle based on backlog and final-goals. Only include one request, never more.',
  code_edit: `# Active Request\n\n<!--\nThis file is drafted and updated by 1000xdev based on backlog.md and final-goals.md. The user reviews and provides feedback; 1000xdev iterates until approved. Only one request is ever present.\n--->\n\n## Requirements: [Request Title]\n\n[Request details here]\n\n## Context References\n- **Key Files:**\n  - cycle-status.md\n  - 1000xdev-brain.md\n  - 00reaper-brain.md\n  - 1000xdev/planning/templates/\n  - 1000xdev/documentation/\n  - 1000xdev/planning/backlog.md\n  - 1000xdev/planning/final-goals.md\n- **Related Requests:**\n  - [Request ID/Title]\n`
});

// Step 3: Present the draft to the user for review and feedback (handled by the system)

// Step 4: On user feedback, iterate on active-request.md and log each iteration in cycle-status.md
// (This loop continues until the user sends > dev-implement to approve the draft)

// Step 5: Log the planning iteration in cycle-status.md (do not log if only a draft or if user has not approved)
// Only log after user approval (i.e., after > dev-implement)

return { success: true, result: 'Drafted/updated active-request.md for user review. Awaiting feedback or approval.' };
```

## Examples

> dev-plan 