---
name: reaper-init
description: Initialize 00reaper context and system understanding
category: 00reaper
author: 00reaper
version: 2.3
---

# Process: reaper-init

USE WHEN you want to execute reaper-init

## Execution

This process initializes the context and documentation for 00reaper, 00OS, and 1000xdev. The default (no flags) behavior loads all core workflow, context, and documentation files. The `--00os` and `--1000xdev` flags restrict initialization to their respective domains.

### Supported Flags (use only one at a time):
- `--00os`: Only initialize 00OS context, documentation, and research
- `--1000xdev`: Only initialize 1000xdev context, documentation, workflow, and process files

---

### Default: Full Initialization (No Flags)
```javascript
if (!flags['00os'] && !flags['1000xdev']) {
  // Load core workflow files
  await tools.call('read_file', { target_file: '00reaper/README.md', should_read_entire_file: true, explanation: 'Load workflow README' });
  await tools.call('read_file', { target_file: '00reaper/active-request.md', should_read_entire_file: true, explanation: 'Load active request' });
  await tools.call('read_file', { target_file: '00reaper/implementation-plan.md', should_read_entire_file: true, explanation: 'Load implementation plan' });
  await tools.call('read_file', { target_file: '00reaper/cycle-status.md', should_read_entire_file: true, explanation: 'Load cycle status' });
  await tools.call('read_file', { target_file: '00reaper/future-enhancements.md', should_read_entire_file: true, explanation: 'Load future enhancements' });

  // Load all documentation in 00OS-architecture
  const archDocs = [
    'tool-call-patterns.md',
    'cursor-rules-manipulation.md',
    'command-template-core.md',
    'command-standards-core.md',
    'ai-identity-map.md',
    '00OS-command-development.md',
    '00OS-command-user-guide.md',
    'dual-mode-interface.md',
    'README.md'
  ];
  for (const doc of archDocs) {
    await tools.call('read_file', { target_file: `00reaper/documentation/00OS-architecture/${doc}`, should_read_entire_file: true, explanation: `Load 00OS architecture doc: ${doc}` });
  }

  // Load all documentation in 00reaper-identity
  const reaperIdentityDocs = [
    'identity.md',
    '00os-integration.md',
    'README.md'
  ];
  for (const doc of reaperIdentityDocs) {
    await tools.call('read_file', { target_file: `00reaper/documentation/00reaper-identity/${doc}`, should_read_entire_file: true, explanation: `Load 00reaper identity doc: ${doc}` });
  }

  // Load all documentation in testing
  const testingDocs = [
    'testing-guide.md',
    'testing-framework.md',
    'README.md'
  ];
  for (const doc of testingDocs) {
    await tools.call('read_file', { target_file: `00reaper/documentation/testing/${doc}`, should_read_entire_file: true, explanation: `Load testing doc: ${doc}` });
  }

  // Load all documentation in templates
  const templateDocs = [
    'command-template-core.md',
    'implementation-plan-template.md',
    'cycle-status-template.md',
    'active-request-template.md',
    'README.md'
  ];
  for (const doc of templateDocs) {
    await tools.call('read_file', { target_file: `00reaper/documentation/templates/${doc}`, should_read_entire_file: true, explanation: `Load template doc: ${doc}` });
  }

  // Load vision and roadmap documents
  await tools.call('read_file', { target_file: '00reaper/user-directed/final-goal.md', should_read_entire_file: true, explanation: 'Load final goal document' });

  // Load context state snapshots
  await tools.call('read_file', { target_file: '00reaper/context/00OS.md', should_read_entire_file: true, explanation: 'Load 00OS system context' });
  await tools.call('read_file', { target_file: '00reaper/context/00reaper.md', should_read_entire_file: true, explanation: 'Load 00reaper context' });
  await tools.call('read_file', { target_file: '00reaper/context/1000xdev.md', should_read_entire_file: true, explanation: 'Load 1000xdev workflow context' });
  await tools.call('read_file', { target_file: '00reaper/context/README.md', should_read_entire_file: true, explanation: 'Load consolidated context overview' });

  return { success: true, result: '00reaper context initialized and all core files loaded' };
}
```

---

