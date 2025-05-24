---
name: reaper-init
description: Initialize 00reaper context and system understanding
category: 00reaper
author: 00reaper
version: 2.6
---

# Process: reaper-init

// Canonical Documentation Locations (as of 2025-05-23)
// 00OS-architecture: 00reaper/documentation/00OS-architecture/
//   - 00OS-command-user-guide.md
//   - 00OS-command-development.md
//   - tool-call-patterns.md
//   - 00OS-rationale.md
//   - README.md
// cursor-rules: 00reaper/documentation/cursor-rules/
//   - ai-identity-map.md
//   - cursor-rules-manipulation.md
//   - dual-mode-interface.md
//   - user-rules-manipulation.md
//   - cursor-rules-strategy.md
// 00reaper-identity: 00reaper/documentation/00reaper-identity/
//   - identity.md
//   - 00os-integration.md
//   - README.md
// ai-identities: 00reaper/documentation/ai-identities/
//   - 00reaper.md
//   - 1000xdev.md
//   - user.md

USE WHEN you want to execute reaper-init

## Execution

This process initializes the context and documentation for 00reaper, 00OS, and 1000xdev. The default (no flags) behavior loads all core workflow, context, and documentation files. The `--00os` and `--1000xdev` flags restrict initialization to their respective domains.

### Supported Flags (use only one at a time):
- `--00os`: Only initialize 00OS context, documentation, and research
- `--1000xdev`: Only initialize 1000xdev context, documentation, workflow, and process files
-
---

### Default: Full Initialization (No Flags)
```javascript
// Loads only the most essential, cross-domain files for baseline context.
// For full 00OS documentation and standards, run `> reaper-init --00os` after this.
if (!flags['00os'] && !flags['1000xdev'] && !flags['self']) {
  // Load system rationale first
  await tools.call('read_file', { target_file: '00reaper/context/why-00os-and-cursor-rules.md', should_read_entire_file: true, explanation: 'Read system rationale and design philosophy' });

  // Load core and master workflow files
  await tools.call('read_file', { target_file: '00reaper/planning/active-request.md', should_read_entire_file: true, explanation: 'Load active request' });
  await tools.call('read_file', { target_file: '00reaper/cycle-status.md', should_read_entire_file: true, explanation: 'Load cycle status file' });
  await tools.call('read_file', { target_file: '00reaper/README.md', should_read_entire_file: true, explanation: 'Load workflow README' });
  await tools.call('read_file', { target_file: '00reaper/00reaper-brain.md', should_read_entire_file: true, explanation: 'Load master workflow file for 00reaper (central protocol for workflow enhancement)' });
  await tools.call('read_file', { target_file: '00reaper/user-rules-00reaper.md', should_read_entire_file: true, explanation: 'Load user rules for 00reaper' });
  await tools.call('read_file', { target_file: '.cursor/rules/00reaper-master.mdc', should_read_entire_file: true, explanation: 'Load master cursor rule for 00reaper' });

  // Load context state snapshots
  await tools.call('read_file', { target_file: '00reaper/context/00OS.md', should_read_entire_file: true, explanation: 'Load 00OS system context' });
  await tools.call('read_file', { target_file: '00reaper/context/00reaper.md', should_read_entire_file: true, explanation: 'Load 00reaper context' });
  await tools.call('read_file', { target_file: '00reaper/context/1000xdev.md', should_read_entire_file: true, explanation: 'Load 1000xdev workflow context' });
  await tools.call('read_file', { target_file: '00reaper/context/README.md', should_read_entire_file: true, explanation: 'Load consolidated context overview' });

  // Load workflow templates from the canonical template directory
  const templateDocs = [
    'cycle-status-template.md',
    'active-request-template.md'
  ];
  for (const doc of templateDocs) {
    await tools.call('read_file', { target_file: `00reaper/planning/templates/${doc}`, should_read_entire_file: true, explanation: `Load workflow template: ${doc}` });
  }

  return { success: true, result: '00reaper baseline context initialized (essential files only)' };
}
```

---

### Flag: --00os (00OS-Only Initialization)
```javascript
// Loads all 00OS-architecture documentation and standards files.
// Run this after the default `> reaper-init` for a full 00OS context.
if (flags['00os']) {
  // Load all documentation in 00OS-architecture
  const archDocs = [
    '00OS-command-user-guide.md',
    '00OS-command-development.md',
    'tool-call-patterns.md',
    '00OS-rationale.md',
    'README.md'
  ];
  for (const doc of archDocs) {
    await tools.call('read_file', { target_file: `00reaper/documentation/00OS-architecture/${doc}`, should_read_entire_file: true, explanation: `Load 00OS architecture doc: ${doc}` });
  }

  // Load all documentation in cursor-rules
  const cursorRulesDocs = [
    'ai-identity-map.md',
    'cursor-rules-manipulation.md',
    'dual-mode-interface.md',
    'user-rules-manipulation.md',
    'cursor-rules-strategy.md'
  ];
  for (const doc of cursorRulesDocs) {
    await tools.call('read_file', { target_file: `00reaper/documentation/cursor-rules/${doc}`, should_read_entire_file: true, explanation: `Load cursor-rules doc: ${doc}` });
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

  // Load vision and roadmap documents
  await tools.call('read_file', { target_file: '00reaper/user-directed/final-goal.md', should_read_entire_file: true, explanation: 'Load final goal document' });

  return { success: true, result: '00OS documentation and standards loaded (full 00OS context)' };
}
```

