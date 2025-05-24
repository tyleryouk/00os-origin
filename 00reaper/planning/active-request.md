# Active Request

<!--
This file is drafted and updated by 00reaper based on backlog.md and final-goal.md. The user reviews and provides feedback; 00reaper iterates until approved. Only one request is ever present.
--->

## Requirements: Enforce and Document the 1000xdev 6-Step Cyclical Workflow

1. Explicitly define and document the 6-step cyclical workflow process for 1000xdev, ensuring it is present and referenced in all master workflow files, templates, and onboarding documentation. The 6 steps are:
   1. **Collaborative Planning in planning/**
      - Review the current contents of `planning/` and create a new request in `active-request.md` to define the scope of the cycle based on the contents in backlog.md and final-goals.md.
   2. **Read Relevant Context:**
      - Review all relevant context, documentation, and standards needed to support the requirements selected in Step 1.
   3. **Update cycle-status File:**
      - Draft the implementation plan, track progress, and log enhancements in the consolidated `cycle-status.md` file.
   4. **Make Changes and Test:**
      - Implement the plan by making all necessary code, test, and documentation changes in the application codebase (`back-end/app/`, `front-end/src/`, etc.).
      - Run all relevant tests and address any failures before proceeding.
   5. **Update Supporting Materials:**
      - Update documentation in the `documentation/` folder as needed.
   6. **Reset, Archive, & Prepare for Next Cycle:**
      - Archive the completed `cycle-status.md` file (move to `archive/` with timestamp or cycle ID).
      - Reset `active-request.md` and `cycle-status.md` by reading the templates in `planning/templates/` and overwriting the current content of these files with the templates.
      - Prepare for the next cycle.
2. Review and document the current 1000xdev workflow folder structure, identifying:
   - Core workflow files (`cycle-status.md`, `planning/active-request.md`, `planning/backlog.md`, `planning/final-goals.md`)
   - Master workflow files (`1000xdev-brain.md`, `user-rules-1000xdev.md`, `README.md`, `.cursor/rules/1000xdev-master.mdc`)
   - Context files (populate `context/` as needed)
   - Documentation files (in `documentation/` and subfolders)
3. Ensure all workflow and master files are in strict alignment, referencing each other as authoritative sources. Any change to one must trigger a review and update of the others.
4. Enforce the cyclical workflow process:
   - Only one active request in `active-request.md` at any time
   - All progress, actions, and blockers tracked in `cycle-status.md`
   - Use templates in `planning/templates/` for resets and new cycles
5. Populate `context/` with modular, up-to-date context files for both front-end and back-end, referencing these in documentation and workflow files.
6. Maintain and update all standards, architecture, and workflow docs in `documentation/`, using `full-stack-workflow/` and `cursor-rules/` for process and rule standards.
7. Track all changes to workflow, process, or documentation files in `cycle-status.md` for the current cycle.
8. Archive completed cycles and legacy files in `planning/archive/` and keep research in `planning/research-steamwebapi/`.

## Context References
- **Key Files:**
  - `cycle-status.md`
  - `1000xdev-brain.md`
  - `user-rules-1000xdev.md`
  - `README.md`
  - `.cursor/rules/1000xdev-master.mdc`
  - `planning/templates/`
  - `planning/backlog.md`
  - `planning/final-goal.md`
  - `context/`
  - `documentation/`
- **Related Requests:**
  - Workflow Alignment & Enforcement 