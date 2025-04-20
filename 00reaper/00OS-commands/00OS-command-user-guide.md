# 00OS Command User Guide

## Introduction

Welcome to 00OS, a terminal-like interface integrated within your AI assistant. This guide explains how to use the available commands to interact with the system, manage files, and automate tasks.

## Getting Started

### Command Syntax

All 00OS commands start with the `>` prefix followed by the command name, optional subcommands, arguments, and flags:

```
> [command] [subcommand] [arguments] [--flags]
```

*   **command**: The primary action (e.g., `file`, `system`).
*   **subcommand**: A specific action within the command (e.g., `list` for `file`).
*   **arguments**: Required or optional values the command needs (e.g., file paths, search terms).
*   **flags**: Modifiers that change command behavior (e.g., `--verbose`, `--recursive`). Boolean flags don't need a value; others use `--flag=value`.

### Getting Help

The primary command for assistance is `help`:

*   `> help`: Lists all available commands.
*   `> help [command-name]`: Shows detailed usage, arguments, and flags for a specific command.

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