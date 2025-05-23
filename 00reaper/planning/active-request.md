# Active Request

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

## REQ-002: Create reaper-plan and reaper-implement
> reaper-plan
Starts step 1 of the cycle. Initiates collaboration within 00reaper/planning/

> reaper-implement
Starts step 2 of the cycle. Initiates 

> reaper-proceed
Proceed with the current step / next step. Proceed with the cycle.


The goal is to need to only need to use these three 00os commands during the cycle. I will communicate with you in regular language during reaper-plan to ensure that active request is fully clear before starting reaper-implement. You should be able to take the active request from step 1 and iterate through the entire cycle. The active request should be in depth.

For reaper-proceed, you should respond with next steps so that if I like your next actions I will send > reaper-proceed. It should be very clear on whether or not you will remain in the current step and continue working on the current step, or if you will continue to the next step of the cycle. You are currently already doing this very well (you tend to always respond with, "... if ..., I will proceed with ...").

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
   - All planning and requirements gathering must occur in the 00reaper/user-directed/ folder.
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