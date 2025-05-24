# Active Request

<!--
This file must ONLY contain the requirements for the current, in-progress cycle.
Do NOT include archived, future, or next requests here.
All other requests must go in planning/backlog.md or planning/archive/.
-->

# [REQ-2025-05-23] Align Workflow Files and Processes with New Template Directory

## Requirements
1. Update all process rules (e.g., reaper-init, reaper-plan) to reference and use templates from `00reaper/planning/templates/` instead of any previous locations.
2. Review and revise all four master workflow files (`00reaper-brain.md`, `README.md`, `user-rules-00reaper.md`, `.cursor/rules/00reaper-master.mdc`) to ensure:
   - All references to templates and workflow files are accurate and up to date
   - The current workflow structure and file locations are described correctly
   - No outdated paths or instructions remain
3. Update all process documentation, code comments, and usage examples to reflect the new directory structure and workflow protocols.
4. Test the updated processes (reaper-init, reaper-plan, cycle reset) to ensure correct operation and update any additional references as needed.
5. Log all actions and changes in `cycle-status.md` and archive the previous cycle as usual.

## Context References
- **Key Files**:
  - 00reaper/planning/templates/
  - 00reaper/00reaper-brain.md
  - 00reaper/README.md
  - 00reaper/user-rules-00reaper.md
  - .cursor/rules/00reaper-master.mdc
  - 00reaper/planning/active-request.md
  - 00reaper/cycle-status.md
  - 00OS/processes/00reaper/reaper-init.md
  - 00OS/processes/00reaper/reaper-plan.md

## REQ-002 (Enhanced): Implement `reaper-plan`, `reaper-implement`, and `reaper-proceed` Commands for Cyclical Workflow

### Objective
Design and implement three new 00OS commands—`reaper-plan`, `reaper-implement`, and `reaper-proceed`—to formalize, automate, and enforce the entire cyclical workflow process. These commands must enable clear, collaborative planning, seamless transition into implementation, and guided advancement through all workflow steps, reducing ambiguity and ensuring strict protocol adherence.

### Requirements

1. **Command Definitions & Purpose**
   - `> reaper-plan`: Initiates Step 1 of the cycle (Collaborative Planning). Prompts both the user and 00reaper to review, clarify, and finalize the active request in `planning/active-request.md` before implementation begins. Ensures all requirements are explicit, detailed, and unambiguous.
   - `> reaper-implement`: Initiates Step 2 of the cycle (Read Relevant Context & Begin Implementation). Triggers 00reaper to review all relevant context, documentation, and standards, and to prepare the implementation plan in `cycle-status.md`.
   - `> reaper-proceed`: Advances the workflow to the next logical step, or continues the current step if not yet complete. 00reaper must always respond with a clear status update, next actions, and whether it will remain in the current step or move forward. This command is the primary way to advance through the cycle after planning and implementation have begun.

2. **Protocols & Behavior**
   - All three commands must enforce the cyclical workflow and reference the 6-step process in all documentation and user prompts.
   - `reaper-plan` must require explicit user confirmation that the active request is clear and complete before allowing transition to `reaper-implement`.
   - `reaper-implement` must only proceed if `reaper-plan` has been completed and the active request is locked in.
   - `reaper-proceed` must always check the current step and status in `cycle-status.md`, and only advance if the current step is complete. If not, it must remain in the current step and explain why.
   - All commands must log all actions and transitions in `cycle-status.md`.
   - All planning and requirements gathering must occur in `planning/active-request.md` and `planning/final-goal.md`.
   - All implementation progress, actions, and blockers must be tracked exclusively in `cycle-status.md`.

3. **User/00reaper Collaboration**
   - The user (Tyler) provides requirements, review, and approval during `reaper-plan`.
   - 00reaper is solely responsible for executing all workflow steps and file changes during `reaper-implement` and beyond.
   - The transition from planning to implementation, and from each step to the next, must be explicit, logged, and confirmed.

4. **Acceptance Criteria**
   - All three commands are implemented as process rules in the appropriate 00reaper/system folder.
   - The commands enforce the cyclical workflow, strict planning/implementation boundaries, and solo developer context.
   - All actions and transitions are logged in `cycle-status.md`.
   - The user experience is clear, guided, and unambiguous at every step.
   - The system prevents accidental skipping of planning or implementation steps, and always makes the current workflow state explicit.

### References
- 6-Step Cyclical Workflow (see master workflow files)
- planning/active-request.md
- planning/final-goal.md
- cycle-status.md
- 00reaper-brain.md
- README.md
- user-rules-00reaper.md
- .cursor/rules/00reaper-master.mdc

---

# Active Request



### Next Set of Requests
## REQ-001: 00reaper/1000xdev Workflow Enhancement: Next Cycle Request
**Workflow Maintenance & Continuous Improvement**
- Perform cycle hygiene: archive and reset `cycle.md` and `active-request.md` using templates. This involves revising the instructions for Step 6. 
**This requires collaboration and planning between you and I to clearly document step 6, so that step 6 is clear**

