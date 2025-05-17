# 00OS Tool Call Patterns

## Core Principle: The 3-Step Pattern

Every 00OS command process must follow this pattern:
1. **User sends a command**: `> command-name [arguments] [--flags]`
2. **AI fetches the process rule**: Use a single `fetch_rules` call
3. **AI executes the defined tool calls**: Follow the rule exactly, no more, no less

> **Keep it simple:**
> - Use direct, minimal tool call sequences
> - Avoid complex error handling or multi-step logic
> - All examples should be short and actionable

## Minimal Tool Call Patterns

### 1. Fetch Process Rule (MANDATORY)
```javascript
await tools.call('fetch_rules', {
  rule_names: [`processes/${category}/${command}`],
  explanation: `Fetching process rule for ${command}`
});
```

### 2. Information Gathering
```javascript
// List directory
await tools.call('list_dir', {
  relative_workspace_path: targetPath,
  explanation: 'Listing directory contents'
});

// Read file
await tools.call('read_file', {
  target_file: targetFile,
  should_read_entire_file: true,
  explanation: 'Reading file content'
});
```

### 3. File Modification
```javascript
// Read file
const fileContent = await tools.call('read_file', {
  target_file: targetFile,
  should_read_entire_file: true,
  explanation: 'Reading file before modification'
});

// Edit file
await tools.call('edit_file', {
  target_file: targetFile,
  instructions: 'Update file content',
  code_edit: `// ... existing code ...\n${newContent}\n// ... existing code ...`
});
```

### 4. Terminal Command Execution
```javascript
await tools.call('run_terminal_cmd', {
  command: 'git status',
  is_background: false,
  explanation: 'Checking git repository status'
});
```

## Minimal Error Handling

Let the system handle errors unless a specific suggestion is needed. Example:
```javascript
try {
  // Tool calls
} catch (error) {
  return {
    success: false,
    error: error.message,
    suggestions: ['Check your input and try again.']
  };
}
```

## Best Practices
- **Always start with fetch_rules**
- **Favor direct, minimal tool call sequences**
- **Avoid over-engineering and complex error handling**
- **All examples should be short and practical**
- **Use clear explanations in tool calls**

## Example: Minimal Command Process

```markdown
---
name: file-list
category: system
description: List files in a directory
version: 1.0
author: 00reaper
permissions: [basic]
inputs:
  - name: path
    type: string
    required: true
    description: Directory path
outputs:
  - name: result
    type: array
    description: List of files
---

# Process: file-list

USE WHEN you want to execute file-list

## Execution

1. list_dir: List files in the specified directory

## Examples

> file-list /00os/processes
```

## Recent Improvements (REQ-003)

All 00OS processes have been updated to follow these enhanced implementation standards:

1. **Replaced Terminal Commands**: Eliminated direct terminal command execution in favor of proper tool call sequences
2. **Enhanced Error Handling**: Added comprehensive try/catch blocks with proper error codes and suggestions
3. **Standardized Response Formatting**: Implemented consistent use of ✅, ❌, and ⚠️ status indicators
4. **Modular Design**: Restructured processes to use helper functions for better code organization
5. **Robust Argument Parsing**: Improved parameter handling with support for both positional arguments and flags
6. **Documentation Integration**: Added detailed explanation parameters to all tool calls

## Common Tool Call Patterns

### 1. Process Rule Fetching (MANDATORY)
```javascript
// ALWAYS start with fetch_rules
const ruleResult = await tools.call('fetch_rules', {
  rule_names: [`processes/${category}/${command}`],
  explanation: `Fetching process rule for ${command}`
});

if (!ruleResult || !ruleResult.results?.[0]) {
  return {
    success: false,
    error: `Process rule not found for ${command}`,
    suggestions: [
      'Verify the command name is correct',
      'Check that the process file exists in the correct category'
    ]
  };
}
```

### 2. Information Gathering Pattern
```
list_dir -> codebase_search -> read_file -> [process data] -> [format response]
```

```javascript
// Example implementation
const dirResult = await tools.call('list_dir', {
  relative_workspace_path: targetPath,
  explanation: "Listing directory contents"
});

const searchResult = await tools.call('codebase_search', {
  query: searchQuery,
  target_directories: [targetPath],
  explanation: "Searching for relevant code"
});

