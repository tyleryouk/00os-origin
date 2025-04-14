# Process: reaper-sync

## Metadata
- Name: reaper-sync
- Description: Synchronize 00os contents to .cursor/rules
- Category: system
- Permissions: system.write
- Author: 00reaper
- Version: 1.0

## Input
- subcommand: Optional subcommand (currently supports "status")
- detect-orphans: Flag to detect orphaned .mdc files (--detect-orphans)
- remove-orphans: Flag to remove orphaned .mdc files (--remove-orphans)
- verbose: Flag to show detailed sync information (--verbose)
- dry-run: Flag to simulate synchronization without making changes (--dry-run)

## Output
- Formatted synchronization results or status information

## Execution

This process triggers the synchronization of the 00os directory to .cursor/rules, converting markdown files to the proper rule format with frontmatter. It allows direct integration of the sync functionality into the 00OS command interface.

### Synchronization Procedure

The process performs the following actions:

1. Validates input parameters for compatibility
2. Executes the appropriate sync scripts with the specified options
3. Captures and formats the output for display
4. Tracks synchronization status and history

For status inquiries, it provides information about the last synchronization run and current differences between 00os and .cursor/rules.

### Process Execution

```javascript
// Parse inputs and prepare parameters
const params = [];
const syncType = inputs.subcommand || 'full';

// Handle flags
if (inputs['detect-orphans']) {
  params.push('-DetectOrphans');
}

if (inputs['remove-orphans']) {
  params.push('-RemoveOrphans');
}

// Track verbose setting for our own output formatting
const isVerbose = !!inputs.verbose;
const isDryRun = !!inputs['dry-run'];

// Status subcommand handling
if (syncType === 'status') {
  return handleStatusSubcommand(isVerbose);
}

// Prepare result storage
let syncOutput = '';
let errorOutput = '';
let exitCode = 0;

try {
  // Build the command to execute
  let syncCmd = '.\\1000xscripts\\Sync-00OS.bat';
  
  // Add parameters
  if (params.length > 0) {
    syncCmd += ' ' + params.join(' ');
  }
  
  // Add dry-run flag handling for PowerShell script
  if (isDryRun) {
    syncCmd = syncCmd.replace('Sync-00OS.bat', 'Sync-00OS.bat -WhatIf');
  }
  
  // Log the sync start
  logSyncEvent('Started synchronization from 00os to .cursor/rules');
  
  // Execute the sync script - ACTUAL COMMAND EXECUTION
  const result = tools.run_terminal_cmd({
    command: syncCmd,
    explanation: 'Running sync process to update .cursor/rules from 00os',
    is_background: false
  });
  
  // Process the result
  syncOutput = result.output || '';
  errorOutput = result.error || '';
  exitCode = result.exitCode || 0;
  
  // Log the completion status
  if (exitCode === 0) {
    logSyncEvent('Completed synchronization successfully');
  } else {
    logSyncEvent(`Synchronization failed with exit code ${exitCode}`);
  }
  
} catch (error) {
  errorOutput = error.message;
  exitCode = 1;
  logSyncEvent(`Synchronization error: ${error.message}`);
}

// Format the output based on the results
return formatSyncResults(syncOutput, errorOutput, exitCode, isVerbose, isDryRun);

/**
 * Executes a command and returns the result
 */
function executeCommand(command) {
  // This would actually call the shell to execute the command
  // For this example, we'll simulate the execution
  
  // In a real implementation, this would use something like:
  // const result = tools.run_terminal_cmd({ command, explanation: 'Running sync process' });
  
  // For simulation purposes:
  const simulatedResult = {
    output: `
====================================================
00OS to Cursor Rules Synchronization
====================================================

Running synchronization from 00os directory...
This will:
1. Find all markdown files in 00os (excluding README.md files)
2. Update corresponding Cursor Rules with content (preserving frontmatter)
3. Create new Cursor Rules for files that don't have a corresponding rule
4. Generate a detailed synchronization report

Starting synchronization...

Processed 27 files:
- 25 files synchronized successfully
- 2 new files created
- 0 files with errors

Synchronization report saved to: 1000xscripts/sync-reports/sync-report-20230615-120145.json

Running sync report cleanup...

====================================================
Synchronization completed!
====================================================
`,
    error: '',
    exitCode: 0
  };
  
  return simulatedResult;
}

/**
 * Handles the status subcommand
 */
function handleStatusSubcommand(verbose) {
  // Get last sync information
  const lastSync = getLastSyncInfo();
  
  // Get current differences
  const differences = getSyncDifferences();
  
  // Format basic status output
  let output = `
✅ 00OS Sync Status

Last synchronization: ${lastSync.timestamp}
Status: ${lastSync.success ? 'Successful' : 'Failed'}
Files processed: ${lastSync.filesProcessed}
`;

  // Add differences summary
  output += `
Current differences:
- ${differences.newFiles.length} new files in 00os
- ${differences.modifiedFiles.length} modified files
- ${differences.orphanedFiles.length} orphaned files in .cursor/rules
`;

  // Add detailed information if verbose
  if (verbose) {
    output += `
DETAILED DIFFERENCES
-------------------
New files:
${differences.newFiles.map(f => `  - ${f}`).join('\n') || '  None'}

Modified files:
${differences.modifiedFiles.map(f => `  - ${f}`).join('\n') || '  None'}

Orphaned files:
${differences.orphanedFiles.map(f => `  - ${f}`).join('\n') || '  None'}

SYNC HISTORY
------------
${lastSync.history.map(h => `${h.timestamp}: ${h.message}`).join('\n')}
`;
  } else {
    output += `
