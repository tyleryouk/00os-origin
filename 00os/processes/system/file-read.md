---
name: file-read
description: View file contents
version: 1.0.0
author: 00reaper
permissions: [basic, file-read]
inputs:
  - name: path
    type: string
    required: true
    description: Path to the file to read
  - name: lines
    type: string
    required: false
    description: Line range to display (e.g., "1-10" or "all")
  - name: format
    type: boolean
    required: false
    default: true
    description: Format output based on file type
outputs:
  - name: content
    type: string
    description: File content
  - name: metadata
    type: object
    description: File metadata
---

# Process: File Read

## Metadata
- Description: Reads and displays the contents of a file
- Category: tools
- Permissions: file.read
- Author: 00reaper
- Version: 1.0

## Input
- path: Path to the file to read (required)
- lines: Line range to display (optional, format: "1-10" or "all")
- format: Whether to format output based on file type (default: true)

## Output
- Formatted file content

## Execution

This process reads and displays the contents of a file, with options for displaying specific line ranges and applying formatting based on file type.

```javascript
// Main execution function
async function execute() {
  try {
    // Get parameters
    const filePath = inputs.path;
    const lineRange = inputs.lines || 'all';
    const shouldFormat = inputs.format !== false;
    
    // Validate inputs
    if (!filePath) {
      return formatError("Missing required parameter: path", "VALIDATION_ERROR", [
        "Specify a file path to read",
        "Example: file read /path/to/file.txt"
      ]);
    }
    
    // Read file content
    const result = await readFile(filePath, lineRange);
    
    // Format response
    return formatFileContent(result, shouldFormat);
  } catch (error) {
    return formatError(`Error reading file: ${error.message}`, "FILE_READ_ERROR");
  }
}

// Read file content
async function readFile(filePath, lineRange) {
  try {
    // Read the file
    const fileContent = await tools.call('read_file', {
      target_file: filePath,
      should_read_entire_file: lineRange === 'all',
      explanation: `Reading file ${filePath}`
    });
    
    if (!fileContent || !fileContent.content) {
      throw new Error(`Failed to read file: ${filePath}`);
    }
    
    // Extract file extension
    const extension = filePath.split('.').pop().toLowerCase();
    
    // Return file content with metadata
    return {
      path: filePath,
      content: fileContent.content,
      extension: extension,
      totalLines: fileContent.content.split('\n').length
    };
  } catch (error) {
    // Handle different error cases
    if (error.message.includes('does not exist')) {
      throw new Error(`File not found: ${filePath}`);
    } else if (error.message.includes('permission denied')) {
      throw new Error(`Permission denied for file: ${filePath}`);
    } else {
      throw error;
    }
  }
}

// Format file content for display
function formatFileContent(fileData, shouldFormat) {
  // Determine language for syntax highlighting
  let language = '';
  if (shouldFormat) {
    switch(fileData.extension) {
      case 'js':
        language = 'javascript';
        break;
      case 'py':
        language = 'python';
        break;
      case 'md':
        language = 'markdown';
        break;
      case 'json':
        language = 'json';
        break;
      case 'html':
      case 'htm':
        language = 'html';
        break;
      case 'css':
        language = 'css';
        break;
      default:
        language = 'text';
    }
  }
  
  // Format the output
  let output = `✅ File: ${fileData.path}\n`;
  output += `Lines: ${fileData.totalLines}\n\n`;
  
  // Add syntax-highlighted content
  if (language && language !== 'text') {
    output += `\`\`\`${language}\n${fileData.content}\n\`\`\``;
  } else {
    output += `\`\`\`\n${fileData.content}\n\`\`\``;
  }
  
  return output;
}

// Format success message
function formatSuccess(message) {
  return `✅ ${message}`;
}

// Format error message
function formatError(message, code, suggestions = []) {
  let output = `❌ Error [${code}]: ${message}\n\n`;
  
  if (suggestions.length > 0) {
    output += "Suggestions:\n";
    for (const suggestion of suggestions) {
      output += `- ${suggestion}\n`;
    }
  }
  
  return output;
}

// Execute the command
execute();
```

## Example Usage

### Basic File Reading
```
> file read /00os/config/settings.md
```

### Reading Specific Line Ranges
```
> file read /00os/config/settings.md --lines=1-10
```

### Reading Without Formatting
```
> file read /00os/config/settings.md --format=false
```

## Error Handling

### File Not Found
```
❌ Error [FILE_READ_ERROR]: File not found: /nonexistent/file.txt

Suggestions:
- Check that the file path is correct
- Use 'file list /directory' to see available files
```

### Permission Denied
```
❌ Error [FILE_READ_ERROR]: Permission denied for file: /restricted/file.txt

Suggestions:
- Check your current permissions with 'identity permissions'
- Request additional permissions if needed
```

## Implementation Notes

This command integrates with the file system tools to access and read file contents. It supports:

1. Reading entire files or specific line ranges
2. Automatic syntax highlighting based on file extension
3. Detailed error messages with helpful suggestions
4. File metadata reporting (path, size, line count)

Future enhancements could include:
- Searching within files
- Displaying file binary content in hex format
- Handling of very large files with pagination
- File comparison functionality 