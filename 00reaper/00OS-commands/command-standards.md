# 00OS Command Standards

## Overview

This document defines the standards for implementing commands in the 00OS environment. Following these standards ensures consistency, reliability, and maintainability across all command implementations.

## Command Structure

### File Structure

Each command must be implemented in its own process file following this structure:

```
00os/processes/
  ├── system/           # Core system commands
  │   ├── echo.js
  │   ├── help.js
  │   └── ...
  ├── tools/            # Utility commands
  │   ├── calculator.js
  │   ├── file-list.js
  │   └── ...
  └── apps/             # Application commands
      ├── counter.js
      └── ...
```

### Command File Template

Each command file must follow this template:

```javascript
/**
 * @command command-name
 * @description Brief description of what the command does
 * @category system|tools|apps
 * @usage command-name [arguments] [--flags]
 * @example command-name arg1 --flag1
 */

module.exports = {
  /**
   * Command metadata
   */
  metadata: {
    name: 'command-name',
    description: 'Brief description of what the command does',
    usage: 'command-name [arguments] [--flags]',
    examples: [
      { 
        command: 'command-name arg1 --flag1', 
        description: 'Description of what this example does' 
      }
    ],
    category: 'system|tools|apps',
    permissions: [
      'filesystem:read',
      'network:connect'
      // Add required permissions
    ]
  },

  /**
   * Execute the command
   * @param {string[]} args - Command arguments
   * @param {Object} env - Execution environment
   * @param {Object} options - Command options
   * @returns {Object} Command result
   */
  execute: (args, env, options = {}) => {
    try {
      // Parameter validation
      if (args.length < 1) {
        return {
          success: false,
          message: '❌ Error: Missing required argument',
          suggestions: ['Try: command-name <required-arg>']
        };
      }

      // Command implementation
      const result = performAction(args, options);

      // Return success response
      return {
        success: true,
        message: `✅ Command executed successfully: ${result}`,
        data: result // Optional structured data
      };
    } catch (error) {
      // Error handling
      return {
        success: false,
        message: `❌ Error: ${error.message}`,
        error: error,
        suggestions: getSuggestions(error)
      };
    }
  }
};

/**
 * Helper functions can be defined below
 */
```

## Command Response Format

Commands must return a consistent response object with these properties:

```javascript
{
  success: true|false,  // Boolean indicating success or failure
  message: "Message for user", // Human-readable message
  data: {}, // Optional structured data
  error: {}, // Error object (only for failures)
  suggestions: [] // Suggested actions (especially for failures)
}
```

### Success Response Example

```javascript
{
  success: true,
  message: "✅ File contents read successfully:",
  data: {
    content: "File content here",
    path: "/path/to/file.txt",
    size: 1024
  }
}
```

### Error Response Example

```javascript
{
  success: false,
  message: "❌ Error: File not found",
  error: {
    code: "FILE_NOT_FOUND",
    details: "The file /path/to/file.txt does not exist"
  },
  suggestions: [
    "Check if the file path is correct",
    "Try running '> file list /path/to' to see available files"
  ]
}
```

## Command Categories

Commands are organized into these categories:

1. **System Commands** (`system/`)
   - Core functionality for the 00OS environment
   - Example: `help`, `echo`, `version`

2. **Tool Commands** (`tools/`)
   - Utility functions for common tasks
   - Example: `calculator`, `file-list`, `file-read`

3. **Application Commands** (`apps/`)
   - More complex applications with state
   - Example: `counter`, `todo`

## Command Naming Conventions

1. **Command Names**
   - Use lowercase letters
   - Use hyphens for multi-word commands
   - Be descriptive but concise
   - Examples: `file-list`, `system-status`

2. **Arguments and Parameters**
   - Use descriptive names
   - Required parameters: `<parameter-name>`
   - Optional parameters: `[parameter-name]`

3. **Flags**
   - Prefix with double dash: `--flag-name`
   - Boolean flags don't require values
   - Value flags: `--flag-name=value`

## Parameter Processing

### Required Parameters

Validate required parameters at the start of command execution:

```javascript
if (!args[0]) {
  return {
    success: false,
    message: '❌ Error: Missing required parameter <file-path>',
    suggestions: ['Try: file-read <file-path>']
  };
}
```

### Optional Parameters

Provide defaults for optional parameters:

