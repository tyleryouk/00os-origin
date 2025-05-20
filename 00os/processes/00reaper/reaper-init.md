---
name: reaper-init
description: Initialize 00reaper context and system understanding
category: 00reaper
author: 00reaper
version: 2.1
---

# Process: reaper-init

USE WHEN you want to execute reaper-init

## Execution

This process loads all critical context and documentation files for 00reaper and 00OS:

1. Load core workflow files:
```javascript
await tools.call('read_file', {
  target_file: '00reaper/README.md',
  should_read_entire_file: true,
  explanation: 'Load workflow README'
});
await tools.call('read_file', {
  target_file: '00reaper/active-request.md',
  should_read_entire_file: true,
  explanation: 'Load active request'
});
await tools.call('read_file', {
  target_file: '00reaper/implementation-plan.md',
  should_read_entire_file: true,
  explanation: 'Load implementation plan'
});
await tools.call('read_file', {
  target_file: '00reaper/cycle-status.md',
  should_read_entire_file: true,
  explanation: 'Load cycle status'
});
```
2. Load vision and roadmap documents:
```javascript
await tools.call('read_file', {
  target_file: '00reaper/user-directed/final-goal.md',
  should_read_entire_file: true,
  explanation: 'Load final goal document'
});
await tools.call('read_file', {
  target_file: '00reaper/user-directed/00OS-simplification-roadmap.md',
  should_read_entire_file: true,
  explanation: 'Load simplification roadmap'
});
```
3. Load command template and standards:
```javascript
await tools.call('read_file', {
  target_file: '00reaper/documentation/command-template-core.md',
  should_read_entire_file: true,
  explanation: 'Load command template'
});
await tools.call('read_file', {
  target_file: '00reaper/documentation/command-standards-core.md',
  should_read_entire_file: true,
  explanation: 'Load command standards'
});
```
4. Load context state snapshot:
```javascript
await tools.call('read_file', {
  target_file: '00reaper/context-00OS-current-state/core.md',
  should_read_entire_file: true,
  explanation: 'Load core context snapshot'
});
```

## Examples

> reaper-init
✅ 00reaper context initialized and all core files loaded 