# Standardized Tool Call Patterns

This document outlines the standardized tool call patterns that have been implemented for 00OS commands. These patterns should be followed when creating new commands to ensure consistency and reliability across the system.

## Core Patterns

Each tool call pattern follows this general structure:

```javascript
const result = await tools.call('tool_name', {
  param1: value1,
  param2: value2,
  explanation: 'Clear explanation of why this tool call is being made'
});
```

## File Operation Patterns

### Reading Files

```javascript
const readResult = await tools.call('read_file', {
  target_file: filePath,
  should_read_entire_file: true,  // Or use offset/limit for partial reads
  explanation: `Reading file ${filePath} as part of command execution`
});

// Handle the result
if (!readResult || !readResult.content) {
  throw new Error(`Failed to read file ${filePath}`);
}

// Process the content
const fileContent = readResult.content;
```

### Listing Directory Contents

```javascript
const dirResult = await tools.call('list_dir', {
  relative_workspace_path: directoryPath,
  explanation: `Listing contents of directory ${directoryPath}`
});

// Check if directory exists
if (!dirResult || !dirResult.entries) {
  throw new Error(`Failed to list directory ${directoryPath}`);
}

// Process entries
const files = dirResult.entries.filter(entry => !entry.isDirectory);
const directories = dirResult.entries.filter(entry => entry.isDirectory);
```

### Writing/Editing Files

```javascript
await tools.call('edit_file', {
  target_file: filePath,
  instructions: `Creating/updating file ${filePath} with new content`,
  code_edit: newContent
});
```

## Search Patterns

### Semantic Search

```javascript
const semanticResults = await tools.call('codebase_search', {
  query: searchQuery,
  target_directories: [specificDir], // Optional
  explanation: `Performing semantic search for ${searchQuery}`
});
```

### Pattern Search (Grep)

```javascript
const grepResults = await tools.call('grep_search', {
  query: searchPattern,
  include_pattern: '*.md', // Optional
  exclude_pattern: 'node_modules', // Optional
  case_sensitive: false, // Optional
  explanation: `Searching for pattern ${searchPattern} in codebase`
});
```

### File Search

```javascript
const fileResults = await tools.call('file_search', {
  query: filenamePattern,
  explanation: `Searching for files matching ${filenamePattern}`
});
```

## Terminal Command Pattern

### Safe Command Execution

```javascript
const cmdResult = await tools.call('run_terminal_cmd', {
  command: `echo "Safe command execution" | cat`,
  is_background: false,
  explanation: `Running safe terminal command for system information`
});

// Check command result
if (cmdResult.exitCode !== 0) {
  throw new Error(`Command failed with exit code ${cmdResult.exitCode}: ${cmdResult.error}`);
}

// Process output
const output = cmdResult.output;
```

## Chain Command Pattern

When needing to run multiple commands in sequence that depend on each other:

```javascript
const results = [];

// First command
const result1 = await tools.call('tool1', {
  param: value,
  explanation: 'First step in the chain'
});
results.push(result1);

// Second command using result from first
if (result1 && result1.success) {
  const result2 = await tools.call('tool2', {
    param: result1.data.someValue,
    explanation: 'Second step in the chain using first result'
  });
  results.push(result2);
} else {
  throw new Error('First step failed, cannot continue chain');
}

// Process combined results
return {
  message: 'Chain completed successfully',
  data: {
    step1: results[0],
    step2: results[1]
  }
};
```

## Validation Pattern

Always validate inputs before performing tool calls:

```javascript
function validateInputs() {
  // Required parameter check
  if (!inputs.requiredParam) {
    return {
      valid: false,
      error: 'Missing required parameter',
      suggestions: ['Provide the required parameter']
    };
  }
  
  // Type validation check
  if (typeof inputs.numericParam !== 'number') {
    if (typeof inputs.numericParam === 'string') {
      // Try to convert
      const num = Number(inputs.numericParam);
      if (!isNaN(num)) {
        inputs.numericParam = num;
      } else {
        return {
          valid: false,
          error: 'Parameter must be a number',
          suggestions: ['Provide a valid number']
        };
      }
    } else {
      return {
        valid: false,
        error: 'Parameter must be a number',
        suggestions: ['Provide a valid number']
      };
    }
  }
  
  return { valid: true };
}
```

## Error Handling Pattern

Always use try/catch blocks for tool calls and provide helpful error messages:

```javascript
try {
  const result = await tools.call('some_tool', {
    param: value,
    explanation: 'Purpose of this tool call'
  });
  
  // Process result
  return formatSuccess('Operation completed', result);
  
} catch (error) {
  // Log error for diagnostic purposes
  tools.error(`Error during operation: ${error.message}`);
  
  // Return formatted error with suggestions
  return formatError(
    error.message,
    'ERROR_CODE',
    ['Suggestion 1', 'Suggestion 2']
  );
}
```

## Response Formatting Patterns

### Success Response

```javascript
function formatSuccess(message, data = null) {
  const response = {
    success: true,
    message: `✅ ${message}`
  };
  
  if (data !== null) {
    response.data = data;
  }
  
  return response;
}
```

### Warning Response

```javascript
function formatWarning(message, data = null) {
  const response = {
    success: true,
    warning: true,
    message: `⚠️ ${message}`
  };
  
  if (data !== null) {
    response.data = data;
  }
  
  return response;
}
```

### Error Response

```javascript
function formatError(message, code = 'EXECUTION_ERROR', suggestions = []) {
  const response = {
    success: false,
    message: `❌ Error [${code}]: ${message}`
  };
  
  if (suggestions && suggestions.length > 0) {
    response.suggestions = suggestions;
  }
  
  return response;
}
```

## Implementation Requirements

When implementing these patterns in your command:

1. **Always** include the `explanation` parameter in tool calls
2. **Always** validate inputs before performing tool calls
3. **Always** use try/catch blocks for error handling
4. **Always** format responses consistently
5. **Never** use `run_terminal_cmd` to execute 00OS commands (with > prefix)
6. **Never** make assumptions about input types without validation
7. **Always** provide helpful error messages and suggestions

By following these standardized patterns, you ensure that your command integrates seamlessly with the 00OS ecosystem and provides a consistent user experience. 