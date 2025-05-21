---
name: dev-scan-front-end
description: Scan and summarize the front-end codebase for 1000xdev
author: 00reaper
version: 1.0.0
category: 1000xdev
permissions: [basic]
inputs: []
outputs:
  - name: summary
    type: string
    description: Summary of the front-end codebase
---

# Process: dev-scan-front-end

USE WHEN you want to execute dev-scan-front-end

## Execution

This process scans and summarizes the front-end codebase:

1. List the main front-end directory
2. Search for key files and components
3. Summarize the structure and main features

```javascript
const dirResult = await tools.call('list_dir', {
  relative_workspace_path: 'front-end/src',
  explanation: 'List main front-end source directory'
});
const searchResult = await tools.call('codebase_search', {
  query: 'main app structure OR key components OR entry point',
  target_directories: ['front-end/src'],
  explanation: 'Search for main app structure and key components'
});
return {
  success: true,
  summary: `Directory: ${JSON.stringify(dirResult)}\nKey components: ${JSON.stringify(searchResult)}`
};
```

## Examples

> dev-scan-front-end
✅ Front-end codebase scanned and summarized 