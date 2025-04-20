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
2. **Read Relevant Context**: Review files in context/, documentation/, templates/, and/or testing/ directories to gather necessary information.
3. **Update Core Workflow Files**: Make changes to current-implementation.md, current-task.md, and major-changes.md to plan the implementation.
4. **Make Changes to 00OS**: Implement the requested changes in the 00OS system.
5. **Update Supporting Materials**: Update context/, documentation/, templates/, and/or testing/ files to align with the new implementation.
6. **Reset Core Workflow Files**: Clear/update the core workflow files to prepare for the next cycle.

### Current Cycle Status

The current cycle is tracked in the three core workflow files:
- **current-task.md**: Defines the active REQ being implemented and specific goals
- **current-implementation.md**: Documents changes being made during this cycle
- **major-changes.md**: Records significant architectural decisions for this cycle

## Directory Structure Supporting the Cycle

The organization of this directory follows a strategic pattern that supports the cyclical workflow:

### Core Workflow Files (Root Directory) - Updated Each Cycle

These files maintain the state of the current cycle and are reset between cycles:

- **current-task.md** - Defines the immediate development goal (Cycle Step 3)
- **current-implementation.md** - Documents implementation details for the current cycle (Cycle Steps 3-4)
- **major-changes.md** - Tracks significant architectural decisions for the current cycle (Cycle Steps 3-5)

### Specialized Subfolder Structure - Persists Across Cycles

These folders contain persistent documentation that accumulates across cycles:

#### user-directed/
Tracks user requests and implementation priorities (Cycle Step 1):
- **user_requests.md** - Catalog of feature requests and implementation tracking

#### context/
Contains snapshots of the current state of different 00OS subsystems (Cycle Step 2):
- **core-current-state.md** - Analysis of the core subsystem components
- **config-current-state.md** - Documentation of system configuration settings
- **system-processes-current-state.md** - Overview of system command implementations
- **00reaper-processes-current-state.md** - Overview of 00reaper-specific command implementations
- **1000xdev-processes-current-state.md** - Overview of 1000xdev-specific command implementations

#### documentation/
Houses formal documentation updated during Cycle Step 5:
- **command-registry.md** - Tracks implementation status of all 00OS commands
- **00OS-command-development.md** - Primary guidelines for command development
- **00OS-command-user-guide.md** - End-user documentation for 00OS commands

#### templates/
Provides standardized templates updated during Cycle Step 5:
- **command-template.md** - Base template for creating new commands
- **implemented-patterns.md** - Collection of proven tool call patterns
- **command-standards.md** - Comprehensive standards for command implementation

#### testing/
Contains testing resources updated during Cycle Step 5:
- **testing-guide.md** - Detailed testing procedures and best practices
- **testing-framework.md** - Structure for test implementation and automation

## Implementing the Cyclical Workflow

To begin a new development cycle:

1. **Initialize**: Run `> reaper-read-files 00reaper/00OS-commands` to load the full context.
2. **Identify Focus**: Determine which REQ to address from user_requests.md.
3. **Plan Implementation**: Update the three core workflow files with implementation plans.
4. **Execute Changes**: Make the necessary changes to 00OS.
5. **Update Documentation**: Ensure all supporting materials reflect the changes.
6. **Reset for Next Cycle**: Clear the core workflow files of cycle-specific content.

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
