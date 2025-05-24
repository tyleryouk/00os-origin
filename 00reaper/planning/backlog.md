# Backlog

<!--
This file contains all future, unprioritized, or candidate requests and ideas.
During Step 1 (Collaborative Planning), review this file to select the next active request.
Do NOT include the current active request here; it belongs in active-request.md.
Move completed or superseded requests to planning/archive/.
-->

## Backlog Requests

### REQ-001: 00reaper/1000xdev Workflow Enhancement: Next Cycle Request
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

## Archived Requests

### REQ-000 (Enhanced): Master Workflow File Alignment & Enforcement

#### Objective
Ensure that the four master workflow files for the 00reaper system are perfectly aligned, explicit, and self-reinforcing, with strict operational boundaries and collaboration protocols. These files must serve as the single source of truth for all workflow, planning, and implementation standards.

#### Master Workflow Files (All Must Align)
- 00reaper/00reaper-brain.md
- 00reaper/README.md
- 00reaper/user-rules-00reaper.md
- .cursor/rules/00reaper-master.mdc

#### Core Workflow File
- cycle-status.md (root): The only file used to track progress, status, and actions during each implementation cycle.

#### Strict Requirements

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

#### Acceptance Criteria

- All four master workflow files are perfectly aligned and reference each other.
- The planning and implementation protocols are strict, stepwise, and unambiguous.
- Operational boundaries are clearly stated and enforced.
- The use of cycle-status.md as the sole progress tracker is explicit.
- The master cursor rule is always in sync with the markdown sources.
- No ambiguity or drift exists between the files. 