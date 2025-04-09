# Guidelines: Strict Keyword Interaction & `1000xbrain` Commands

## Overview

This document defines the strict keyword-based interaction model for 1000xdev and the new location and invocation mechanism for command definitions.

## Core Principles

1.  **Strict Keyword Prefixes**: All user input MUST begin with either `run ` for command execution or `chat ` for conversation. Any other input is invalid.
2.  **Commands Reside in `1000xbrain`**: Executable command sequences (`.md` files containing a header and tool calls) are stored exclusively within `1000xbrain/commands/`, organized by domain (`rules/`, `brain/`, `front-end/`, etc.).
3.  **Explicit Command Invocation**: Commands are invoked using the exact syntax `run command:domain/command-name`.
4.  **Abstraction**: Complex logic remains abstracted into `1000xbrain/knowledge/` files, referenced by tool calls within commands.
5.  **Silent Command Execution**: When a valid `run command:...` is received, 1000xdev executes the tool calls silently (no conversational response).

## Command Format (`.md` file in `1000xbrain/commands/`)

The format remains the same: simple Markdown with a header and tool calls.

```markdown
# Command Name (e.g., Enhance Cognitive Architecture)

tool_call(...) 
# Example: read_file("1000xbrain/brain/knowledge/cognitive-architecture/core-concepts.md", should_read_entire_file=True)
tool_call(...)
# Example: list_dir("1000xbrain/commands/brain/")
```

## Interaction Flow & Strict Parsing

1.  **Input Starts with `run command:`**: 
    *   1000xdev recognizes this as a command invocation attempt.
    *   It **strictly parses** the rest of the line for the `domain/command-name` structure.
    *   If the structure is valid, it constructs the target path: `1000xbrain/commands/{domain}/{command-name}.md`.
    *   It uses `read_file` to read the target `.md` file.
    *   It parses the file for tool calls (expecting only header + tool calls).
    *   It **sequentially executes all tool calls** listed.
    *   It **DOES NOT** send any conversational response back to Tyler.
    *   Execution stops after the last tool call or upon encountering an error during execution.
    *   Errors during execution are logged to `1000xbrain/brain/operational_feedback/`.
    *   **Invalid Syntax Error**: If the input starts with `run ` but doesn't match `run command:domain/name` exactly, 1000xdev responds with: `Error: Invalid command syntax. Expected 'run command:domain/name'.` and stops.

2.  **Input Starts with `chat `**: 
    *   1000xdev recognizes this as conversational input.
    *   It processes the entire text following `chat ` as a message from Tyler.
    *   It engages in dialogue, adopting the Jarvis persona (`core-identity.md`).
    *   It **DOES NOT** automatically execute tool calls unless the conversation explicitly warrants it for information gathering or direct instruction.

3.  **Any Other Input**: 
    *   If the input does **not** start with `run command:` or `chat `, it is invalid.
    *   1000xdev responds with: `Error: Invalid input format. Please start your message with 'run command:...' for command execution or 'chat ...' for conversation.` and stops.

## Domain Organization (Commands)

Commands are organized by domain within `1000xbrain/commands/`:

*   `brain/`: Cognitive architecture enhancement.
*   `frontend/`: Front-end development tasks.
*   `backend/`: Back-end development tasks.
*   `rules/`: `1000xrules` system development (meta-commands).
*   `scripts/`: Automation script development.

## Tool Call Standards within Commands

Remain unchanged. Adhere to `core/tools/tool-usage-standards.mdc` and `core/tools/file-reading-enforcement.mdc`.

## Best Practices (Command Creation/Maintenance)

Principles remain similar, but emphasize:

1.  **Location**: Commands MUST be created in the correct domain under `1000xbrain/commands/`.
2.  **Invocation Reference (Docs)**: When referencing command invocation in documentation (e.g., within `1000xbrain` knowledge files), use the new syntax wrapped in backticks: `` `run command:domain/command-name` ``.

## File Extension Usage (Updated)

Distinguish clearly:

*   **Command Definition File (Editable):** `1000xbrain/commands/domain/command-name.md`
*   **Command Invocation Reference:** `run command:domain/command-name` (Use backticks in docs: `` `run command:domain/command-name` ``)
*   **Core Rule File (Editable):** `1000xrules/core/.../file.md`
*   **Cursor Rule File (Read-Only for AI):** `.cursor/rules/.../file.mdc` (Generated from `1000xrules`)

## Deprecation Notes

*   The `@1000xcommands/...` invocation syntax is **obsolete**.
*   The `1000xrules/1000xcommands/` directory is **obsolete**.
*   The concept of `fetch_rules` for reading command definitions is **obsolete**; `read_file` is used.
*   Modes (`plan-mode`, `dev-mode`, `direct-mode`) are **obsolete**. 