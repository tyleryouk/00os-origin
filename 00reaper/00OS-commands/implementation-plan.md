# Implementation Plan - Current Development Cycle

This file contains the concrete implementation plan for the current development cycle. It outlines architectural decisions, required changes, documentation updates, and testing approach.

## Current Cycle: REQ-002 Command-Process Alignment

### Analysis of Current State

Based on the comprehensive review of relevant context files and cursor rules manipulation documentation, we've identified the following current state:

1. **Command Registry Status**:
   - Multiple command sources exist (`> help`, `> command-registry`, actual process files)
   - Some commands listed may not have corresponding process files
   - Some process files may not be listed in the registry

2. **Process Organization**:
   - Processes are organized into three categories (system, 00reaper, 1000xdev)
   - System commands (echo, help, system-status, version, state, chain) are implemented
   - Tool commands (calculator, file-list, file-read, file-search, system-monitor) are implemented
   - 00reaper commands (reaper-init, reaper-sync, reaper-read-files, reaper-analyze-tasks, reaper-implement) are implemented
   - 1000xdev category is defined but no commands implemented yet
   - Naming conventions are not consistently enforced

3. **Command Execution Flow**:
   - Command handler detects `>` prefix
   - Inconsistent implementation of `fetch_rules` calls
   - Some commands may attempt self-execution via terminal commands

4. **Cursor Rules System**:
   - Development happens in `00OS` directory using `.md` files
   - Production rules are in `.cursor/rules` as `.mdc` files with proper frontmatter
   - Synchronization occurs via `00reaper/00scripts\Sync-00OS-Complete.ps1`
   - Three rule types exist: Always Applied (core components), Description-Based (processes), File Pattern (context-specific)

### Architectural Decisions

1. **Terminology Standardization**:
   - Adopt "00OS processes" as the standard term for process definitions in the `00os/` directory.
   - Use "command" to refer to user-invoked actions prefixed with `>`.
   - Use "rule" when referring to the `.mdc` files in the `.cursor/rules/` directory after synchronization.

2. **1:1 Command-Process Mapping**:
   - Each command (`> command-name`) must have exactly one corresponding process file (`command-name.md`) in the `00os/` development directory.
   - Process filenames must match command names (lowercase, hyphens for spaces).
   - All process files must reside in the correct category subdirectory (`system/`, `00reaper/`, `1000xdev/`) within `00os/processes/`.

3. **Execution Flow Enforcement**:
   - The command handler MUST use `fetch_rules` to retrieve the process definition (rule) for *every* command detected.
   - No command process should attempt to execute itself or another 00OS command via `run_terminal_cmd`.
   - All execution logic MUST reside within the fetched process rule's JavaScript block.

4. **Cursor Rules Development Workflow**:
   - **Development**: All process creation and modification occurs in the `00os/` directory using standard markdown (`.md`) files.
   - **Synchronization**: Changes are propagated to the production environment using the `> reaper-sync` command (which runs `00reaper/00scripts/Sync-00OS-Complete.ps1`). This script handles the conversion to `.mdc` and adds the necessary frontmatter.
   - **Production**: Active rules reside in the `.cursor/rules/` directory as `.mdc` files. These files should **never** be edited directly.
   - **Rule Types**:
     - Core components (e.g., `command-handler`) require `alwaysApply: true` in their production `.mdc` frontmatter.
     - Process files require descriptive triggers (e.g., `description: USE WHEN you want to execute help`) in their production `.mdc` frontmatter.
   - **Token Efficiency**: Core components (always applied rules) should be kept concise.

### Required Changes to 00OS

1. **Command Handler Updates (`00os/core/command-handler.md`)**:
   - Verify and ensure the handler *always* uses `fetch_rules` for *all* commands starting with `>`.
   - Add validation or logging to detect and prevent attempts at self-execution via `run_terminal_cmd`.
   - Improve error handling for cases where `fetch_rules` fails to find a corresponding process rule.
   - Perform all updates in the `00os/core/command-handler.md` development file.

2. **Process File Alignment (`00os/processes/`)**:
   - Conduct a thorough audit comparing documented/expected commands against actual `.md` files in `00os/processes/` subdirectories.
   - Create missing `.md` process files (using `templates/command-template.md`) for any identified gaps (e.g., `reaper-update`, `cd`, `pwd`, `file`).
   - Rename or move any incorrectly named or categorized `.md` process files.
   - Remove any orphaned `.md` process files that don't correspond to a valid command concept.
   - Verify all existing `.md` process files contain the standard YAML frontmatter (for metadata, not rule activation) and basic execution structure.

3. **Dynamic Command Discovery Strategy**:
   - Remove dependency on a static `documentation/command-registry.md` file.
   - Plan for commands like `> help` and `> reaper-verify` (or similar) to dynamically list available commands by scanning the `00os/processes/` directory structure and parsing `.md` file metadata.
   - This aligns with the principle that the process files are the single source of truth for command availability.

4. **Synchronization Process Verification**:
   - Test the `> reaper-sync` command (and underlying PowerShell script) thoroughly after making changes to core components or processes.
   - Verify that the script correctly generates `.mdc` files in `.cursor/rules/`.
   - Confirm that core components (`.cursor/rules/core/*.mdc`) receive `alwaysApply: true` in their frontmatter.
   - Confirm that process files (`.cursor/rules/processes/**/*.mdc`) receive the correct `description: USE WHEN...` trigger in their frontmatter.

