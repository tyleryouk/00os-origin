---
name: reaper-init
description: Initialize the context and documentation for 00reaper, 00OS, and 1000xdev. The --00os flag loads all 00OS and cursor-rules documentation.
version: 1.1.1
author: 00reaper
permissions: [basic, file-read]
inputs:
  - name: 00os
    type: boolean
    required: false
    default: false
    description: Only initialize 00OS context, documentation, and research
  - name: 1000xdev
    type: boolean
    required: false
    default: false
    description: Only initialize 1000xdev context, documentation, workflow, and process files
  - name: self
    type: boolean
    required: false
    default: false
    description: Only initialize 00reaper self-enhancement and meta-workflow files
outputs: []
examples:
  - command: "> reaper-init"
    description: Load all core workflow, context, and documentation files
  - command: "> reaper-init --00os"
    description: Load all 00OS and cursor-rules documentation
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

  return { success: true, result: '00reaper baseline context initialized (essential files only)' };
}
```

---

### Flag: --00os (00OS-Only Initialization)
```javascript
// Loads all 00OS-architecture documentation and standards files.
// Run this after the default `> reaper-init` for a full 00OS context.
if (flags['00os']) {
  // Read all files in 00reaper/documentation/00OS-architecture
  await tools.call('read_file', { target_file: '00reaper/documentation/00OS-architecture/00OS-command-user-guide.md', should_read_entire_file: true, explanation: 'Load 00OS architecture doc: 00OS-command-user-guide.md' });
  await tools.call('read_file', { target_file: '00reaper/documentation/00OS-architecture/00OS-command-development.md', should_read_entire_file: true, explanation: 'Load 00OS architecture doc: 00OS-command-development.md' });
  await tools.call('read_file', { target_file: '00reaper/documentation/00OS-architecture/tool-call-patterns.md', should_read_entire_file: true, explanation: 'Load 00OS architecture doc: tool-call-patterns.md' });
  await tools.call('read_file', { target_file: '00reaper/documentation/00OS-architecture/00OS-rationale.md', should_read_entire_file: true, explanation: 'Load 00OS architecture doc: 00OS-rationale.md' });
  await tools.call('read_file', { target_file: '00reaper/documentation/00OS-architecture/README.md', should_read_entire_file: true, explanation: 'Load 00OS architecture doc: README.md' });

  // Read all files in 00reaper/documentation/cursor-rules
  await tools.call('read_file', { target_file: '00reaper/documentation/cursor-rules/ai-identity-map.md', should_read_entire_file: true, explanation: 'Load cursor-rules doc: ai-identity-map.md' });
  await tools.call('read_file', { target_file: '00reaper/documentation/cursor-rules/cursor-rules-manipulation.md', should_read_entire_file: true, explanation: 'Load cursor-rules doc: cursor-rules-manipulation.md' });
  await tools.call('read_file', { target_file: '00reaper/documentation/cursor-rules/dual-mode-interface.md', should_read_entire_file: true, explanation: 'Load cursor-rules doc: dual-mode-interface.md' });
  await tools.call('read_file', { target_file: '00reaper/documentation/cursor-rules/user-rules-manipulation.md', should_read_entire_file: true, explanation: 'Load cursor-rules doc: user-rules-manipulation.md' });
  await tools.call('read_file', { target_file: '00reaper/documentation/cursor-rules/cursor-rules-strategy.md', should_read_entire_file: true, explanation: 'Load cursor-rules doc: cursor-rules-strategy.md' });

  return { success: true, result: '00OS and cursor-rules documentation loaded (full 00OS context)' };
}
```

---

### Flag: --1000xdev (1000xdev-Only Initialization)
```javascript
// Only load 1000xdev-specific files not included in the default context.
// The default `> reaper-init` must be run first for a complete baseline.
if (flags['1000xdev']) {
  // Read all files in 00reaper/documentation/ai-identities
  await tools.call('read_file', { target_file: '00reaper/documentation/ai-identities/00reaper.md', should_read_entire_file: true, explanation: 'Load ai-identities doc: 00reaper.md' });
  await tools.call('read_file', { target_file: '00reaper/documentation/ai-identities/1000xdev.md', should_read_entire_file: true, explanation: 'Load ai-identities doc: 1000xdev.md' });
  await tools.call('read_file', { target_file: '00reaper/documentation/ai-identities/user.md', should_read_entire_file: true, explanation: 'Load ai-identities doc: user.md' });

  // List all process files in 00OS/processes/1000xdev
  await tools.call('list_dir', { relative_workspace_path: '00OS/processes/1000xdev', explanation: 'List all 1000xdev process files' });

  return { success: true, result: '1000xdev identity documentation and process list loaded (flag: --1000xdev)' };
}
```

---

### Flag: --self (00reaper Self-Enhancement Initialization)
```javascript
// Only load self-enhancement, research, or meta-workflow files not included in the default context.
// The default `> reaper-init` must be run first for a complete baseline.
if (flags['self']) {
  // Read all files in 00reaper/documentation/00reaper-identity
  await tools.call('read_file', { target_file: '00reaper/documentation/00reaper-identity/README.md', should_read_entire_file: true, explanation: 'Load 00reaper-identity doc: README.md' });
  await tools.call('read_file', { target_file: '00reaper/documentation/00reaper-identity/identity.md', should_read_entire_file: true, explanation: 'Load 00reaper-identity doc: identity.md' });
  await tools.call('read_file', { target_file: '00reaper/documentation/00reaper-identity/00os-integration.md', should_read_entire_file: true, explanation: 'Load 00reaper-identity doc: 00os-integration.md' });

  // Read all files in 00reaper/documentation/ai-identities
  await tools.call('read_file', { target_file: '00reaper/documentation/ai-identities/00reaper.md', should_read_entire_file: true, explanation: 'Load ai-identities doc: 00reaper.md' });
  await tools.call('read_file', { target_file: '00reaper/documentation/ai-identities/1000xdev.md', should_read_entire_file: true, explanation: 'Load ai-identities doc: 1000xdev.md' });
  await tools.call('read_file', { target_file: '00reaper/documentation/ai-identities/user.md', should_read_entire_file: true, explanation: 'Load ai-identities doc: user.md' });

  // List all process files in 00OS/processes/00reaper
  await tools.call('list_dir', { relative_workspace_path: '00OS/processes/00reaper', explanation: 'List all 00reaper process files' });

  return { success: true, result: '00reaper self-enhancement and identity documentation loaded (flag: --self)' };
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