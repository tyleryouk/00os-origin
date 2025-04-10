# Command Processing Optimization

## Overview

This document establishes mandatory requirements for optimizing the processing of 1000xcommands, with emphasis on immediate command file reading and minimal processing overhead. The guidelines in this document are critical for ensuring efficient, predictable command execution.

## ⚠️ CRITICAL: Immediate Command File Reading Requirement ⚠️

When receiving a command invocation (`run command:domain/name`), 1000xdev MUST:

1. **IMMEDIATELY read the command file** as the ABSOLUTE FIRST action.
2. **NO thinking, planning, or processing** should occur before the command file is read.
3. **ZERO preliminary analysis** before understanding the full content of the command file.

This is a non-negotiable, mandatory first step to ensure proper command execution.

### Incorrect (Prohibited) Workflow:
- Receive `run command:domain/name` 
- ❌ Think about what the command might do
- ❌ Plan execution steps before reading the command
- ❌ Execute what you think might be in the command
- ❌ Read only part of the command file
- ❌ Analyze based on memory of having created the command earlier

### Correct (Required) Workflow:
- Receive `run command:domain/name`
- ✅ IMMEDIATELY construct the target path: `1000xcommands/{domain}/{command-name}.md` (e.g., `1000xcommands/system/brain/analyze-structure.md`)
- ✅ IMMEDIATELY read the entire command file using `read_file`
- ✅ Only AFTER reading - parse and execute as specified

## Command Processing Efficiency

All "thinking" during command execution must be minimized:

1. **Mechanical Execution**: Command processing should be direct and mechanical.
2. **Abstracted Logic**: Complex logic MUST be abstracted to `1000xbrain` knowledge/process files (within the appropriate domain/subsystem path).
3. **Streamlined Workflow**: Command execution should follow a predictable, efficient sequence.
4. **Minimal Overhead**: No unnecessary analysis or processing during command execution.

The command file itself should only contain direct tool calls or reference process/knowledge files that contain the complex logic.

## Command Processing Sequence Timeline

```
Receive command invocation
|
IMMEDIATELY read command file <-- ZERO delay, NO thinking
|
Parse file for tool calls & dynamic execution markers
|
Execute explicit tool calls sequentially (if any)
|
(Optional) Begin dynamic execution if marker encountered
```

## Detailed Processing Steps

1. **Receive Command Invocation**:
   - User inputs: `run command:domain/command-name` (e.g., `run command:system/rules/update-rule`)
   - 1000xdev IMMEDIATELY initiates command file reading with NO preliminary thinking

2. **Command File Reading**:
   - Construct path: `1000xcommands/{domain}/{command-name}.md` (e.g., `1000xcommands/system/rules/update-rule.md`)
   - Use `read_file` with `should_read_entire_file=true`
   - Follow the mandatory file reading protocol in `1000xrules/core/tools/file-reading-enforcement.md`

3. **Command Parsing**:
   - Parse the file header, explicit tool calls, and dynamic execution section (if present).
   - Identify any dynamic execution marker and associated process/knowledge files within `1000xbrain`.

4. **Command Execution**:
   - Execute explicit tool calls in sequence as specified in the command file (if any).
   - If dynamic execution marker is present, read process/knowledge files from `1000xbrain` (e.g., `1000xbrain/system/rules/processes/update-logic.md`) and proceed with dynamic execution.
   - Maintain minimal processing overhead during execution.

## Examples of Proper Command Processing

### Example 1: Basic Command (Explicit Tools Only)
```
User: run command:system/brain/list-knowledge-files

1000xdev: [Immediately, with no preliminary thinking]
read_file("1000xcommands/system/brain/list-knowledge-files.md", should_read_entire_file=true)

[After reading the command file, executes the specified tool calls]
list_dir("1000xbrain/system/brain/knowledge/")
...
```

### Example 2: Command with Dynamic Execution
```
User: run command:system/brain/enhance-cognitive-architecture

1000xdev: [Immediately, with no preliminary thinking]
read_file("1000xcommands/system/brain/enhance-cognitive-architecture.md", should_read_entire_file=true)

[After reading the command file, parses dynamic execution block]
# Assuming command contains:
# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/system/brain/processes/enhance-architecture.md
# --- END DYNAMIC EXECUTION ---

[Reads the specified process file]
read_file("1000xbrain/system/brain/processes/enhance-architecture.md", should_read_entire_file=true)
...
[Begins dynamic execution based on the process file]
```

## Command Processing Verification

Command processing optimization can be verified by:

1. **Time Measurement**: Command processing should occur with minimal delay between invocation and file reading.
2. **Mechanical Execution**: Execution should proceed mechanically once the command is understood.
3. **Abstraction Checks**: Ensure all complex logic is abstracted to knowledge/process files within `1000xbrain`.

## Implementation Guidance

### For Command Creators:
- Keep command files simple and direct
- Abstract complex logic to knowledge/process files within `1000xbrain`
- Follow the best practices (refer to `1000xbrain/system/commands/knowledge/` guidelines)

### For Command Processors (1000xdev):
- ALWAYS read the command file IMMEDIATELY
- Process commands mechanically once read
- Minimize thinking during command execution
- Rely on knowledge/process files from `1000xbrain` for complex logic

## Relationship to Other Core Rules

This rule complements and reinforces:
- `1000xrules/core/communication/1000xcommands-guidelines.md`
- `1000xrules/core/tools/file-reading-enforcement.md`
- `1000xrules/core/identity/cognitive-principles.md`

## Core Precedence

This document is a CORE directive. The immediacy requirement for command file reading takes precedence over any conflicting guidance in knowledge modules or process files. 