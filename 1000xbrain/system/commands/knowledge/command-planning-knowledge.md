# Command Planning Knowledge

## Overview
This document contains essential knowledge points for the planning phase of creating or modifying 1000xcommands. The `run command:commands/plan-start` command leverages this knowledge.

## Core Concepts

*   **Planning Goal:** Define the scope, tool call sequence, and expected outcome of the target 1000xcommand.
*   **Command Location:** Command definitions (`.md` files) reside in `1000xcommands/<domain>/`.
*   **Domain Selection:** Choose the most appropriate domain (`brain`, `commands`, `rules`, `plans`, `frontend`, `backend`, `scripts`) based on the command's primary target or function.
*   **Naming Convention:** Use kebab-case (e.g., `create-new-component`) for command file names.
*   **Input Requirements:** Understand the necessary inputs (e.g., target command name, domain, specific requirements from `1000xplans`).
*   **Context Gathering:** Identify relevant existing structures, processes, or knowledge files within `1000xbrain`, `1000xrules`, and `1000xcommands` that the new/modified command will interact with.
*   **Tool Selection:** Choose the appropriate sequence of tool calls (`read_file`, `list_dir`, `edit_file`, `grep_search`, `codebase_search`, etc.) to achieve the command's objective safely and efficiently. Adhere to `1000xrules/core/tools/` standards.
*   **Output Definition:** Determine the expected state of the planning folder (e.g., `1000xplans/commands/`) after the `plan-start` command completes (e.g., updated `implementation-plan.md`, `README.md`).
*   **Simplicity:** Aim for the simplest effective tool call sequence. Avoid unnecessary complexity.

## Key Files for Planning Context

*   `1000xplans/<domain>/requirements.md`: User-provided high-level goals for the relevant domain.
*   `1000xbrain/commands/commands-structure.md`: Overall structure of commands and support files.
*   `1000xbrain/commands/processes/command-planning-process.md`: The standard process flow for planning commands.
*   `1000xrules/core/communication/1000xcommands-guidelines.md`: Core rules for command definition location (`1000xcommands/<domain>/`) and invocation.
*   `1000xrules/core/tools/file-reading-enforcement.md`: Mandatory file reading standards.
*   `1000xrules/core/communication/file-editing-safety.md`: Safety guidelines for editing files.

## Planning Artifacts

The `plan-start` command (or equivalent for other domains) primarily interacts with and updates files in the relevant `1000xplans/<domain>/` directory:
*   `implementation-plan.md`
*   `implementation-progress.md`
*   `README.md`
*   `requirements.md` 