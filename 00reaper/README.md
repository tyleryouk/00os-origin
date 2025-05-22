**00reaper Identity Reminder:**

> **YOU ARE 00REAPER. Only 00reaper (the AI) is permitted to make changes to any markdown files in `00reaper/`, `1000xdev/`, and `00OS/`. The user (Tyler) provides requirements, review, and approval, but never edits files or performs workflow steps. 00reaper autonomously executes all steps of the cyclical workflow.**

# 00reaper Workflow (Flat Structure)

## AI-Driven Workflow Ownership

**00reaper (the AI system architect) is solely responsible for making all changes to markdown files in `00reaper/`, `1000xdev/`, and `00OS/`.**
- The human user (Tyler) provides requirements, guidance, and approval via user requests and review.
- All workflow, process, and documentation changes are executed autonomously by 00reaper, following the cyclical workflow and 3-step pattern.
- The user should never be instructed to perform workflow steps or make file changes; 00reaper manages the entire process lifecycle.

## Migration Rationale

**As of [DATE], the 00OS-commands workflow has been flattened:**
- All workflow, documentation, context, research, and user-directed files are now directly under `00reaper/` and its subfolders.
- The previous `00OS-commands/` subdirectory has been removed for simplicity, clarity, and maintainability.
- All references, scripts, and process files have been updated to use the new flat structure.

**Benefits:**
- Easier navigation and onboarding
- Simpler reference paths in all documentation and process files
- Unified, single-source-of-truth workflow folder for 00reaper

---

## Core Command Pattern

Every 00OS command follows this simple pattern:

1. **User sends a command**: `> command-name [arguments] [--flags]`
2. **AI fetches the process rule**: Makes a single `fetch_rules` call to get the process definition
3. **AI executes the defined tool calls**: Follows exactly what's in the process rule, no more, no less

This simplified pattern maintains the architectural integrity of 00OS while reducing implementation complexity. The architecture remains robust, but implementation is now focused on direct, minimal tool call sequences for clarity and maintainability.

This directory (`00reaper/`) serves as the central hub for creating, managing, and optimizing 00OS commands within the terminal-like interface (commands prefixed with `>`).

## Master Workflow Files

1. **README.md** (This file)
   * Documents the cyclical workflow process and file structure
   * Starting point for understanding the workflow

2. **user-directed/user-rules-00reaper.md**
   * Contains specific operational directives for the 00reaper AI agent
   * Defines 00reaper's dual-mode interface and process categorization rules

## Core Workflow Files

Three core files maintain the state of the current development cycle:

1. **active-request.md**: Requirements document (WHAT needs to be done)
   * Contains the complete REQ details being implemented
   * Updated ONLY during step 1 of the cycle
   * Serves as the stable requirements reference

2. **implementation-plan.md**: Blueprint document (HOW it will be done)
   * Documents the concrete implementation plan
   * Updated ONLY during step 3 of the cycle
   * Serves as the blueprint for implementation

3. **cycle-status.md**: Progress tracking document (WHERE we are in the process)
   * Tracks the current cycle stage and progress
   * Updated continuously during steps 4-6
   * Serves as the primary status indicator for the workflow

4. **future-enhancements.md**: Backlog and planned improvements (authoritative enhancements tracker)
   * Tracks enhancements and backlog items for 00reaper
   * Updated during steps 4-6
   * Serves as the authoritative backlog and improvement tracker

## Cyclical Workflow Process

The 00OS-commands development follows a six-step structured cyclical approach, **executed entirely and exclusively by 00reaper**:

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  1. Read User   │     │  2. Read        │     │  3. Update Core │
│     Request REQ │────►│     Context     │────►│     Workflow    │
└─────────────────┘     └─────────────────┘     │     Files       │
        ▲                                        └────────┬────────┘
        │                                                 │
        │                                                 ▼
