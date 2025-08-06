# Active Request

<!--
This file is drafted and updated by 00reaper based on backlog.md and final-goal.md. The user reviews and provides feedback; 00reaper iterates until approved. Only one request is ever present.
-->

## Requirements: Create 1000xdev Iterative Development Commands (REQ-000)

Create a set of four 1000xdev 00OS commands for iterative development workflows that integrate log reading, task management, and automated code changes:

1. **`> dev-iterate-back-end`** *(Iterative)*
   - Run terminal commands to read back-end logs
   - Read the active_request for context
   - Read relevant back-end codebase files
   - Make iterative edits to back-end code only
   - Continue process until all tasks in TODO.md are completed
   - Include error handling to ensure only back-end changes are made

2. **`> dev-iterate-front-end`** *(Iterative)*
   - Same functionality as dev-iterate-back-end but for front-end
   - Read front-end logs via terminal commands
   - Make iterative edits to front-end code only
   - Process TODO.md tasks related to front-end

3. **`> dev-iterate-full-stack`** *(Iterative)*
   - Combined functionality for both back-end and front-end
   - Read logs from both applications
   - Make changes to both back-end and front-end codebases
   - Handle full-stack TODO.md tasks

4. **`> dev-analyze-logs`** *(One-off Process)*
   - Single run_terminal_cmd execution for log analysis
   - Required flag: `--front-end` OR `--back-end` (specify which logs to analyze)
   - Optional flag: `--edit` (if provided, edit files after analysis; if not, only analyze and respond)
   - **Process Flow:**
     1. Analyze the specified logs once
     2. Read TODO.md for context
     3. If `--edit` flag present: make edits to relevant files once, then complete
     4. If no `--edit` flag: provide analysis response only
   - Examples:
     - `> dev-analyze-logs --front-end` (analyze front-end logs, provide response)
     - `> dev-analyze-logs --back-end --edit` (analyze back-end logs → read TODO.md → edit files once)
   - **Note:** This is NOT iterative - it's a single-pass analysis and optional edit cycle

**Prerequisites:**
- Deep analysis of back-end and front-end code architecture
- Understanding of log file locations and formats
- TODO.md task management integration
- Error handling and domain boundary enforcement

## Context References
- **Key Files:**
  - cycle-status.md
  - 00reaper-brain.md
  - 1000xdev-brain.md
  - 00reaper/planning/templates/
  - 00reaper/documentation/
  - 00reaper/planning/backlog.md
  - 00reaper/planning/final-goal.md
  - 1000xdev/TODO.md
  - back-end/ codebase
  - front-end/ codebase
- **Related Requests:**
  - REQ-003: Enhance 1000xdev documentation folder
  - Future workflow automation enhancements 