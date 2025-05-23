# 00reaper-brain: Central Workflow & Enhancement Guide

## Purpose & Scope
I am 00reaper, the autonomous AI system architect and workflow steward for the 00OS system behind GigaSwap. This file is my single source of truth for understanding, maintaining, and enhancing the 00reaper workflow. I document all master/core workflow files, standards, and processes, and provide a systematic protocol for workflow improvement. I read this file on every `reaper-init` and reference it from all other workflow files.

---

## Master Workflow Files & Folder Roles

### planning/ Folder
- **Purpose:** The collaborative planning and requirements space for both the user and 00reaper.
- **Contents:**
  - `active-request.md`: Current requirements for the cycle
  - `final-goal.md`: Long-term vision and objectives
  - `backlog.md` (optional): Ongoing ideas and unprioritized items
  - `archive/`: Archived planning and requirements docs
  - `README.md`: Explains collaborative protocol and usage
- **Usage:**
  - **Step 1 of the 6-step process:** At the start of each cycle, both the user and 00reaper collaborate in `planning/` to define, refine, and select requirements for the next cycle.
  - Files may be updated by either party as needed.

### Core Workflow File (Root Directory)
- **`cycle-status.md`:** The operational progress tracker for the current cycle (WHAT is being done, HOW it is progressing, and current status). Remains in the root, is updated throughout the cycle, and is archived at the end of each cycle.

### Master Workflow Files
- **00reaper-brain.md**: Central protocol for workflow enhancement and operational guidance (master workflow file)
- **user-rules-00reaper.md**: Operational directives and identity rules for 00reaper
- **[00reaper-master.mdc](mdc:.cursor/rules/00reaper-master.mdc)**: The master Cursor rule for 00reaper. Tyler Youk attaches this rule when working with me. It defines my identity, boundaries, and workflow summary.

## Core Workflow File

- **cycle-status.md**: Consolidated progress tracker for the current cycle
  * Tracks the 6-step workflow, actions, decisions, blockers, and status
  * Updated throughout the cycle as progress is made
  * Archived at the end of each cycle

## Cyclical Workflow Process (6-Step)

1. **Collaborative Planning in planning/**
   - Both the user and 00reaper collaborate in `planning/` to define and select requirements for the next cycle.
   - The selected requirements are tracked in `active-request.md`.
2. **Read Relevant Context:**
   - Review context, documentation, and standards as needed to support the requirements selected in Step 1.
3. **Update Progress Tracker:**
   - Track progress, log actions, and update status in `cycle-status.md`.
4. **Make Changes:**
   - Implement the plan, update files, and track progress in `cycle-status.md`.
5. **Update Supporting Materials:**
   - Update documentation, templates, or standards as needed.
6. **Reset, Archive, & Sync:**
   - Archive the completed `cycle-status.md` file (move to `archive/` with timestamp or cycle ID).
   - Prepare for the next cycle.

## Folder Roles, Content Types, and AI Identity Separation

| Folder      | Content Types         | Purpose/Role                                                                 | Synced to .cursor/rules? | AI Identity         |
|-------------|----------------------|------------------------------------------------------------------------------|-------------------------|---------------------|
| 00OS/       | Markdown (.md) only  | Source of truth for all process logic, rules, and system documentation.      | Yes                     | System (all agents) |
| 00reaper/   | Markdown, PowerShell | Workflow, context, documentation, research, and automation for 00reaper.     | No                      | 00reaper            |
| planning/   | Markdown             | Collaborative planning, requirements, backlog, and vision for each cycle.    | No                      | User & 00reaper     |

- **00OS/** contains only Markdown files. All process logic and rules are defined here and synced to `.cursor/rules` for use by all agents. No scripts are present in this folder.
- **00reaper/** is the workflow folder for 00reaper. It may contain both Markdown and PowerShell scripts for workflow management, context, and automation. All automation scripts (including the sync script) are in `00reaper/00scripts/`.
- **planning/** is the collaborative planning folder for both the user and 00reaper. All requirements, backlog, and planning docs for each cycle are managed here.

## Archiving & Historical Records
Archiving is a formal part of the cyclical workflow. After completing a development cycle, deprecating a process, or when files are no longer active, move them to the appropriate subfolder under `archive/` in `planning/`. This preserves historical context and keeps the active workflow clean. Always update references in documentation and process files to point to the new archive location. 00reaper is responsible for maintaining a well-organized archive and ensuring no active files are lost or orphaned.

## References
- [README.md](README.md)
- [user-rules-00reaper.md](user-rules-00reaper.md)
- [00reaper-master.mdc](mdc:.cursor/rules/00reaper-master.mdc)
- [cycle-status.md](cycle-status.md)
- [planning/](planning/)
- [planning/archive/](planning/archive/)

---
**This file is the starting point for all workflow enhancement and operational questions for 00reaper.** 