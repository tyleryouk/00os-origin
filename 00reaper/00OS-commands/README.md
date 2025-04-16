# 00OS Command Development

This directory serves as the central hub for creating, managing, and optimizing 00OS commands. Read this file first at the beginning of each development session.

## Quick Start Guide

1. **Start with reading all base folder files:**
   - Read all files in the 00reaper/00OS-commands directory:
     ```
     > reaper-read-files 00reaper/00OS-commands
     ```
   - This loads the complete context including:
     - `user_requests.md` - Active work items and tracking
     - `command-registry.md` - Command status
     - `operational-feedback.md` - Recent feedback
     - `enhancement-roadmap.md` - Prioritized work

2. **Development Workflow:**
   ```
   Read All Files → Plan Changes → Implement Changes → Sync → Test → Update Progress → Iterate
   ```

3. **File Structure:**
   - `README.md` - This starting guide
   - `user_requests.md` - Active work items and implementation tracking
   - `command-registry.md` - Current command implementation status
   - `common-patterns.md` - Reusable implementation patterns
   - `operational-feedback.md` - Command execution feedback
   - `enhancement-roadmap.md` - Prioritized enhancement queue

## Command Implementation Standards

### Command Structure
```
> [command] [subcommand] [arguments] [--flags]
```

### Process File Template
```markdown
---
name: command-name
description: Brief description of command
version: 1.0
author: 00reaper
permissions: [basic]
inputs:
  - name: arg1
    type: string
    required: true
    description: Description of first argument
  - name: verbose
    type: boolean
    required: false
    default: false
    description: Show detailed output
outputs:
  - name: result
    type: string
    description: Command output
---

# Process: command-name

## Description
Detailed description of what the command does.

## Execution

```javascript
function execute() {
  // Validate inputs
  // Process logic
  // Return formatted result
}
```

### Response Format Standards
```
✅ Success: [Command output]
❌ Error [CODE]: [Error message]
⚠️ Warning: [Warning message]
```

## Current Focus Areas

1. **Command Execution Reliability:**
   - Fixing inconsistent behavior in command execution
   - Implementing robust error handling
   - Ensuring consistent operation of all commands

2. **File Operations:**
   - Directory listing and file reading
   - Implementing file search functionality
   - Adding recursive operations support

3. **Response Standardization:**
   - Consistent formatting across all commands
   - Improved visual structure for outputs
   - Standard error handling patterns

4. **Command Handler Enhancements:**
   - Better argument parsing
   - Support for complex command syntax
   - Foundation for command piping

## Structured Session Workflow

To maintain continuity between development sessions:

1. **Begin each session** by reading all files in the base folder:
   ```
   > reaper-read-files 00reaper/00OS-commands
   ```

2. **During the session:**
   - Focus on specific requests based on priority
   - Document progress directly in user_requests.md
   - Use patterns from common-patterns.md for implementation

3. **End each session** by updating progress in user_requests.md

This structured approach ensures context preservation between sessions and clear tracking of implementation progress.

## Development Process

1. Update process implementations in `00OS/processes/`
2. **Sync changes to .cursor/rules/ using the synchronization script:**
   ```
   .\Sync-00OS-Complete.ps1
   ```
   This script will:
   - Copy all 00OS files to the .cursor/rules/ directory
   - Update frontmatter for proper rule types
   - Generate a sync report

3. Test command execution using the command prefix:
   ```
   > [command] [arguments]
   ```

4. Document feedback in `operational-feedback.md`
5. Update progress in `user_requests.md`
6. Implement improvements based on feedback

## Command Pipeline Architecture

```
Input → Command Handler → Parser → Registry → Executor → Process → Response
```

Always ensure changes maintain compatibility with this processing pipeline.

## Note by Tyler [TYLER]
You are allowed to make changes to any files in 00reaper/00OS-commands/. If you want to change the workflow, solution, or guidelines for 00OS commands you are allowed to do so.