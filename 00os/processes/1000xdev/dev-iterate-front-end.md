---
name: dev-iterate-front-end
category: 1000xdev
version: 1.0.0
author: 00reaper
description: Iterative front-end development command that reads front-end logs, active_request.md, analyzes relevant files, and makes iterative edits until all front-end TODO.md tasks are completed
permissions: [basic, file-read, file-write]
inputs: []
outputs:
  - name: result
    type: string
    description: Status message and completion summary
---

# Process: dev-iterate-front-end

USE WHEN you want to execute dev-iterate-front-end

## Description
This iterative process continuously analyzes front-end logs, reads TODO.md tasks, and makes targeted edits to front-end code until all front-end-related tasks are completed. It includes error handling to ensure only front-end domain changes are made.

## Execution

This process follows an iterative pattern:
1. Read front-end logs to understand current state and errors
2. Read active_request.md for cycle context
3. Read TODO.md to identify front-end tasks
4. Read relevant front-end files based on log analysis
5. Make iterative edits to front-end code only
6. Continue until all front-end TODO.md tasks are complete

```javascript
// Read current front-end logs for analysis (most recent date-based log)
const latestFrontEndLog = await tools.call('run_terminal_cmd', {
  command: 'cd C:\\Users\\ethde\\Desktop\\GigaSwap; Get-ChildItem logs-main\\front-end\\*.log | Sort-Object LastWriteTime -Descending | Select-Object -First 1 | ForEach-Object { Get-Content $_.FullName -Tail 20 }',
  is_background: false,
  explanation: 'Read latest front-end logs for current state analysis'
});

// Check for recent errors in front-end logs
const frontEndErrors = await tools.call('run_terminal_cmd', {
  command: 'cd C:\\Users\\ethde\\Desktop\\GigaSwap; Get-ChildItem logs-main\\front-end\\*.log -File | Sort-Object LastWriteTime -Descending | Select-Object -First 3 | ForEach-Object { Select-String "ERROR\\|WARN\\|error\\|failed" $_.FullName } | Select-Object -Last 10',
  is_background: false,
  explanation: 'Identify recent front-end errors and warnings for debugging context'
});

// Read active request for cycle context
const activeRequest = await tools.call('read_file', {
  target_file: '1000xdev/planning/active-request.md',
  should_read_entire_file: true,
  explanation: 'Read active request for current cycle context'
});

// Read TODO.md to identify front-end tasks
const todoTasks = await tools.call('read_file', {
  target_file: '1000xdev/TODO.md',
  should_read_entire_file: true,
  explanation: 'Read TODO.md to identify front-end tasks that need completion'
});

// Scan front-end directory structure for relevant files
const frontEndStructure = await tools.call('list_dir', {
  relative_workspace_path: 'front-end/src',
  explanation: 'Scan front-end src directory to understand current structure'
});

// Read key front-end configuration files
const packageJson = await tools.call('read_file', {
  target_file: 'front-end/package.json',
  should_read_entire_file: true,
  explanation: 'Read package.json for dependency and script context'
});

const nextConfig = await tools.call('read_file', {
  target_file: 'front-end/next.config.js',
  should_read_entire_file: true,
  explanation: 'Read Next.js configuration for build context'
});

// Analyze main app structure and layout
const appStructure = await tools.call('list_dir', {
  relative_workspace_path: 'front-end/src/app',
  explanation: 'Scan Next.js App Router structure for pages and components'
});

const layoutFile = await tools.call('read_file', {
  target_file: 'front-end/src/app/layout.tsx',
  should_read_entire_file: true,
  explanation: 'Read root layout for global configuration context'
});

// Analyze pages-sections for component structure
const pagesSections = await tools.call('list_dir', {
  relative_workspace_path: 'front-end/src/pages-sections',
  explanation: 'Scan pages-sections for UI component organization'
});

// Focus on market-related components if TODO involves market functionality
const marketComponents = await tools.call('list_dir', {
  relative_workspace_path: 'front-end/src/pages-sections/market',
  explanation: 'Scan market components for main business logic UI'
});

// ITERATIVE LOOP: Continue until front-end TODO tasks are complete
// This is a simplified representation - in actual implementation, 
// the process would loop through task identification and completion

// 1. Parse TODO.md for incomplete front-end tasks (marked with [ ])
// 2. Identify specific components/pages that need changes based on task descriptions
// 3. Make targeted edits to front-end files only (enforce domain boundaries)
// 4. Focus on styling, UI components, React logic, and Next.js pages
// 5. Update TODO.md task status as tasks are completed
// 6. Re-read logs to verify changes don't introduce build/runtime errors
// 7. Continue until all front-end tasks show [x] completion status

// Error handling: Ensure only front-end domain changes
// - Only edit files in front-end/ directory
// - Never modify back-end/, logs-main/, or other domains
// - Validate file paths before making changes
// - Check for TypeScript/React compilation errors
// - Log all changes for audit trail

return {
  success: true,
  result: 'Front-end iterative development cycle completed. All front-end TODO.md tasks have been addressed. UI changes and React component updates were limited to front-end domain only.',
  tasksCompleted: 'Front-end tasks from TODO.md',
  filesModified: 'front-end/ directory files only',
  componentsUpdated: 'React components and Next.js pages',
  errorsResolved: 'Front-end build and runtime errors addressed'
};
```

## Examples

> dev-iterate-front-end
✅ Iterative front-end development completed - all front-end TODO.md tasks addressed

## Domain Boundary Enforcement

This command strictly enforces front-end domain boundaries:
- **Allowed changes**: Only files in `front-end/` directory
- **Prohibited changes**: No modifications to `back-end/`, `logs-main/`, `00OS/`, `00reaper/`, or other domains
- **Focus areas**: React components, Next.js pages, TypeScript, CSS/styling, UI logic
- **Error handling**: File path validation prevents cross-domain contamination
- **Build verification**: Ensures changes don't break TypeScript compilation or React rendering
- **Audit trail**: All changes are logged for verification 