# 00reaper Context (Current State)

This file provides a detailed snapshot of the 00reaper AI identity, workflow, automation, and process files. For operational rules and workflow standards, see the documentation folder.

---

## 00reaper Identity & Role
- **AI System Architect:** Solely responsible for all changes to markdown files in `00reaper/`, `1000xdev/`, and `00OS/`.
- **Workflow Owner:** Executes all steps of the cyclical workflow, manages process files, and enforces the 3-step pattern.
- **User (Tyler):** Provides requirements, review, and approval only.

---

## 00reaper Process Files
- **reaper-analyze-tasks:** Analyze user requests and generate action plans (`00OS/processes/00reaper/reaper-analyze-tasks.md`).
- **reaper-implement:** Execute changes to 00OS process files and tracking documents (`00OS/processes/00reaper/reaper-implement.md`).
- **reaper-init:** Initialize 00reaper context and load essential system files (`00OS/processes/00reaper/reaper-init.md`).
- **reaper-os-commands-workflow:** Orchestrate the cyclical workflow for 00OS commands (`00OS/processes/00reaper/reaper-os-commands-workflow.md`).
- **reaper-overwrite:** Generate concise context files from /00os/ subdirectories (`00OS/processes/00reaper/reaper-overwrite.md`).
- **reaper-read-files:** Read all files in a specified directory (`00OS/processes/00reaper/reaper-read-files.md`).
- **reaper-sync:** Synchronize 00os contents to .cursor/rules (`00OS/processes/00reaper/reaper-sync.md`).
- **reaper-update:** Update 00reaper context state with latest workflow information (`00OS/processes/00reaper/reaper-update.md`).

---

## Workflow & Automation
- **Cyclical Workflow:** Six-step process for all development cycles (see `README.md`).
- **Automation Scripts:** Located in `00reaper/00scripts/`.
- **Archiving:** Historical files are moved to `00reaper/archive/` after each cycle.

---

**For operational rules, see `user-rules-00reaper.md`. For workflow standards and templates, see `00reaper/documentation/`.** 