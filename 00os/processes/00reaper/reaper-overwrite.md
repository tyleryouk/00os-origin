---
name: reaper-overwrite
description: Reads all files in a source /00os/ subdirectory and overwrites a target context file with consolidated content.
version: 1.0.0
author: 00reaper
category: 00reaper # Specific to reaper workflow tasks
permissions: [basic, file-read, file-write] # Permissions needed for list_dir, read_file, edit_file
inputs:
  - name: source_directory
    type: string
    required: true
    description: Source directory path relative to /00os/ (e.g., 'config', 'core', 'processes/system')
  - name: target_context_file
    type: string
    required: true
    description: Full path to the target context file to overwrite (e.g., '00reaper/00OS-commands/context-00OS-current-state/config.md')
outputs:
  - name: result
    type: object
    description: The command execution result (success/failure, message)
usage: reaper-overwrite <source_directory> <target_context_file>
examples:
  - reaper-overwrite config 00reaper/00OS-commands/context-00OS-current-state/config.md
  - reaper-overwrite core 00reaper/00OS-commands/context-00OS-current-state/core.md
  - reaper-overwrite processes/system 00reaper/00OS-commands/context-00OS-current-state/system-processes.md
---

# Process: reaper-overwrite

## Metadata
- Description: Reads all files in a source `/00os/` subdirectory and overwrites a target context file with consolidated content.
- Category: 00reaper
- Permissions: [basic, file-read, file-write]
- Author: 00reaper
- Version: 1.0.0

## Input
- source_directory: Source directory path relative to `/00os/` (required string)
- target_context_file: Full path to the target context file to overwrite (required string)

## Output
- Structured result object indicating success or failure of the overwrite operation.

