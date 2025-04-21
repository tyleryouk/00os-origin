# Implementation Plan for REQ-003

## Enhance 00reaper and system 00OS Processes to focus on dynamic Tool Calls sequences

### Overview

This plan outlines the approach for enhancing all 00OS processes to properly implement dynamic tool call execution. Per REQ-003, we need to ensure that each process file triggers a strict set of tool calls when executed, focusing on the fact that 00OS is designed as a system to manipulate Cursor Rules for faster development rather than a real operating system.

### Current State Assessment

Based on our analysis, there are currently:
- 8 00reaper processes in `/00os/processes/00reaper/`
- 2 system processes in `/00os/processes/system/`
- 0 1000xdev processes (future implementation)

We've identified several issues that need to be addressed:

1. **Inconsistent Tool Call Implementation**: Some processes use direct terminal commands rather than proper tool call sequences
2. **Self-Execution Risks**: Some processes attempt to execute 00OS commands through terminal commands
3. **Insufficient Error Handling**: Error handling for tool call failures is often minimal or inconsistent
4. **Inconsistent Response Formatting**: Output formatting varies across processes

### Implementation Phases

#### Phase 1: Research and Context Analysis (COMPLETED)
1. ✅ Conducted research on Cursor Tool Calls using web search
2. ✅ Documented findings in `00reaper/00OS-commands/research-cursor/research-cursor-tool-call.md`
3. ✅ Read all existing research to understand 00OS goals and cursor rule manipulation
4. ✅ Analyzed current state of all 00OS processes to understand current implementation

#### Phase 2: Process Design Standardization
1. Establish standard templates for different types of processes:
   - **Information Retrieval Processes**: Processes that primarily read and display information
   - **File Modification Processes**: Processes that modify file content
   - **Command Execution Processes**: Processes that execute external commands
   - **Compound Processes**: Processes that combine multiple operation types
   
2. Define mandatory components for each process file:
   - **Input Validation**: Clear validation of all input parameters
   - **Tool Call Sequences**: Explicit definition of tool call sequences for each operation path
   - **Error Handling**: Comprehensive error handling for each tool call
   - **Response Formatting**: Consistent formatting using status indicators (✅, ❌, ⚠️)

3. Establish standard patterns for common tool call sequences:
   - **Information Gathering Pattern**: 
     ```
     list_dir -> codebase_search -> read_file
     ```
   - **File Modification Pattern**: 
     ```
     read_file -> edit_file -> [optional: reapply]
     ```
   - **Command Execution Pattern**: 
     ```
     run_terminal_cmd -> [verification steps]
     ```

#### Phase 3: Process Implementation Updates

1. Update System Processes:
   - **help.md**: Enhance with proper tool call sequencing, focusing on list_dir and read_file usage
   - **version.md**: Implement standardized response formatting

2. Update 00reaper Processes (Priority Order):
   - **reaper-sync.md**: Replace direct terminal command execution with proper tool calls
   - **reaper-read-files.md**: Enhance error handling and response formatting
   - **reaper-init.md**: Ensure proper tool call sequence with no self-execution
   - **reaper-implement.md**: Standardize tool call execution pattern
   - **reaper-overwrite.md**: Ensure consistency with recent changes
   - **reaper-analyze-tasks.md**: Update to follow standardized patterns
   - **reaper-update.md**: Enhance with proper tool call sequencing
   - **reaper-os-commands-workflow.md**: Verify and update tool call execution

3. Address specific issues by process type:
   - **Terminal Command Processes**: Replace direct terminal execution with structured tool call patterns
   - **File Modification Processes**: Enhance error handling and validation
   - **Information Gathering Processes**: Standardize response formatting

#### Phase 4: Testing and Verification

1. Create test cases for each process type:
   - Valid input scenarios
   - Invalid input handling
   - Error condition responses
   - Edge cases

2. Execute test cases against each updated process:
   - Verify proper tool call execution
   - Validate error handling
   - Confirm response formatting

3. Verify global requirements across all processes:
   - All processes use fetch_rules
   - No self-execution through terminal commands
   - Consistent response formatting
   - Clear error handling

#### Phase 5: Documentation and Context Updates

1. Update context files to reflect enhanced processes:
   - Update `00reaper/00OS-commands/context-00OS-current-state/00reaper-processes.md`
   - Update `00reaper/00OS-commands/context-00OS-current-state/system-processes.md`

2. Document standardized tool call patterns:
   - Create `00reaper/00OS-commands/documentation/tool-call-patterns.md`
   - Update `00reaper/00OS-commands/documentation/command-standards.md`

