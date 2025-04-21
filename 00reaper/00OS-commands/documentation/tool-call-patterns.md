# 00OS Tool Call Patterns

## Overview

This document defines the standardized tool call patterns for all 00OS processes. These patterns ensure consistency, reliability, and maintainability across the system by establishing clear sequences of tool calls for common operations.

## Core Principles

1. **Explicit Tool Call Declaration**: All tool calls must be explicitly declared in process files
2. **Sequential Execution**: Tool calls should be executed in a logical, sequential order
3. **Proper Error Handling**: Each tool call must include appropriate error handling
4. **No Self-Execution**: Processes must never attempt to execute 00OS commands through terminal commands
5. **Consistent Response Formatting**: All responses should use standard indicators (✅, ❌, ⚠️)

## Common Tool Call Patterns

### 1. Information Gathering Pattern

Used for processes that primarily collect and display information.

```
list_dir -> codebase_search -> read_file -> [process data] -> [format response]
```

**Example Implementation:**

```javascript
// 1. List directory contents
const directoryContents = await tools.call('list_dir', {
  relative_workspace_path: targetPath,
  explanation: "Listing directory contents to gather information"
});

// 2. Perform targeted search if needed
const searchResults = await tools.call('codebase_search', {
  query: searchQuery,
  target_directories: [targetPath],
  explanation: "Searching for specific information in the codebase"
});

// 3. Read specific files of interest
const fileContent = await tools.call('read_file', {
  target_file: targetFile,
  should_read_entire_file: true,
  explanation: "Reading file to extract detailed information"
});

// 4. Process gathered information
const processedData = processInformation(directoryContents, searchResults, fileContent);

// 5. Return formatted response
return formatSuccess("Information gathered successfully", processedData);
```

### 2. File Modification Pattern

Used for processes that modify file contents.

```
read_file -> [generate modifications] -> edit_file -> [optional: reapply] -> [format response]
```

**Example Implementation:**

```javascript
// 1. Read existing file
const fileContent = await tools.call('read_file', {
  target_file: targetFile,
  should_read_entire_file: true,
  explanation: "Reading file before modification"
});

// 2. Generate modifications
const modification = generateModification(fileContent.content);

// 3. Apply changes
await tools.call('edit_file', {
  target_file: targetFile,
  instructions: "Updating file content",
  code_edit: modification
});

// 4. Verify changes (optional)
if (verificationNeeded) {
  await tools.call('reapply', {
    target_file: targetFile
  });
}

// 5. Return success
return formatSuccess(`File ${targetFile} updated successfully`);
```

### 3. Command Execution Pattern

Used for processes that execute terminal commands.

```
[prepare command] -> run_terminal_cmd -> [verify execution] -> [format response]
```

**Example Implementation:**

```javascript
// 1. Prepare command
const command = buildCommand(inputs);

// 2. Execute command
const result = await tools.call('run_terminal_cmd', {
  command: command,
  explanation: "Executing command for process",
  is_background: false
});

// 3. Verify execution
if (result.exitCode !== 0) {
  return formatError(`Command execution failed: ${result.error}`, "COMMAND_ERROR");
}

// 4. Return success
return formatSuccess(`Command executed successfully: ${result.output}`);
```

### 4. Rule-Based Execution Pattern

Used for processes that rely on fetching rules before execution.

```
fetch_rules -> [process rule content] -> [execute appropriate tools] -> [format response]
```

**Example Implementation:**

```javascript
// 1. Fetch required rule
const ruleResult = await tools.call('fetch_rules', {
  rule_names: ["processes/system/help"],
  explanation: "Fetching help process rule to execute help command"
});

// 2. Process rule content
const processTools = extractToolsFromRule(ruleResult);

// 3. Execute appropriate tools based on rule content
for (const toolCall of processTools) {
  await executeToolCall(toolCall);
}

// 4. Return formatted response
return formatSuccess("Rule-based execution completed successfully");
```

## Standard Error Handling Pattern

Each tool call should implement this error handling pattern:

```javascript
try {
  const result = await tools.call('tool_name', {
    // tool parameters
  });
  
  // Verify tool call success
  if (!result || result.error) {
    throw new Error(`Tool call failed: ${result ? result.error : 'No result'}`);
  }
  
  // Process successful result
} catch (error) {
  // Handle error appropriately
  return formatError(`Error during operation: ${error.message}`, "TOOL_ERROR");
}
```

## Standard Response Formatting

All processes should use these standard response formatting functions:

```javascript
function formatSuccess(message, data = null) {
  return `✅ ${message}${data ? '\n\n' + JSON.stringify(data, null, 2) : ''}`;
}

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

function formatWarning(message, details = null) {
  return `⚠️ Warning: ${message}${details ? '\n\n' + details : ''}`;
}
```

## Tool Call Parameter Guidelines

### 1. Always Include Explanations

All tool calls should include an explanation parameter that clearly describes the purpose of the call:

```javascript
await tools.call('read_file', {
  target_file: path,
  explanation: "Reading configuration file to determine system settings"
});
```

### 2. Be Specific with Search Queries

When using search tools, be as specific as possible with queries:

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

When reading files, specify the relevant portions rather than reading entire files when possible:

```javascript
// Preferred when only a portion is needed
await tools.call('read_file', {
  target_file: path,
  offset: 100,
  limit: 200,
  explanation: "Reading the configuration section of the file"
});

// Use only when necessary
await tools.call('read_file', {
  target_file: path,
  should_read_entire_file: true,
  explanation: "Reading entire file for comprehensive analysis"
});
```

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