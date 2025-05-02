# 00OS Commands - Simplified Vision

## Core Philosophy: The 3-Step Pattern

Every 00OS command should follow this simple pattern:

1. **User sends a command**: `> command-name [arguments] [--flags]`
2. **AI fetches the process rule**: Makes a single `fetch_rules` call to get the process definition
3. **AI executes the defined tool calls**: Follows exactly what's in the process rule, no more, no less

## Current Issues

1. **Excessive complexity**: Commands have become overly complex with unnecessary steps
2. **Inconsistent implementation**: Different approaches to similar commands
3. **Documentation overload**: Too many files that are rarely or never read
4. **Workflow burden**: The cyclical workflow adds overhead to simple tasks
5. **Self-execution risk**: Some processes attempt to execute commands through terminal calls (creating infinite loops)
6. **Inefficient rule management**: Lack of clear system for rules deployment and synchronization

## Cursor Rules Integration Model

The 00OS system leverages Cursor's rules infrastructure in specific ways:

1. **Rule Hierarchy**:
   - Core system components (command handler, parser, etc.) use `alwaysApply: true`
   - Individual process files use descriptions starting with "USE WHEN..." for on-demand loading
   - File-specific behaviors use `globs` patterns for context-sensitive activation

2. **Development vs. Deployment**:
   - Development happens in `/00OS/` directory using standard markdown (`.md`)
   - Deployment targets `.cursor/rules/` with MDC (`.mdc`) files
   - Synchronization happens through `reaper-sync` command

3. **Tool Call Execution**:
   - Process files define explicit tool call sequences rather than complex logic
   - Error handling is standardized across all processes
   - Response formatting follows consistent patterns

## Simplified Command Process File Template

```markdown
---
name: command-name
description: Simple description of what the command does
category: [system|00reaper|1000xdev]
author: 00reaper
version: 1.0
---

# Process: command-name

USE WHEN you want to execute command-name

## Execution

This process executes the following tool calls:

1. FIRST TOOL CALL (e.g., read_file, list_dir, etc.)
2. SECOND TOOL CALL (if needed)
3. TERMINAL COMMAND (if appropriate)

## Examples

> command-name arg1 --flag1
> command-name arg2 --flag2
```

## Files That Need Modification

### Core System Files

1. **00OS/core/command-handler**
   - Simplify to focus on the 3-step pattern
   - Remove extraneous logic that complicates command processing
   - Ensure clear intercept of `>` prefixed commands
   - Reinforce mandatory `fetch_rules` usage

2. **00OS/core/executor**
   - Streamline to support simpler command execution
   - Maintain backward compatibility with existing processes
   - Optimize for direct tool call execution

3. **00OS/processes/system/** and **00OS/processes/00reaper/**
   - Update all process files to follow the simplified template
   - Start with most commonly used commands (help, version, reaper-sync, etc.)
   - Ensure clear separation between system, 00reaper, and 1000xdev processes

### Workflow Files

1. **00reaper/00OS-commands/README.md**
   - Update to emphasize the 3-step pattern
   - Simplify the cyclical workflow description
   - Place the command processing model at the top for immediate visibility

2. **00reaper/00OS-commands/documentation/command-template-core.md**
   - Replace with simplified template that focuses on the 3-step pattern
   - Remove unnecessary sections and complexity
   - Add examples of ideal tool call sequences for common operations

3. **00reaper/00OS-commands/documentation/command-standards-core.md**
   - Update to reflect the simplified approach
   - Remove standards that encourage unnecessary complexity
   - Add explicit guidance on tool call implementation

### Synchronization System

1. **00reaper/00scripts/Sync-00OS-Complete.ps1**
   - Ensure it properly converts MD to MDC with correct frontmatter
   - Verify it maintains the structure required by Cursor's rule system
   - Simplify the synchronization process while maintaining reliability

## Example: Ideal Process File

### Current reaper-sync (complex)

```markdown
---
name: reaper-sync
description: Synchronize 00OS contents to .cursor/rules
category: 00reaper
permissions: system.write
author: 00reaper
version: 1.4
---

# Process: reaper-sync

USE WHEN you want to execute reaper-sync

## Metadata
- Name: reaper-sync
- Description: Synchronize 00OS contents to .cursor/rules  
- Category: 00reaper
- Permissions: system.write
- Author: 00reaper
- Version: 1.4

## Input
- subcommand: Optional subcommand
- detect-orphans: Flag to detect orphaned files
- remove-orphans: Flag to remove orphaned files
- verbose: Flag to show detailed sync information  
- dry-run: Flag to simulate synchronization
...

[many more sections with validation, error handling, etc.]
```

### Simplified reaper-sync (ideal)

```markdown
---
name: reaper-sync
description: Synchronize 00OS contents to .cursor/rules
category: 00reaper
author: 00reaper
version: 2.0
---

# Process: reaper-sync

USE WHEN you want to execute reaper-sync

## Execution

This process executes the following tool calls:

1. run_terminal_cmd: .\00reaper\00scripts\Sync-00OS-Complete.ps1

## Examples

> reaper-sync
> reaper-sync --verbose
```

## Tool Call Implementation Patterns

Based on the research in the Cursor tool call documentation, these patterns should be followed:

### Information Gathering Pattern
```
1. list_dir to identify relevant files
2. codebase_search to find specific code elements
3. read_file to examine specific implementations
```

### File Modification Pattern
```
1. read_file to understand current state
2. edit_file to make changes
3. reapply if needed to correct the application
```

### Command Execution Pattern
```
1. run_terminal_cmd with explanation
2. read_file or list_dir to verify results
```

### Rule-Based Execution Pattern
```
1. fetch_rules to get specific process definition
2. Execute necessary tool calls as defined in the process
3. Format response according to process standards
```

## Implementation Priority

1. **Command Handler Updates**
   - Start with updating core/command-handler to ensure proper command interception
   - Reinforce the 3-step pattern at the system level

2. **Template Standardization**
   - Update command templates to reflect the simplified approach
   - Ensure all new processes follow the standard pattern

3. **Core Command Updates**
   - Begin with high-usage commands (reaper-sync, help, version)
   - Create clear examples of the simplified pattern

4. **Documentation Alignment**
   - Update all documentation to reflect the new approach
   - Remove contradictory guidance

5. **Gradual Process Conversion**
   - Convert remaining processes incrementally
   - Prioritize by usage frequency

## Cursor Rules Deployment Strategy

Understanding Cursor's rule architecture helps us implement the following approach:

1. **Core Components** (`alwaysApply: true`)
   - Command handler, parser, registry, executor
   - Critical framework components
   - Kept minimal to reduce token usage

2. **Process Rules** (description-based activation)
   - Individual command implementations
   - Loaded only when needed via "USE WHEN..." descriptions
   - Self-contained tool call sequences

3. **Context Rules** (glob-based activation)
   - File-specific behaviors
   - Development environment enhancements
   - Special handling for particular file types

This approach ensures efficient rule loading while maintaining the flexibility needed for a comprehensive command system. 