## Execution
```javascript
// Main execution function
async function execute() {
  let consolidatedContent = '';
  let filesProcessed = 0;
  let errorsEncountered = [];

  try {
    // =========================================
    // 1. PARAMETER VALIDATION
    // =========================================
    const sourceDirRelative = inputs.source_directory;
    const targetFile = inputs.target_context_file;

    if (!sourceDirRelative) {
      return formatError('Missing required parameter: source_directory', 'VALIDATION_ERROR', [
        'Provide the source directory relative to /00os/',
        'Example: > reaper-overwrite config <target_file>'
      ]);
    }
    if (!targetFile) {
      return formatError('Missing required parameter: target_context_file', 'VALIDATION_ERROR', [
        'Provide the full path to the target context file',
        'Example: > reaper-overwrite <source_dir> path/to/context.md'
      ]);
    }

    const sourceDirFull = `00os/${sourceDirRelative}`.replace(/\\/g, '/'); // Construct full path and normalize slashes
    tools.log(`Executing reaper-overwrite: Source='${sourceDirFull}', Target='${targetFile}'`);

    // =========================================
    // 2. LIST SOURCE DIRECTORY
    // =========================================
    let fileListResult;
    try {
      fileListResult = await tools.call('list_dir', {
        relative_workspace_path: sourceDirFull,
        explanation: `Listing files in source directory ${sourceDirFull}`
      });
      if (!fileListResult || !fileListResult.entries) {
         throw new Error('Could not list directory or directory is empty.');
      }
    } catch (listError) {
      return formatError(`Failed to list source directory '${sourceDirFull}': ${listError.message}`, 'LIST_DIR_ERROR', [
        'Ensure the source directory exists within /00os/.',
        'Check permissions for the directory.'
      ]);
    }

    const filesToRead = fileListResult.entries.filter(entry => !entry.is_directory);
    if (filesToRead.length === 0) {
       return formatWarning(`No files found in source directory '${sourceDirFull}'. Target file '${targetFile}' will be empty.`);
    }

    // =========================================
    // 3. READ & CONSOLIDATE FILES
    // =========================================
    tools.log(`Found ${filesToRead.length} files to read.`);
    for (const fileEntry of filesToRead) {
      const filePath = fileEntry.path; // list_dir provides the full path already
      tools.log(`Reading file: ${filePath}`);
      try {
        // Attempt to read the entire file
        const readResult = await tools.call('read_file', {
          target_file: filePath,
          should_read_entire_file: true, // Try reading all at once
          explanation: `Reading content of ${filePath}`
        });

        if (readResult && readResult.content !== undefined) {
          // Successfully read entire file
          consolidatedContent += `--- File: ${filePath} ---\n\n`;
          consolidatedContent += readResult.content;
          consolidatedContent += '\n\n';
          filesProcessed++;
        } else {
          // Handle potential partial read or error, log and continue if possible
          const errorMsg = `Could not read full content for ${filePath}. Tool Response: ${JSON.stringify(readResult)}`;
           tools.error(errorMsg);
           errorsEncountered.push(errorMsg);
           consolidatedContent += `--- File: ${filePath} --- \n\n *** ERROR: Could not read full content *** \n\n`;
        }
      } catch (readError) {
         const errorMsg = `Error reading file ${filePath}: ${readError.message}`;
         tools.error(errorMsg);
         errorsEncountered.push(errorMsg);
         consolidatedContent += `--- File: ${filePath} --- \n\n *** ERROR: ${readError.message} *** \n\n`;
      }
    }

    // =========================================
    // 4. OVERWRITE TARGET FILE
    // =========================================
    tools.log(`Consolidated content length: ${consolidatedContent.length}. Overwriting target file: ${targetFile}`);
    try {
       const editResult = await tools.call('edit_file', {
         target_file: targetFile,
         code_edit: consolidatedContent, // Provide the entire new content
         instructions: `Overwrite the entire file with the consolidated content from ${sourceDirFull}.`
       });
       // Note: edit_file might not return detailed success/failure in a structured way currently.
       // We assume success if no exception is thrown.
       tools.log(`Successfully called edit_file for ${targetFile}.`);

    } catch(editError) {
        // This is a critical error, fail the whole operation
         return formatError(`Failed to overwrite target file '${targetFile}': ${editError.message}`, 'EDIT_FILE_ERROR', [
             'Check write permissions for the target file.',
             'Ensure the target path is correct.'
         ]);
    }

    // =========================================
    // 5. FINAL RESULT FORMATTING 
    // =========================================
    let finalMessage = `Successfully overwrote '${targetFile}' with consolidated content from ${filesProcessed} files in '${sourceDirFull}'.`;
    if (errorsEncountered.length > 0) {
        finalMessage += ` \n\n⚠️ Encountered ${errorsEncountered.length} errors during file reading (check logs). File content might be incomplete or include error markers.`;
        return formatWarning(finalMessage, { targetFile, filesProcessed, errors: errorsEncountered.length });
    }

    return formatSuccess(finalMessage, { targetFile, filesProcessed });

  } catch (error) {
    // =========================================
    // 6. GLOBAL ERROR HANDLING 
    // =========================================
    tools.error(`Unhandled error in reaper-overwrite: ${error.message}\n${error.stack}`);
    return formatError(`An unexpected error occurred: ${error.message}`, 'EXECUTION_ERROR');
  }
}

// =========================================
// UTILITY FUNCTIONS (Copied from template)
// =========================================
function formatSuccess(message, data = null) {
  const response = { success: true, message: `✅ ${message}` };
  if (data !== null) response.data = data;
  return response;
}

function formatWarning(message, data = null) {
  const response = { success: true, warning: true, message: `⚠️ ${message}` };
  if (data !== null) response.data = data;
  return response;
}

function formatError(message, code = 'EXECUTION_ERROR', suggestions = []) {
  let output = `❌ Error [${code}]: ${message}\n`;
  if (suggestions.length > 0) {
    output += "\nSuggestions:\n";
    suggestions.forEach(s => output += `- ${s}\n`);
  }
  // Return a structured object for programmatic use, the handler formats the final message
  return { success: false, message: output.trim(), errorDetails: { code, originalMessage: message } }; 
}

// Call the main execution function
execute();
``` 