### Flag: --00os (00OS-Only Initialization)
```javascript
if (flags['00os']) {
  // Load core workflow files
  await tools.call('read_file', { target_file: '00reaper/README.md', should_read_entire_file: true, explanation: 'Load workflow README' });
  await tools.call('read_file', { target_file: '00reaper/active-request.md', should_read_entire_file: true, explanation: 'Load active request' });
  await tools.call('read_file', { target_file: '00reaper/implementation-plan.md', should_read_entire_file: true, explanation: 'Load implementation plan' });
  await tools.call('read_file', { target_file: '00reaper/cycle-status.md', should_read_entire_file: true, explanation: 'Load cycle status' });
  await tools.call('read_file', { target_file: '00reaper/future-enhancements.md', should_read_entire_file: true, explanation: 'Load future enhancements' });

  // Load all documentation in 00OS-architecture
  const archDocs = [
    'tool-call-patterns.md',
    'cursor-rules-manipulation.md',
    'command-template-core.md',
    'command-standards-core.md',
    'ai-identity-map.md',
    '00OS-command-development.md',
    '00OS-command-user-guide.md',
    'dual-mode-interface.md',
    'README.md'
  ];
  for (const doc of archDocs) {
    await tools.call('read_file', { target_file: `00reaper/documentation/00OS-architecture/${doc}`, should_read_entire_file: true, explanation: `Load 00OS architecture doc: ${doc}` });
  }

  // Load all documentation in 00reaper-identity
  const reaperIdentityDocs = [
    'identity.md',
    '00os-integration.md',
    'README.md'
  ];
  for (const doc of reaperIdentityDocs) {
    await tools.call('read_file', { target_file: `00reaper/documentation/00reaper-identity/${doc}`, should_read_entire_file: true, explanation: `Load 00reaper identity doc: ${doc}` });
  }

  // Load all documentation in testing
  const testingDocs = [
    'testing-guide.md',
    'testing-framework.md',
    'README.md'
  ];
  for (const doc of testingDocs) {
    await tools.call('read_file', { target_file: `00reaper/documentation/testing/${doc}`, should_read_entire_file: true, explanation: `Load testing doc: ${doc}` });
  }

  // Load all documentation in templates
  const templateDocs = [
    'command-template-core.md',
    'implementation-plan-template.md',
    'cycle-status-template.md',
    'active-request-template.md',
    'README.md'
  ];
  for (const doc of templateDocs) {
    await tools.call('read_file', { target_file: `00reaper/documentation/templates/${doc}`, should_read_entire_file: true, explanation: `Load template doc: ${doc}` });
  }

  // Load vision and roadmap documents
  await tools.call('read_file', { target_file: '00reaper/user-directed/final-goal.md', should_read_entire_file: true, explanation: 'Load final goal document' });

  // Load context state snapshots
  await tools.call('read_file', { target_file: '00reaper/context/00OS.md', should_read_entire_file: true, explanation: 'Load 00OS system context' });
  await tools.call('read_file', { target_file: '00reaper/context/00reaper.md', should_read_entire_file: true, explanation: 'Load 00reaper context' });
  await tools.call('read_file', { target_file: '00reaper/context/1000xdev.md', should_read_entire_file: true, explanation: 'Load 1000xdev workflow context' });
  await tools.call('read_file', { target_file: '00reaper/context/README.md', should_read_entire_file: true, explanation: 'Load consolidated context overview' });

  return { success: true, result: '00OS context initialized and all core files loaded' };
}
```

---

