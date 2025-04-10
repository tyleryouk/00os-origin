# Plan: 1000x System Command Refinement and Enhancement

## 1. Overview

This plan outlines the strategy for refining the `1000xcommands/system/` structure and associated `1000xbrain` knowledge. The primary goals are to eliminate outdated information and command structures, ensure adherence to the current 3-domain architecture (`system`, `frontend`, `backend`) and dynamic execution principles, and introduce new system-level commands for managing cross-component changes. This will improve the reliability, maintainability, and autonomous capabilities of the 1000x system command infrastructure.

## 2. Goals

*   **Align Knowledge with Reality**: Update `1000xbrain` knowledge files (architecture, commands structure/organization) to accurately reflect the adopted 3-domain structure and current best practices.
*   **Modernize System Commands**: Refactor existing commands in `1000xcommands/system/` subdirectories to use correct paths, modern syntax, and rely on `1000xbrain` processes via dynamic execution.
*   **Introduce System-Level Coordination**: Define and implement commands in `1000xcommands/system/` for orchestrating system-wide analysis, updates, and verification across multiple components (`brain`, `rules`, `commands`, `plans`, `scripts`).
*   **Enforce Holistic Updates**: Establish processes/commands that ensure `1000xbrain` knowledge/processes are reviewed and potentially updated whenever component-specific commands or their underlying logic changes.
*   **Improve Autonomous Workflow Potential**: Create a more robust and reliable command structure to better support future autonomous workflows initiated via `run command:`.

## 3. Current State Analysis Summary

*   **Outdated Knowledge**: Critical `1000xbrain` knowledge files related to architecture and commands are based on an obsolete 4-subsystem model.
*   **Inconsistent Commands**: Existing `1000xcommands/system/` commands contain incorrect paths, outdated syntax, and flawed dynamic execution patterns.
*   **Missing System-Level Commands**: No commands currently exist at the `1000xcommands/system/` root level for system-wide coordination.
*   **Manual Workflow**: Current operations rely heavily on `chat` interactions rather than autonomous `run command:` execution due to command unreliability.

## 4. Detailed Plan

**Phase 1: Knowledge Alignment (1000xbrain Update)**

1.  **Identify Outdated Knowledge**: Review files identified during initial analysis (primarily in `1000xbrain/system/brain/knowledge/system-structure/` and `1000xbrain/system/commands/knowledge/`).
2.  **Update Architecture Documentation**:
    *   Rewrite `1000xbrain/system/brain/knowledge/system-structure/system-architecture.md` and `system-vs-subsystem.md` (or consolidate/replace) to accurately describe the 3-domain structure (`system`, `frontend`, `backend`), the hierarchy within the `system` domain (`brain`, `rules`, etc.), and the role of `1000xbrain` as the master system. Remove references to the 4-subsystem model and obsolete rule types.
    *   **Tool**: `edit_file`.
3.  **Update Command Documentation**:
    *   Rewrite `1000xbrain/system/commands/knowledge/command-structure.md` to detail the current standard tool call syntax and the `# --- BEGIN DYNAMIC EXECUTION ---` marker format. Remove all references to XML tags and obsolete tools.
    *   Rewrite `1000xbrain/system/commands/knowledge/directory-organization.md` to reflect the `1000xcommands/system/`, `1000xcommands/frontend/`, `1000xcommands/backend/` top-level structure and the subdirectories within `system/`. Correct the `run command:` syntax example.
    *   Update `1000xbrain/system/commands/knowledge/best-practices.md` to correct paths (e.g., use `1000xbrain/system/commands/`) and remove references to outdated documentation. Reinforce reliance on dynamic execution and `1000xbrain` processes.
    *   **Tool**: `edit_file`.
4.  **Verify Updates**: Read the updated files to confirm accuracy and consistency with the current system state.
    *   **Tool**: `read_file`.

