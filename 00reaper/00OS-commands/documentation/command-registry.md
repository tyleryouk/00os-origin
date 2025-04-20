# Command Registry

This file tracks the implementation status and location of essential 00OS commands using the Cursor tool call approach.

## System Commands (Global)
| Command | Status | Process File | Description |
|---------|--------|--------------|-------------|
| `help` | ✅ | system/help.md | Display command help information |
| `system status` | ✅ | system/system-status.md | Show system status and health |
| `echo` | ✅ | system/echo.md | Echo a message back to user |
| `version` | ✅ | system/version.md | Display system version information |
| `file list` | ✅ | system/file-list.md | List files in directory |
| `file read` | ✅ | system/file-read.md | View file contents |
| `file search` | ✅ | system/file-search.md | Find files by pattern |
| `calculator` | ✅ | system/calculator.md | Perform calculations |
| `system-monitor` | ✅ | system/system-monitor.md | Monitor system resources and status |
| `state` | ✅ | system/state.md | Manage system state |
| `chain` | ✅ | system/chain.md | Execute multiple commands in sequence |

## 00reaper-specific Commands
| Command | Status | Process File | Description |
|---------|--------|--------------|-------------|
| `reaper-init` | ✅ | 00reaper/reaper-init.md | Initialize 00reaper context |
| `reaper-update` | ✅ | 00reaper/reaper-update.md | Update context state |
| `reaper-sync` | ✅ | 00reaper/reaper-sync.md | Synchronize 00OS content to rules |
| `reaper-read-files` | ✅ | 00reaper/reaper-read-files.md | Read files in a directory |
| `reaper-analyze-tasks` | ✅ | 00reaper/reaper-analyze-tasks.md | Analyze implementation tasks |
| `reaper-implement` | ✅ | 00reaper/reaper-implement.md | Implement changes based on analysis |

## 1000xdev-specific Commands
| Command | Status | Process File | Description |
|---------|--------|--------------|-------------|
| No commands implemented yet | 📅 | - | - |

## Status Legend
- ✅ Implemented with tool call approach (pending testing)
- 📅 Planned for implementation
- ❌ Deprecated

## Implementation Priority

1. Complete system command implementations:
   - `help` - Essential for discovering other commands
   - `echo` - Simple test command for validation
   - `file list` - Basic file system navigation
   - `file read` - Basic file system operation

2. Implement new tool call optimized commands:
   - `file search` - Enhanced file system searching
   - More complex commands using tool call sequences

3. Develop agent-specific commands:
   - Complete development of 00reaper-specific commands
   - Begin implementing 1000xdev-specific commands

## Development Workflow

1. Implement command process file using tool call pattern
2. Place the file in the appropriate category directory (system, 00reaper, or 1000xdev)
3. Sync process file to the Cursor rules directory
4. Test command execution with `>` prefix
5. Document implementation and any issues

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

For detailed implementation guidelines, see `command-standards.md`.

##### Possible command: > reaper-consolidate-base-folder 00reaper/00OS-commands/
(exact prompt):
Optimize and consolidate the files in the folder 00reaper/00OS-commands/. Only keep what is essential, and update the README.md which serves as the starting point for this folder. This folder is the base for creating, updating, and managing 00OS commands.

##### Possible command: > reaper-read-all 00OS/
(exact prompt):
00reaper, read all files in 00OS/. Read-only, do not make any changes to the files.