### Flag: --1000xdev (1000xdev-Only Initialization)
```javascript
if (flags['1000xdev']) {
  // Load core workflow files (mandatory)
  await tools.call('read_file', { target_file: '00reaper/active-request.md', should_read_entire_file: true, explanation: 'Load active request' });
  await tools.call('read_file', { target_file: '00reaper/implementation-plan.md', should_read_entire_file: true, explanation: 'Load implementation plan' });
  await tools.call('read_file', { target_file: '00reaper/cycle-status.md', should_read_entire_file: true, explanation: 'Load cycle status' });
  await tools.call('read_file', { target_file: '00reaper/future-enhancements.md', should_read_entire_file: true, explanation: 'Load future enhancements' });

  // Load essential 00reaper/00OS docs for workflow and standards
  await tools.call('read_file', { target_file: '00reaper/README.md', should_read_entire_file: true, explanation: 'Load workflow README' });
  await tools.call('read_file', { target_file: '00reaper/user-rules-00reaper.md', should_read_entire_file: true, explanation: 'Load 00reaper user rules' });
  await tools.call('read_file', { target_file: '00reaper/documentation/00OS-architecture/command-standards-core.md', should_read_entire_file: true, explanation: 'Load command standards' });
  await tools.call('read_file', { target_file: '00reaper/documentation/00OS-architecture/00OS-command-development.md', should_read_entire_file: true, explanation: 'Load 00OS command development guide' });
  await tools.call('read_file', { target_file: '00reaper/documentation/00OS-architecture/ai-identity-map.md', should_read_entire_file: true, explanation: 'Load AI identity map' });
  await tools.call('read_file', { target_file: '00reaper/documentation/00OS-architecture/cursor-rules-manipulation.md', should_read_entire_file: true, explanation: 'Load cursor rules manipulation guide' });
  await tools.call('read_file', { target_file: '00reaper/documentation/00reaper-identity/identity.md', should_read_entire_file: true, explanation: 'Load 00reaper identity doc' });
  await tools.call('read_file', { target_file: '00reaper/documentation/00reaper-identity/00os-integration.md', should_read_entire_file: true, explanation: 'Load 00OS integration doc' });
  await tools.call('read_file', { target_file: '00reaper/context/1000xdev.md', should_read_entire_file: true, explanation: 'Load 1000xdev workflow context snapshot' });

  // Load 1000xdev workflow, user rules, and user request files
  await tools.call('read_file', { target_file: '1000xdev/README.md', should_read_entire_file: true, explanation: 'Load 1000xdev workflow README' });
  await tools.call('read_file', { target_file: '1000xdev/documentation/workflow.md', should_read_entire_file: true, explanation: 'Load 1000xdev workflow doc' });
  await tools.call('read_file', { target_file: '1000xdev/documentation/final-goals.md', should_read_entire_file: true, explanation: 'Load 1000xdev final goals' });
  await tools.call('read_file', { target_file: '1000xdev/documentation/tool-call-processes.md', should_read_entire_file: true, explanation: 'Load 1000xdev tool call processes' });
  await tools.call('read_file', { target_file: '1000xdev/user-directed/user-rules-1000xdev-global.md', should_read_entire_file: true, explanation: 'Load 1000xdev global user rules' });
  await tools.call('read_file', { target_file: '1000xdev/user-directed/user-request.md', should_read_entire_file: true, explanation: 'Load 1000xdev user request' });

  // Load 00OS 1000xdev process files
  await tools.call('read_file', { target_file: '00os/processes/1000xdev/dev-init.md', should_read_entire_file: true, explanation: 'Load dev-init process' });
  await tools.call('read_file', { target_file: '00os/processes/1000xdev/dev-git.md', should_read_entire_file: true, explanation: 'Load dev-git process' });
  await tools.call('read_file', { target_file: '00os/processes/1000xdev/dev-scan-front-end.md', should_read_entire_file: true, explanation: 'Load dev-scan-front-end process' });
  await tools.call('read_file', { target_file: '00os/processes/1000xdev/dev-scan-back-end.md', should_read_entire_file: true, explanation: 'Load dev-scan-back-end process' });

  return { success: true, result: '1000xdev workflow enhancement context initialized (concise set)' };
}
```

---