### Documentation Updates

1. **Command Registry (`documentation/command-registry.md`)**: **DEPRECATED**. This file will be removed or repurposed. Command availability will be determined dynamically.

2. **Command Development Guidelines (`documentation/00OS-command-development.md` & `templates/command-standards.md`)**:
   - Emphasize the strict 1:1 command-process mapping requirement within `00os/processes/`.
   - Detail the naming and categorization conventions within the `00os/` directory.
   - Reinforce the mandatory `fetch_rules` execution flow handled by the command handler.
   - Explicitly document the development (`00os/`) -> synchronization (`> reaper-sync`) -> production (`.cursor/rules/`) workflow.
   - Provide clear instructions on frontmatter requirements for `.md` files (metadata).
   - Explain that rule-activation frontmatter (`alwaysApply`, `description`) is added to `.mdc` files during sync.
   - Add a note explaining the shift to dynamic command discovery instead of a static registry file.

3. **System Architecture Documentation (`context-00OS-current-state/core-current-state.md` or similar)**:
   - Update diagrams and descriptions to accurately reflect the mandatory `fetch_rules` step and the dev/sync/prod workflow.
   - Document the purpose and function of the `> reaper-sync` command.
   - Mention the dynamic command discovery approach.

4. **User Guide (`documentation/00OS-command-user-guide.md`)**: **DEPRECATED/NEEDS REVISION**. This guide needs to be updated to reflect dynamically discovered commands, likely driven by the `> help` command's output.

5. **Cursor Rules Documentation (`context-cursor-rules-manipulation/`)**:
   - Consolidate research findings into a clear guide on how 00OS utilizes Cursor Rules.
   - Document the sync process (`> reaper-sync`) in detail.
   - Explain the different rule types (`alwaysApply`, `description`) and their use in 00OS.

### Testing Approach

1. **Static Verification (Pre-Sync)**:
   - Implement or enhance a verification process (potentially a new `> reaper-verify` command) to:
     - Scan `00os/processes/` subdirectories for `.md` files.
     - Validate process file naming and categorization within `00os/processes/`.
     - Parse YAML frontmatter from `.md` files to verify required metadata (name, description, etc.).
     - Scan process file content for potential `run_terminal_cmd` self-execution patterns.

2. **Synchronization Tests**:
   - After running `> reaper-sync`, inspect the generated `.mdc` files in `.cursor/rules/`:
     - Verify correct file structure mirroring `00os/`.
     - Check `.mdc` frontmatter: `alwaysApply: true` for core components, correct `description: USE WHEN...` for processes.
   - Test the `> reaper-sync` command itself for successful execution and error handling.

3. **Command Execution Tests (Post-Sync)**:
   - Execute each discovered command (`> command-name`) in Cursor.
   - Verify the command executes successfully using its intended process (confirm via logs or behavior).
   - Test error handling for commands with missing or incorrect parameters.
   - Confirm no commands attempt self-execution.
   - Specifically test `> help` to ensure it dynamically lists commands based on the synced process rules.

4. **Documentation Tests**: **REVISED**.
   - Verify `> help` output dynamically reflects the available commands based on synced rules in `.cursor/rules/`.
   - Ensure development guides accurately reflect the dynamic discovery workflow and standards.

## Implementation Timeline and Action Items

1. **Phase 1: Complete Audit & Analysis** (Steps 1-2) ✅
   - Full audit of commands, processes, and Cursor Rules context complete.
   - Core workflow files read.

2. **Phase 2: Update Core Workflow Files** (Step 3) ✅
   - [x] Revised `implementation-plan.md` (this file).
   - [x] Updated `active-request.md`.
   - [x] Updated `cycle-status.md`.

3. **Phase 3: Command Handler Updates** (Step 4) ✅
   - [x] Modified `00os/core/command-handler.md` to enforce `fetch_rules` and prevent self-execution.

4. **Phase 4: Process File Alignment** (Step 4) ✅
   - [x] Audited `00os/processes/` subdirectories.
   - [x] Removed dependency on static `command-registry.md` (per user instruction).
   - [x] Created placeholder `.md` files for `reaper-update`, `file`, `cd`, `pwd`.
   - [ ] *Deferred*: Detailed verification of all existing process file metadata/structure (can be part of a future REQ).

5. **Phase 5: Documentation Update** (Step 5) ⏳
   - [ ] Update development guides (`00OS-command-development.md`, `command-standards.md`) to reflect dynamic discovery.
   - [ ] Update or create Cursor Rules documentation.
   - [ ] Revise System Architecture documentation.
   - [ ] *Deferred*: Update User Guide (depends on `> help` implementation).

6. **Phase 6: Synchronization & Testing** (Step 4 & 5 Combined) ⏱️
   - [ ] Run `> reaper-sync` to deploy changes to `.cursor/rules/`.
   - [ ] Perform Synchronization Tests (verify `.mdc` files and frontmatter).
   - [ ] Perform Command Execution Tests on synced rules (including `> help`).
   - [ ] Implement/Run Static Verification checks (`> reaper-verify` or similar).

7. **Phase 7: Review & Finalize** (Step 6) ⏱️
   - [ ] Review implementation against REQ-002 criteria.
   - [ ] Address any remaining issues found during testing.
   - [ ] Update `cycle-status.md` to ✅ Completed.
   - [ ] Prepare for the next cycle. 