---
name: reaper-proceed
category: 00reaper
version: 1.1.0
author: 00reaper
description: Advance the cyclical workflow to the next step, or continue the current step if not yet complete. Always logs status and next actions.
permissions: [basic]
inputs: []
outputs:
  - name: result
    type: string
    description: Status message
---

# Process: reaper-proceed

USE WHEN you want to execute reaper-proceed

## Execution

```javascript
// 1. Read the current cycle status
const statusFile = await tools.call('read_file', {
  target_file: '00reaper/cycle-status.md',
  should_read_entire_file: true,
  explanation: 'Determine current workflow step and completion state.'
});

// 2. Parse the current step and completion flags
const currentStep = parseCurrentStep(statusFile.content);
const isCurrentStepComplete = checkStepComplete(statusFile.content, currentStep);

// 3. Decide next step (stay or advance)
let nextStep = currentStep;
if (isCurrentStepComplete) {
  nextStep = currentStep + 1;
  // Update the checklist start timestamp
  await markStepStarted(nextStep);
}

// 4. If advancing to Step 5, automatically perform supporting-materials review
if (nextStep === 5) {
  const docDir = '00reaper/documentation';
  const ctxDir = '00reaper/context';
  // List documentation and context folders for review
  const docs = await tools.call('list_dir', { relative_workspace_path: docDir, explanation: 'Review documentation files for supporting materials update.' });
  const ctx  = await tools.call('list_dir', { relative_workspace_path: ctxDir,  explanation: 'Review context files for supporting materials update.' });
  // (Optional) additional automation such as TODO extraction, lint checks, or template updates could be inserted here.
  await tools.call('edit_file', {
    target_file: '00reaper/cycle-status.md',
    instructions: 'Log automatic documentation/context review for Step 5.',
    code_edit: `| 2025-01-08 current  | Step 5: Docs Reviewed | ${docs.entries.length + ctx.entries.length} top-level files inspected | None | Auto review |\n`
  });
}

return { success: true, result: `Workflow step handled. Current step: ${nextStep}.` };

// Helper functions (pseudo-code)
function parseCurrentStep(content) { /* ... */ }
function checkStepComplete(content, step) { /* ... */ }
async function markStepStarted(step) { /* ... */ }
```

This revised process now:
1. Reads `cycle-status.md` to detect the active step and its completion.
2. Advances to the next step when appropriate and marks it as started in `cycle-status.md`.
3. When advancing to **Step 5 (Update Supporting Materials)**, it automatically reviews the `documentation/` and `context/` folders in `00reaper` (or switch to `1000xdev` paths when acting as that agent) and logs the review.
4. Returns a clear status message describing the new workflow state.

## Examples

> reaper-proceed 