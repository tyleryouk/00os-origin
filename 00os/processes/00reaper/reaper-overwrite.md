---
name: reaper-overwrite
description: Reads all files in a source /00os/ subdirectory and generates a concise context file with basic information.
version: 2.0.0
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

## Description
Reads all files in a source `/00os/` subdirectory and generates a concise context file with basic information. This process helps maintain up-to-date documentation of the current state of different components of the 00OS system.

## Execution
```javascript
/**
 * Main execution function
 */
async function execute(args) {
  try {
    // =========================================
    // 1. PARAMETER VALIDATION
    // =========================================
    const params = parseArgs(args);
    
    if (!params.sourceDirectory) {
      return formatError('Missing required parameter: source_directory', 'VALIDATION_ERROR', [
        'Provide the source directory relative to /00os/',
        'Example: > reaper-overwrite config <target_file>'
      ]);
    }
    
    if (!params.targetFile) {
      return formatError('Missing required parameter: target_context_file', 'VALIDATION_ERROR', [
        'Provide the full path to the target context file',
        'Example: > reaper-overwrite <source_dir> path/to/context.md'
      ]);
    }

    const sourceDirFull = `00os/${params.sourceDirectory}`.replace(/\\\\/g, '/'); // Construct full path and normalize slashes
    
    // =========================================
    // 2. LIST SOURCE DIRECTORY
    // =========================================
    const sourceFiles = await listSourceDirectory(sourceDirFull);
    
    if (sourceFiles.length === 0) {
      return formatWarning(`No markdown files found in source directory '${sourceDirFull}'. Target file '${params.targetFile}' will be empty or contain only the header.`);
    }

    // =========================================
    // 3. READ ALL FILES
    // =========================================
    const fileInfo = await readAllFiles(sourceFiles);
    
    if (fileInfo.length === 0) {
      return formatError(`Failed to read any files from source directory '${sourceDirFull}'`, 'READ_FILES_ERROR', [
        'Check permissions for the files in the source directory.'
      ]);
    }

    // =========================================
    // 4. GENERATE CONTEXT CONTENT
    // =========================================
    const contextContent = generateContextContent(params.sourceDirectory, fileInfo);

    // =========================================
    // 5. OVERWRITE TARGET FILE
    // =========================================
    await overwriteTargetFile(params.targetFile, contextContent, sourceDirFull);

    // =========================================
    // 6. RETURN SUCCESS
    // =========================================
    return formatSuccess(`Successfully updated '${params.targetFile}' with context information from ${fileInfo.length} files in '${sourceDirFull}'.`, 
                        { targetFile: params.targetFile, filesProcessed: fileInfo.length });

  } catch (error) {
    // =========================================
    // 7. GLOBAL ERROR HANDLING
    // =========================================
    console.error(`Unhandled error in reaper-overwrite: ${error.message}`);
    return formatError(`An unexpected error occurred: ${error.message}`, 'EXECUTION_ERROR');
  }
}

/**
 * Parse command arguments into parameters object
 */
function parseArgs(args) {
  const params = {
    sourceDirectory: null,
    targetFile: null
  };
  
  // Process positional arguments
  if (args.length > 0) {
    params.sourceDirectory = args[0];
  }
  
  if (args.length > 1) {
    params.targetFile = args[1];
  }
  
  return params;
}

/**
 * List files in the source directory
 */
async function listSourceDirectory(sourceDirFull) {
  try {
    const fileListResult = await tools.call('list_dir', {
      relative_workspace_path: sourceDirFull,
      explanation: `Listing files in source directory ${sourceDirFull} for reaper-overwrite command`
    });
    
    if (!fileListResult || !fileListResult.entries) {
      throw new Error('Could not list directory or directory is empty.');
    }
    
    // Only process markdown files
    return fileListResult.entries.filter(entry => !entry.is_directory && entry.path.endsWith('.md'));
  } catch (listError) {
    throw new Error(`Failed to list source directory '${sourceDirFull}': ${listError.message}`);
  }
}

/**
 * Read all files from the source directory
 */
async function readAllFiles(sourceFiles) {
  const fileInfo = [];
  
  for (const fileEntry of sourceFiles) {
    const filePath = fileEntry.path;
    const fileName = filePath.split('/').pop().replace('.md', '');
    
    try {
      const readResult = await tools.call('read_file', {
        target_file: filePath,
        should_read_entire_file: true,
        explanation: `Reading content of ${filePath} for reaper-overwrite command`
      });

      if (readResult && readResult.content !== undefined) {
        fileInfo.push({
          name: fileName,
          path: filePath,
          content: readResult.content
        });
      } else {
        console.error(`Could not read content for ${filePath}.`);
      }
    } catch (readError) {
      console.error(`Error reading file ${filePath}: ${readError.message}`);
      // Continue with other files despite error
    }
  }
  
  return fileInfo;
}

/**
 * Generate context content from file information
 */
function generateContextContent(sourceDirRelative, fileInfo) {
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
    const purpose = extractPurpose(info.content);
    
    // Extract status
    const status = extractStatus(info.content);
    
    // Add the information to the context content
    contextContent += `- **Purpose**: ${purpose}\n`;
    contextContent += `- **Location**: \`${info.path}\`\n`;
    contextContent += `- **Status**: ${status}\n`;
    
    // Extract key tools used
    const toolsUsed = extractToolsUsed(info.content);
    
    // Add key tools if any were found
    if (toolsUsed.length > 0) {
      contextContent += `- **Key Tools**: ${toolsUsed.join(', ')}\n`;
    }
    
    // Add a blank line after each file's information
    contextContent += '\n';
  }
  
  return contextContent;
}

