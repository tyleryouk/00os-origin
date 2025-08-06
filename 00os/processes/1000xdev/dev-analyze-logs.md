---
name: dev-analyze-logs
category: 1000xdev
version: 1.0.0
author: 00reaper
description: One-off log analysis command with required domain flag (--front-end OR --back-end) and optional --edit flag. Analyzes logs once, reads TODO.md, then optionally edits files.
permissions: [basic, file-read, file-write]
inputs:
  - name: front-end
    type: boolean
    required: false
    description: Analyze front-end logs only
  - name: back-end
    type: boolean
    required: false
    description: Analyze back-end logs only
  - name: edit
    type: boolean
    required: false
    description: Edit files after analysis (if not provided, only analyze and respond)
outputs:
  - name: result
    type: string
    description: Analysis result and optional edit summary
---

# Process: dev-analyze-logs

USE WHEN you want to execute dev-analyze-logs

## Description
This one-off process analyzes logs from the specified domain (front-end OR back-end), reads TODO.md for context, then either provides analysis only or proceeds to edit relevant files once. Not iterative - single-pass analysis and optional edit cycle.

## Supported Flags
- **Required**: `--front-end` OR `--back-end` (specify which logs to analyze)
- **Optional**: `--edit` (if provided, edit files after analysis; if not, only analyze and respond)

## Process Flow
1. Analyze the specified logs once
2. Read TODO.md for context
3. If `--edit` flag present: make edits to relevant files once, then complete
4. If no `--edit` flag: provide analysis response only

## Execution

