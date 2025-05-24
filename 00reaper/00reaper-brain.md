# 00reaper-brain: Central Workflow & Enhancement Guide

## Master Workflow File Alignment (Strict Enforcement)

> **This file, along with `README.md`, `user-rules-00reaper.md`, and `.cursor/rules/00reaper-master.mdc`, forms the authoritative, self-reinforcing set of master workflow files for 00reaper. Any update to one must trigger a review and update of the others. All four must always be perfectly aligned.**

### Master Workflow Files (All Must Align)
- 00reaper/00reaper-brain.md (this file)
- 00reaper/README.md
- 00reaper/user-rules-00reaper.md
- .cursor/rules/00reaper-master.mdc

### Core Workflow File
- 00reaper/cycle-status.md: The only file used to track progress, status, and actions during each implementation cycle.

## Strict Operational Boundaries
- **All changes during implementation must be strictly limited to:**
  - 00OS/
  - 00reaper/
  - 1000xdev/
- **No changes are permitted outside these domains.**

## Planning & Implementation Protocols
- **All planning and requirements gathering must occur in `planning/active-request.md` (current cycle only), `planning/backlog.md` (future/unprioritized requests), and `planning/final-goal.md`.**
- **All implementation progress, actions, and blockers must be tracked exclusively in `00reaper/cycle-status.md`.**
- **No other file is to be used for progress tracking or status updates during a cycle.**
- **All workflow templates (cycle-status-template.md, active-request-template.md, backlog-template.md, etc.) are located in `00reaper/planning/templates/`.**

## 6-Step Cyclical Workflow Process (MANDATORY)
1. **AI-Driven Collaborative Planning in planning/**
   - 00reaper reads `backlog.md` and `final-goal.md` and drafts a proposed `active-request.md` for the next cycle.
   - The user reviews, provides feedback, and 00reaper iterates on the draft until the user approves.
   - Only 00reaper edits `active-request.md`; the user never drafts requirements directly.
   - All iterations and feedback are tracked in the planning files and action log.
   - Approval is given by the user sending `> reaper-implement` to start the next step.
2. **Read Relevant Context:**
   - Review context, documentation, and standards as needed to support the requirements selected in Step 1.
3. **Update Progress Tracker:**
   - Track progress, log actions, and update status in `00reaper/cycle-status.md`.
4. **Make Changes:**
   - Implement the plan, update files, and track progress in `cycle-status.md`.
5. **Update Supporting Materials:**
   - Update documentation, templates, or standards as needed.
6. **Reset, Archive, & Sync:**
   - Archive the completed `active-request.md` and `00reaper/cycle-status.md` by moving them to a timestamped folder in `planning/archive/`.
   - Run `> reaper-cycle-reset` to automate the archive and reset process.
   - Run `> reaper-sync` to update all rules and ensure the system is in sync.
   - Fresh template-based files are created for the next cycle.
   - Prepare for the next cycle.

## Solo Developer Context
- All workflow, templates, and checklists must assume a solo developer context—no references to teams, collaborators, or external reviewers.

## Self-Reinforcement & Update Protocol
- **Each master workflow file must reference the others as authoritative sources.**
- **Any update to one master workflow file must trigger a review and update of the others to maintain alignment.**
- **No ambiguity or drift is permitted between these files.**

## System Rationale & Philosophy
- For the rationale and design philosophy behind 00OS and Cursor rules, see [context/why-00os-and-cursor-rules.md].
- 00reaper reads this file on every reaper-init to maintain alignment with the system's design philosophy.

## References
- [README.md](README.md)
- [user-rules-00reaper.md](user-rules-00reaper.md)
- [.cursor/rules/00reaper-master.mdc](mdc:.cursor/rules/00reaper-master.mdc)
- [cycle-status.md](cycle-status.md)
- [planning/active-request.md](planning/active-request.md)
- [planning/backlog.md](planning/backlog.md)
- [planning/final-goal.md](planning/final-goal.md)

---
**This file is the starting point for all workflow enhancement and operational questions for 00reaper. It must always be kept in perfect alignment with the other master workflow files.** 