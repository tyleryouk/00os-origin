---
name: dev-iterate-full-stack
category: 1000xdev
version: 1.0.0
author: 00reaper
description: Iterative full-stack development command that reads both back-end and front-end logs, coordinates changes across domains, and makes iterative edits until all full-stack TODO.md tasks are completed
permissions: [basic, file-read, file-write]
inputs: []
outputs:
  - name: result
    type: string
    description: Status message and completion summary
---

# Process: dev-iterate-full-stack

USE WHEN you want to execute dev-iterate-full-stack

## Description
This iterative process continuously analyzes both back-end and front-end logs, reads TODO.md tasks, and makes coordinated edits across both domains until all full-stack-related tasks are completed. It handles dependencies between front-end and back-end changes while maintaining domain boundaries.

## Execution

This process follows an iterative full-stack pattern:
1. Read both back-end and front-end logs to understand system state
2. Read active_request.md for cycle context
3. Read TODO.md to identify full-stack tasks
4. Analyze dependencies between front-end and back-end changes
5. Make coordinated edits to both domains with proper sequencing
6. Continue until all full-stack TODO.md tasks are complete

```javascript
// ========== BACK-END LOG ANALYSIS ==========
// Read current back-end logs for analysis
const latestMainLog = await tools.call('run_terminal_cmd', {
  command: 'cd C:\\Users\\ethde\\Desktop\\GigaSwap; Get-Content logs-main\\main\\database_connection.log -Tail 15',
  is_background: false,
  explanation: 'Read latest database connection logs for back-end state analysis'
});

const latestAppLog = await tools.call('run_terminal_cmd', {
  command: 'cd C:\\Users\\ethde\\Desktop\\GigaSwap; Get-Content logs-main\\app\\main.log -Tail 15',
  is_background: false,
  explanation: 'Read latest main app logs for back-end state analysis'
});

const steamLogs = await tools.call('run_terminal_cmd', {
  command: 'cd C:\\Users\\ethde\\Desktop\\GigaSwap; Get-Content logs-main\\steam\\steam_profile_client.log -Tail 10',
  is_background: false,
  explanation: 'Read Steam service logs for API integration status'
});

// Check for recent back-end errors
const backEndErrors = await tools.call('run_terminal_cmd', {
  command: 'cd C:\\Users\\ethde\\Desktop\\GigaSwap; Select-String "ERROR" logs-main\\main\\database_connection.log -Context 1 | Select-Object -Last 5',
  is_background: false,
  explanation: 'Identify recent back-end errors for debugging context'
});

// ========== FRONT-END LOG ANALYSIS ==========
// Read current front-end logs for analysis
const latestFrontEndLog = await tools.call('run_terminal_cmd', {
  command: 'cd C:\\Users\\ethde\\Desktop\\GigaSwap; Get-ChildItem logs-main\\front-end\\*.log | Sort-Object LastWriteTime -Descending | Select-Object -First 1 | ForEach-Object { Get-Content $_.FullName -Tail 15 }',
  is_background: false,
  explanation: 'Read latest front-end logs for current state analysis'
});

// Check for recent front-end errors
const frontEndErrors = await tools.call('run_terminal_cmd', {
  command: 'cd C:\\Users\\ethde\\Desktop\\GigaSwap; Get-ChildItem logs-main\\front-end\\*.log -File | Sort-Object LastWriteTime -Descending | Select-Object -First 2 | ForEach-Object { Select-String "ERROR\\|WARN\\|error\\|failed" $_.FullName } | Select-Object -Last 8',
  is_background: false,
  explanation: 'Identify recent front-end errors and warnings for debugging context'
});

// ========== CONTEXT AND TASK ANALYSIS ==========
// Read active request for cycle context
const activeRequest = await tools.call('read_file', {
  target_file: '1000xdev/planning/active-request.md',
  should_read_entire_file: true,
  explanation: 'Read active request for current cycle context'
});

// Read TODO.md to identify full-stack tasks
const todoTasks = await tools.call('read_file', {
  target_file: '1000xdev/TODO.md',
  should_read_entire_file: true,
  explanation: 'Read TODO.md to identify full-stack tasks that need completion'
});

// ========== ARCHITECTURE ANALYSIS ==========
// Scan both back-end and front-end structures
const backEndStructure = await tools.call('list_dir', {
  relative_workspace_path: 'back-end/app',
  explanation: 'Scan back-end app directory to understand current structure'
});

const frontEndStructure = await tools.call('list_dir', {
  relative_workspace_path: 'front-end/src',
  explanation: 'Scan front-end src directory to understand current structure'
});

// Read key integration points between front-end and back-end
const backEndMain = await tools.call('read_file', {
  target_file: 'back-end/app/main.py',
  should_read_entire_file: true,
  explanation: 'Read FastAPI main entry point for API endpoint context'
});

const frontEndApiClient = await tools.call('read_file', {
  target_file: 'front-end/src/api/client.ts',
  should_read_entire_file: true,
  explanation: 'Read front-end API client configuration for integration context'
});

// Analyze market-related integration points (key business logic)
const backEndSteamRoutes = await tools.call('list_dir', {
  relative_workspace_path: 'back-end/app/steam/routes',
  explanation: 'Scan Steam API routes for back-end business logic'
});

const frontEndMarketComponents = await tools.call('list_dir', {
  relative_workspace_path: 'front-end/src/pages-sections/market',
  explanation: 'Scan market components for front-end business logic UI'
});

// ========== ITERATIVE FULL-STACK COORDINATION ==========
// ITERATIVE LOOP: Continue until full-stack TODO tasks are complete
// This process coordinates changes across both domains while maintaining boundaries

// 1. Parse TODO.md for incomplete full-stack tasks (marked with [ ])
// 2. Identify dependencies between front-end and back-end changes
// 3. Sequence changes appropriately (often back-end API first, then front-end integration)
// 4. Make targeted edits to both back-end/ and front-end/ directories
// 5. Verify integration points work correctly between domains
// 6. Update TODO.md task status as coordinated tasks are completed
// 7. Re-read logs from both domains to verify no integration errors
// 8. Continue until all full-stack tasks show [x] completion status

// COORDINATION PRINCIPLES:
// - API changes in back-end typically come before front-end integration
// - Database schema changes require both back-end services and front-end models
// - Authentication flows require coordination between auth services and UI
// - Steam API integration requires both back-end clients and front-end display components
// - Error handling should be consistent across both domains

// Error handling: Coordinate both domains while maintaining boundaries
// - Edit files in both back-end/ and front-end/ directories as needed
// - Never modify logs-main/, 00OS/, 00reaper/, or other domains
// - Validate file paths before making changes in both domains
// - Ensure API contracts remain consistent between back-end and front-end
// - Check for integration errors across domain boundaries
// - Log all changes in both domains for audit trail

return {
  success: true,
  result: 'Full-stack iterative development cycle completed. All full-stack TODO.md tasks have been addressed with coordinated changes across both back-end and front-end domains.',
  tasksCompleted: 'Full-stack tasks from TODO.md',
  backEndFilesModified: 'back-end/ directory files',
  frontEndFilesModified: 'front-end/ directory files',
  integrationPointsUpdated: 'API contracts and cross-domain communication',
  errorsResolved: 'Both back-end and front-end errors addressed with coordination'
};
```

## Examples

> dev-iterate-full-stack
✅ Iterative full-stack development completed - all full-stack TODO.md tasks addressed with coordination

## Full-Stack Coordination Principles

This command coordinates changes across both domains while maintaining boundaries:
- **Allowed changes**: Files in both `back-end/` and `front-end/` directories
- **Prohibited changes**: No modifications to `logs-main/`, `00OS/`, `00reaper/`, or other domains
- **Coordination areas**: API endpoints, data models, authentication flows, business logic integration
- **Sequencing**: Back-end API changes typically precede front-end integration updates
- **Integration testing**: Verify contracts and communication between domains
- **Error handling**: Comprehensive monitoring of both back-end and front-end logs
- **Audit trail**: All changes in both domains are logged for verification 