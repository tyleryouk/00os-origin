# 00OS: Terminal Command System for Cursor AI

## Overview

00OS is a terminal-like operating system built on top of Cursor's AI knowledge base (`.cursor/rules`). It transforms the standard Cursor prompt box into a command-line terminal interface, allowing users to execute structured commands with the prefix `>`.

## Core Objective

Create a comprehensive terminal command system that:

1. Recognizes commands with the `>` prefix (e.g., `> help`, `> system status`)
2. Routes commands to appropriate "process" handlers
3. Executes structured workflows based on command input
4. Returns formatted responses with status indicators

## System Architecture

00OS consists of several key components:

- **Command Parser**: Detects and parses terminal commands starting with `>`
- **Process Registry**: Maintains a catalog of available commands and processes
- **Executor**: Loads and runs processes based on parsed commands
- **Permission System**: Controls access to system resources
- **Response Formatter**: Standardizes command output with status indicators

## Implementation Strategy

1. Leverage `.cursor/rules` as the foundation for the operating system
2. Define "processes" as markdown files with structured metadata
3. Create a command handler that intercepts `>` prefixed messages
4. Implement system commands like `help`, `echo`, `system status`
5. Develop a process execution framework for custom commands

## Command Structure

Commands follow this syntax:
```
> [command] [subcommand] [arguments] [--flags]
```

Examples:
- `> help` - Display help information
- `> system status` - Show system status
- `> file list /path` - List files in a directory
- `> echo Hello, world!` - Echo a message

## Response Format

Responses use standardized formats with status indicators:
```
✅ Success: [Command output]
❌ Error: [Error message]
⚠️ Warning: [Warning message]
```

## Future Development

00OS can be extended with additional features:
- Advanced command chaining and piping
- Custom user-defined processes
- Deep integration with filesystem operations
- Enhanced permission systems
- Command history and aliases

## Reference

When enhancing 00OS, follow these steps:
1. Read the existing rules in the 00os directory
2. Maintain consistent command syntax and response formatting
3. Use the 00OS core components for command parsing and execution
4. Follow the established process definition format for new commands 