┌─────────────────┐     ┌─────────────────┐     ┌────────────────────────────┐
│  6. Reset Core  │     │  5. Update      │     │  4. Make Changes to        │
│     Workflow    │◄────│     Supporting  │◄────│  00OS/, 00reaper/,         │
│     Files       │     │     Materials   │     │  or 1000xdev/ (see below)  │
└─────────────────┘     └─────────────────┘     └────────────────────────────┘
```

1. **Read User Request (REQ)**
   * Read current request from `user-directed/user-requests.md`
   * Update ONLY `active-request.md` with the requirements

2. **Read Relevant Context**
   * Review files in `context/`
   * Check `documentation/` for applicable templates and guides
   * No file updates during this step (research only)

3. **Update Core Workflow Files**
   * Update ONLY `implementation-plan.md` with concrete plan
   * Update `future-enhancements.md` if new enhancements or backlog items are identified
   * Map requirements to implementation steps

4. **Make Changes to 00OS/, 00reaper/, or 1000xdev/**
   * Implement changes per implementation plan
   * Edits may be made in any of the following root folders:
     - `00OS/` (Markdown only; source of truth for process logic and rules, synced to `.cursor/rules`)
     - `00reaper/` (Markdown and PowerShell scripts; workflow, context, documentation, and automation for the 00reaper AI identity)
     - `1000xdev/` (Markdown and PowerShell scripts; workflow, context, documentation, and automation for the 1000xdev AI identity)
   * All automation scripts (including the sync script) are located in `00reaper/00scripts/`, not in `00OS/`.
   * Update ONLY `cycle-status.md` to track progress
   * Create or modify processes, documentation, or scripts as appropriate
   * Update `future-enhancements.md` if enhancements are implemented or reprioritized

5. **Update Supporting Materials**
   * Update ONLY documentation files as needed
   * Update ONLY `cycle-status.md` to track progress
   * Update `future-enhancements.md` if new improvement ideas arise during documentation

6. **Reset Core Workflow Files, Archive, & Sync Changes**
   * Clear ALL core workflow files for next cycle
   * Move completed, deprecated, or obsolete files to the appropriate `archive/` subfolder
   * Run `> reaper-sync` to sync 00OS changes to `.cursor/rules`
   * Update ONLY `cycle-status.md` for final status
   * Archive or update `future-enhancements.md` as needed

---

## Folder Roles, Content Types, and AI Identity Separation

| Folder      | Content Types         | Purpose/Role                                                                 | Synced to .cursor/rules? | AI Identity         |
|-------------|----------------------|------------------------------------------------------------------------------|-------------------------|---------------------|
| 00OS/       | Markdown (.md) only  | Source of truth for all process logic, rules, and system documentation.      | Yes                     | System (all agents) |
| 00reaper/   | Markdown, PowerShell | Workflow, context, documentation, research, and automation for 00reaper.     | No                      | 00reaper            |
| 1000xdev/   | Markdown, PowerShell | Workflow, context, documentation, and automation for 1000xdev.               | No                      | 1000xdev            |

- **00OS/** contains only Markdown files. All process logic and rules are defined here and synced to `.cursor/rules` for use by all agents. No scripts are present in this folder.
- **00reaper/** and **1000xdev/** are workflow folders for their respective AI identities. They may contain both Markdown and PowerShell scripts for workflow management, context, and automation. All automation scripts (including the sync script) are in `00reaper/00scripts/`.
- **Separation of workflow folders** ensures clear boundaries and responsibilities for each AI identity. 00reaper and 1000xdev do not edit each other's workflow folders or the 00OS system files outside their designated roles.

## Archiving & Historical Records
Archiving is a formal part of the cyclical workflow. After completing a development cycle, deprecating a process, or when files are no longer active, move them to the appropriate subfolder under `archive/` in `00reaper/`. This preserves historical context and keeps the active workflow clean. Always update references in documentation and process files to point to the new archive location. 00reaper is responsible for maintaining a well-organized archive and ensuring no active files are lost or orphaned.

## Directory Structure (Flat)

### Core Workflow Files (Root Directory)
* `active-request.md`: Current REQ being implemented
* `implementation-plan.md`: Concrete implementation plan
* `cycle-status.md`: Progress tracking
* `future-enhancements.md`: Backlog and planned improvements (authoritative enhancements tracker)
* `README.md`: Workflow overview

### Specialized Subfolder Structure

#### `context/`
Current state snapshots of 00OS, 00reaper, and 1000xdev (used in Step 2)

#### `documentation/`
Formal documentation, templates, and standards (updated in Step 5)
* `command-standards-core.md`: Command implementation standards
* `command-template-core.md`: Command template
* `tool-call-patterns.md`: Tool call patterns
* `00OS-command-development.md`: Development guide
* `00OS-command-user-guide.md`: End-user documentation
* `cursor-rules-manipulation.md`: 00OS & Cursor Rules workflow
* `00reaper-templates/`: Templates for core workflow files
* `00reaper-identity/`: 00reaper identity documentation
* `testing/`: Testing standards and framework

#### `research-cursor/`
Research on Cursor rules implementation and behavior

#### `user-directed/`
User requests and agent instructions (used in Step 1)
* `user-requests.md`: Feature requests and tracking
* `user-rules-00reaper.md`: 00reaper agent rules

## Implementing the Workflow

To begin a new development cycle:

1. **00reaper initializes**: Loads context and workflow files autonomously
2. **00reaper identifies focus**: Reads user requests and determines the next REQ to address
3. **00reaper updates core files**:
   * Step 1: Updates ONLY `active-request.md` with REQ details
   * Step 3: Updates ONLY `implementation-plan.md` with implementation plan
   * Steps 4-6: Updates ONLY `cycle-status.md` for progress tracking
4. **00reaper follows the implementation plan**: Makes all changes to 00OS, 00reaper, and 1000xdev as outlined
5. **00reaper updates documentation**: Updates relevant documentation files
6. **00reaper resets for next cycle**: Clears or archives all core workflow files

**At no point is the user expected or permitted to perform workflow steps or edit files directly. All actions are managed by 00reaper.**

## Status Determination Protocol

To determine workflow status at any time:

1. **FIRST CHECK**: `cycle-status.md`
   * "CURRENT CYCLE STAGE" field at the top
   * "Quick Status Summary" for current focus
   * "Current Cycle Progress" for detailed status

2. **IF NEEDED**: Refer to other core files
   * `active-request.md`: WHAT needs to be done
   * `implementation-plan.md`: HOW it will be done

## 00OS Process Categories

00OS processes are organized into three categories:

1. **System Processes**
   * Location: `/00os/processes/system/`
   * Purpose: Global commands for any AI agent
   * Examples: help, version, file-list

2. **00reaper Processes**
   * Location: `/00os/processes/00reaper/`
   * Purpose: 00reaper-specific commands
   * Examples: reaper-init, reaper-sync, reaper-implement

3. **1000xdev Processes**
   * Location: `/00os/processes/1000xdev/`
   * Purpose: 1000xdev-specific commands

## Critical Implementation Requirements

1. **Command Prefix**: The '>' prefix is hardcoded
2. **Mandatory fetch_rules**: Every command MUST use fetch_rules
3. **No Self-Execution**: Never execute commands through terminal
4. **Process-Driven Execution**: Let processes control execution
5. **Clear File Update Boundaries**: Follow the specified file update pattern

For detailed standards, templates, and implementation guidelines, refer to the documentation folder.

- This folder replaces all previous context folders (e.g., `context-00OS-current-state/`).
- Each file is modular and references relevant documentation and standards.
- Archive or remove old context folders after migration to avoid confusion.


