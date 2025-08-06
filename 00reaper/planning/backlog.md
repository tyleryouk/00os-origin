# Backlog

<!--
This file contains all future, unprioritized, or candidate requests and ideas.
During Step 1 (Collaborative Planning), review this file to select the next active request.
Do NOT include the current active request here; it belongs in active-request.md.
Move completed or superseded requests to planning/archive/.
-->

## Backlog Requests

### REQ-000
Highest priority:
Create a set of 1000xdev 00commands. These processes will include tool calls to run terminal commands to read the front-end and back-end logs. The tool calling processes should be strict and should be for step 4 of the cycle. 

00OS command `> dev-iterate-back-end`
This command will run a terminal command read the back-end logs, read the active_request, then read relevant files in the codebase and make edits. This will be an iterative process in which 1000xdev will continue to run terminal commands for the back-end until all tasks in the TODO.md are done. The TODO.md must contain tasks for the back-end application, and only code changes to the back-end application may be made. There must be some type of error handling to ensure that only back-end code changes and back-end terminal commands are made.

00OS command `> dev-iterate-front-end`
This command will be the same as dev-iterate-back-end but for iterative terminal commands to view the front-end logs along with changes to the front-end

00OS command `> dev-iterate-full-stack`
This command will be like dev-iterate-back-end and dev-iterate-front-end, except 1000xdev will be making terminal commands to view the logs of both the back-end and front-end and making changes to the back-end and front-end respectively.

You need to deeply analyze the code for back-end and front-end to understand the architecture before making these tool call 00OS processes.

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

### REQ-006
Create dev-implement and dev-proceed for 1000xdev.
