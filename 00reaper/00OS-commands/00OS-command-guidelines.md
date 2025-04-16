# 00OS Command Implementation Guidelines

This document provides standards for creating consistent, reliable 00OS commands.

## Command Structure

All commands follow this syntax:
```
> [command] [subcommand] [arguments] [--flags]
```

Examples:
- `> help` - Display help information
- `> system status` - Show system status
- `> file list /path` - List files in directory
- `> echo Hello, world!` - Echo a message

## Process File Requirements

### Metadata Section
Every process file must include complete metadata:
```yaml
---
name: command-name
description: Brief description
version: 1.0
author: 00reaper
permissions: [basic]
inputs:
  - name: param1
    type: string
    required: true
    description: Description of parameter
outputs:
  - name: result
    type: string
    description: Command output
---
```

### Core Structure
Every process file should include:
1. Clear description section
2. Well-documented execution code
3. Error handling with specific codes
4. Consistent response formatting

## Implementation Patterns

### Standard Execution Pattern
```javascript
function execute() {
  try {
    // Validate inputs first
    const validationErrors = validateInputs(inputs);
    if (validationErrors.length > 0) {
      return formatError(validationErrors.join("\n"), "VALIDATION_ERROR");
    }
    
    // Process logic
    const result = performOperation();
    
    // Return formatted success
    return formatSuccess(result);
  } catch (error) {
    return formatError(error.message, "EXECUTION_ERROR");
  }
}
```

### Response Formatting
Always use these standard formatters:
```javascript
function formatSuccess(result) {
  return `✅ ${result}`;
}

function formatError(message, code, suggestions = []) {
  let output = `❌ Error [${code}]: ${message}\n\n`;
  
  if (suggestions.length > 0) {
    output += "Suggestions:\n";
    suggestions.forEach(suggestion => {
      output += `- ${suggestion}\n`;
    });
  }
  
  return output;
}
```

## Development Workflow

### Command Implementation Process
1. Create or update process file in the appropriate directory:
   - `/00OS/processes/system/` - For system commands
   - `/00OS/processes/tools/` - For utility commands
   - `/00OS/processes/examples/` - For example commands

2. Sync changes to the rules directory using the PowerShell script:
   ```
   .\Sync-00OS-Complete.ps1
   ```
   
3. Test the command execution
4. Document any issues or improvements in operational-feedback.md

### Sync Process
The synchronization script handles:
- Copying files from 00OS directory to .cursor/rules/
- Converting .md files to .mdc format
- Setting proper rule types based on file location:
  - Core components → `alwaysApply: true` 
  - Process files → `alwaysApply: false` with descriptive triggers
- Generating a sync report

Always run this script after making changes to ensure they're properly deployed.

## Best Practices

1. **Input Validation**: Always validate all inputs before processing
2. **Dynamic Discovery**: Use directory scanning over hardcoded lists
3. **Error Handling**: Include specific error codes and helpful suggestions
4. **Consistency**: Follow existing patterns for similar commands
5. **Documentation**: Include clear descriptions and examples
6. **Testing**: Test commands in isolation before integration

## Response Format Standards

All command responses should follow these formats:
```
✅ Success: [Command output]
❌ Error [CODE]: [Error message]
⚠️ Warning: [Warning message]
```

Error codes should be specific and descriptive:
- `VALIDATION_ERROR`: Invalid input parameters
- `EXECUTION_ERROR`: Error during command execution
- `NOT_FOUND_ERROR`: Requested resource not found
- `PERMISSION_ERROR`: Insufficient permissions
