# Process: reaper-sync

## Metadata
- Name: reaper-sync
- Description: Synchronize 00os contents to .cursor/rules
- Category: system
- Permissions: system.write
- Author: 00reaper
- Version: 1.2

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
  let syncCmd = '.\\00reaper\\00scripts\\Sync-00OS-Complete.ps1';
  
  // Add parameters
  if (params.length > 0) {
    syncCmd += ' ' + params.join(' ');
  }
  
  // Only add dry-run flag if explicitly requested
  if (isDryRun) {
    syncCmd += ' -DryRun';
  }
  
  // Log the sync start
  logSyncEvent('Started synchronization from 00os to .cursor/rules');
  
  // Execute the sync script - ACTUAL COMMAND EXECUTION
  const result = tools.run_terminal_cmd({
    command: syncCmd,
    explanation: 'Running complete sync process to update .cursor/rules from 00os',
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
${lastSync.history.map(h => `${h.timestamp}: ${h.message}`