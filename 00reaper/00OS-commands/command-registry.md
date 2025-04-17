# Command Registry

This file tracks the implementation status and location of essential 00OS commands using the Cursor tool call approach.

## Core System Commands
| Command | Status | Process File | Description |
|---------|--------|--------------|-------------|
| `help` | 🔄 | system/help.md | Display command help information |
| `system status` | 🔄 | system/system-status.md | Show system status and health |
| `echo` | 🔄 | system/echo.md | Echo a message back to user |
| `version` | 🔄 | system/version.md | Display system version information |

## File Operations
| Command | Status | Process File | Description |
|---------|--------|--------------|-------------|
| `file list` | 🔄 | tools/file-list.md | List files in directory |
| `file read` | 🔄 | tools/file-read.md | View file contents |
| `file search` | 📅 | tools/file-search.md | Find files by pattern |

## Context Management
| Command | Status | Process File | Description |
|---------|--------|--------------|-------------|
| `reaper-read-files` | 🔄 | system/reaper-read-files.md | Read files in a directory |

## Status Legend
- ✅ Implemented with tool call approach and tested
- 🔄 In process of converting to tool call approach
- 📅 Planned for implementation
- ❌ Deprecated

## Implementation Priority

1. Convert basic commands to tool call approach:
   - `help` - Essential for discovering other commands
   - `echo` - Simple test command for validation
   - `file list` - Basic file system navigation
   - `file read` - Basic file system operation

2. Implement new tool call optimized commands:
   - `file search` - Enhanced file system searching
   - More complex commands using tool call sequences

## Development Workflow

1. Implement command process file using tool call pattern
2. Sync process file to the Cursor rules directory
3. Test command execution with `>` prefix
4. Document implementation and any issues

## Command Implementation Notes

Each command must follow these guidelines:

1. Use native Cursor tool calls instead of terminal commands
2. Implement proper parameter validation
3. Use standardized response formatting
4. Include comprehensive error handling
5. Follow the execution flow:
   ```
   Command Detection → Process Selection → Parameter Parsing → Tool Call Execution → Response Formatting
   ```

For detailed implementation guidelines, see `00OS-command-guidelines.md`.

##### Possible command: > reaper-consolidate-base-folder 00reaper/00OS-commands/
(exact prompt):
Optimize and consolidate the files in the folder 00reaper/00OS-commands/. Only keep what is essential, and update the README.md which serves as the starting point for this folder. This folder is the base for creating, updating, and managing 00OS commands.


##### Possible command: > reaper-read-all 00OS/
(exact prompt):
00reaper, read all files in 00OS/. Read-only, do not make any changes to the files.