const fileContent = await tools.call('read_file', {
  target_file: targetFile,
  should_read_entire_file: true,
  explanation: "Reading file content"
});
```

### 3. File Modification Pattern
```
read_file -> [generate modifications] -> edit_file -> [optional: reapply] -> [format response]
```

```javascript
// Example implementation
const fileContent = await tools.call('read_file', {
  target_file: targetFile,
  should_read_entire_file: true,
  explanation: "Reading file before modification"
});

await tools.call('edit_file', {
  target_file: targetFile,
  instructions: "Updating file content",
  code_edit: `// ... existing code ...
${newContent}
// ... existing code ...`
});

// Verify changes if needed
if (verificationNeeded) {
  await tools.call('reapply', {
    target_file: targetFile
  });
}
```

### 4. Terminal Command Execution Pattern
```
[prepare command] -> run_terminal_cmd -> [verify execution] -> [format response]
```

```javascript
// Example implementation
const result = await tools.call('run_terminal_cmd', {
  command: "git status", // NEVER execute 00OS commands via terminal
  is_background: false,
  explanation: "Checking git repository status"
});
```

## Standard Error Handling Pattern

```javascript
try {
  // Tool call with appropriate parameters
  const result = await tools.call('tool_name', {
    // tool parameters
    explanation: "Purpose of this tool call"
  });
  
  // Process successful result
} catch (error) {
  // Handle error appropriately
  return formatError(`Error during operation: ${error.message}`, "TOOL_ERROR", [
    "Suggestion 1 to resolve the issue",
    "Suggestion 2 to resolve the issue"
  ]);
}
```

## Standard Response Formatting

### Success Response
```javascript
return {
  success: true,
  result: data,
  message: "✅ Operation completed successfully"
};
```

### Error Response
```javascript
return {
  success: false,
  error: "❌ Operation failed",
  code: "ERROR_CODE",
  suggestions: [
    "Suggestion 1",
    "Suggestion 2"
  ]
};
```

### Warning Response
```javascript
return {
  success: true,
  result: data,
  message: "⚠️ Operation completed with warnings",
  warnings: ["Warning detail"]
};
```

## Tool Call Parameter Guidelines

### 1. Always Include Explanations
```javascript
await tools.call('read_file', {
  target_file: path,
  explanation: "Reading configuration file to determine system settings"
});
```

### 2. Be Specific with Search Queries
```javascript
// Good
await tools.call('codebase_search', {
  query: "function executeCommand implementation",
  target_directories: ["/00os/core"],
  explanation: "Finding the command execution function"
});

// Bad
await tools.call('codebase_search', {
  query: "command",
  explanation: "Searching"
});
```

### 3. Minimize File Reading Scope
```javascript
// Preferred when only a portion is needed
await tools.call('read_file', {
  target_file: path,
  offset: 100,
  limit: 200,
  explanation: "Reading the configuration section of the file"
});
```

## Implementation Checklist

- [ ] Process uses explicit tool calls (no terminal execution of 00OS commands)
- [ ] All tool calls include explanation parameters
- [ ] Comprehensive argument parsing is implemented
- [ ] Error handling with try/catch is implemented for all tool calls
- [ ] Response formatting uses standard indicators (✅, ❌, ⚠️)
- [ ] Command errors include helpful suggestions
- [ ] Process respects its category permissions
- [ ] Code is modular and maintainable with clear function names
- [ ] Documentation is up-to-date and reflects actual implementation

## Best Practices

1. **Tool Call Optimization**
   - Minimize number of calls
   - Prefer larger reads over multiple small ones
   - Include clear explanations

2. **Error Handling**
   - Always use try/catch blocks
   - Provide specific error codes
   - Include helpful suggestions

3. **Response Formatting**
   - Use standard indicators (✅, ❌, ⚠️)
   - Include relevant data
   - Provide clear messages

4. **Documentation**
   - Clear explanation parameters
   - Consistent formatting
   - Proper error handling

## Process-Specific Patterns

### Help Process Pattern

```
[get command] -> list_dir -> [for target dirs] -> [format help output]
```

### Version Process Pattern

```
[get settings] -> [format version information]
```

### Reaper-Sync Process Pattern

```
list_dir -> [for each file] -> [determine destination] -> run_terminal_cmd -> [format results]
```

## Conclusion

By adhering to these standardized tool call patterns, 00OS processes maintain consistency, reliability, and maintainability. Each process should implement the appropriate pattern based on its primary function, while ensuring proper error handling and response formatting throughout. 

## Standard Tool Call Patterns

### 1. Process Rule Fetching (MANDATORY)
```javascript
// ALWAYS start with fetch_rules
const ruleResult = await tools.call('fetch_rules', {
  rule_names: [`processes/${category}/${command}`],
  explanation: `Fetching process rule for ${command}`
});

