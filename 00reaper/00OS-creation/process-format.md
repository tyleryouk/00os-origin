# 00OS Process File Format

## Overview
Process files are executable units within 00OS that perform specific functions when triggered by commands. They replace the previous 1000xcommands system with a more structured, modular approach that aligns with operating system principles.

## File Structure

Process files use a standardized format with metadata and execution blocks:

```markdown
---
name: process-name
description: Process description
version: 1.0.0
author: 00reaper
permissions: [basic, file-read, file-write]
inputs:
  - name: input1
    type: string
    required: true
    description: Description of input1
  - name: input2
    type: number
    required: false
    default: 10
    description: Description of input2
outputs:
  - name: result
    type: object
    description: Process result
---

# Process: process-name

## Initialization
```javascript
// Any initialization code or variable setup
const inputValue = inputs.input1;
const options = {
  parameter: inputs.input2
};
```

## Execution
```javascript
// Main execution logic
// This section contains tool calls and processing
read_file(targetFile);
edit_file(targetFile, "Instructions", "New content");
```

## Output
```javascript
// Define the output to return
return {
  result: "Operation completed",
  status: "success"
};
```
```

## Process Lifecycle

### 1. Registration
- Process is registered in the system registry
- Metadata is extracted and indexed
- Process is made available to the command parser

### 2. Triggering
- Command parser identifies matching process
- Validates input parameters against requirements
- Checks permissions for execution

### 3. Initialization
- Process context is created
- Input parameters are validated and normalized
- Initial state is established

### 4. Execution
- Main process logic is executed
- Tool calls are performed
- Progress is tracked

### 5. Output Generation
- Output is formatted according to process specifications
- Results are validated
- Return object is created

### 6. Completion
- Resources are cleaned up
- Logs are generated
- Command parser receives output

## Process Categories

Processes are organized into categories based on function:

### System Processes
Located in `/00os/processes/system/`
- System management
- Configuration
- Maintenance

### Tool Processes
Located in `/00os/processes/tools/`
- File operations
- Search functions
- Utility functions

### Application Processes
Located in `/00os/processes/apps/`
- Development tasks (previously 1000xdev tasks)
- Project-specific operations
- User-defined applications

### Service Processes
Located in `/00os/processes/services/`
- Long-running operations
- Monitoring functions
- Scheduled tasks

## Process Permissions

Processes must declare required permissions:

- `basic` - Basic operations, no file or system access
- `file-read` - Read access to files
- `file-write` - Write access to files
- `system-read` - Read system configuration
- `system-write` - Modify system configuration
- `network` - Network access
- `execution` - Execute other processes
- `admin` - Administrative privileges (00reaper only)

## Process Communication

Processes can communicate with each other through:

1. **Direct Calls**
   ```javascript
   const result = execute_process("other-process", { param: value });
   ```

2. **Event System**
   ```javascript
   emit_event("process.completed", { data: result });
   ```

3. **Shared State**
   ```javascript
   set_state("key", value);
   const value = get_state("key");
   ```

## Migration from 1000xcommands

To convert existing 1000xcommands to process files:

1. Extract command metadata (name, description, parameters)
2. Identify tool calls and execution logic
3. Structure into process file format with proper sections
4. Add appropriate permissions and input/output definitions
5. Register in the process registry

## Best Practices

1. **Single Responsibility**
   Each process should perform a single, well-defined function

2. **Clear Documentation**
   Include detailed descriptions of inputs, outputs, and behavior

3. **Error Handling**
   Implement robust error handling with meaningful messages

4. **Idempotency**
   When possible, design processes to be safely repeatable

5. **Modularity**
   Break complex operations into smaller, reusable processes

6. **Permission Minimization**
   Request only the minimum permissions required 