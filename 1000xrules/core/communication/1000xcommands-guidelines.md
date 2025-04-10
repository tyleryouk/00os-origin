# Guidelines: Strict Keyword Interaction & `1000xcommands` Commands

## Overview

This document defines the strict keyword-based interaction model for 1000xdev and the location and invocation mechanism for command definitions within the `system`/`frontend`/`backend` architecture.

## Core Principles

1.  **Strict Keyword Prefixes**: All user input MUST begin with either `run ` for command execution or `chat ` for conversation. Any other input is invalid.
2.  **Commands Reside in `1000xcommands`**: Executable command sequences (`.md` files) are stored exclusively within `1000xcommands/`, organized by top-level domain (`system/`, `frontend/`, `backend/`). Commands targeting the meta-systems reside under `system/` (e.g., `1000xcommands/system/brain/`, `1000xcommands/system/rules/`).
3.  **Explicit Command Invocation**: Commands are invoked using the exact syntax `run command:domain/command-name` (e.g., `run command:system/brain/analyze-structure`).
4.  **Abstraction**: Complex logic MUST be abstracted into knowledge or process files within the `1000xbrain` master system (e.g., `1000xbrain/system/brain/knowledge/`, `1000xbrain/frontend/processes/`), referenced by tool calls within commands using dynamic execution.
5.  **Silent Command Execution**: When a valid `run command:...` is received, 1000xdev executes the tool calls silently (no conversational response).
6.  **Immediate Command Reading**: Upon receiving a command invocation, 1000xdev MUST immediately read the command file before any thinking or processing. See `1000xrules/core/communication/command-processing-optimization.md` for detailed requirements.

## Command Format (`.md` file in `1000xcommands/`)

The format remains the same: simple Markdown with a header and tool calls, potentially including dynamic execution markers.

```markdown
# Command Name (e.g., Enhance Cognitive Architecture)

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/system/brain/processes/enhance-architecture.md
# Knowledge: 1000xbrain/system/brain/knowledge/architecture-principles.md

# --- END DYNAMIC EXECUTION ---

# (Explicit tool calls can also exist, typically for simpler commands)
tool_call(...)
# Example: list_dir("1000xcommands/system/brain/")
tool_call(...)
```

## ⚠️ CRITICAL: Immediate Command File Reading Requirement ⚠️

When receiving a command invocation (`run command:domain/name`), 1000xdev MUST:

1.  **IMMEDIATELY read the command file** as the ABSOLUTE FIRST action.
2.  **NO thinking, planning, or processing** should occur before the command file is read.
3.  **ZERO preliminary analysis** before understanding the full content of the command file.

For complete requirements and detailed guidance, see `1000xrules/core/communication/command-processing-optimization.md`.

## Interaction Flow & Strict Parsing

1.  **Input Starts with `run command:`**:
    *   1000xdev recognizes this as a command invocation attempt.
    *   It **strictly parses** the rest of the line for the `domain/command-name` structure.
    *   If the structure is valid, it constructs the target path: `1000xcommands/{domain}/{command-name}.md` (interpreting `domain` which may include sub-paths like `system/brain`).
    *   It uses `read_file` to read the target `.md` file. **THIS MUST HAPPEN IMMEDIATELY WITH ZERO DELAY.**
    *   It parses the file for tool calls and dynamic execution markers.
    *   It **sequentially executes explicit tool calls** listed **UNTIL** it encounters the `# --- BEGIN DYNAMIC EXECUTION ---` marker OR reaches the end of the file.
    *   **If the marker IS encountered:**
        *   Execution of explicit tool calls from the command file stops.
        *   The AI parses the `Process:` line following the marker to identify the guiding process file (within `1000xbrain`).
        *   The AI parses any optional `Knowledge:` lines to identify supplementary knowledge files (within `1000xbrain`).
        *   The AI reads the specified process/knowledge files (if not already loaded).
        *   The AI then begins **dynamic execution**, interpreting the steps in the process file and using all gathered context (including loaded knowledge) to determine and execute the necessary sequence of tool calls.
    *   **If the marker IS NOT encountered:**
        *   Execution stops after the last explicit tool call in the command file or upon encountering an error.
    *   It **DOES NOT** send any conversational response back to Tyler during either explicit or dynamic execution triggered by `run command:`.
    *   Errors during execution (explicit or dynamic) are logged to the relevant operational feedback directory within the `1000xbrain` master system (e.g., `1000xbrain/system/brain/operational_feedback/`, `1000xbrain/frontend/operational_feedback/`).
    *   **Invalid Syntax Error**: If the input starts with `run ` but doesn't match `run command:domain/name` exactly, 1000xdev responds with: `Error: Invalid command syntax. Expected 'run command:domain/name'.` and stops.

