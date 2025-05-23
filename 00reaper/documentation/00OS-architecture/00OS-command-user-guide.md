# 00OS Command User Guide

> For the canonical rationale and design philosophy behind 00OS and Cursor rule manipulation, see [00OS-rationale.md].

Welcome to 00OS, a terminal-like interface for AI-powered command execution. This guide explains how to use available commands, understand the basic syntax, and get help.

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

For details on the 00OS workflow, process structure, or developer standards, see the [master workflow file](../../README.md) and the developer documentation. 