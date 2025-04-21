---
name: cd
description: Changes the current working directory (placeholder).
version: 1.0.0
author: 00reaper
category: system
permissions: [basic] # Might need special shell/state access
inputs:
  - name: directory
    type: string
    required: true
    description: The path to the directory to change into.
outputs:
  - name: result
    type: object
    description: Status of the directory change.
usage: cd <directory>
examples:
  - cd /path/to/directory
  - cd ..
---

# Process: cd

## Metadata
- Description: Changes the current working directory.
- Category: system
- Permissions: [basic] # Needs clarification on how CWD is managed.
- Author: 00reaper
- Version: 1.0.0

## Input
- directory (required string): The target directory path.

## Output
- Confirmation message or error if the directory cannot be changed.

## Execution
```javascript
// Main execution function
async function execute() {
  try {
    // 1. PARAMETER VALIDATION
    const targetDir = inputs.directory;
    if (!targetDir) {
      return formatError('Missing required directory parameter.', 'VALIDATION_ERROR', [
        'Specify the directory path to change into.',
        'Example: > cd /path/to/target',
        'Example: > cd ..'
      ]);
    }
    
    tools.log(`Executing cd command: target=${targetDir}`);

    // 2. TOOL CALL EXECUTION (Placeholder - CWD Management Logic)
    // How 00OS manages CWD needs definition. 
    // Option 1: Use run_terminal_cmd('cd ...') - Risky if not sandboxed.
    // Option 2: Manage CWD via state manager.
    // Option 3: Rely on host environment CWD (if persistent).
    
    // For now, simulate success via state manager (if available)
    // await tools.state.set('current_working_directory', targetDir, 'session');
    // tools.log(`Placeholder: Would attempt to change directory to ${targetDir}`);
    
    // Or, attempt via terminal command (USE WITH EXTREME CAUTION)
    /*
    try {
        // IMPORTANT: This assumes the terminal context persists.
        // It might not work reliably depending on the environment setup.
        // It also presents security risks if not properly handled.
        const cdResult = await tools.call('run_terminal_cmd', {
            command: `cd "${targetDir}"`,
            explanation: `Attempting to change directory to ${targetDir}`
        });
        if (cdResult.exitCode !== 0) {
            throw new Error(`Terminal command 'cd' failed: ${cdResult.error || cdResult.output}`);
        }
        tools.log(`Terminal command 'cd ${targetDir}' executed.`);
        
    } catch (termError) {
        return formatError(`Failed to change directory: ${termError.message}`, 'CWD_ERROR', [
            'Ensure the directory path is correct and exists.',
            'Verify permissions to access the directory.'
        ]);
    }
    */
   
   // Placeholder message as actual CWD change is complex/undefined for 00OS internal state
    const resultMessage = `Placeholder: Would attempt to change directory to ${targetDir}. Actual CWD management TBD.`;
    const resultData = { target: targetDir };

    // 3. RESULT FORMATTING
    return formatSuccess(resultMessage, resultData);

  } catch (error) {
    // 4. ERROR HANDLING
    tools.error(`Error executing cd command: ${error.message}`);
    const errorCode = determineErrorCode(error);
    const suggestions = generateSuggestions(error, errorCode);
    return formatError(error.message, errorCode, suggestions);
  }
}

// Placeholder Utility Functions
function formatSuccess(message, data = null) {
  const response = { success: true, message: `✅ ${message}` };
  if (data !== null) response.data = data;
  return response;
}
function formatError(message, code = 'EXECUTION_ERROR', suggestions = []) {
  let output = `❌ Error [${code}]: ${message}\n`;
  if (suggestions.length > 0) {
    output += "\nSuggestions:\n";
    suggestions.forEach(s => output += `- ${s}\n`);
  }
  return { success: false, message: output.trim(), errorDetails: { code, originalMessage: message } };
}
function determineErrorCode(error) { return 'CD_ERROR'; }
function generateSuggestions(error, errorCode) { return ['Verify path exists.', 'Check permissions.']; }

// Call the main execution function
execute();
```

## Usage Examples
```
> cd /00os/processes
✅ Placeholder: Would attempt to change directory to /00os/processes. Actual CWD management TBD.
```
```
> cd ..
✅ Placeholder: Would attempt to change directory to ... Actual CWD management TBD.
``` 