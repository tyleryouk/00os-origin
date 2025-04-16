[Tyler] Written by Tyler
Everything else is written by 00reaper

# Command Registry

This file tracks the implementation status and location of all 00OS commands.

## System Commands
| Command | Status | Process File | Description |
|---------|--------|--------------|-------------|
| `help` | ✅ | system/help.md | Display command help information |
| `system status` | ✅ | system/system-status.md | Show system status and health |
| `echo` | ✅ | system/echo.md | Echo a message back to user |
| `version` | ✅ | system/version.md | Display system version information |

## File Operations
| Command | Status | Process File | Description |
|---------|--------|--------------|-------------|
| `file list` | ✅ | tools/file-list.md | List files in directory |
| `file read` | ✅ | tools/file-read.md | View file contents |
| `file search` | 📅 | tools/file-search.md | Find files by pattern |

## Context Management
| Command | Status | Process File | Description |
|---------|--------|--------------|-------------|
| `reaper-init` | ✅ | system/reaper-init.md | Initialize system context |
| `reaper-update` | ✅ | system/reaper-update.md | Update context state |
| `reaper-sync` | ✅ | system/reaper-sync.md | Trigger sync operations (Note: For development use `.\Sync-00OS-Complete.ps1`) |
| `reaper-read-files` | ✅ | system/reaper-read-files.md | Read files in a directory (Params: path, --recursive) |

## Workflow Commands
| Command | Status | Process File | Description |
|---------|--------|--------------|-------------|
| `reaper-analyze-tasks` | 🔄 | system/reaper-analyze-tasks.md | Analyze current tasks and generate action plan |
| `reaper-implement` | 🔄 | system/reaper-implement.md | Structured implementation of a specific request |

## Utility Commands
| Command | Status | Process File | Description |
|---------|--------|--------------|-------------|
| `calculator` | ✅ | tools/calculator.md | Perform calculations |
| `state` | ✅ | system/state.md | Manage system state |

## Status Legend
- ✅ Implemented and tested
- 🔄 In development
- 📅 Planned
- ❌ Deprecated

## Implementation Priority
1. Implement workflow commands for improved development process
2. Implement `file search` command
3. Enhance command response formatting standardization
4. Add command aliasing support
5. Implement command piping functionality
6. Develop file comparison functionality
7. Add recursive directory support to `file list` command

## Development Sync Process

For development, always use the PowerShell script to sync changes to the rules directory:

```
.\Sync-00OS-Complete.ps1
```

This script performs a complete synchronization of all 00OS files to the .cursor/rules/ directory, including:
- File content updates
- Rule type configuration
- Frontmatter formatting

Note that while the `> reaper-sync` command exists for use within the 00OS system, the PowerShell script above is required for development workflow to ensure proper file transformation and rule type configuration.

##### Common prompts to turn to 00OS commands [Tyler]

##### Possible command: > reaper-consolidate-base-folder 00reaper/00OS-commands/
(exact prompt):
Optimize and consolidate the files in the folder 00reaper/00OS-commands/. Only keep what is essential, and update the README.md which serves as the starting point for this folder. This folder is the base for creating, updating, and managing 00OS commands.


##### Possible command: > reaper-read-all 00OS/
(exact prompt):
00reaper, read all files in 00OS/. Read-only, do not make any changes to the files.