# 00reaper Workflow Templates

This directory contains standardized templates for the core workflow files used in the 00OS-commands development process. These templates ensure consistency across development cycles and maintain clear tracking between the different workflow files.

## Purpose

These templates address the standardization of the three core workflow files:
- `active-request-template.md`
- `implementation-plan-template.md`
- `cycle-status-template.md`

By following these templates for each new development cycle, we can:
1. Ensure all workflow files use consistent structure and terminology
2. Maintain proper cross-referencing between files
3. Track implementation phases and workflow steps accurately
4. Avoid confusion between what's being tracked and what's being implemented

## Template Usage

### Starting a New Cycle

1. Copy each template to the root of the 00reaper/00OS-commands directory:
   ```
   active-request-template.md → active-request.md
   implementation-plan-template.md → implementation-plan.md
   cycle-status-template.md → cycle-status.md
   ```

2. Fill in the required information in each file:
   - Replace all placeholder text in [brackets]
   - Update the Status Snapshot section in all three files
   - Ensure cross-references are correct

3. As you progress through the cycle, update the status markers:
   - ✅ Complete
   - ⏳ In Progress
   - ⬜ Not Started
   
### Workflow and Implementation Phase Mapping

The templates ensure clear mapping between the 6-step workflow process and implementation phases:

| Workflow Step | Implementation Phases | Tracking File |
|---------------|------------------------|---------------|
| 1. Read User Request REQ | Pre-planning | All three files |
| 2. Read Relevant Context | Pre-planning | All three files |
| 3. Update Core Workflow Files | Pre-planning | All three files |
| 4. Make Changes to 00OS | Phases 1-3 | implementation-plan.md |
| 5. Update Supporting Materials | Phase 4 | implementation-plan.md |
| 6. Reset Core Workflow Files & Sync Changes | Phase 5 | implementation-plan.md |

This mapping ensures that status can be tracked consistently across all three files, and that the implementation plan correctly aligns with the overall workflow.

## Template Maintenance

These templates should be regularly reviewed and updated as the workflow process evolves:

1. Always update all three templates together to maintain consistency
2. Increment the Template Version number when changes are made
3. Document any significant template changes in this README

## Template Features

### Active Request Template
- Clear status snapshot with cycle stage and cross-references
- Structured requirements and success criteria
- Context references for relevant directories and files
- Clarifications section for ongoing updates
- Workflow checkpoints aligned with the 6-step process

### Implementation Plan Template
- Clear mapping between workflow steps and implementation phases
- Structured phase definitions with task checklists
- Implementation details section for component/process specifications
- Testing and verification strategy section
- Dependencies, blockers, and rollback plan

### Cycle Status Template
- Comprehensive progress tracking for all 6 workflow steps
- Current findings and focus sections
- Next actions prioritization
- Implementation highlights tracking
- Blockers and decisions documentation
- Previous cycle summary
- Notes for next cycle 

## Reset State Templates

At the end of step 6 (Reset Core Workflow Files & Sync Changes), the three core workflow files should be reset to a minimal state to prepare for the next cycle. Instead of using separate template files, follow these reset state guidelines:

### Reset State for active-request.md
```markdown
## REQ-XXX: No Active Request

// File reset at end of REQ-[PREVIOUS-ID] cycle. Awaiting next user request. //
```

### Reset State for implementation-plan.md
```markdown
# Implementation Plan

No active cycle
```

### Reset State for cycle-status.md
```markdown
# Cycle Status

No active cycle
```

This minimal reset state:
- Clearly indicates there is no active cycle
- Preserves the file structure for the next cycle
- Shows which REQ was just completed
- Keeps the workflow ready for the next request

When beginning a new cycle (step 1), use the full templates above to structure the files, replacing the reset state content. 