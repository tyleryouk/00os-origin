# Notes: Comprehensive 1000x System Architecture Enhancement

## Phase 1: Deep Dive Analysis & Goal Refinement

*Detailed findings for each system review are stored in dedicated `research_*.md` files (to be located in `1000xplans/system/`).*

*(High-level summaries or critical cross-system issues identified during review can be noted here if necessary.)*

### Regarding Input Keywords (`run:`, `chat`):

*   The `run command:domain/name` syntax is established. Sticking to `run command:` seems optimal for clarity and avoiding potential parsing ambiguity compared to `run:`. `run command:` explicitly signals the intent.
*   Regarding `chat`: While direct messages might work currently, enforcing the `chat ` prefix provides a clear, unambiguous signal for conversational input versus command input or other data. Maintaining this strict keyword separation (`run command:`, `chat `) is recommended for long-term parser reliability and reducing cognitive load during input interpretation.

## Phase 2: Cross-System Communication Enhancement

### Conceptual Information Flow Map (Aligned with New Structure)

This map outlines the **intended** flow of information and control between the 1000x systems, respecting the `system`, `frontend`, and `backend` domains:

1.  **Initiation (`1000xplans`)**: 
    *   Tasks start with defining requirements (`requirements.md`) and a plan (`plan.md`) in `1000xplans/<domain>/` (where `<domain>` is `system`, `frontend`, or `backend`).
    *   Plans reference necessary `1000xcommands` and `1000xbrain` knowledge/processes relevant to their domain.

2.  **Execution Trigger (`1000xcommands`)**: 
    *   Plan execution is driven by invoking `run command:<domain>/action` (where `<domain>` is `system`, `frontend`, or `backend`, potentially with sub-paths like `system/brain`).
    *   Commands should access relevant plan context via conventions in their dynamic execution processes.

3.  **Command Processing (`1000xcommands` + `1000xrules` + `1000xbrain`)**: 
    *   Command file (`1000xcommands/<domain>/path/to/file.md`) is immediately read (`1000xrules` enforcement).
    *   Explicit tool calls run sequentially.
    *   Dynamic Execution: Reads specified `1000xbrain/<domain>/processes/` and `1000xbrain/<domain>/knowledge/` files (using correct domain path).
    *   AI follows process steps, using knowledge and context.
    *   All actions governed by core `1000xrules`.
    *   Operational guidelines sourced from `1000xbrain/system/guidelines/`.

4.  **Cognitive Support (`1000xbrain`)**: 
    *   Provides domain-specific `knowledge/` and `processes/` within `system/`, `frontend/`, `backend/`.
    *   `1000xbrain/system/guidelines/` provides cross-cutting operational standards.

5.  **Automation Support (`1000xscripts`)**: 
    *   Contains scripts invoked via `run_terminal_cmd` from `1000xcommands`, organized by `system/`, `frontend/`, `backend/`.
    *   May interact with `1000xplans` or codebase.

6.  **Feedback Loop (`1000xplans` + `1000xbrain`)**: 
    *   Progress tracked in `1000xplans/<domain>/implementation-progress.md`.
    *   Detailed findings/notes in `1000xplans/<domain>/notes.md`.
    *   Errors/learnings logged in `1000xbrain/<domain>/operational_feedback/` (`Autonomous Optimization Goal`).

7.  **Governance (`1000xrules`)**: 
    *   Provides minimal, stable foundational rules for identity, safety, communication, tools.

**Critical Flow Requirement Alignment:** Knowledge/Processes supporting a command domain (e.g., `system/commands`) reside in the corresponding `1000xbrain` path (e.g., `1000xbrain/system/commands/knowledge/`). Guidelines reside in `1000xbrain/system/guidelines/`.

## Phase 3: Centralized Guidelines Implementation

### Guideline Candidates (Identified from Phase 1 Review)

*   **`1000xrules/core/identity/implementation-standards.md`**: Sections suitable for migration to `1000xbrain/system/guidelines/` include:
    *   Core Implementation Approach / Pattern (-> `implementation/`)
    *   Technical Implementation Standards (Code Guidelines -> `coding/`? or `implementation/`, Tracking -> `implementation/`)
    *   Context Management Standards / Tool Sequence Example (-> `implementation/` & `tool-usage/`)
    *   Communication Format Standards (-> `communication/`)
    *   Error Recovery Protocols (-> `error-handling/`)
    *   Performance Optimization Protocols (-> `performance/`)
*   **Rationale**: Migration keeps `1000xrules` lean and centralizes operational standards in `1000xbrain/system/guidelines/`, improving maintainability.
