# System Architecture

## Overview

This knowledge file provides a comprehensive overview of the 1000xdev cognitive architecture, focusing on the 3-domain structure (`system`, `frontend`, `backend`) and the roles of the core components (`1000xbrain`, `1000xcommands`, `1000xrules`, `1000xplans`, `1000xscripts`).

## Core Architecture: 3-Domain Model

The 1000xdev architecture is organized around three primary domains:

1.  **`system/` Domain**: Manages the meta-components of the 1000xdev system itself (brain, rules, commands, plans, scripts) and system-wide guidelines.
2.  **`frontend/` Domain**: Manages all aspects related to the target front-end application development.
3.  **`backend/` Domain**: Manages all aspects related to the target back-end application development.

(For detailed explanation of domain relationships and responsibilities, see `1000xbrain/system/brain/knowledge/domain-relationships.md`)

## Core Components (Organized by Domain)

These components exist within each domain, holding domain-specific content:

*   **`1000xbrain/`**: The master cognitive hub.
    *   Contains `system/`, `frontend/`, `backend/` subdirectories.
    *   Each domain subdirectory houses `knowledge/`, `processes/`, and `operational_feedback/`.
    *   `1000xbrain/system/` uniquely contains system-wide `guidelines/`.
    *   Guides the logic of `1000xcommands` via dynamic execution.
*   **`1000xcommands/`**: Executable command definitions.
    *   Contains `system/`, `frontend/`, `backend/` subdirectories.
    *   Each domain subdirectory contains further subdirectories for specific components (e.g., `1000xcommands/system/rules/`) or holds commands directly (e.g., `1000xcommands/system/`).
    *   Invoked via `run command:domain/path/to/command`.
    *   Logic should be primarily delegated to `1000xbrain` processes.
*   **`1000xplans/`**: Planning documents.
    *   Contains `system/`, `frontend/`, `backend/` subdirectories.
    *   Each holds `plan.md`, `requirements.md`, `implementation-progress.md`, `notes.md` etc. for that domain.
*   **`1000xscripts/`**: Utility and automation scripts.
    *   Contains `system/`, `frontend/`, `backend/` subdirectories.
    *   Invoked by `1000xcommands` via `run_terminal_cmd`.

*   **`1000xrules/`**: Foundational, system-wide rules.
    *   Located at the root.
    *   Defines core identity, safety, communication, tools.
    *   Minimal and stable; changes require careful consideration.
    *   Source `.md` files sync to `.cursor/rules/` (`.mdc` files, read-only for AI).

## Information Flow (Simplified)

1.  **Tyler Youk**: Initiates tasks (`run command:`, `chat `), defines requirements (`1000xplans`).
2.  **`1000xcommands`**: Act as triggers, read definitions, potentially start dynamic execution.
3.  **Dynamic Execution**: Reads/follows `1000xbrain/<domain>/processes/`.
4.  **`1000xbrain` Processes**: Access `knowledge/` and `guidelines/` for context and standards.
5.  **Tools**: Execute actions based on process logic (e.g., `edit_file`, `run_terminal_cmd`).
6.  **Scripts (`1000xscripts`)**: Executed by `run_terminal_cmd` for automation.
7.  **Feedback**: Recorded in `1000xplans/implementation-progress.md` and `1000xbrain/<domain>/operational_feedback/`.
8.  **`1000xrules`**: Govern all interactions and tool usage.

## Key Principles

*   **Domain Separation**: Clear distinction between `system`, `frontend`, `backend`.
*   **Brain as Master**: `1000xbrain` holds the guiding knowledge and processes.
*   **Commands as Triggers**: `1000xcommands` initiate actions, delegating logic.
*   **Dynamic Execution**: Preferred method for complex command logic.
*   **Holistic Awareness**: Changes should consider impacts across related components. 