---

### Flag: --1000xdev (1000xdev-Only Initialization)
```javascript
// Only load 1000xdev-specific files not included in the default context.
// The default `> reaper-init` must be run first for a complete baseline.
if (flags['1000xdev']) {
  // Load 1000xdev workflow, user rules, and user request files
  await tools.call('read_file', { target_file: '1000xdev/README.md', should_read_entire_file: true, explanation: 'Load 1000xdev workflow README' });
  await tools.call('read_file', { target_file: '1000xdev/documentation/workflow.md', should_read_entire_file: true, explanation: 'Load 1000xdev workflow doc' });
  await tools.call('read_file', { target_file: '1000xdev/user-directed/final-goals.md', should_read_entire_file: true, explanation: 'Load 1000xdev final goals' });
  await tools.call('read_file', { target_file: '1000xdev/user-rules-1000xdev.md', should_read_entire_file: true, explanation: 'Load 1000xdev user rules' });
  await tools.call('read_file', { target_file: '1000xdev/documentation/tool-call-processes.md', should_read_entire_file: true, explanation: 'Load 1000xdev tool call processes' });
  await tools.call('read_file', { target_file: '1000xdev/user-directed/user-request.md', should_read_entire_file: true, explanation: 'Load 1000xdev user request' });

  // Load 00OS 1000xdev process files
  await tools.call('read_file', { target_file: '00OS/processes/1000xdev/dev-init.md', should_read_entire_file: true, explanation: 'Load dev-init process' });
  await tools.call('read_file', { target_file: '00OS/processes/1000xdev/dev-git.md', should_read_entire_file: true, explanation: 'Load dev-git process' });
  await tools.call('read_file', { target_file: '00OS/processes/1000xdev/dev-scan-front-end.md', should_read_entire_file: true, explanation: 'Load dev-scan-front-end process' });
  await tools.call('read_file', { target_file: '00OS/processes/1000xdev/dev-scan-back-end.md', should_read_entire_file: true, explanation: 'Load dev-scan-back-end process' });

  // Load context state snapshot (if not already loaded by default)
  // (Optional: Only if not included in default context)
  // await tools.call('read_file', { target_file: '00reaper/context/1000xdev.md', should_read_entire_file: true, explanation: 'Load 1000xdev workflow context snapshot' });

  return { success: true, result: '1000xdev-specific context loaded (specialized files only)' };
}
```

---

### Flag: --self (00reaper Self-Enhancement Initialization)
```javascript
// Only load self-enhancement, research, or meta-workflow files not included in the default context.
// The default `> reaper-init` must be run first for a complete baseline.
if (flags['self']) {
  // List 00reaper workflow and process directories (for self-enhancement and meta-workflow)
  await tools.call('list_dir', { relative_workspace_path: '00reaper', explanation: 'List 00reaper root workflow files and folders' });
  await tools.call('list_dir', { relative_workspace_path: '00reaper/context', explanation: 'List 00reaper context files' });
  await tools.call('list_dir', { relative_workspace_path: '00reaper/documentation', explanation: 'List 00reaper documentation files' });
  await tools.call('list_dir', { relative_workspace_path: '00reaper/00scripts', explanation: 'List 00reaper automation scripts' });
  await tools.call('list_dir', { relative_workspace_path: '00reaper/research-cursor', explanation: 'List 00reaper research files' });
  await tools.call('list_dir', { relative_workspace_path: '00OS/processes/00reaper', explanation: 'List 00reaper process files in 00OS' });

  // Read 00reaper automation scripts (optional, for self-enhancement)
  await tools.call('read_file', { target_file: '00reaper/00scripts/Sync-00OS.ps1', should_read_entire_file: true, explanation: 'Read sync automation script' });
  await tools.call('read_file', { target_file: '00reaper/00scripts/Clean-SyncReports.ps1', should_read_entire_file: true, explanation: 'Read clean sync reports script' });
  await tools.call('read_file', { target_file: '00reaper/00scripts/Sync-00OS-Complete.ps1', should_read_entire_file: true, explanation: 'Read complete sync automation script' });

  // Read 00reaper research files
  await tools.call('read_file', { target_file: '00reaper/research-cursor/research-cursor-tool-call.md', should_read_entire_file: true, explanation: 'Read Cursor tool call research' });
  await tools.call('read_file', { target_file: '00reaper/research-cursor/research-cursor-rules-manipulation.md', should_read_entire_file: true, explanation: 'Read Cursor rules manipulation research' });
  await tools.call('read_file', { target_file: '00reaper/research-cursor/research-cursor-project-rules.md', should_read_entire_file: true, explanation: 'Read Cursor project rules research' });
  await tools.call('read_file', { target_file: '00reaper/research-cursor/research-cursor-user-rules.md', should_read_entire_file: true, explanation: 'Read Cursor user rules research' });

  return { success: true, result: '00reaper self-enhancement context loaded (specialized files only)' };
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