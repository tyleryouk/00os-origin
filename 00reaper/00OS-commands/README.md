# 00OS-commands Workflow

This directory serves as the central hub for creating, managing, and optimizing 00OS commands within the terminal-like interface (commands prefixed with `>`).

## Master Workflow Files

1. **README.md** (This file)
   * Documents the cyclical workflow process and file structure
   * Starting point for understanding the workflow

2. **user-directed/user-rules-00OS-commands.md**
   * Contains specific operational directives for the 00reaper AI agent
   * Defines 00reaper's dual-mode interface and process categorization rules

## Core Workflow Files

Three core files maintain the state of the current development cycle:

1. **active-request.md**: Requirements document (WHAT needs to be done)
   * Contains the complete REQ details being implemented
   * Updated ONLY during step 1 of the cycle
   * Serves as the stable requirements reference

2. **implementation-plan.md**: Blueprint document (HOW it will be done)
   * Documents the concrete implementation plan
   * Updated ONLY during step 3 of the cycle
   * Serves as the blueprint for implementation

3. **cycle-status.md**: Progress tracking document (WHERE we are in the process)
   * Tracks the current cycle stage and progress
   * Updated continuously during steps 4-6
   * Serves as the primary status indicator for the workflow

## Cyclical Workflow Process

The 00OS-commands development follows a six-step structured cyclical approach:

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  1. Read User   │     │  2. Read        │     │  3. Update Core │
│     Request REQ │────►│     Context     │────►│     Workflow    │
└─────────────────┘     └─────────────────┘     │     Files       │
        ▲                                        └────────┬────────┘
        │                                                 │
        │                                                 ▼
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  6. Reset Core  │     │  5. Update      │     │  4. Make        │
│     Workflow    │◄────│     Supporting  │◄────│     Changes     │
│     Files       │     │     Materials   │     │     to 00OS     │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

1. **Read User Request (REQ)**
   * Read current request from user-directed/user_requests.md
   * Update ONLY active-request.md with the requirements

2. **Read Relevant Context**
   * Review files in context-00OS-current-state/
   * Check documentation/ for applicable templates and guides
   * No file updates during this step (research only)

3. **Update Core Workflow Files**
   * Update ONLY implementation-plan.md with concrete plan
   * Map requirements to implementation steps

4. **Make Changes to 00OS**
   * Implement changes per implementation plan
   * Update ONLY cycle-status.md to track progress
   * Create or modify processes in appropriate categories

5. **Update Supporting Materials**
   * Update ONLY documentation files as needed
   * Update ONLY cycle-status.md to track progress

6. **Reset Core Workflow Files & Sync Changes**
   * Clear ALL core workflow files for next cycle
   * Run `> reaper-sync` to sync 00OS changes to .cursor/rules
   * Update ONLY cycle-status.md for final status

## Directory Structure

### Core Workflow Files (Root Directory)
* **active-request.md**: Current REQ being implemented
* **implementation-plan.md**: Concrete implementation plan
* **cycle-status.md**: Progress tracking
* **README.md**: Workflow overview

### Specialized Subfolder Structure

#### `context-00OS-current-state/`
Current state snapshots of 00OS components (used in Step 2)

#### `documentation/`
Formal documentation, templates, and standards (updated in Step 5)
* `command-standards-core.md`: Command implementation standards
* `command-template-core.md`: Command template
* `tool-call-patterns.md`: Tool call patterns
* `00OS-command-development.md`: Development guide
* `00OS-command-user-guide.md`: End-user documentation
* `cursor-rules-manipulation.md`: 00OS & Cursor Rules workflow
* `00reaper-templates/`: Templates for core workflow files
* `00reaper-identity/`: 00reaper identity documentation
* `testing/`: Testing standards and framework

#### `research-cursor/`
Research on Cursor rules implementation and behavior

#### `user-directed/`
User requests and agent instructions (used in Step 1)
* `user-requests.md`: Feature requests and tracking
* `user-rules-00OS-commands.md`: 00reaper agent rules

## Implementing the Workflow

To begin a new development cycle:

1. **Initialize**: Run `> reaper-read-files 00reaper/00OS-commands` to load context
2. **Identify Focus**: Determine which REQ to address from user-requests.md
3. **Update Core Files**:
   * Step 1: Update ONLY active-request.md with REQ details
   * Step 3: Update ONLY implementation-plan.md with implementation plan
   * Steps 4-6: Update ONLY cycle-status.md for progress tracking
4. **Follow Implementation Plan**: Make changes to 00OS as outlined
5. **Update Documentation**: Update relevant documentation files
6. **Reset for Next Cycle**: Clear ALL core workflow files or archive them

## Status Determination Protocol

To determine workflow status at any time:

1. **FIRST CHECK**: cycle-status.md
   * "CURRENT CYCLE STAGE" field at the top
   * "Quick Status Summary" for current focus
   * "Current Cycle Progress" for detailed status

2. **IF NEEDED**: Refer to other core files
   * active-request.md: WHAT needs to be done
   * implementation-plan.md: HOW it will be done

## 00OS Process Categories

00OS processes are organized into three categories:

1. **System Processes**
   * Location: `/00os/processes/system/`
   * Purpose: Global commands for any AI agent
   * Examples: help, version, file-list

2. **00reaper Processes**
   * Location: `/00os/processes/00reaper/`
   * Purpose: 00reaper-specific commands
   * Examples: reaper-init, reaper-sync, reaper-implement

3. **1000xdev Processes**
   * Location: `/00os/processes/1000xdev/`
   * Purpose: 1000xdev-specific commands

## Critical Implementation Requirements

1. **Command Prefix**: The '>' prefix is hardcoded
2. **Mandatory fetch_rules**: Every command MUST use fetch_rules
3. **No Self-Execution**: Never execute commands through terminal
4. **Process-Driven Execution**: Let processes control execution
5. **Clear File Update Boundaries**: Follow the specified file update pattern

For detailed standards, templates, and implementation guidelines, refer to the documentation folder.