### Flag: --self (00reaper Self-Enhancement Initialization)
```javascript
if (flags['self']) {
  // Always load core workflow files
  await tools.call('read_file', { target_file: '00reaper/README.md', should_read_entire_file: true, explanation: 'Load workflow README' });
  await tools.call('read_file', { target_file: '00reaper/active-request.md', should_read_entire_file: true, explanation: 'Load active request' });
  await tools.call('read_file', { target_file: '00reaper/implementation-plan.md', should_read_entire_file: true, explanation: 'Load implementation plan' });
  await tools.call('read_file', { target_file: '00reaper/cycle-status.md', should_read_entire_file: true, explanation: 'Load cycle status' });
  await tools.call('read_file', { target_file: '00reaper/future-enhancements.md', should_read_entire_file: true, explanation: 'Load future enhancements' });

  // List 00reaper workflow and process directories
  await tools.call('list_dir', { relative_workspace_path: '00reaper', explanation: 'List 00reaper root workflow files and folders' });
  await tools.call('list_dir', { relative_workspace_path: '00reaper/context', explanation: 'List 00reaper context files' });
  await tools.call('list_dir', { relative_workspace_path: '00reaper/documentation', explanation: 'List 00reaper documentation files' });
  await tools.call('list_dir', { relative_workspace_path: '00reaper/00scripts', explanation: 'List 00reaper automation scripts' });
  await tools.call('list_dir', { relative_workspace_path: '00reaper/research-cursor', explanation: 'List 00reaper research files' });
  await tools.call('list_dir', { relative_workspace_path: '00OS/processes/00reaper', explanation: 'List 00reaper process files in 00OS' });

  // Read 00reaper context and workflow files
  await tools.call('read_file', { target_file: '00reaper/context/00reaper.md', should_read_entire_file: true, explanation: 'Read 00reaper context summary' });
  await tools.call('read_file', { target_file: '00reaper/context/README.md', should_read_entire_file: true, explanation: 'Read consolidated context overview' });

  // Read 00reaper process files
  await tools.call('read_file', { target_file: '00OS/processes/00reaper/reaper-init.md', should_read_entire_file: true, explanation: 'Read reaper-init process' });
  await tools.call('read_file', { target_file: '00OS/processes/00reaper/reaper-update.md', should_read_entire_file: true, explanation: 'Read reaper-update process' });
  await tools.call('read_file', { target_file: '00OS/processes/00reaper/reaper-os-commands-workflow.md', should_read_entire_file: true, explanation: 'Read reaper-os-commands-workflow process' });
  await tools.call('read_file', { target_file: '00OS/processes/00reaper/reaper-overwrite.md', should_read_entire_file: true, explanation: 'Read reaper-overwrite process' });
  await tools.call('read_file', { target_file: '00OS/processes/00reaper/reaper-read-files.md', should_read_entire_file: true, explanation: 'Read reaper-read-files process' });
  await tools.call('read_file', { target_file: '00OS/processes/00reaper/reaper-sync.md', should_read_entire_file: true, explanation: 'Read reaper-sync process' });
  await tools.call('read_file', { target_file: '00OS/processes/00reaper/reaper-implement.md', should_read_entire_file: true, explanation: 'Read reaper-implement process' });
  await tools.call('read_file', { target_file: '00OS/processes/00reaper/reaper-analyze-tasks.md', should_read_entire_file: true, explanation: 'Read reaper-analyze-tasks process' });

  // Read 00reaper documentation
  await tools.call('read_file', { target_file: '00reaper/documentation/command-standards-core.md', should_read_entire_file: true, explanation: 'Read command standards' });
  await tools.call('read_file', { target_file: '00reaper/documentation/command-template-core.md', should_read_entire_file: true, explanation: 'Read command template' });
  await tools.call('read_file', { target_file: '00reaper/documentation/tool-call-patterns.md', should_read_entire_file: true, explanation: 'Read tool call patterns documentation' });
  await tools.call('read_file', { target_file: '00reaper/documentation/cursor-rules-manipulation.md', should_read_entire_file: true, explanation: 'Read cursor rules manipulation guide' });
  await tools.call('read_file', { target_file: '00reaper/documentation/ai-identity-map.md', should_read_entire_file: true, explanation: 'Read AI identity map' });

  // Read 00reaper automation scripts (optional, for self-enhancement)
  await tools.call('read_file', { target_file: '00reaper/00scripts/Sync-00OS.ps1', should_read_entire_file: true, explanation: 'Read sync automation script' });
  await tools.call('read_file', { target_file: '00reaper/00scripts/Clean-SyncReports.ps1', should_read_entire_file: true, explanation: 'Read clean sync reports script' });
  await tools.call('read_file', { target_file: '00reaper/00scripts/Sync-00OS-Complete.ps1', should_read_entire_file: true, explanation: 'Read complete sync automation script' });

  // Read 00reaper research files
  await tools.call('read_file', { target_file: '00reaper/research-cursor/research-cursor-tool-call.md', should_read_entire_file: true, explanation: 'Read Cursor tool call research' });
  await tools.call('read_file', { target_file: '00reaper/research-cursor/research-cursor-rules-manipulation.md', should_read_entire_file: true, explanation: 'Read Cursor rules manipulation research' });
  await tools.call('read_file', { target_file: '00reaper/research-cursor/research-cursor-project-rules.md', should_read_entire_file: true, explanation: 'Read Cursor project rules research' });
  await tools.call('read_file', { target_file: '00reaper/research-cursor/research-cursor-user-rules.md', should_read_entire_file: true, explanation: 'Read Cursor user rules research' });

  return { success: true, result: '00reaper self-enhancement context initialized (flag: --self)' };
}
```

---

## Examples

> reaper-init
✅ 00reaper context initialized and all core files loaded

> reaper-init --00os
✅ 00OS context initialized and all core files loaded

> reaper-init --1000xdev
✅ 1000xdev context initialized and all core files loaded

> reaper-init --self
✅ 00reaper self-enhancement context initialized (flag: --self) 