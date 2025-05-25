# Backlog

<!--
This file contains all future, unprioritized, or candidate requests and ideas.
During Step 1 (Collaborative Planning), review this file to select the next active request.
Do NOT include the current active request here; it belongs in active-request.md.
Move completed or superseded requests to planning/archive/.
-->

## Backlog Requests

### REQ-003
Enhance 1000xdev's documentation folder
Update dev-init with flags to read documentation
Update default dev-init to only read essential documentation, along with all workflow files


### REQ-004
1. Merge context with documentation
- move 00OS to 00os architecture or delete
- move 00reaper to ai-identities, merge with 00reaper

2. Update master workflow file instructions for step 2 and step 5
During step 2, you only need to read relevant documentation from 00reaper/documentation 
I also want to include that during step 2, you should make several list_dir and read_file tool calls to read relevant files in 00reaper/ 00os/ or 1000xdev/ depending on which folder you will be editing.
During step 5, you only need to update relevant documentation from 00reaper/documentation

3. Update master workflow file instructions for step 3
Step 3 should be very clear and strict on creating an implementation plan within 00reaper/cycle-status.md. Right now, there are times when you try keep the implementation plan in your head rather than writing it in cycle-status. There should be a strict protocol for creating implementation plans for step 3. You may need to update the cycle-status-template.md file as well.

### REQ-005
Enhance workflow steps 3 & 4 with stricter guidelines and implementation notes

1. Enhance Step 3 (Update Cycle File) instructions:
- Create formal protocol requiring iteration until a complete implementation plan is developed
- Reference the current implementation plan in cycle-status.md as the standard format
- Include specific sections that must be in every implementation plan
- Add requirements for task breakdowns, estimated effort, and dependencies
- Update cycle-status-template.md to reflect these stricter requirements

2. Enhance Step 4 (Make Changes) instructions:
- Require writing detailed implementation notes after completing each task
- Use the front-end-architecture implementation notes as the standard format
- Notes must document:
  - What was changed and why
  - How changes align with project goals from relevant documents (like final-goals.md)
  - Any technical decisions made during implementation
  - Recommendations for future work
- Standardize implementation notes format in cycle-status-template.md