if (!ruleResult || !ruleResult.results?.[0]) {
  return {
    success: false,
    error: `Process rule not found for ${command}`,
    suggestions: [
      'Verify the command name is correct',
      'Check that the process file exists in the correct category'
    ]
  };
}
```

### 2. Information Gathering
```javascript
// Directory listing
const dirResult = await tools.call('list_dir', {
  relative_workspace_path: targetPath,
  explanation: "Listing directory contents"
});

// Semantic search
const searchResult = await tools.call('codebase_search', {
  query: searchQuery,
  target_directories: [targetPath],
  explanation: "Searching for relevant code"
});

// File reading
const fileContent = await tools.call('read_file', {
  target_file: targetFile,
  should_read_entire_file: false,
  start_line_one_indexed: 1,
  end_line_one_indexed_inclusive: 200,
  explanation: "Reading file content"
});
```

### 3. File Modification
```javascript
// Read existing content
const currentContent = await tools.call('read_file', {
  target_file: targetFile,
  should_read_entire_file: true,
  start_line_one_indexed: 1,
  end_line_one_indexed_inclusive: 1000,
  explanation: "Reading current file content"
});

// Apply changes
await tools.call('edit_file', {
  target_file: targetFile,
  instructions: "Updating file content with new changes",
  code_edit: `// ... existing code ...
${newContent}
// ... existing code ...`
});

// Verify changes if needed
await tools.call('reapply', {
  target_file: targetFile
});
```

### 4. File Search and Navigation
```javascript
// Fuzzy file search
const files = await tools.call('file_search', {
  query: "pattern",
  explanation: "Finding files matching pattern"
});

// Exact text search
const matches = await tools.call('grep_search', {
  query: "exactPattern",
  case_sensitive: true,
  explanation: "Finding exact text matches"
});
```

### 5. Terminal Command Execution
```javascript
// NEVER execute 00OS commands via terminal
const result = await tools.call('run_terminal_cmd', {
  command: "git status",
  is_background: false,
  explanation: "Checking git repository status"
});
```

## Error Handling Pattern

```javascript
try {
  // 1. Fetch process rule (MANDATORY)
  const ruleResult = await tools.call('fetch_rules', {
    rule_names: [`processes/${category}/${command}`],
    explanation: `Fetching process rule for ${command}`
  });

  // 2. Execute main tool calls
  const result = await executeMainLogic();

  // 3. Return success
  return {
    success: true,
    result: result,
    message: "Operation completed successfully"
  };

} catch (error) {
  return {
    success: false,
    error: error.message,
    code: error.code || "EXECUTION_ERROR",
    suggestions: [
      "Check input parameters",
      "Verify file paths exist",
      "Ensure proper permissions"
    ]
  };
}
```

## Response Formatting

### Success Response
```javascript
return {
  success: true,
  result: data,
  message: "✅ Operation completed successfully"
};
```

### Error Response
```javascript
return {
  success: false,
  error: "❌ Operation failed",
  code: "ERROR_CODE",
  suggestions: [
    "Suggestion 1",
    "Suggestion 2"
  ]
};
```

### Warning Response
```javascript
return {
  success: true,
  result: data,
  message: "⚠️ Operation completed with warnings",
  warnings: ["Warning detail"]
};
```

## Best Practices

1. **Tool Call Optimization**
   - Minimize number of calls
   - Prefer larger reads over multiple small ones
   - Include clear explanations

2. **Error Handling**
   - Always use try/catch blocks
   - Provide specific error codes
   - Include helpful suggestions

3. **Response Formatting**
   - Use standard indicators (✅, ❌, ⚠️)
   - Include relevant data
   - Provide clear messages

4. **Documentation**
   - Clear explanation parameters
   - Consistent formatting
   - Proper error handling 