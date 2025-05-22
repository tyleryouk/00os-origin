---
name: reaper-git
description: Stage, commit, and push all changes to the 00reaper branch using git. Commit message is written by 00reaper.
category: 00reaper
author: 00reaper
version: 1.0.0
permissions: [basic, execution]
inputs:
  - name: message
    type: string
    required: false
    description: Optional custom commit message (if not provided, 00reaper generates one)
outputs:
  - name: result
    type: string
    description: Git commit and push result
---

# Process: reaper-git

USE WHEN you want to stage, commit, and push all changes to the 00reaper branch in git. The commit message is written by 00reaper unless a custom message is provided.

## Execution

This process executes the following tool calls:

```javascript
// 0. Ensure we are on the correct branch ('00reaper')
await tools.call('run_terminal_cmd', {
  command: 'git checkout 00reaper',
  is_background: false,
  explanation: 'Ensure we are on the 00reaper branch before committing and pushing.'
});

// 1. Stage all changes
await tools.call('run_terminal_cmd', {
  command: 'git add .',
  is_background: false,
  explanation: 'Stage all changes for commit.'
});

// 2. Commit with a message (use provided message or generate one)
const commitMessage = inputs.message || `Automated commit by 00reaper: workflow/process update and sync`;
await tools.call('run_terminal_cmd', {
  command: `git commit -m "${commitMessage}"`,
  is_background: false,
  explanation: 'Commit staged changes with a 00reaper-generated message.'
});

// 3. Push to the 00reaper branch
await tools.call('run_terminal_cmd', {
  command: 'git push origin 00reaper',
  is_background: false,
  explanation: 'Push committed changes to the remote 00reaper branch.'
});

return { success: true, result: '✅ All changes committed and pushed to 00reaper branch.' };
```

## Examples

> reaper-git
✅ All changes committed and pushed to 00reaper branch.

> reaper-git --message "Refactor: update process automation logic"
✅ All changes committed and pushed to 00reaper branch with custom message. 