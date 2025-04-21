---
name: reaper-overwrite
description: Reads all files in a source /00os/ subdirectory and generates a concise context file with basic information.
version: 1.1.0
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
- Description: Reads all files in a source `/00os/` subdirectory and generates a concise context file with basic information.
- Category: 00reaper
- Permissions: [basic, file-read, file-write]
- Author: 00reaper
- Version: 1.1.0

## Input
- source_directory: Source directory path relative to `/00os/` (required string)
- target_context_file: Full path to the target context file to overwrite (required string)

## Output
- Structured result object indicating success or failure of the overwrite operation.

## Execution
```javascript
// Main execution function
async function execute() {
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
    // 3. READ ALL FILES
    // =========================================
    tools.log(`Found ${filesToRead.length} markdown files to process.`);
    
    // Create data structure to store file information
    const fileInfo = [];
    
    // Read all files first
    for (const fileEntry of filesToRead) {
      const filePath = fileEntry.path;
      const fileName = filePath.split('/').pop().replace('.md', '');
      
      tools.log(`Reading file: ${filePath}`);
      try {
        // Read the file
        const readResult = await tools.call('read_file', {
          target_file: filePath,
          should_read_entire_file: true,
          explanation: `Reading content of ${filePath}`
        });

        if (readResult && readResult.content !== undefined) {
          // Basic info about the file
          const info = {
            name: fileName,
            path: filePath,
            content: readResult.content
          };
          
          fileInfo.push(info);
        } else {
          tools.error(`Could not read content for ${filePath}.`);
        }
      } catch (readError) {
        tools.error(`Error reading file ${filePath}: ${readError.message}`);
      }
    }

    // =========================================
    // 4. GENERATE CONTEXT CONTENT
    // =========================================
    // Determine folder name for the header
    const folderName = sourceDirRelative.split('/').pop() || sourceDirRelative;
    const formattedFolderName = folderName.charAt(0).toUpperCase() + folderName.slice(1);
    
    // Create the context content
    let contextContent = `# Context: ${formattedFolderName} Current State\n\n`;
    contextContent += `This file provides context on the contents of the \`${sourceDirRelative}\` directory.\n\n`;
    
    // Process each file's information
    for (const info of fileInfo) {
      // Extract the process name
      const processName = info.name;
      contextContent += `## ${processName}\n`;
      
      // Extract purpose/description
      let purpose = 'No description available.';
      
      // Try to extract from frontmatter
      const frontmatterMatch = info.content.match(/---\s*\n([\s\S]*?)\n\s*---/);
      if (frontmatterMatch) {
        const frontmatter = frontmatterMatch[1];
        const descMatch = frontmatter.match(/description:\s*(.*?)(\n|$)/);
        if (descMatch && descMatch[1]) {
          purpose = descMatch[1].trim();
        }
      }
      
      // If no description found in frontmatter, look in markdown content
      if (purpose === 'No description available.') {
        // Look for "Description:" or "Purpose:" sections
        const descriptionMatch = info.content.match(/##\s*Description\s*\n(.*?)(\n##|\n$)/s);
        if (descriptionMatch && descriptionMatch[1]) {
          purpose = descriptionMatch[1].trim().split('\n')[0]; // Get first line only
        } else {
          const purposeMatch = info.content.match(/##\s*Purpose\s*\n(.*?)(\n##|\n$)/s);
          if (purposeMatch && purposeMatch[1]) {
            purpose = purposeMatch[1].trim().split('\n')[0]; // Get first line only
          }
        }
      }
      
      // Extract status, if available
      let status = 'Status unknown.';
      
      // Try to extract from frontmatter
      if (frontmatterMatch) {
        const frontmatter = frontmatterMatch[1];
        const statusMatch = frontmatter.match(/status:\s*(.*?)(\n|$)/);
        if (statusMatch && statusMatch[1]) {
          status = statusMatch[1].trim();
        }
      }
      
      // If no status found in frontmatter, look in markdown content
      if (status === 'Status unknown.') {
        const statusMatch = info.content.match(/##\s*Status\s*\n(.*?)(\n##|\n$)/s);
        if (statusMatch && statusMatch[1]) {
          status = statusMatch[1].trim().split('\n')[0]; // Get first line only
        }
      }
      
      // If we could determine implementation status from content
      if (status === 'Status unknown.') {
        if (info.content.includes('function execute()') || 
            info.content.includes('async function execute()')) {
          status = 'Implemented';
        } else if (info.content.includes('To be implemented')) {
          status = 'Defined (Implementation TBD)';
        }
      }
      
      // Add the information to the context content
      contextContent += `- **Purpose**: ${purpose}\n`;
      contextContent += `- **Location**: \`${info.path}\`\n`;
      contextContent += `- **Status**: ${status}\n`;
      
      // Look for key tools used
      const toolsUsed = [];
      const toolMatches = info.content.match(/tools\.call\(['"]([^'"]+)['"]/g);
      if (toolMatches) {
        for (const match of toolMatches) {
          const toolName = match.match(/tools\.call\(['"]([^'"]+)['"]/)[1];
          if (!toolsUsed.includes(toolName)) {
            toolsUsed.push(toolName);
          }
        }
      }
      
      // Add key tools if any were found
      if (toolsUsed.length > 0) {
        contextContent += `- **Key Tools**: ${toolsUsed.join(', ')}\n`;
      }
      
      // Add a blank line after each file's information
      contextContent += '\n';
    }

    // =========================================
    // 5. OVERWRITE TARGET FILE
    // =========================================
    tools.log(`Generated context content (${contextContent.length} chars). Overwriting target file: ${targetFile}`);
    try {
      const editResult = await tools.call('edit_file', {
        target_file: targetFile,
        code_edit: contextContent,
        instructions: `Overwrite the entire file with generated context for ${sourceDirFull}.`
      });
      tools.log(`Successfully updated ${targetFile}.`);
    } catch(editError) {
      return formatError(`Failed to overwrite target file '${targetFile}': ${editError.message}`, 'EDIT_FILE_ERROR', [
        'Check write permissions for the target file.',
        'Ensure the target path is correct.'
      ]);
    }

    // =========================================
    // 6. RETURN SUCCESS
    // =========================================
    return formatSuccess(`Successfully updated '${targetFile}' with context information from ${fileInfo.length} files in '${sourceDirFull}'.`, 
                        { targetFile, filesProcessed: fileInfo.length });

  } catch (error) {
    // =========================================
    // 7. GLOBAL ERROR HANDLING
    // =========================================
    tools.error(`Unhandled error in reaper-overwrite: ${error.message}\n${error.stack}`);
    return formatError(`An unexpected error occurred: ${error.message}`, 'EXECUTION_ERROR');
  }
}

// =========================================
// UTILITY FUNCTIONS
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
  return { success: false, message: output.trim(), errorDetails: { code, originalMessage: message } }; 
}

// Call the main execution function
execute();
``` 