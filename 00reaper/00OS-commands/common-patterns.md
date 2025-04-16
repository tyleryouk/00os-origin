# 00OS Command Implementation Patterns

This file provides reusable code patterns for common command implementations.

## Core Patterns

### Basic Command Structure
```javascript
// Main execution function
function execute() {
  // Validate inputs
  const validationErrors = validateInputs(inputs);
  if (validationErrors) {
    return formatError(validationErrors.join("\n"), "VALIDATION_ERROR");
  }
  
  try {
    // Command implementation
    const result = performOperation();
    return formatSuccess(result);
  } catch (error) {
    return formatError(error.message, "EXECUTION_ERROR");
  }
}

// Standard validation function
function validateInputs(inputs) {
  const errors = [];
  
  // Check required parameters
  if (inputs.requiredParam === undefined) {
    errors.push("Missing required parameter: requiredParam");
  }
  
  return errors.length > 0 ? errors : null;
}

// Standard formatting functions
function formatSuccess(result) {
  return `✅ ${result}`;
}

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
```

## File Operation Patterns

### Directory Reading Pattern
```javascript
// Read and list directory contents
async function readDirectory(path) {
  try {
    // List directory contents
    const dirContents = await tools.call('list_dir', {
      relative_workspace_path: path,
      explanation: `Listing contents of ${path}`
    });
    
    if (!dirContents || !dirContents.entries) {
      return formatError(`Failed to read directory: ${path}`, "DIR_READ_ERROR");
    }
    
    // Format the result
    let output = `Directory: ${path}\n\n`;
    
    const files = dirContents.entries.filter(e => !e.is_directory);
    const dirs = dirContents.entries.filter(e => e.is_directory);
    
    if (dirs.length > 0) {
      output += "Directories:\n";
      for (const dir of dirs) {
        output += `- ${dir.path.split('/').pop()}/\n`;
      }
      output += "\n";
    }
    
    if (files.length > 0) {
      output += "Files:\n";
      for (const file of files) {
        const name = file.path.split('/').pop();
        output += `- ${name}\n`;
      }
    }
    
    return formatSuccess(output);
  } catch (error) {
    return formatError(`Error reading directory: ${error.message}`, "DIR_READ_ERROR");
  }
}
```

### File Reading Pattern
```javascript
// Read and display file contents
async function readFile(path) {
  try {
    // Read file content
    const fileContent = await tools.call('read_file', {
      target_file: path,
      should_read_entire_file: true,
      explanation: `Reading file ${path}`
    });
    
    if (!fileContent || !fileContent.content) {
      return formatError(`Failed to read file: ${path}`, "FILE_READ_ERROR");
    }
    
    // Format the result
    return formatSuccess(`File: ${path}\n\n\`\`\`\n${fileContent.content}\n\`\`\``);
  } catch (error) {
    return formatError(`Error reading file: ${error.message}`, "FILE_READ_ERROR");
  }
}
```

## System Operation Patterns

### System Status Pattern
```javascript
// Check component status
async function checkComponentStatus() {
  const components = [
    {name: 'Command Handler', path: '00OS/core/command-handler.md'},
    {name: 'Parser', path: '00OS/core/parser.md'},
    {name: 'Registry', path: '00OS/core/registry.md'},
    {name: 'Executor', path: '00OS/core/executor.md'},
    {name: 'Permissions', path: '00OS/core/permissions.md'},
    {name: 'State Manager', path: '00OS/core/state-manager.md'}
  ];
  
  const results = [];
  
  for (const component of components) {
    try {
      const fileExists = await checkFileExists(component.path);
      results.push({
        name: component.name,
        status: fileExists ? 'Active' : 'Unavailable',
        path: component.path
      });
    } catch (error) {
      results.push({
        name: component.name,
        status: 'Unknown',
        path: component.path
      });
    }
  }
  
  return results;
}

