# 00OS Terminal Interface Design

## Overview

This document outlines the design for the 00OS terminal interface, which transforms the Cursor prompt box into a command-line terminal that processes commands through a structured operating system approach.

## Core Interface Principles

The 00OS terminal interface is designed with the following principles:

1. **Intuitive Command Structure**: Commands follow a consistent, easy-to-learn structure
2. **Clear Mode Identification**: Users can easily identify when they're in command mode
3. **Discoverability**: Available commands are easy to discover and explore
4. **Consistency**: Similar operations have similar command patterns
5. **Feedback**: Clear feedback on command execution and errors
6. **Context Awareness**: Commands understand the current system context
7. **Progressive Disclosure**: Simple commands are easy, advanced features are available when needed

## Command Syntax

### Primary Command Format

```
> [command] [subcommand] [arguments] [--flags]
```

Example:
```
> file list /00os/processes --detailed
```

Components:
- **Prefix**: `>` indicates command mode (similar to how "chat" indicates chat mode)
- **Command**: Primary operation category (e.g., `file`, `process`, `system`)
- **Subcommand**: Specific operation within category (e.g., `list`, `create`, `delete`)
- **Arguments**: Required inputs for the operation
- **Flags**: Optional modifiers prefixed with `--` (e.g., `--detailed`, `--recursive`)

### Command Variations

#### Basic Commands
```
> help
> version
> list commands
```

#### Compound Commands
```
> system update && system restart
```

#### Piped Commands
```
> file list /00os | grep parser
```

#### Context Operations
```
> cd /00os/processes
> pwd
```

## Mode Identification

The system provides clear indicators to distinguish command mode from chat mode:

1. **Command Prefix**: All commands start with `>` 
2. **Visual Formatting**: Command responses have distinct formatting
3. **Context Indicator**: System shows current mode and working directory

## Command Categories

### System Commands
- `> system [status|update|restart]`: System management operations
- `> config [get|set|list]`: Configuration management
- `> help [command]`: Get help on commands

### File Operations
- `> file [list|read|edit|create|delete]`: File operations
- `> cd [directory]`: Change working directory
- `> pwd`: Print working directory

### Process Management
- `> process [list|run|stop|create]`: Process management
- `> service [start|stop|status]`: Service operations

### Identity Commands
- `> identity [switch|status]`: Manage identity (00reaper vs 1000xdev)
- `> permissions [list|check|grant]`: Manage permissions

### Tool Commands
- `> tools [list|run]`: Access and execute tools
- `> shell [command]`: Execute shell commands

## Command Response Format

Command responses follow a consistent format:

```
[Status Indicator] Command Result
[Details if needed]
```

Example:
```
✅ File list for /00os/processes:
- parser.md (265 lines)
- executor.md (481 lines)
- registry.md (400 lines)
```

Status indicators:
- ✅ Success
- ❌ Error
- ⚠️ Warning
- 🔄 Processing

## Help System

The help system provides contextual assistance:

1. **General Help**: `> help` shows overall command categories
2. **Command Help**: `> help [command]` shows details for specific command
3. **Interactive Help**: `> help interactive` provides a guided tour
4. **Examples**: `> help examples` shows common usage examples

Example help output:
```
== 00OS HELP: FILE COMMAND ==

USAGE:
  > file [subcommand] [arguments] [--flags]

SUBCOMMANDS:
  list     - List files in directory
  read     - View file contents
  edit     - Modify file contents
  create   - Create new file
  delete   - Remove file

EXAMPLES:
  > file list /00os/core
  > file read /00os/core/parser.md
  > file edit /00os/processes/system/help.md

FLAGS:
  --detailed    - Show additional file details
  --recursive   - Include subdirectories
```

## Command Discovery

Users can discover available commands through:

1. **List Commands**: `> list commands` shows all available commands
2. **Tab Completion**: The system offers tab completion for commands
3. **Command Explorer**: `> explore` provides an interactive command browser
4. **Suggestions**: The system suggests related commands after execution

## Terminal State Management

The terminal maintains state information:

1. **Working Directory**: Current location in the file system
2. **Environment Variables**: System-specific variables
3. **Command History**: Recently executed commands
4. **Active Identity**: Current operating identity (00reaper or 1000xdev)
5. **Permission Context**: Current permission level for operations

## Compatibility Layer

During transition, the system supports backward compatibility:

1. **Legacy Command Support**: `run command:domain/name` format still works
2. **Command Mapping**: Legacy commands map to new process equivalents
3. **Automatic Conversion**: System can suggest new command format for legacy inputs
4. **Hybrid Mode**: System can operate in both legacy and new command modes

## Error Handling

The terminal provides helpful error messages:

```
❌ Error: File '/00os/nonexistent.md' not found
Suggestions:
- Check file path spelling
- Use '> file list /00os' to see available files
- Use '> help file' for more information on file commands
```

## Implementation Components

The terminal interface is implemented through these components:

1. **00os/core/parser.md**: Command input parsing
2. **00os/core/registry.md**: Command-to-process mapping
3. **00os/core/executor.md**: Command execution 
4. **00os/core/permissions.md**: Access control for commands
5. **00os/processes/system/help.md**: Help system implementation

## User Experience Flow

1. **Command Input**: User enters command with `>` prefix
2. **Command Parsing**: System parses and validates input
3. **Process Selection**: System identifies appropriate process
4. **Permission Check**: System verifies user has permission
5. **Execution**: System runs the process with provided arguments
6. **Response Formatting**: Result is formatted according to standards
7. **Response Display**: Formatted result is shown to user

## Visual Design Elements

To enhance the terminal experience:

1. **Color Coding**: Different elements use distinct colors
   - Commands in blue
   - Arguments in white
   - Flags in yellow
   - Errors in red
   - Success in green

2. **Formatting**:
   - Monospace font for command output
   - Bold for important elements
   - Structured tables for data display

3. **Icons**:
   - Status indicators (✅, ❌, ⚠️, 🔄)
   - File type indicators (📁, 📄, 🔧, etc.)

## User Onboarding

To help users transition to the terminal interface:

1. **Welcome Message**: Introduction to terminal interface on first use
2. **Quick Start Guide**: `> quickstart` command for basic tutorial
3. **Guided Examples**: `> tutorial` command for interactive learning
4. **Cheat Sheet**: `> cheatsheet` command for quick reference

## Conclusion

The 00OS terminal interface transforms the Cursor prompt box into a powerful command-line environment, offering structured command processing, consistent feedback, and a discoverable command set. This design balances simplicity for new users with power for advanced operations, creating an intuitive and effective interaction model for the 00OS system. 