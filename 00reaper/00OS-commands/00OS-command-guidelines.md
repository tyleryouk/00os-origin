# 00OS Command Implementation Guidelines

This document provides standards for creating consistent, reliable 00OS commands using Cursor's tool call capabilities.

## Core Principles

The fundamental goal of 00OS commands is to create processes **based on tool call patterns** to automate development workflows. Commands should:

1. Use native Cursor tool calls rather than terminal commands
2. Follow a consistent structure and response format 
3. Implement robust error handling with recovery suggestions
4. Optimize tool call sequences for efficiency

## Command Processing Flow

1. User sends command with `>` prefix 
2. Command handler detects command and parses parameters
3. `fetch_rules` retrieves the appropriate process
4. Process executes a sequence of tool calls
5. Formatted response is returned to user

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
2. Parameter validation function
3. Tool call execution sequence
4. Error handling with specific codes
5. Consistent response formatting

## Tool Call Implementation Pattern

```javascript
// Input validation
function validateInput(args, flags) {
  // Validation logic
  return { valid: true/false, error: "Error message if invalid" };
}

// Execution logic - defines tool call sequence
async function execute(args, flags) {
  // Validate input
  const validation = validateInput(args, flags);
  if (!validation.valid) {
    return {
      success: false,
      message: `❌ Error: ${validation.error}`,
      suggestions: [...] // Recovery suggestions
    };
  }
  
  try {
    // Execute tool calls in sequence
    const result1 = await tools.call('tool_name', {
      param1: 'value1',
      param2: 'value2',
      explanation: 'Purpose of this tool call'
    });
    
    const result2 = await tools.call('another_tool', {
      param1: result1.output, // Use result from previous call
      explanation: 'Purpose of this tool call'
    });
    
    // Process results
    const processedResult = processResults(result1, result2);
    
    // Return formatted response
    return {
      success: true,
      message: `✅ Command executed successfully`,
      data: processedResult
    };
  } catch (error) {
    // Handle errors
    return {
      success: false,
      message: `❌ Error: ${error.message}`,
      code: determineErrorCode(error),
      suggestions: generateSuggestions(error)
    };
  }
}
```

## Cursor Tool Types

### Search Tools
- `read_file`: Reads file contents (up to 750 lines in MAX mode, 250 in regular)
- `list_dir`: Lists directory contents without reading files
- `codebase_search`: Performs semantic search within codebase
- `grep_search`: Searches for exact patterns within files
- `file_search`: Finds files by name using fuzzy matching
- `web_search`: Searches the web for information

### Edit Tools
- `edit_file`: Creates or modifies files
- `reapply`: Re-applies edits when previous attempts weren't successful
- `delete_file`: Removes files from the system

### Terminal Tools
- `run_terminal_cmd`: Executes terminal commands and returns results

### Other Tools
- `fetch_rules`: Retrieves Cursor rules by name or description

## Tool Call Best Practices

### Efficiency
- Limit total tool calls (25 per request limit, 200 in MAX mode)
- Read larger sections of files at once
- Stop tool calls once you have the information you need
- Use targeted searches before broad file reads

### Chaining
- Chain tool calls in logical sequences
- Use results from one tool call to inform the next
- Cache results to avoid redundant tool calls
- Process data between calls to minimize total calls

### Error Handling
- Handle tool call failures gracefully
- Provide alternative approaches when primary methods fail
- Include specific error codes and helpful suggestions
- Format error responses consistently

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
- `TOOL_CALL_ERROR`: Error during tool call execution

## Example Command Implementation

### Command: file-read

```javascript
// Validate input parameters
function validateInput(args) {
  if (!args || args.length === 0) {
    return {
      valid: false,
      error: "Missing file path parameter",
      suggestions: ["Provide a file path to read"]
    };
  }
  return { valid: true };
}

// Main execution function
async function execute(args, flags) {
  // Validate input
  const validation = validateInput(args);
  if (!validation.valid) {
    return {
      success: false,
      message: `❌ Error: ${validation.error}`,
      suggestions: validation.suggestions
    };
  }
  
  const filePath = args[0];
  
  try {
    // Execute read_file tool call
    const fileContent = await tools.call("read_file", {
      target_file: filePath,
      should_read_entire_file: true,
      explanation: `Reading contents of ${filePath}`
    });
    
    // Check for errors in tool call response
    if (!fileContent || !fileContent.content) {
      return {
        success: false,
        message: `❌ Error: Failed to read file contents`,
        code: "TOOL_CALL_ERROR",
        suggestions: [
          "Check if the file exists",
          "Verify file path is correct"
        ]
      };
    }
    
    // Return formatted response
    return {
      success: true,
      message: `✅ File contents of ${filePath}:`,
      data: {
        path: filePath,
        content: fileContent.content
      }
    };
  } catch (error) {
    // Handle errors
    return {
      success: false,
      message: `❌ Error: ${error.message}`,
      code: "EXECUTION_ERROR",
      suggestions: [
        "Check if the file exists",
        "Verify file path is correct",
        "Ensure you have permission to read the file"
      ]
    };
  }
}
```

## Important Notes

1. **NEVER** implement commands that run terminal commands which then try to execute the same 00OS command - this creates an infinite loop
2. Always use native Cursor tool calls for functionality
3. Provide meaningful error messages with recovery suggestions
4. Test commands thoroughly with various inputs
5. Document command behavior and examples
