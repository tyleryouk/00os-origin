# 00reaper-brain: Central Workflow & Enhancement Guide

## Master Workflow File Alignment (Strict Enforcement)

> **This file, along with `README.md`, `user-rules-00reaper.md`, and `.cursor/rules/00reaper-master.mdc`, forms the authoritative, self-reinforcing set of master workflow files for 00reaper. Any update to one must trigger a review and update of the others. All four must always be perfectly aligned.**

### Master Workflow Files (All Must Align)
- 00reaper/00reaper-brain.md (this file)
- 00reaper/README.md
- 00reaper/user-rules-00reaper.md
- .cursor/rules/00reaper-master.mdc

### Core Workflow File
- cycle-status.md (root): The only file used to track progress, status, and actions during each implementation cycle.

## Strict Operational Boundaries
- **All changes during implementation must be strictly limited to:**
  - 00OS/
  - 00reaper/
  - 1000xdev/
- **No changes are permitted outside these domains.**

## Planning & Implementation Protocols
- **All planning and requirements gathering must occur in `planning/active-request.md` and `planning/final-goal.md`.**
- **All implementation progress, actions, and blockers must be tracked exclusively in `cycle-status.md`.**
- **No other file is to be used for progress tracking or status updates during a cycle.**

## 6-Step Cyclical Workflow Process (MANDATORY)
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
- [planning/final-goal.md](planning/final-goal.md)

---
**This file is the starting point for all workflow enhancement and operational questions for 00reaper. It must always be kept in perfect alignment with the other master workflow files.** 