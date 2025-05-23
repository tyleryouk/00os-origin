# 00OS Tool Call Patterns (Canonical Reference)

> For the canonical rationale and design philosophy behind 00OS and Cursor rule manipulation, see [00OS-rationale.md].

This file is the single canonical reference for all tool call patterns, error handling, and response formatting in 00OS command processes.

> For command structure and developer standards, see [00OS-command-development.md](00OS-command-development.md). For workflow/process context, see the [master workflow file](../../README.md).

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

## Error Handling and Response Formatting

### Minimal Error Handling

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

### Standard Response Formatting

- **Success:**
  ```javascript
  return {
    success: true,
    result: data,
    message: "✅ Operation completed successfully"
  };
  ```
- **Error:**
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
- **Warning:**
  ```javascript
  return {
    success: true,
    result: data,
    message: "⚠️ Operation completed with warnings",
    warnings: ["Warning detail"]
  };
  ```

## Tool Call Parameter Guidelines

1. **Always Include Explanations**
2. **Be Specific with Search Queries**
3. **Minimize File Reading Scope**

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

---

For command structure and developer best practices, see [00OS-command-development.md](00OS-command-development.md). For workflow/process context, see the [master workflow file](../../README.md). 