/**
 * Extract purpose/description from file content
 */
function extractPurpose(content) {
  let purpose = 'No description available.';
  
  // Try to extract from frontmatter
  const frontmatterMatch = content.match(/---\s*\n([\s\S]*?)\n\s*---/);
  if (frontmatterMatch) {
    const frontmatter = frontmatterMatch[1];
    const descMatch = frontmatter.match(/description:\s*(.*?)(\n|$)/);
    
    if (descMatch && descMatch[1]) {
      purpose = descMatch[1].trim();
    }
  }
  
  // If no description in frontmatter, try to extract from first heading
  if (purpose === 'No description available.') {
    const headingMatch = content.match(/# .*?\n\n## Description\n\n([^\n]+)/);
    if (headingMatch && headingMatch[1]) {
      purpose = headingMatch[1].trim();
    }
  }
  
  // Limit purpose length
  if (purpose.length > 120) {
    purpose = purpose.substring(0, 117) + '...';
  }
  
  return purpose;
}

/**
 * Extract current status from file content
 */
function extractStatus(content) {
  // Check for implementation status hints in the content
  if (content.includes('NOT IMPLEMENTED') || content.includes('TO BE IMPLEMENTED')) {
    return 'Not implemented';
  } else if (content.includes('PARTIAL IMPLEMENTATION') || content.includes('WORK IN PROGRESS')) {
    return 'Partial implementation';
  } else if (content.includes('DEPRECATED')) {
    return 'Deprecated';
  } else if (content.includes('REFACTORING NEEDED') || content.includes('NEEDS REFACTORING')) {
    return 'Needs refactoring';
  } else {
    return 'Implemented';
  }
}

/**
 * Extract tool calls used in the file
 */
function extractToolsUsed(content) {
  const toolCalls = [];
  
  // Look for tool call patterns in the code
  const toolCallMatches = content.match(/tools\.call\(['"]([^'"]+)['"]/g) || [];
  
  // Extract tool names from matches
  for (const match of toolCallMatches) {
    const toolMatch = match.match(/tools\.call\(['"]([^'"]+)['"]/);
    if (toolMatch && toolMatch[1]) {
      const tool = toolMatch[1];
      if (!toolCalls.includes(tool)) {
        toolCalls.push(tool);
      }
    }
  }
  
  return toolCalls;
}

/**
 * Overwrite target file with generated context content
 */
async function overwriteTargetFile(targetFile, contextContent, sourceDirFull) {
  try {
    // Create or overwrite the target file
    await tools.call('edit_file', {
      target_file: targetFile,
      instructions: `Overwriting context file with summaries from ${sourceDirFull}`,
      code_edit: contextContent
    });
  } catch (writeError) {
    throw new Error(`Failed to write to target file '${targetFile}': ${writeError.message}`);
  }
}

/**
 * Format a success response
 * @param {string} message - Success message
 * @param {Object} data - Optional data to include
 * @returns {string} Formatted success message
 */
function formatSuccess(message, data = null) {
  return `✅ ${message}${data ? '\n\n' + JSON.stringify(data, null, 2) : ''}`;
}

/**
 * Format an error response
 * @param {string} message - Error message
 * @param {string} code - Error code
 * @param {Array} suggestions - Optional suggestions
 * @returns {string} Formatted error message
 */
function formatError(message, code = "ERROR", suggestions = []) {
  let output = `❌ Error [${code}]: ${message}`;
  
  if (suggestions && suggestions.length > 0) {
    output += "\n\nSuggestions:";
    for (const suggestion of suggestions) {
      output += `\n- ${suggestion}`;
    }
  }
  
  return output;
}

/**
 * Format a warning response
 * @param {string} message - Warning message
 * @param {Object} details - Optional details
 * @returns {string} Formatted warning message
 */
function formatWarning(message, details = null) {
  return `⚠️ Warning: ${message}${details ? '\n\n' + JSON.stringify(details, null, 2) : ''}`;
}

// Parse command line arguments
const args = process.argv.slice(2);

// Execute the command
execute(args);
``` 