- Review and refine all workflow templates and checklists in `documentation/`
- Review and prioritize items in the self-improvement backlog (in `cycle-status.md`)
- Review and update `00reaper-brain.md` and `1000xdev-brain.md` as needed
- Improve onboarding and reference documentation for both agents
- Review and update master cursor rules for clarity and accuracy
- Invite collaborative notes or additions for further workflow/system improvement

### REQ-003 Need clear instructions for step 6 to use templates.
Maybe we should move the template folder to planning? Let's think this out


---
# Archived Requests

## REQ-000 (Enhanced): Master Workflow File Alignment & Enforcement

### Objective
Ensure that the four master workflow files for the 00reaper system are perfectly aligned, explicit, and self-reinforcing, with strict operational boundaries and collaboration protocols. These files must serve as the single source of truth for all workflow, planning, and implementation standards.

### Master Workflow Files (All Must Align)
- 00reaper/00reaper-brain.md
- 00reaper/README.md
- 00reaper/user-rules-00reaper.md
- .cursor/rules/00reaper-master.mdc

### Core Workflow File
- cycle-status.md (root): The only file used to track progress, status, and actions during each implementation cycle.

### Strict Requirements

1. **Alignment & Consistency**
   - All four master workflow files must contain identical, up-to-date information regarding:
     - The cyclical workflow process (6 steps)
     - File and folder boundaries for all changes (only 00OS/, 00reaper/, 1000xdev/)
     - The planning and implementation protocol
     - The role and authority of 00reaper vs. the user (Tyler)
     - The use of cycle-status.md as the sole progress tracker

2. **Planning Protocol**
   - All planning and requirements gathering must occur in the 00reaper/planning/ folder.
   - Only two files are used for collaboration with the user:
     - active-request.md: Operational requirements for the current cycle
     - final-goal.md: Long-term vision and objectives
   - The process for copying, reviewing, and updating these files at the start of each cycle must be strict, stepwise, and clearly documented in all master workflow files.

3. **Implementation Protocol**
   - All implementation progress, actions, and blockers must be tracked exclusively in cycle-status.md.
   - No other file is to be used for progress tracking or status updates during a cycle.

4. **Operational Boundaries**
   - All changes during implementation must be strictly limited to the following directories:
     - 00OS/
     - 00reaper/
     - 1000xdev/
   - No changes are permitted outside these domains.

5. **Self-Reinforcement**
   - Each master workflow file must reference the others as authoritative sources.
   - The rules, boundaries, and protocols must be stated in a way that is unambiguous and leaves no room for misinterpretation.
   - Any update to one master workflow file must trigger a review and update of the others to maintain alignment.

6. **Cursor Rule Enforcement**
   - .cursor/rules/00reaper-master.mdc must always reflect the current, aligned state of the markdown sources.
   - The master cursor rule must be as strict and explicit as the markdown files.

7. **Solo Developer Context**
   - All documentation, rules, and protocols must assume a solo developer context (no teams, no external reviewers).

### Acceptance Criteria

- All four master workflow files are perfectly aligned and reference each other.
- The planning and implementation protocols are strict, stepwise, and unambiguous.
- Operational boundaries are clearly stated and enforced.
- The use of cycle-status.md as the sole progress tracker is explicit.
- The master cursor rule is always in sync with the markdown sources.
- No ambiguity or drift exists between the files.

---

# REQ-2025-05-23: Align Workflow Files and Processes with New Template Directory

## Requirements
1. Update all process rules (e.g., reaper-init, reaper-plan) to reference and use templates from `00reaper/planning/templates/` instead of any previous locations.
2. Review and revise all four master workflow files (`00reaper-brain.md`, `README.md`, `user-rules-00reaper.md`, `.cursor/rules/00reaper-master.mdc`) to ensure:
   - All references to templates and workflow files are accurate and up to date
   - The current workflow structure and file locations are described correctly
   - No outdated paths or instructions remain
3. Update all process documentation, code comments, and usage examples to reflect the new directory structure and workflow protocols.
4. Test the updated processes (reaper-init, reaper-plan, cycle reset) to ensure correct operation and update any additional references as needed.
5. Log all actions and changes in `cycle-status.md` and archive the previous cycle as usual.

## Context References
- **Key Files**:
  - 00reaper/planning/templates/
  - 00reaper/00reaper-brain.md
  - 00reaper/README.md
  - 00reaper/user-rules-00reaper.md
  - .cursor/rules/00reaper-master.mdc
  - 00reaper/planning/active-request.md
  - 00reaper/cycle-status.md
  - 00OS/processes/00reaper/reaper-init.md
  - 00OS/processes/00reaper/reaper-plan.md
- **Related Requests**:
  - Previous cycle: Template directory migration and workflow flattening