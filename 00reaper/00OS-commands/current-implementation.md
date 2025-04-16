# 00OS System Architecture

## Command Processing Pipeline

```
User Input → Command Detection → Parsing → Process Selection → Execution → Response
```

## Core Components

1. **Command Handler** (`00OS/core/command-handler.md`)
   - Detects input with `>` prefix
   - Delegates command execution to appropriate process
   - Manages return formatting

2. **Parser** (`00OS/core/parser.md`)
   - Tokenizes input into command parts
   - Handles arguments, flags, and quotes
   - Validates command syntax

3. **Registry** (`00OS/core/registry.md`)
   - Maps commands to process files
   - Provides command discovery
   - Tracks command metadata

4. **Executor** (`00OS/core/executor.md`)
   - Loads process files
   - Creates execution environment
   - Manages process lifecycle

5. **Permissions** (`00OS/core/permissions.md`)
   - Controls access to system resources
   - Manages identity-based permissions
   - Validates process access rights

6. **State Manager** (`00OS/core/state-manager.md`)
   - Maintains persistent state
   - Provides process isolation
   - Enables stateful commands

## Process File Structure

Process files are organized by category:
- `/00OS/processes/system/` - Core system commands
- `/00OS/processes/tools/` - Utility commands
- `/00OS/processes/examples/` - Example templates

Each process file follows a standard structure:
```markdown
---
name: command-name
description: Command description
version: 1.0
author: 00reaper
permissions: [permission-list]
inputs: [input-parameters]
outputs: [output-parameters]
---

# Process: command-name

## Description
Detailed description...

## Execution
```javascript
// Implementation code
```
```

## Identity Framework

The system operates with two distinct identities:

1. **00reaper**: System administrator and architect
   - Maintains natural language conversation
   - Oversees system architecture
   - Delegates command execution

2. **1000xdev**: Process executor
   - Executes tool calls
   - Performs command operations
   - Operates in background

## Standard Response Format

Responses follow consistent patterns:
- `✅ Success: [Result]` - Successful operations
- `❌ Error [CODE]: [Message]` - Error conditions
- `⚠️ Warning: [Message]` - Warning notifications

## Current Enhancement Focus

1. **Dynamic Command Discovery**
   - Commands are discovered at runtime by scanning process directories
   - Help system builds command list dynamically

2. **Real-Time System Status**
   - Component statuses are checked by verifying file existence
   - System metrics are gathered at execution time

3. **Optimized Context Loading**
   - Targeted file reading for essential context
   - Prioritization of critical architecture files

4. **Permission Management**
   - Access control for system resources
   - Identity-based permission system

## Development and Deployment

### Synchronization Process
00OS development occurs in the `/00OS/` directory and is synchronized to the `.cursor/rules/` directory using the PowerShell script:

```
.\Sync-00OS-Complete.ps1
```

This synchronization process:
1. Copies markdown files from `/00OS/` to `.cursor/rules/`
2. Transforms `.md` files to `.mdc` format with proper frontmatter
3. Sets appropriate rule types based on file location:
   - Core components: `alwaysApply: true`
   - Process files: `alwaysApply: false` with descriptive triggers
4. Generates a sync report for verification

Always run this script after making changes to process files to ensure they're properly deployed to the rules system.