**Phase 2: Component Command Refactoring (1000xcommands/system/*/)**

1.  **Iterate Through Subdirectories**: Systematically review commands within each subdirectory (`brain/`, `rules/`, `commands/`, `plans/`, `scripts/`).
2.  **Refactor Each Command**:
    *   Read the command file (`.md`).
    *   Identify and correct outdated file paths (e.g., `1000xplans/brain/` -> `1000xplans/system/`, `1000xbrain/commands/` -> `1000xbrain/system/commands/`).
    *   Replace placeholder/conceptual comments with functional dynamic execution blocks referencing appropriate `1000xbrain` process files (creating basic process files if they don't exist).
    *   Ensure explicit tool calls (like context gathering `read_file`) appear *before* the dynamic execution block.
    *   Remove unnecessary comments (like conceptual `edit_file` examples).
    *   Update tool syntax if outdated (though most seem to use current `run_terminal_cmd` or `read_file`).
    *   **Tool**: `read_file`, `edit_file`, `list_dir` (to find/verify process files).
3.  **Create/Update Process Files**: For commands switched to dynamic execution, ensure the referenced `1000xbrain` process file exists (e.g., in `1000xbrain/system/commands/processes/`) and contains the core logic previously implied or scripted.
    *   **Tool**: `edit_file`.
4.  **Verify Refactoring**: Perform a logical walkthrough or simple read verification of refactored commands and associated process files.
    *   **Tool**: `read_file`.

**Phase 3: System-Level Command Implementation (1000xcommands/system/)**

1.  **Define System-Level Commands**: Identify necessary commands for system-wide coordination. Examples:
    *   `run command:system/verify-system-integrity`: Checks consistency across `1000xbrain` knowledge, `1000xcommands`, `1000xrules`.
    *   `run command:system/update-system-documentation`: Updates cross-component documentation like indexes or architecture diagrams based on current state.
    *   `run command:system/propagate-guideline-change`: Analyzes impact of a guideline change and proposes/makes updates to relevant commands/processes.
    *   `run command:system/analyze-command-usage`: (Future) Analyze logs to identify frequently used or problematic commands.
2.  **Create Process Files**: Define the logic for these system-level commands in corresponding `1000xbrain/system/brain/processes/` files (as they coordinate the overall system).
    *   **Tool**: `edit_file`.
3.  **Create Command Files**: Implement the command files in `1000xcommands/system/` using dynamic execution referencing the new process files.
    *   **Tool**: `edit_file`.
4.  **Update Index**: Ensure the command index (`1000xplans/system/commands-index.md`) is updated to include these new system-level commands (potentially by modifying and re-running the index generation script).
    *   **Tool**: `edit_file`, `run_terminal_cmd`.

**Phase 4: Establishing Holistic Update Workflow**

1.  **Define Update Process**: Create a new process file (e.g., `1000xbrain/system/brain/processes/holistic-update-verification.md`) outlining steps to take *after* modifying any command or its underlying process:
    *   Identify related `1000xbrain` knowledge/guideline files.
    *   Review them for potential inconsistencies introduced by the change.
    *   Propose/make necessary updates to `1000xbrain` files.
2.  **Integrate Verification**: Modify the process for creating/updating commands (e.g., `1000xbrain/system/commands/processes/creation-process.md`, `update-process.md`) to include a final step invoking the `holistic-update-verification.md` process.
    *   **Tool**: `edit_file`.
3.  **(Optional) Create Command**: Implement `run command:system/verify-holistic-update target_command=<domain/component/command_name>` which triggers the verification process for a specific command.
    *   **Tool**: `edit_file`.

**Phase 5: Verification and Documentation**

1.  **System-Wide Verification**: Execute `run command:system/verify-system-integrity` (once implemented).
2.  **Review Key Files**: Manually review updated knowledge files and examples of refactored/new commands.
3.  **Update Progress Tracker**: Update `1000xplans/system/implementation-progress.md` throughout the process.
4.  **Final Notes**: Add any relevant observations or decisions to `1000xplans/system/notes.md`.

## 5. Implementation Notes

*   Prioritize updating the core `1000xbrain` knowledge (Phase 1) first, as this provides the correct foundation.
*   Refactoring component commands (Phase 2) can be done iteratively, subdirectory by subdirectory.
*   System-level commands (Phase 3) build upon the corrected component commands.
*   Holistic updates (Phase 4) integrate the principle of linked changes into the workflow.
*   Adhere strictly to dynamic execution principles and minimize logic within command files themselves.

## 6. Verification Strategy

*   Use `read_file` extensively to verify changes made by `edit_file`.
*   Perform logical walkthroughs of commands and their associated process files.
*   Execute new verification commands (e.g., `verify-system-integrity`) once implemented.
*   Cross-reference changes against this plan and core rules (`1000xrules`).
