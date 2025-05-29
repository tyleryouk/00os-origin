---
name: dev-init
description: Initialize the context and documentation for 1000xdev. Each flag loads all docs in the corresponding documentation subfolder. The default (no flags) behavior loads only the four master workflow files and the current cycle-status and active-request files.
version: 2.2.0
author: 1000xdev
permissions: [basic, file-read]
inputs:
  - name: front-end
    type: boolean
    required: false
    default: false
    description: Only initialize front-end documentation
  - name: back-end
    type: boolean
    required: false
    default: false
    description: Only initialize back-end documentation
  - name: full-stack
    type: boolean
    required: false
    default: false
    description: Only initialize full-stack workflow documentation
  - name: steam
    type: boolean
    required: false
    default: false
    description: Only initialize Steam API integration documentation
  - name: cursor-rules
    type: boolean
    required: false
    default: false
    description: Only initialize cursor rules documentation
  - name: identity-and-rules
    type: boolean
    required: false
    default: false
    description: Only initialize 1000xdev identity documentation
  - name: onboarding
    type: boolean
    required: false
    default: false
    description: Only initialize onboarding documentation
  - name: integration
    type: boolean
    required: false
    default: false
    description: Only initialize integration documentation
outputs: []
examples:
  - command: "> dev-init"
    description: Load all master workflow, status, and documentation files
  - command: "> dev-init --front-end"
    description: Load only front-end documentation
  - command: "> dev-init --back-end"
    description: Load only back-end documentation
  - command: "> dev-init --steam"
    description: Load only Steam API integration documentation
  - command: "> dev-init --full-stack"
    description: Load only full-stack workflow documentation
  - command: "> dev-init --identity-and-rules"
    description: Load only 1000xdev identity and cursor rules documentation
  - command: "> dev-init --onboarding"
    description: Load only onboarding documentation
  - command: "> dev-init --integration"
    description: Load only integration documentation
---

# Process: dev-init

// This process initializes the context and documentation for 1000xdev. Each flag loads all docs in the corresponding documentation subfolder. The default (no flags) behavior loads only the four master workflow files, along with the current cycle-status, TODO and active-request files.

## Execution

```javascript
// Always load the four master workflow files, cycle-status and active-request files, and root documentation files
const masterFiles = [
  '1000xdev/1000xdev-brain.md',
  '1000xdev/README.md',
  '1000xdev/user-rules-1000xdev.md',
  '.cursor/rules/1000xdev-master.mdc'
];

const workflowFiles = [
  '1000xdev/cycle-status.md',
  '1000xdev/TODO.md',
  '1000xdev/planning/active-request.md',
  '1000xdev/documentation/README.md'
];

// Parse flags
const flags = {
  'front-end': inputs['front-end'] === true,
  'back-end': inputs['back-end'] === true,
  'full-stack': inputs['full-stack'] === true,
  'steam': inputs['steam'] === true,
  'cursor-rules': inputs['cursor-rules'] === true,
  'identity-and-rules': inputs['identity-and-rules'] === true,
  'onboarding': inputs['onboarding'] === true,
  'integration': inputs['integration'] === true
};
const flagKeys = Object.keys(flags).filter(k => flags[k]);
const anyFlag = flagKeys.length > 0;

// If more than one flag is set, return an error and do not proceed
if (flagKeys.length > 1) {
  return { success: false, result: '❌ Only one flag may be used at a time. Please specify a single documentation flag (e.g., --front-end) or run without flags for full context.' };
}

// Helper to load all .md files in a subfolder
tools.log = tools.log || (() => {});
async function loadAllFilesInFolder(folder, explanationPrefix) {
  const dirResult = await tools.call('list_dir', { relative_workspace_path: folder, explanation: `List all files in ${folder}` });
  if (!dirResult || !dirResult.files) return;
  for (const file of dirResult.files) {
    if (file.endsWith('.md')) {
      await tools.call('read_file', { target_file: `${folder}/${file}`, should_read_entire_file: true, explanation: `${explanationPrefix}: ${file}` });
    }
  }
}

// If no flags, load only master workflow and status files
if (!anyFlag) {
  for (const file of masterFiles) {
    await tools.call('read_file', { target_file: file, should_read_entire_file: true, explanation: 'Load master file' });
  }
  for (const file of workflowFiles) {
    await tools.call('read_file', { target_file: file, should_read_entire_file: true, explanation: 'Load workflow file' });
  }
  return { success: true, result: '✅ 1000xdev context initialized with all master and workflow files' };
}

// If exactly one flag is set, load the corresponding documentation subfolder
const docFolders = {
  'front-end': '1000xdev/documentation/front-end',
  'back-end': '1000xdev/documentation/back-end',
  'full-stack': '1000xdev/documentation/full-stack',
  'steam': '1000xdev/documentation/steam',
  'cursor-rules': '1000xdev/documentation/cursor-rules',
  'identity-and-rules': '1000xdev/documentation/identity-and-rules',
  'onboarding': '1000xdev/documentation/onboarding',
  'integration': '1000xdev/documentation/integration'
};
const flag = flagKeys[0];
if (flag && docFolders[flag]) {
  await loadAllFilesInFolder(docFolders[flag], `Load ${flag} documentation`);
  return { success: true, result: `✅ 1000xdev documentation initialized for --${flag}` };
}

return { success: false, result: 'No documentation loaded. Please specify a valid flag or run without flags for full context.' };
```