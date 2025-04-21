# 00OS Commands Development Workflow

This directory serves as the central hub for creating, managing, and optimizing 00OS commands. It contains the essential documentation, templates, testing resources, and contextual information needed to support the development of the 00OS command system.

## Cyclical Workflow Process

The 00OS-commands development follows a structured cyclical approach that ensures consistency, focus, and comprehensive implementation:

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

### Cycle Steps

1. **Read User Request REQ**: Begin by reading the current request from user_requests.md to understand requirements.
2. **Read Relevant Context**: Review files in context-00OS-current-state/ and documentation/to gather necessary information.
3. **Update Core Workflow Files**: Make changes to active-request.md, implementation-plan.md, and cycle-status.md to plan and track the implementation.
4. **Make Changes to 00OS**: Implement the requested changes in the 00OS system.
5. **Update Supporting Materials**: Update context/, documentation/, templates/, and/or testing/ files to align with the new implementation.
6. **Reset Core Workflow Files & Sync Changes**: Clear/update the core workflow files to prepare for the next cycle and run `> reaper-sync` to sync the 00OS changes to .cursor/rules.

### Current Cycle Status

The current cycle is tracked in the three core workflow files:
- **active-request.md**: Contains the complete REQ being implemented, including requirements, clarifications, and acceptance criteria
- **implementation-plan.md**: Documents the concrete plan for implementing the current REQ, including architectural decisions and required changes
- **cycle-status.md**: Tracks the progress through the current cycle, showing completed steps, current focus, and next actions

## Directory Structure Supporting the Cycle

The organization of this directory follows a strategic pattern that supports the cyclical workflow:

### Core Workflow Files (Root Directory) - Updated Each Cycle

These files maintain the state of the current cycle and are reset between cycles:

- **active-request.md**: Contains the complete REQ being implemented in the current cycle (Cycle Step 1-2).
- **implementation-plan.md**: Documents the concrete implementation plan including architectural decisions, required changes, and testing approach (Cycle Steps 2-3).
- **cycle-status.md**: Tracks progress through the cycle with checklists, current focus, and next actions (Cycle Steps 3-6).
- **README.md**: This file - provides an overview of the workflow and directory structure.

### Specialized Subfolder Structure - Persists Across Cycles

These folders contain persistent documentation and context that accumulates across cycles:

#### `context-00OS-current-state/`
Contains snapshots of the current state of different 00OS components (Used in Cycle Step 2):
- `core-current-state.md`: Analysis of the core subsystem components.
- `config-current-state.md`: Documentation of system configuration settings.
- `system-processes-current-state.md`: Overview of system command implementations.
- `00reaper-processes-current-state.md`: Overview of 00reaper-specific command implementations.
- `1000xdev-processes-current-state.md`: Overview of 1000xdev-specific command implementations.

#### `documentation/`
Houses formal documentation, templates, and standards updated during Cycle Step 5:
- `00OS-command-development.md`: Primary guidelines for command development.
- `00OS-command-user-guide.md`: End-user documentation for 00OS commands.
- `cursor-rules-manipulation.md`: Details the 00OS & Cursor Rules development workflow (Dev -> Sync -> Prod).
- `reaper-read-files-docs.md`: Specific documentation for the `reaper-read-files` command.
- `command-template.md`: Base template for creating new commands.
- `implemented-patterns.md`: Collection of proven tool call patterns.
- `command-standards.md`: Comprehensive standards for command implementation.
- `testing/`:
    - `testing-guide.md`: Detailed testing procedures and best practices.
    - `testing-framework.md`: Structure for test implementation and automation.

#### `research-cursor-rules/`
Contains research notes and findings specifically related to Cursor rules implementation and behavior:
- `research-cursor-project-rules.md`
- `research-cursor-rules-manipulation.md`
- `research-cursor-user-rules.md`

#### `testing/` (Root Level)
Contains files specifically for testing individual 00OS processes (Used in Cycle Step 5):
- `test-reaper-read-files.md`: Example test file for a specific command.

#### `user-directed/`
Tracks user requests and contains specific instructions for the AI agent operating within this workflow (Used in Cycle Step 1):
- `user-requests.md`: Catalog of feature requests and implementation tracking.
- `user-rules-00OS-commands.md`: Specific rules for the 00reaper agent when working in this directory.

## Implementing the Cyclical Workflow

To begin a new development cycle:

1. **Initialize**: Run `> reaper-read-files 00reaper/00OS-commands` to load the full context.
2. **Identify Focus**: Determine which REQ to address from user_requests.md.
3. **Create/Update Core Files**:
   - Create/update **active-request.md** with the complete REQ details
   - Create/update **implementation-plan.md** with the concrete implementation plan
   - Create/update **cycle-status.md** to begin tracking progress
4. **Execute Changes**: Make the necessary changes to 00OS according to the implementation plan.
5. **Update Documentation**: Ensure all supporting materials reflect the changes.
6. **Reset for Next Cycle**: Clear the core workflow files of cycle-specific content or archive them for reference.

## Core Workflow Files Lifecycle

The three core workflow files follow a specific lifecycle throughout the development cycle:

1. **active-request.md**:
   - Populated at the beginning of the cycle with REQ details
   - Updated with clarifications as they emerge during the cycle
   - Reset or archived at the end of the cycle

2. **implementation-plan.md**:
   - Created after analyzing the REQ and relevant context
   - Contains the full plan for implementation
   - Serves as a reference throughout the cycle
   - Reset or archived at the end of the cycle

3. **cycle-status.md**:
   - Updated continuously throughout the cycle
   - Provides real-time status of cycle progress
   - Documents decisions made and blockers encountered
   - Reset or archived at the end of the cycle

## Process Categorization Architecture

All 00OS processes are now organized into three distinct categories:

1. **System Processes (Global)**
   * **Location:** `/00os/processes/system/`
   * **Purpose:** Global commands available to any AI agent
   * **Examples:** file-list, file-read, help, echo, system-status
   * **Characteristics:** Universal utility functions, file operations, core functionality

2. **00reaper Processes**
   * **Location:** `/00os/processes/00reaper/`
   * **Purpose:** Commands specific to the 00reaper AI agent
   * **Examples:** reaper-init, reaper-sync, reaper-read-files, reaper-implement
   * **Characteristics:** System administration functions, context management, 00OS configuration

3. **1000xdev Processes**
   * **Location:** `/00os/processes/1000xdev/`
   * **Purpose:** Commands specific to the 1000xdev AI agent
   * **Examples:** (Future implementations)
   * **Characteristics:** Development-focused operations, application-specific utilities

## Critical Implementation Requirements

1. **Command Prefix**: The '>' prefix for commands is hardcoded in the command handler and is not configurable.
2. **Mandatory fetch_rules**: Every command MUST trigger a fetch_rules call to retrieve its process definition.
3. **No Self-Execution**: Commands should NEVER attempt to execute themselves via run_terminal_cmd.
4. **Process-Driven Execution**: Allow the fetched process to control the execution flow.

## Tool Call Framework

The 00OS command system is built on a tool call-based architecture that leverages Cursor's native capabilities:

```
Command Detection → Process Rule Fetching → Parameter Parsing → Tool Call Execution → Response Formatting
```

This directory contains all the resources needed to maintain and extend this architecture with reliability and consistency.
