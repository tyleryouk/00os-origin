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
  // Use summaryContent instead of consolidatedContent
  let summaryContent = `# Context Summary from Directory: ${inputs.source_directory}\\n\\n`;
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

    const sourceDirFull = `00os/${sourceDirRelative}`.replace(/\\\\/g, '/'); // Construct full path and normalize slashes
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

    const filesToRead = fileListResult.entries.filter(entry => !entry.is_directory && entry.path.endsWith('.md')); // Only process markdown files
    if (filesToRead.length === 0) {
       return formatWarning(`No markdown files found in source directory '${sourceDirFull}'. Target file '${targetFile}' will be empty or contain only the header.`);
    }

    // =========================================
    // 3. READ & GENERATE SUMMARY
    // =========================================
    tools.log(`Found ${filesToRead.length} markdown files to summarize.`);
    for (const fileEntry of filesToRead) {
      const filePath = fileEntry.path; // list_dir provides the full path already
      tools.log(`Summarizing file: ${filePath}`);
      try {
        // Read the entire file to parse metadata easily
        const readResult = await tools.call('read_file', {
          target_file: filePath,
          should_read_entire_file: true,
          explanation: `Reading content of ${filePath} to extract metadata for summary.`
        });

        if (readResult && readResult.content !== undefined) {
          // Extract metadata and append to summary
          const summaryLines = extractMetadataSummary(filePath, readResult.content);
          summaryContent += summaryLines + '\\n'; // Add newline between file summaries
          filesProcessed++;
        } else {
          // Handle potential read error
          const errorMsg = `Could not read content for ${filePath}. Tool Response: ${JSON.stringify(readResult)}`;
           tools.error(errorMsg);
           errorsEncountered.push(errorMsg);
           summaryContent += `## Error Processing: ${filePath}\\n- Could not read file content.\\n\\n`;
        }
      } catch (readError) {
         const errorMsg = `Error reading file ${filePath}: ${readError.message}`;
         tools.error(errorMsg);
         errorsEncountered.push(errorMsg);
         summaryContent += `## Error Processing: ${filePath}\\n- ${readError.message}\\n\\n`;
      }
    }

    // =========================================
    // 4. OVERWRITE TARGET FILE WITH SUMMARY
    // =========================================
    tools.log(`Generated summary length: ${summaryContent.length}. Overwriting target file: ${targetFile}`);
    try {
       // Use summaryContent instead of consolidatedContent
       const editResult = await tools.call('edit_file', {
         target_file: targetFile,
         code_edit: summaryContent, // Provide the generated summary
         instructions: `Overwrite the entire file with the generated context summary from ${sourceDirFull}.`
       });
       tools.log(`Successfully called edit_file for ${targetFile}.`);

    } catch(editError) {
        // This is a critical error, fail the whole operation
         return formatError(`Failed to overwrite target file '${targetFile}' with summary: ${editError.message}`, 'EDIT_FILE_ERROR', [
             'Check write permissions for the target file.',
             'Ensure the target path is correct.'
         ]);
    }

    // =========================================
    // 5. FINAL RESULT FORMATTING
    // =========================================
    let finalMessage = `Successfully overwrote '${targetFile}' with a generated summary from ${filesProcessed} files in '${sourceDirFull}'.`;
    if (errorsEncountered.length > 0) {
        finalMessage += ` \\n\\n⚠️ Encountered ${errorsEncountered.length} errors during file reading/summarization (check logs). Summary might be incomplete.`;
        return formatWarning(finalMessage, { targetFile, filesProcessed, errors: errorsEncountered.length });
    }

    return formatSuccess(finalMessage, { targetFile, filesProcessed });

  } catch (error) {
    // =========================================
    // 6. GLOBAL ERROR HANDLING
    // =========================================
    tools.error(`Unhandled error in reaper-overwrite: ${error.message}\\n${error.stack}`);
    return formatError(`An unexpected error occurred: ${error.message}`, 'EXECUTION_ERROR');
  }
}

// Helper function to extract metadata summary from file content
function extractMetadataSummary(filePath, content) {
    // Simple parser: Look for specific markdown patterns or frontmatter
    const fileName = filePath.split('/').pop().replace('.md', '');
    let summary = `## ${fileName}\\n`;
    summary += `- **Location**: \`${filePath}\`\\n`;

    // Attempt to parse frontmatter (simple regex approach)
    const frontmatterRegex = /^---\\n([\s\S]*?)\\n---/;
    const fmMatch = content.match(frontmatterRegex);
    let description = 'No description found.';
    let status = 'Status unknown.'; // Default status

    if (fmMatch && fmMatch[1]) {
        const fmContent = fmMatch[1];
        const descMatch = fmContent.match(/^description:\s*(.*)/m);
        if (descMatch && descMatch[1]) {
            description = descMatch[1].trim();
        }
        // Add more frontmatter extractions if needed (e.g., status)
    } else {
        // Fallback: Look for specific markdown headings if no frontmatter
        const purposeMatch = content.match(/## Purpose\n(.+)/); // Example: look for ## Purpose
        if (purposeMatch && purposeMatch[1]) {
             description = purposeMatch[1].trim();
        } else {
             const descMatch = content.match(/## Description\n(.+)/); // Example: look for ## Description
             if (descMatch && descMatch[1]){
                description = descMatch[1].trim();
             }
        }

         // Example fallback for status
        const statusMatch = content.match(/## Status\n(.+)/);
        if (statusMatch && statusMatch[1]){
            status = statusMatch[1].trim();
        }
    }

    summary += `- **Purpose**: ${description}\\n`;
    summary += `- **Status**: ${status}\\n`; // Add status if found/relevant

    // Add more extracted info as needed following the user's example format

    return summary;
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