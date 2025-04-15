---
name: reaper-read-files
description: Reads the content of all files in the 00reaper directory using Cursor tools.
version: 1.2.0 # Version updated for new target
author: 00reaper
permissions: [admin, file-read] # Requires admin (potentially for path access/tool usage) and file-read
inputs: []
outputs:
  - name: fileContents
    type: object
    description: An object where keys are filenames and values are file contents or error messages.
---

## Execution

```javascript
// Define the target directory (relative to workspace root)
const targetDirectory = '00reaper'; // Updated target directory to workspace root 00reaper

// Object to store file contents
const allContents = {};
let fileCount = 0;

try {
    // Ensure the tool calling mechanism is available
    if (!tools.call || typeof tools.call !== 'function') {
        throw new Error("Tool calling mechanism (tools.call) is not available in this 00OS process environment.");
    }
    // Ensure state tools are available
    if (!tools.state || typeof tools.state.set !== 'function') {
       throw new Error("State management tools (tools.state.set) are not available.");
    }

    // 1. List directory contents using list_dir tool call
    tools.log(`Listing directory: ${targetDirectory}`);
    const listResult = await tools.call('list_dir', { 
        relative_workspace_path: targetDirectory,
        explanation: `Listing files in '${targetDirectory}' for the reaper-read-files command.` 
    });

    // --- Assumption: list_dir returns an object with an 'entries' array ---
    // Example: { entries: [{ path: '00os/processes/system/file1.txt', is_directory: false }, ...] }
    // Adjust parsing based on the actual tool output structure.
    if (!listResult || !Array.isArray(listResult.entries)) {
        const errorDetail = listResult && listResult.error ? `: ${listResult.error}` : '';
        throw new Error(`Failed to list directory '${targetDirectory}'. Invalid or error response from list_dir tool${errorDetail}. Response: ${JSON.stringify(listResult)}`);
    }
    
    const entries = listResult.entries;
    tools.log(`Found ${entries.length} entries in '${targetDirectory}'.`);

    // 2. Iterate and read each file using read_file tool call
    for (const entry of entries) {
        // Skip directories
        if (entry.is_directory) { 
            tools.log(`Skipping directory: ${entry.path}`);
            continue;
        }

        // Use the path provided by list_dir (assumed relative to workspace)
        const filePath = entry.path; 
        const filename = filePath.split(/[\/]/).pop(); // Extract filename

        tools.log(`Attempting to read file: ${filePath} (filename key: ${filename})`);
        try {
            // 3. Read file content using read_file tool call
            const readResult = await tools.call('read_file', {
                target_file: filePath,
                should_read_entire_file: true, // Read the whole file
                explanation: `Reading file ${filePath} for the reaper-read-files command.`
            });

            // --- Assumption: read_file returns { content: '...' } on success ---
            if (readResult && readResult.content !== undefined) {
                 allContents[filename] = readResult.content;
                 fileCount++;
                 tools.log(`Successfully read: ${filename}`);
            } else {
                 const readErrorMsg = readResult ? readResult.error || 'Unknown read error (no content property)' : 'No response from read_file tool';
                 tools.log(`Warning: Could not read file ${filePath}. Tool response: ${readErrorMsg}`);
                 allContents[filename] = `Error reading file: ${readErrorMsg}`;
            }
        } catch (readToolError) {
             tools.log(`Warning: Exception calling read_file tool for ${filePath}: ${readToolError.message}`);
             allContents[filename] = `Exception executing read_file tool: ${readToolError.message}`;
        }
    }

    // 4. Store results for output block
    tools.state.set('fileContents', allContents, 'process');
    tools.state.set('targetDirectory', targetDirectory, 'process'); 
    tools.state.set('fileCount', fileCount, 'process');
    tools.log(`Finished processing. Stored content for ${fileCount} files.`);

} catch (error) {
    tools.error(`Error in reaper-read-files process execution: ${error.message}`);
    if (tools.state && typeof tools.state.set === 'function') {
        tools.state.set('executionError', error.message, 'process');
    }
    throw error; 
}
```

## Output

```javascript
// Ensure state tools are available
if (!tools.state || typeof tools.state.get !== 'function') {
     return "❌ FATAL ERROR: State management tools (tools.state.get) are not available for the output block.";
}

// Check for execution errors first
const executionError = tools.state.get('executionError', 'process');
if (executionError) {
    return `❌ Error during command execution: ${executionError}`;
}

// Retrieve results from process state
const fileContents = tools.state.get('fileContents', 'process');
const targetDirectory = tools.state.get('targetDirectory', 'process') || '00reaper'; // Default if somehow not set
const fileCount = tools.state.get('fileCount', 'process'); 

// Validate retrieved state
if (fileContents === null || typeof fileContents !== 'object') {
    return "⚠️ An unexpected state error occurred. File contents could not be retrieved.";
}

// Handle case where directory was listed successfully but contained no files
if (fileCount === 0 && Object.keys(fileContents).length === 0) {
     return `ℹ️ No files found in the target directory '${targetDirectory}'.`;
}

let output = `
📑 Contents of files in '${targetDirectory}':

`;

// Format the output for each processed entry
for (const [filename, content] of Object.entries(fileContents)) {
    output += `📄 === File: ${filename} ===
`;
    if (typeof content === 'string' && (content.startsWith('Error reading file:') || content.startsWith('Exception executing read_file tool:'))) {
         output += `   ${content}
`; 
    } else if (typeof content === 'string'){
         output += content; 
    } else {
         output += `   [Invalid or unexpected content type: ${typeof content}]
`;
    }
    output += `
=== End of ${filename} ===

`;
}

// Add a summary status
output += `✅ Successfully processed ${Object.keys(fileContents).length} entries found in '${targetDirectory}'. Read content for ${fileCount} file(s).`;

return output;
``` 