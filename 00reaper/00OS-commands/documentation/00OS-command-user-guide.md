# 00OS Command User Guide

## Introduction

Welcome to 00OS, a terminal-like interface for AI-powered command execution. This guide explains how to use the available commands, understand the workflow, and get help.

## The 3-Step Pattern (How 00OS Commands Work)

Every 00OS command follows this simple pattern:

1. **User sends a command**: `> command-name [arguments] [--flags]`
2. **AI fetches the process rule**: The system loads the command definition
3. **AI executes the defined tool calls**: The command runs exactly as defined, with no extra steps

> **Tip:** All commands are designed to be simple, direct, and predictable. If you know the command name, you can use it immediately.

## Command Syntax

```
> [command] [subcommand] [arguments] [--flags]
```

- **command**: The main action (e.g., `file`, `system`, `reaper-sync`)
- **subcommand**: (Optional) A specific action (e.g., `list` for `file`)
- **arguments**: Required or optional values (e.g., file paths)
- **flags**: Modifiers (e.g., `--verbose`). Boolean flags need no value; others use `--flag=value`.

## Getting Help

- `> help`: Lists all available commands
- `> help [command-name]`: Shows usage and details for a specific command

## Practical Examples

- List files in a directory:
  - `> file list /00os/processes`
- Read a file:
  - `> file read 00os/processes/system/help.md`
- Show the current 00OS version:
  - `> version`
- Synchronize 00OS rules:
  - `> reaper-sync`
- Get help for a command:
  - `> help reaper-sync`

## Available Commands (Common)

- **`> help`**: Show help for commands
- **`> version`**: Show the current 00OS version
- **`> file list [path]`**: List files in a directory
- **`> file read [file-path]`**: Read a file's content
- **`> reaper-sync`**: Synchronize 00OS rules
- **`> reaper-init`**: Load all core context for 00OS

> Use `> help [command]` for details and more examples for each command.

## Troubleshooting

- **Command Not Found**: Check the command name. Use `> help` to see available commands.
- **Missing Argument**: Use `> help [command]` to see required arguments.
- **Permission Error**: Some commands require special permissions.
- **Tool Call Error**: If you see an internal error, try again or contact support.

## Best Practices
- Use the simplest command for your task
- Use flags only when needed (e.g., `--verbose`)
- If unsure, start with `> help`

---

**00OS is designed for clarity and ease of use. All commands follow the same 3-step pattern, so once you learn one, you can use them all!**

## Available Commands

*(This section will be populated with details for each available command)*

### System Commands

*   **`> help`**: Displays help information.
    *   Usage: `> help [command-name]`
*   **`> system status`**: Shows the current status and health of the 00OS system.
    *   Usage: `> system status [--detailed]`
*   **`> echo`**: Prints a message back to the console.
    *   Usage: `> echo [message]`
*   **`> version`**: Displays the current 00OS version.
    *   Usage: `> version`

### File Operations

*   **`> file list`**: Lists files and directories at a specified path.
    *   Usage: `> file list [path]`
*   **`> file read`**: Displays the content of a specified file.
    *   Usage: `> file read <file-path>`
*   **`> file search`**: (Planned) Searches for files based on a pattern.
    *   Usage: `> file search <pattern> [search-path]`

### Context Management Commands (for 00reaper)

*   **`> reaper-read-files`**: Reads all files within a specified directory.
    *   Usage: `> reaper-read-files <path> [--recursive] [--max-depth=N] [--file-pattern=PATTERN]`

*(Add other command categories and commands as they become available and tested)*

## Examples

*(Provide practical examples of common workflows)*

*   Listing files in the current directory: `> file list .`
*   Reading the first 10 lines of a file: *(Requires line limit feature)* `> file read my_document.md --lines=10`
*   Getting help for the file list command: `> help file list`

## Troubleshooting

*   **Command Not Found**: Ensure the command name is spelled correctly. Use `> help` to see available commands.
*   **Missing Argument**: Check the command's help (`> help [command-name]`) to see required arguments.
*   **Permission Error**: Some commands require specific permissions. Contact the system administrator if you believe you need access.
*   **Tool Call Error**: This indicates an internal issue. Please report the command and any error messages. 