```javascript
const limit = args[1] ? parseInt(args[1], 10) : 10;
```

### Flags

Parse flags using a helper function:

```javascript
const parseFlags = (args) => {
  const flags = {};
  const cleanArgs = [];
  
  args.forEach(arg => {
    if (arg.startsWith('--')) {
      const [key, value] = arg.substring(2).split('=');
      flags[key] = value !== undefined ? value : true;
    } else {
      cleanArgs.push(arg);
    }
  });
  
  return { flags, args: cleanArgs };
};

const { flags, args: cleanArgs } = parseFlags(args);
```

## Error Handling

### Error Types

Define specific error types:

```javascript
const ErrorTypes = {
  PARAMETER_MISSING: 'PARAMETER_MISSING',
  INVALID_PARAMETER: 'INVALID_PARAMETER',
  RESOURCE_NOT_FOUND: 'RESOURCE_NOT_FOUND',
  PERMISSION_DENIED: 'PERMISSION_DENIED',
  EXECUTION_ERROR: 'EXECUTION_ERROR'
};
```

### Error Creation

Create structured errors:

```javascript
const createError = (type, message, details = {}) => {
  return {
    type,
    message,
    details,
    timestamp: new Date().toISOString()
  };
};
```

### Error Response

Return consistent error responses:

```javascript
return {
  success: false,
  message: `❌ Error: ${error.message}`,
  error: createError(ErrorTypes.RESOURCE_NOT_FOUND, error.message, { path }),
  suggestions: [
    'Check if the file exists',
    `Run '> file list ${path}' to see available files`
  ]
};
```

## Command Documentation

### In-Code Documentation

Use JSDoc-style comments for code documentation:

```javascript
/**
 * Process the file contents
 * @param {string} content - File content to process
 * @param {Object} options - Processing options
 * @param {boolean} options.trim - Whether to trim whitespace
 * @param {number} options.limit - Maximum number of lines
 * @returns {string} Processed content
 */
function processContent(content, options = {}) {
  // Implementation
}
```

### Help Text

Every command must provide comprehensive help information:

```javascript
const helpText = `
Command: file-read
Description: Read the contents of a file
Usage: file-read <file-path> [line-limit] [--raw] [--no-line-numbers]

Arguments:
  <file-path>     Path to the file to read (required)
  [line-limit]    Maximum number of lines to display (default: all)

Flags:
  --raw           Display raw file contents without formatting
  --no-line-numbers  Hide line numbers in output

Examples:
  > file-read /path/to/file.txt
  > file-read /path/to/file.txt 20
  > file-read /path/to/file.txt --raw
`;
```

## Command Testing

Commands must include tests as specified in the testing framework document:

1. **Unit tests** - Test core functionality
2. **Error condition tests** - Test handling of invalid inputs
3. **Integration tests** - Test interactions with other commands

## Command Implementation Checklist

Before submitting a command implementation, verify:

- [ ] Command follows the standard file structure
- [ ] Metadata is complete and accurate
- [ ] Required permissions are specified
- [ ] Parameter validation is implemented
- [ ] Error handling is comprehensive
- [ ] Response format follows standards
- [ ] Documentation is complete
- [ ] Tests are implemented and passing

## Command Registry Integration

Commands must register themselves with the command registry:

```javascript
// In command implementation file
module.exports = {
  metadata: { /* ... */ },
  execute: (args, env, options) => { /* ... */ }
};

// Command registry will auto-discover commands based on file structure
```

## Common Helper Functions

Reuse these helper functions across commands:

1. **Flag parsing**
2. **Parameter validation**
3. **Response formatting**
4. **Error handling**

Implementation examples are available in the utility library.

## Best Practices

1. **Single Responsibility**
   - Each command should do one thing well
   - Break complex tasks into multiple commands

2. **Consistent Output**
   - Use consistent formatting for all outputs
   - Follow the response format standards

3. **Helpful Error Messages**
   - Provide clear, actionable error messages
   - Include suggestions for resolving errors

4. **Performance**
   - Optimize for response time
   - Handle large datasets efficiently

5. **Security**
   - Validate all inputs
   - Request only necessary permissions

6. **Interoperability**
   - Design commands to work together
   - Support command chaining through structured output

By following these standards, we ensure that 00OS commands are consistent, reliable, and maintainable, providing a seamless experience for users. 