3. Update the research documentation with implementation findings.

### Implementation Details

#### Process Template: Information Retrieval

```markdown
# Process Name

## Metadata
[Standard metadata section]

## Input
[Input parameters definition]

## Output
[Output format definition]

## Execution

```javascript
// Main execution function
async function execute() {
  try {
    // 1. Input validation
    if (!validateInputs()) {
      return formatError("Invalid input parameters", "VALIDATION_ERROR");
    }
    
    // 2. Information gathering
    const dirContents = await tools.call('list_dir', {
      relative_workspace_path: targetPath,
      explanation: "Listing directory contents for information retrieval"
    });
    
    // 3. Process information
    const results = await processDirectoryContents(dirContents);
    
    // 4. Format and return results
    return formatSuccess(results);
  } catch (error) {
    // Error handling
    return formatError(`Error in process execution: ${error.message}`, "EXECUTION_ERROR");
  }
}
```

#### Process Template: File Modification

```markdown
# Process Name

## Metadata
[Standard metadata section]

## Input
[Input parameters definition]

## Output
[Output format definition]

## Execution

```javascript
// Main execution function
async function execute() {
  try {
    // 1. Input validation
    if (!validateInputs()) {
      return formatError("Invalid input parameters", "VALIDATION_ERROR");
    }
    
    // 2. Read existing file
    const fileContent = await tools.call('read_file', {
      target_file: targetFile,
      should_read_entire_file: true,
      explanation: "Reading file before modification"
    });
    
    // 3. Generate modifications
    const modification = generateModification(fileContent.content);
    
    // 4. Apply changes
    await tools.call('edit_file', {
      target_file: targetFile,
      instructions: "Updating file content",
      code_edit: modification
    });
    
    // 5. Format and return success
    return formatSuccess(`File ${targetFile} updated successfully`);
  } catch (error) {
    // Error handling
    return formatError(`Error modifying file: ${error.message}`, "EXECUTION_ERROR");
  }
}
```

#### Process Template: Command Execution

```markdown
# Process Name

## Metadata
[Standard metadata section]

## Input
[Input parameters definition]

## Output
[Output format definition]

## Execution

```javascript
// Main execution function
async function execute() {
  try {
    // 1. Input validation
    if (!validateInputs()) {
      return formatError("Invalid input parameters", "VALIDATION_ERROR");
    }
    
    // 2. Prepare command
    const command = buildCommand(inputs);
    
    // 3. Execute command
    const result = await tools.call('run_terminal_cmd', {
      command: command,
      explanation: "Executing command for process",
      is_background: false
    });
    
    // 4. Verify execution
    if (result.exitCode !== 0) {
      return formatError(`Command execution failed: ${result.error}`, "COMMAND_ERROR");
    }
    
    // 5. Format and return success
    return formatSuccess(`Command executed successfully: ${result.output}`);
  } catch (error) {
    // Error handling
    return formatError(`Error executing command: ${error.message}`, "EXECUTION_ERROR");
  }
}
```

### Standard Error Handling Pattern

Each tool call should follow this pattern for error handling:

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
  // Handle error
  return formatError(`Error during operation: ${error.message}`, "TOOL_ERROR");
}
```

### Standard Response Formatting

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

### Timeline and Milestones

1. Phase 2 (Design Standardization): Complete by day 1-2
2. Phase 3 (Implementation Updates):
   - System Processes: Complete by day 3
   - 00reaper Processes (4 highest priority): Complete by day 4-5
   - 00reaper Processes (remaining 4): Complete by day 6-7
3. Phase 4 (Testing): Complete by day 8-9
4. Phase 5 (Documentation): Complete by day 10

### Technical Decisions

1. **Explicit Tool Call Declaration**: Each process must explicitly define the exact tool calls it will execute
2. **No Self-Execution**: Processes must never attempt to execute 00OS commands through terminal commands
3. **Mandatory fetch_rules**: Every command execution must retrieve its process definition via fetch_rules
4. **Consistent Response Formatting**: All processes will use the standard indicators (✅, ❌, ⚠️)
5. **Clear Tool Call Separation**: Multi-step processes will separate tool calls into distinct, sequential operations

### Success Criteria

1. All 10 processes properly implement dynamic tool call sequences
2. No processes attempt self-execution through terminal commands
3. All processes return properly formatted responses
4. All processes follow the standardized process structure and error handling
5. All processes are properly documented in context files

### Next Steps

1. Finalize the process templates for each type
2. Begin implementation updates following the priority order
3. Update cycle-status.md as progress is made 