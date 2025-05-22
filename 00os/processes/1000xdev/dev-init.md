---
name: dev-init
description: Load all relevant workflow, context, and standards for 1000xdev
author: 00reaper
version: 1.0.0
category: 1000xdev
permissions: [basic]
inputs: []
outputs:
  - name: result
    type: string
    description: Initialization status
---

# Process: dev-init

USE WHEN you want to execute dev-init

## Execution

This process loads all key workflow, documentation, and context files for 1000xdev:

1. Load 1000xdev/README.md
2. Load 1000xdev/documentation/workflow.md
3. Load 1000xdev/documentation/final-goals.md
4. Load 1000xdev/documentation/tool-call-processes.md
5. Load 1000xdev/context/steam.md
6. Load 1000xdev/context/context-front-end-api.md

```javascript
await tools.call('read_file', {
  target_file: '1000xdev/README.md',
  should_read_entire_file: true,
  explanation: 'Load 1000xdev workflow overview'
});
await tools.call('read_file', {
  target_file: '1000xdev/documentation/workflow.md',
  should_read_entire_file: true,
  explanation: 'Load main workflow documentation'
});
await tools.call('read_file', {
  target_file: '1000xdev/documentation/final-goals.md',
  should_read_entire_file: true,
  explanation: 'Load final goals documentation'
});
await tools.call('read_file', {
  target_file: '1000xdev/documentation/tool-call-processes.md',
  should_read_entire_file: true,
  explanation: 'Load tool call processes documentation'
});
await tools.call('read_file', {
  target_file: '1000xdev/context/steam.md',
  should_read_entire_file: true,
  explanation: 'Load backend context snapshot'
});
await tools.call('read_file', {
  target_file: '1000xdev/context/context-front-end-api.md',
  should_read_entire_file: true,
  explanation: 'Load frontend context snapshot'
});
```

## Examples

> dev-init
✅ 1000xdev context initialized and all core files loaded 