# Commands Structure

## Overview

This document defines the structure and organization of the command system. Commands are executable sequences of tool calls defined in `.md` files located within the `1000xcommands` directory, organized by domain.

## Directory Structure (`1000xcommands`)

```
1000xcommands/
├── brain/                  # Commands for 1000xbrain enhancement & interaction
│   ├── enhance-cognitive-architecture.md
│   ├── analyze-system-structure.md
│   └── create-1000xcommand.md # Note: Likely should be in commands/ domain
├── commands/               # Commands for managing the command system itself
│   ├── plan-start.md       # Starts planning for commands domain enhancements
│   ├── dev-start.md        # Starts development for commands domain enhancements
│   ├── create-command.md   # Guides creation of new command files (AI uses logic)
│   ├── update-command.md   # Guides update of command files (AI uses logic)
│   ├── delete-command.md   # Guides deletion of command files (AI uses logic)
│   ├── list-commands.md    # Lists available commands
│   └── new-1000xplan.md    # Analyzes commands domain & updates its planning files
├── front-end/              # Commands for front-end development
│   └── .gitkeep
├── back-end/               # Commands for back-end development
│   └── .gitkeep
├── rules/                  # Commands for 1000xrules system management
│   ├── explore-rule-structure.md
│   ├── update-rule-content.md
│   ├── enhance-core-rules.md
│   ├── test-new-syntax.md
│   └── .gitkeep
├── scripts/                # Commands for 1000xscripts management
│   └── .gitkeep
└── plans/                  # Commands for managing 1000xplans system & processes
    # (Currently empty, planned commands: plan-initiate, plan-update-progress, plan-finalize)
```

## Directory Structure (`1000xbrain/commands` - Support Files)

This directory within `1000xbrain` contains the *supporting* knowledge and process files for the command system, not the command definitions themselves.

```
1000xbrain/commands/
├── knowledge/
│   ├── command-planning-knowledge.md
│   └── command-patterns.md
├── processes/
│   ├── command-planning-process.md
│   ├── command-development-process.md
│   └── execution-process.md
└── commands-structure.md   # This file
```

## Command Format

Each command file (`.md` in `1000xcommands/<domain>/`) follows a standard format:

```markdown
# Command Name

tool_call("parameters")
# Optional comments explaining the call
tool_call("parameters")
```

## Command Invocation

Commands are invoked using the exact syntax:

```
run command:<domain>/<command-name>
```

For example:
```
run command:brain/enhance-cognitive-architecture
run command:commands/plan-start
```

## Domain Organization

Commands are organized by domain within `1000xcommands/` to match the target areas they operate on:

1.  **brain/**: Commands that manage the cognitive architecture (`1000xbrain`) and its interaction with other systems.
2.  **rules/**: Commands that operate on the `1000xrules` system.
3.  **front-end/**: Commands that implement front-end functionality.
4.  **back-end/**: Commands that implement back-end functionality.
5.  **scripts/**: Commands that manage system scripts in `1000xscripts/`.
6.  **commands/**: Commands that manage the command system itself (e.g., `create-command`, `list-commands`, `plan-start` for command enhancements).
7.  **plans/**: Commands that manage the planning process and artifacts across domains (e.g., `plan-initiate` for a new domain plan).

## 1000x Systems
All 1000x systems (`1000xbrain`, `1000xcommands`, `1000xrules`, `1000xplans`, `1000xscripts`, `front-end`, `back-end`) work together to enhance development productivity. Each system has editing access to others as needed. The domain separation primarily facilitates focused optimization and understanding. Continuous improvement of all systems is a core objective.

## Related Components

- **1000xbrain/commands/knowledge/**: Contains knowledge supporting the command system.
- **1000xbrain/commands/processes/**: Defines processes related to command development and execution.
- **1000xrules/core/communication/1000xcommands-guidelines.md**: Core guidelines defining the command system's location and invocation.

## Implementation Guidelines

1.  **Command Creation**: Create new command definition files in the appropriate `1000xcommands/<domain>/` directory.
2.  **Naming Convention**: Use kebab-case for command file names.
3.  **Tool Call Structure**: Ensure tool calls are properly formatted.
4.  **Verification**: Test command functionality.
5.  **Documentation**: Include clear comments within command files.

## Relationship to Core Rules

- Command definition files (`.md` in `1000xcommands/`) are NOT synchronized to Cursor Rules.
- Core rules (`.md` in `1000xrules/core/`) ARE synchronized to Cursor Rules (`.mdc`).
- Commands are executed via `read_file` + tool call parsing based on the `run command:...` invocation.