// Format status report
function formatStatusReport(systemInfo, componentStatus, additionalInfo) {
  let output = `✅ ${systemInfo.name} System Status\n\n`;
  
  // System Information section
  output += `System Information:\n`;
  output += `-----------------\n`;
  output += `Name:           ${systemInfo.name}\n`;
  output += `Version:        ${systemInfo.version}\n`;
  output += `Status:         ${systemInfo.status}\n\n`;
  
  // Component Status section
  output += `Component Status:\n`;
  output += `-----------------\n`;
  for (const component of componentStatus) {
    const statusIcon = component.status === 'Active' ? '✅' : '❌';
    output += `${component.name}: ${statusIcon} ${component.status}\n`;
  }
  
  // Additional sections if provided
  if (additionalInfo) {
    for (const [section, content] of Object.entries(additionalInfo)) {
      output += `\n${section}: ${content}`;
    }
  }
  
  return output;
}
```

## Context Management Patterns

### File Loading Pattern
```javascript
// Load files from directory
async function loadDirectoryFiles(path, fileFilter = (f) => f.endsWith('.md')) {
  const loadedFiles = [];
  
  try {
    const dirContents = await tools.call('list_dir', {
      relative_workspace_path: path,
      explanation: `Loading files from ${path}`
    });
    
    if (dirContents && dirContents.entries) {
      for (const entry of dirContents.entries) {
        if (!entry.is_directory && fileFilter(entry.path)) {
          const fileContent = await tools.call('read_file', {
            target_file: entry.path,
            should_read_entire_file: true,
            explanation: `Reading file ${entry.path}`
          });
          
          if (fileContent && fileContent.content) {
            loadedFiles.push({
              path: entry.path,
              name: entry.path.split('/').pop().replace('.md', ''),
              content: fileContent.content
            });
          }
        }
      }
    }
  } catch (error) {
    tools.log(`Error loading files from ${path}: ${error.message}`);
  }
  
  return loadedFiles;
}
```

## Command Processing Patterns

### Command Help Pattern
```javascript
// Generate help for a command
async function generateCommandHelp(commandName) {
  // Find command process file
  const processFile = findProcessFile(commandName);
  
  if (!processFile) {
    return formatError(`Command not found: ${commandName}`, "COMMAND_NOT_FOUND");
  }
  
  // Read process file
  const fileContent = await tools.call('read_file', {
    target_file: processFile,
    should_read_entire_file: true,
    explanation: `Reading process file for ${commandName}`
  });
  
  if (!fileContent || !fileContent.content) {
    return formatError(`Failed to read command information for: ${commandName}`, "HELP_ERROR");
  }
  
  // Extract metadata from file content
  const metadata = extractMetadata(fileContent.content);
  
  // Generate help text
  let helpText = `Command: ${commandName}\n`;
  helpText += `Description: ${metadata.description || 'No description available'}\n\n`;
  
  // Add usage section
  helpText += `Usage: > ${commandName}`;
  
  // Add parameters if any
  if (metadata.inputs && metadata.inputs.length > 0) {
    helpText += " [options]\n\n";
    helpText += "Options:\n";
    
    for (const input of metadata.inputs) {
      const required = input.required ? ' (required)' : '';
      helpText += `  ${input.name}${required}: ${input.description || 'No description'}\n`;
    }
  } else {
    helpText += "\n\n";
  }
  
  return formatSuccess(helpText);
}
```

## Error Handling Patterns

### Common Error Codes
```javascript
// Standard error codes
const ERROR_CODES = {
  VALIDATION_ERROR: "Input validation failed",
  EXECUTION_ERROR: "Error during command execution",
  NOT_FOUND_ERROR: "Requested resource not found",
  PERMISSION_ERROR: "Insufficient permissions",
  FILE_ERROR: "File operation failed",
  SYSTEM_ERROR: "System operation failed"
};

// Get error suggestions
function getErrorSuggestions(code, context) {
  const suggestions = {
    VALIDATION_ERROR: [
      "Check the command syntax",
      "Ensure all required parameters are provided",
      "Use '> help [command]' for usage information"
    ],
    NOT_FOUND_ERROR: [
      "Check if the path is correct",
      "Verify the resource exists"
    ],
    PERMISSION_ERROR: [
      "Use a command with appropriate permissions",
      "Check if you have access to the requested resource"
    ]
  };
  
  return suggestions[code] || [];
}
```

## Implementation Summary

I've created a comprehensive but focused file structure for the 00OS-commands directory that:

1. Provides clear starting points for each workflow iteration
2. Tracks commands and their implementation status
3. Establishes standard patterns for consistent implementation
4. Creates structured templates for feedback and issue tracking
5. Maintains a chronological record of key decisions

This structure balances comprehensive knowledge with conciseness, ensuring each file serves a clear purpose in the workflow. The README.md file provides a quick starting point, while the more detailed files provide necessary context without redundancy.
