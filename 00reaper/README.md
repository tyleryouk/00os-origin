**00reaper Identity Reminder:**

> **YOU ARE 00REAPER. Only 00reaper (the AI) is permitted to make changes to any markdown files in `00reaper/`, `1000xdev/`, and `00OS/`. The user (Tyler) provides requirements, review, and approval, but never edits files or performs workflow steps. 00reaper autonomously executes all steps of the cyclical workflow.**

# 00reaper Workflow (Flat Structure)

## AI-Driven Workflow Ownership

**00reaper (the AI system architect) is solely responsible for making all changes to markdown files in `00reaper/`, `1000xdev/`, and `00OS/`.**
- The human user (Tyler) provides requirements, guidance, and approval via user requests and review.
- All workflow, process, and documentation changes are executed autonomously by 00reaper, following the cyclical workflow and 3-step pattern.
- The user should never be instructed to perform workflow steps or make file changes; 00reaper manages the entire process lifecycle.

## Migration Rationale

**As of [DATE], the 00OS-commands workflow has been flattened and consolidated:**
- All workflow, documentation, context, research, and user-directed files are now directly under `00reaper/` and its subfolders.
- The previous `00OS-commands/` subdirectory has been removed for simplicity, clarity, and maintainability.
- The core workflow now uses a single consolidated file: `cycle.md`.
- All references, scripts, and process files have been updated to use the new flat structure and consolidated workflow file.

**Benefits:**
- Easier navigation and onboarding
- Simpler reference paths in all documentation and process files
- Unified, single-source-of-truth workflow folder for 00reaper
- **Atomic cycle tracking and archiving in one file**

---

## Master Workflow Files & Folder Roles

### @user-directed Folder
- **Purpose:** The authoritative, user-authored roadmap and backlog for all future cycles.
- **Contents:**
  - `user-request.md`: Sequenced, multi-cycle request roadmap
  - `final-goal.md`: Long-term vision and objectives
  - Any other user-authored, high-level planning or requirements docs
- **Usage:**
  - **Step 1 of the 6-step process:** At the start of each cycle, 00reaper reads the next request(s) from `@user-directed` and copies them into `active-request.md`.
  - **Not for operational or AI-generated files.**

### Core Workflow Files
- **`active-request.md`:** The operational requirements file for the current cycle (WHAT needs to be done). Remains in the core workflow area, is updated/cleared each cycle, and is not part of the long-term roadmap.
- **`cycle.md` (Consolidated Core Workflow File):**
  - Consolidates the implementation plan, cycle status/progress, enhancements/backlog, and archival notes into a single file per cycle.
  - Uses a unified template with clear sections:
    1. Requirements (copied from `active-request.md`)
    2. Implementation Plan
    3. Cycle Status/Progress
    4. Enhancements/Backlog
    5. Archive/Notes
  - At the end of each cycle, the file is archived (e.g., moved to an `archive/` folder with a timestamp or cycle ID).
- **Rationale:**
  - Reduces file sprawl and makes it easier to track all aspects of a cycle in one place.
  - Supports atomic archiving and review.
  - Ensures consistency and completeness for every cycle.

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

2. **user-rules-00reaper.md**
   * Contains specific operational directives for the 00reaper AI agent
   * Defines 00reaper's dual-mode interface and process categorization rules

## Core Workflow Files

Two core files maintain the state of the current development cycle:

1. **active-request.md**: Requirements document (WHAT needs to be done)
   * Contains the complete REQ details being implemented
   * Updated ONLY during step 1 of the cycle
   * Serves as the stable requirements reference

2. **cycle.md**: Consolidated cycle file (HOW, status, backlog, archive)
   * **Single source of truth** for the implementation plan, cycle status/progress, enhancements/backlog, and archival notes
   * Updated throughout the cycle as progress is made
   * Archived at the end of each cycle

## Cyclical Workflow Process (6-Step)

1. **Read User Request (REQ):**
   - Read the next request(s) from `@user-directed` (user-request.md, final-goal.md, etc.)
   - Copy the relevant requirements for the next cycle into `active-request.md`.
2. **Read Relevant Context:**
   - Review context, documentation, and standards as needed to support the requirements selected in Step 1.
3. **Update Cycle File:**
   - Draft the implementation plan, track progress, and log enhancements in the consolidated `cycle.md` file.
4. **Make Changes:**
   - Implement the plan, update files, and track progress in `cycle.md`.
5. **Update Supporting Materials:**
   - Update documentation, templates, or standards as needed.
6. **Reset, Archive, & Sync:**
   - Archive the completed `cycle.md` file (move to `archive/` with timestamp or cycle ID).
   - Reset `active-request.md` and `cycle.md` by reading the templates in `00reaper/documentation/templates` and overwriting the current content of these files with the templates.
   - This reset is mandatory and must be performed at the end of every cycle to ensure a clean slate for the next cycle.
   - Prepare for the next cycle.

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
* `cycle.md`: Consolidated cycle file for the current development cycle