Use 'reaper-sync status --verbose' for detailed information.
Use 'reaper-sync' to perform synchronization.
`;
  }
  
  return output;
}

/**
 * Gets information about the last synchronization
 */
function getLastSyncInfo() {
  // This would read from a stored sync history file
  // For this example, we'll return simulated data
  return {
    timestamp: '2023-06-15 11:45:22',
    success: true,
    filesProcessed: 27,
    history: [
      { timestamp: '2023-06-15 11:45:22', message: 'Completed synchronization successfully' },
      { timestamp: '2023-06-15 11:45:20', message: 'Started synchronization from 00os to .cursor/rules' },
      { timestamp: '2023-06-14 15:30:45', message: 'Completed synchronization successfully' },
      { timestamp: '2023-06-14 15:30:40', message: 'Started synchronization from 00os to .cursor/rules' }
    ]
  };
}

/**
 * Gets current differences between 00os and .cursor/rules
 */
function getSyncDifferences() {
  // This would actually scan directories and compare files
  // For this example, we'll return simulated data
  return {
    newFiles: [
      '00os/processes/system/reaper-sync.md'
    ],
    modifiedFiles: [
      '00os/processes/system/reaper-init.md',
      '00os/core/parser.md'
    ],
    orphanedFiles: [
      '.cursor/rules/old-command.mdc'
    ]
  };
}

/**
 * Formats the synchronization results for display
 */
function formatSyncResults(output, error, exitCode, verbose, isDryRun) {
  const resultPrefix = isDryRun ? '🔍 DRY RUN' : (exitCode === 0 ? '✅ SYNC COMPLETED' : '❌ SYNC FAILED');
  
  // Extract key information from the output
  const fileStats = extractFileStats(output);
  
  // Create basic output
  let formattedOutput = `
${resultPrefix}

${fileStats ? `Files processed: ${fileStats.total}
- ${fileStats.synced} synchronized
- ${fileStats.created} created
- ${fileStats.errors} errors` : 'No file statistics available'}
`;

  // Add error information if present
  if (error && error.length > 0) {
    formattedOutput += `
ERROR:
${error}`;
  }
  
  // Add verbose output if requested
  if (verbose) {
    formattedOutput += `
DETAILED OUTPUT:
--------------
${output}`;
  } else if (exitCode !== 0) {
    formattedOutput += `
Use 'reaper-sync --verbose' for detailed error information.`;
  }
  
  // Add dry run notice
  if (isDryRun) {
    formattedOutput += `
NOTE: This was a dry run. No actual changes were made.
Use 'reaper-sync' without --dry-run to perform actual synchronization.`;
  }
  
  return formattedOutput;
}

/**
 * Extracts file statistics from the sync output
 */
function extractFileStats(output) {
  // This would parse the actual output to extract real statistics
  // For this example, we'll use regex to extract from our simulated output
  
  const matches = output.match(/Processed (\d+) files:[\s\S]*?- (\d+) files synchronized[\s\S]*?- (\d+) new files[\s\S]*?- (\d+) files with errors/);
  
  if (matches && matches.length >= 5) {
    return {
      total: parseInt(matches[1], 10),
      synced: parseInt(matches[2], 10),
      created: parseInt(matches[3], 10),
      errors: parseInt(matches[4], 10)
    };
  }
  
  // If we can't parse the output, return null
  return null;
}

/**
 * Logs a sync event to the history
 */
function logSyncEvent(message) {
  // This would append to a sync history file
  // For this example, we'll just log to the console
  console.log(`[${new Date().toISOString()}] ${message}`);
}
```

### Response Format

#### Standard Sync Response
```
✅ SYNC COMPLETED

Files processed: 27
- 25 synchronized
- 2 created
- 0 errors
```

#### Verbose Sync Response
```
✅ SYNC COMPLETED

Files processed: 27
- 25 synchronized
- 2 created
- 0 errors

DETAILED OUTPUT:
--------------
====================================================
00OS to Cursor Rules Synchronization
====================================================

Running synchronization from 00os directory...
This will:
1. Find all markdown files in 00os (excluding README.md files)
2. Update corresponding Cursor Rules with content (preserving frontmatter)
3. Create new Cursor Rules for files that don't have a corresponding rule
4. Generate a detailed synchronization report

Starting synchronization...

Processed 27 files:
- 25 files synchronized successfully
- 2 new files created
- 0 files with errors

Synchronization report saved to: 1000xscripts/sync-reports/sync-report-20230615-120145.json

Running sync report cleanup...

====================================================
Synchronization completed!
====================================================
```

#### Status Response
```
✅ 00OS Sync Status

Last synchronization: 2023-06-15 11:45:22
Status: Successful
Files processed: 27

Current differences:
- 1 new files in 00os
- 2 modified files
- 1 orphaned files in .cursor/rules

Use 'reaper-sync status --verbose' for detailed information.
Use 'reaper-sync' to perform synchronization.
```

#### Dry Run Response
```
🔍 DRY RUN

Files processed: 27
- 25 synchronized
- 2 created
- 0 errors

NOTE: This was a dry run. No actual changes were made.
Use 'reaper-sync' without --dry-run to perform actual synchronization.
```

### Error Handling

If the synchronization process encounters errors, the command provides detailed information:

```
❌ SYNC FAILED

Files processed: 15
- 10 synchronized
- 0 created
- 5 errors

ERROR:
Access denied to .cursor/rules directory

Use 'reaper-sync --verbose' for detailed error information.
```

### Integration with Other Commands

This command complements other system management commands and enables direct control over the synchronization process from within the 00OS environment. It bridges the gap between development work in the 00os directory and deployment to the .cursor/rules directory where rules are accessed by Cursor.

### Future Enhancements

Potential future enhancements include:
- AI-driven sync decisions based on file changes and context
- Bidirectional sync for specific scenarios
- Scheduled synchronization
- Change preview capabilities 