2.  **Input Starts with `chat `**:
    *   1000xdev recognizes this as conversational input.
    *   It processes the entire text following `chat ` as a message from Tyler.
    *   It engages in dialogue, adopting the Jarvis persona (see `1000xrules/core/identity/core-identity.md`).
    *   It **DOES NOT** automatically execute tool calls unless the conversation explicitly warrants it for information gathering or direct instruction.

3.  **Any Other Input**:
    *   If the input does **not** start with `run command:` or `chat `, it is invalid.
    *   1000xdev responds with: `Error: Invalid input format. Please start your message with 'run command:...' for command execution or 'chat ...' for conversation.` and stops.

## Command Processing Efficiency

1000xdev must minimize "thinking time" during command execution:

1.  **Mechanical Execution**: Command processing should be direct and mechanical.
2.  **Abstracted Logic**: Complex logic MUST be abstracted to `1000xbrain` knowledge/process files (within the correct domain/subsystem path).
3.  **Streamlined Workflow**: Command execution should follow a predictable, efficient sequence guided by core rules and `1000xbrain` processes.

For detailed optimization requirements, see `1000xrules/core/communication/command-processing-optimization.md`.

## Domain Organization (Commands)

Commands are organized by domain within `1000xcommands/`:

*   **`system/`**: Commands targeting the 1000x meta-systems.
    *   `system/brain/`: Commands for managing `1000xbrain`.
    *   `system/rules/`: Commands for managing `1000xrules`.
    *   `system/commands/`: Commands for managing `1000xcommands` itself.
    *   `system/plans/`: Commands related to the planning process for the system.
    *   `system/scripts/`: Commands for managing `1000xscripts` related to the system.
*   **`frontend/`**: Commands for front-end application development tasks.
*   **`backend/`**: Commands for back-end application development tasks.

## Tool Call Standards within Commands

Adhere to core tool usage standards defined in `1000xrules/core/tools/` (`.md` files) and operational guidelines in `1000xbrain/system/guidelines/tool-usage/`. Key standards like `file-reading-enforcement.md` are critical.

## Best Practices (Command Creation/Maintenance)

Principles remain similar, but emphasize:

1.  **Location**: Commands MUST be created in the correct domain/sub-path under `1000xcommands/` (e.g., `1000xcommands/system/brain/new-command.md`).
2.  **Invocation Reference (Docs)**: When referencing command invocation in documentation (e.g., within `1000xbrain` files), use the full syntax wrapped in backticks: `` `run command:system/brain/command-name` ``.
3.  **Abstraction**: Leverage dynamic execution referencing `1000xbrain` process/knowledge files for non-trivial logic.
4.  **Optimization**: Follow the optimization guidelines in `1000xrules/core/communication/command-processing-optimization.md`.

## File Extension Usage (Updated)

Distinguish clearly:

*   **Command Definition File (Editable):** `1000xcommands/<domain>/<command-name>.md` (e.g., `1000xcommands/system/rules/update-rule.md`)
*   **Command Invocation Reference:** `run command:domain/command-name` (Use backticks in docs: `` `run command:system/rules/update-rule` ``)
*   **Core Rule File (Editable):** `1000xrules/core/.../file.md`
*   **Cursor Rule File (Read-Only for AI):** `.cursor/rules/.../file.mdc` (Generated from `1000xrules`)

## Deprecation Notes

*   The `@1000xcommands/...` invocation syntax is **obsolete**.
*   The `1000xrules/1000xcommands/` directory is **obsolete**.
*   The concept of `fetch_rules` for reading command definitions is **obsolete**; `read_file` is used.
*   Modes (`plan-mode`, `dev-mode`, `direct-mode`) are **obsolete**. 