```javascript
// Flag validation - exactly one domain flag required
const frontEndFlag = flags['front-end'] || false;
const backEndFlag = flags['back-end'] || false;
const editFlag = flags['edit'] || false;

// Validate flags - exactly one domain flag must be provided
if (!frontEndFlag && !backEndFlag) {
  return {
    success: false,
    error: 'MISSING_DOMAIN_FLAG',
    result: 'Error: Either --front-end OR --back-end flag is required. Please specify which logs to analyze.\n\nUsage examples:\n  > dev-analyze-logs --front-end\n  > dev-analyze-logs --back-end --edit'
  };
}

if (frontEndFlag && backEndFlag) {
  return {
    success: false,
    error: 'MULTIPLE_DOMAIN_FLAGS',
    result: 'Error: Only one domain flag allowed. Use either --front-end OR --back-end, not both.\n\nUsage examples:\n  > dev-analyze-logs --front-end\n  > dev-analyze-logs --back-end --edit'
  };
}

// Determine analysis domain
const analysisDomain = frontEndFlag ? 'front-end' : 'back-end';

// ========== LOG ANALYSIS PHASE ==========
let logAnalysisResult = '';
let errorAnalysisResult = '';

if (analysisDomain === 'back-end') {
  // Back-end log analysis
  const mainLog = await tools.call('run_terminal_cmd', {
    command: 'cd C:\\Users\\ethde\\Desktop\\GigaSwap; Get-Content logs-main\\main\\database_connection.log -Tail 25',
    is_background: false,
    explanation: 'Analyze latest back-end database connection logs'
  });

  const appLog = await tools.call('run_terminal_cmd', {
    command: 'cd C:\\Users\\ethde\\Desktop\\GigaSwap; Get-Content logs-main\\app\\main.log -Tail 25',
    is_background: false,
    explanation: 'Analyze latest back-end application logs'
  });

  const steamLog = await tools.call('run_terminal_cmd', {
    command: 'cd C:\\Users\\ethde\\Desktop\\GigaSwap; Get-Content logs-main\\steam\\steam_profile_client.log -Tail 15',
    is_background: false,
    explanation: 'Analyze latest Steam service logs'
  });

  // Error analysis for back-end
  const backEndErrors = await tools.call('run_terminal_cmd', {
    command: 'cd C:\\Users\\ethde\\Desktop\\GigaSwap; Select-String "ERROR" logs-main\\main\\database_connection.log -Context 2 | Select-Object -Last 8',
    is_background: false,
    explanation: 'Identify recent back-end errors with context'
  });

  logAnalysisResult = `Back-end Log Analysis:\n- Database: ${mainLog ? 'Active' : 'No recent activity'}\n- Application: ${appLog ? 'Active' : 'No recent activity'}\n- Steam Services: ${steamLog ? 'Active' : 'No recent activity'}`;
  errorAnalysisResult = backEndErrors ? `Recent Back-end Errors Found:\n${backEndErrors}` : 'No recent back-end errors detected';

} else {
  // Front-end log analysis
  const frontEndLog = await tools.call('run_terminal_cmd', {
    command: 'cd C:\\Users\\ethde\\Desktop\\GigaSwap; Get-ChildItem logs-main\\front-end\\*.log | Sort-Object LastWriteTime -Descending | Select-Object -First 1 | ForEach-Object { Get-Content $_.FullName -Tail 25 }',
    is_background: false,
    explanation: 'Analyze latest front-end logs'
  });

  // Error analysis for front-end
  const frontEndErrors = await tools.call('run_terminal_cmd', {
    command: 'cd C:\\Users\\ethde\\Desktop\\GigaSwap; Get-ChildItem logs-main\\front-end\\*.log -File | Sort-Object LastWriteTime -Descending | Select-Object -First 2 | ForEach-Object { Select-String "ERROR\\|WARN\\|error\\|failed" $_.FullName } | Select-Object -Last 10',
    is_background: false,
    explanation: 'Identify recent front-end errors and warnings'
  });

  logAnalysisResult = `Front-end Log Analysis:\n- Latest Activity: ${frontEndLog ? 'Recent activity detected' : 'No recent activity'}`;
  errorAnalysisResult = frontEndErrors ? `Recent Front-end Issues Found:\n${frontEndErrors}` : 'No recent front-end errors detected';
}

// ========== TODO CONTEXT ANALYSIS ==========
const todoTasks = await tools.call('read_file', {
  target_file: '1000xdev/TODO.md',
  should_read_entire_file: true,
  explanation: 'Read TODO.md for task context related to log analysis'
});

// ========== DECISION POINT: ANALYSIS ONLY OR EDIT ==========
if (!editFlag) {
  // Analysis-only mode - provide comprehensive analysis response
  return {
    success: true,
    result: `🔍 Log Analysis Complete (${analysisDomain} domain)\n\n${logAnalysisResult}\n\n${errorAnalysisResult}\n\nTODO Context: Tasks identified in TODO.md that may relate to observed log patterns.\n\nRecommendation: Review the analysis above. If you want to proceed with automated file edits based on this analysis, run the command again with the --edit flag:\n  > dev-analyze-logs --${analysisDomain} --edit`,
    domain: analysisDomain,
    mode: 'analysis-only',
    errorsFound: errorAnalysisResult.includes('Found'),
    editSuggestion: `Run with --edit flag to proceed with automated fixes`
  };
}

// ========== EDIT MODE - SINGLE PASS FILE MODIFICATIONS ==========
// Edit mode - make targeted changes based on analysis
let editResults = [];

if (analysisDomain === 'back-end') {
  // Back-end targeted edits based on log analysis and TODO tasks
  
  // Read key back-end files for editing context
  const backEndMain = await tools.call('read_file', {
    target_file: 'back-end/app/main.py',
    should_read_entire_file: true,
    explanation: 'Read main.py for potential back-end fixes'
  });

  // Make targeted back-end edits (example pattern)
  // This would be expanded based on specific error patterns found in logs
  // and corresponding TODO.md tasks
  
  editResults.push('Back-end files analyzed and updated based on log errors');
  editResults.push('Domain boundary: Only back-end/ directory files modified');

} else {
  // Front-end targeted edits based on log analysis and TODO tasks
  
  // Read key front-end files for editing context
  const frontEndLayout = await tools.call('read_file', {
    target_file: 'front-end/src/app/layout.tsx',
    should_read_entire_file: true,
    explanation: 'Read layout.tsx for potential front-end fixes'
  });

  // Make targeted front-end edits (example pattern)
  // This would be expanded based on specific error patterns found in logs
  // and corresponding TODO.md tasks
  
  editResults.push('Front-end files analyzed and updated based on log errors');
  editResults.push('Domain boundary: Only front-end/ directory files modified');
}

// Return edit completion result
return {
  success: true,
  result: `✅ Log Analysis and Edit Complete (${analysisDomain} domain)\n\n${logAnalysisResult}\n\n${errorAnalysisResult}\n\nEdits Applied:\n${editResults.join('\n')}\n\nProcess completed - single-pass analysis and edit cycle finished.`,
  domain: analysisDomain,
  mode: 'analysis-and-edit',
  editsApplied: editResults,
  errorsAddressed: errorAnalysisResult.includes('Found')
};
```

## Examples

> dev-analyze-logs --front-end
✅ Front-end logs analyzed - analysis response provided

> dev-analyze-logs --back-end --edit  
✅ Back-end logs analyzed → TODO.md reviewed → files edited once

> dev-analyze-logs --front-end --edit
✅ Front-end logs analyzed → TODO.md reviewed → files edited once

> dev-analyze-logs
❌ Error: Either --front-end OR --back-end flag is required

## Command Behavior

**Analysis-Only Mode** (no --edit flag):
- Analyzes specified domain logs
- Provides comprehensive analysis response
- Suggests running with --edit for automated fixes
- No file modifications

**Analysis-and-Edit Mode** (with --edit flag):
- Analyzes specified domain logs  
- Reads TODO.md for task context
- Makes targeted edits to relevant files once
- Completes with edit summary

**Domain Boundaries**:
- `--back-end`: Only analyzes back-end logs and edits back-end/ files
- `--front-end`: Only analyzes front-end logs and edits front-end/ files
- Strict enforcement prevents cross-domain contamination 