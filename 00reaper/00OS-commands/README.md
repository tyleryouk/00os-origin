# 00OS-commands Workflow

This directory serves as the central hub for creating, managing, and optimizing 00OS commands. It contains the essential documentation, templates, testing resources, and contextual information needed to support the development of the 00OS command system.

## Overview
This README documents the 00OS-commands workflow, a cyclical development process for building and maintaining terminal-like command capabilities (prefixed with `>`) within an AI system. The workflow enables structured, traceable, and high-quality command implementation within the 00OS architecture.

## Master Workflow Files

This workflow is governed by two master workflow files:

1. **README.md** (This file)
   * Serves as the base master workflow file
   * Should be read upon every initialization
   * Documents the cyclical workflow process, file structure, and implementation standards
   * Provides the foundational knowledge for working within the 00OS-commands development environment

2. **user-directed/user-rules-00OS-commands.md**
   * Represents the highest hierarchy cursor rule
   * Should be engrained in memory for each thread and every message
   * Contains specific operational directives for the 00reaper AI agent
   * Defines 00reaper's dual-mode interface, process categorization rules, and command processing guarantees

These master workflow files work together to establish the operational context for the 00reaper agent, while the core workflow files (described below) track the state of individual development cycles.

## Core Workflow Files

The workflow relies on three core files that maintain the state of the current development cycle:

1. **active-request.md**:
   * Contains the complete REQ details being implemented
   * Written in clear requirements language
   * Updated primarily in steps 1-3 of the cycle
   * Serves as the stable requirements reference

2. **implementation-plan.md**:
   * Documents the concrete implementation plan
   * Maps requirements to implementation phases
   * Updated primarily in step 3 of the cycle
   * Serves as the blueprint for implementation

3. **cycle-status.md**:
   * Tracks the current cycle stage and progress
   * Updated continuously throughout all steps
   * Shows next actions and blockers
   * Serves as the primary status indicator for the workflow

These files are created, updated, and reset according to the cyclical workflow process. To determine the current workflow stage at any time, first check cycle-status.md, then consult active-request.md and implementation-plan.md if needed.

## Cyclical Workflow Process

The 00OS-commands development follows a six-step structured cyclical approach that ensures consistency, focus, and comprehensive implementation:

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
   * Understand requirements and scope
   * Map request to 00OS architecture

2. **Read Relevant Context**
   * Review files in context-00OS-current-state/
   * Check documentation/ for applicable templates and guides
   * Examine documentation/testing/ for relevant process tests

3. **Update Core Workflow Files**
   * Update active-request.md with REQ details
   * Create implementation-plan.md with concrete plan
   * Initialize cycle-status.md to track progress

4. **Make Changes to 00OS**
   * Implement changes per implementation plan
   * Create or modify processes in appropriate categories
   * Ensure command integrity and proper fetch_rules usage

5. **Update Supporting Materials**
   * Update context files with new state
   * Update/create documentation as needed
   * Create or update test files for new functionality

6. **Reset Core Workflow Files & Sync Changes**
   * Reset or archive core workflow files for next cycle
   * Run `> reaper-sync` to sync 00OS changes to .cursor/rules

At the completion of step 6, the cycle begins again with a new request.

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
- `core.md`: Analysis of the core subsystem components.
- `config.md`: Documentation of system configuration settings.
- `system-processes.md`: Overview of system command implementations.
- `00reaper-processes.md`: Overview of 00reaper-specific command implementations.
- `1000xdev-processes.md`: Overview of 1000xdev-specific command implementations.

#### `documentation/`
Houses formal documentation, templates, and standards updated during Cycle Step 5:
- `00OS-command-development.md`: Primary guidelines for command development.
- `00OS-command-user-guide.md`: End-user documentation for 00OS commands.
- `cursor-rules-manipulation.md`: Details the 00OS & Cursor Rules development workflow (Dev -> Sync -> Prod).
- `command-template.md`: Base template for creating new commands.
- `implemented-patterns.md`: Collection of proven tool call patterns.
- `command-standards.md`: Comprehensive standards for command implementation.
- `tool-call-patterns.md`: Documentation of tool call patterns for command implementation.
- `00reaper-templates/`:
    - `active-request-template.md`: Template for active-request.md.
    - `implementation-plan-template.md`: Template for implementation-plan.md.
    - `cycle-status-template.md`: Template for cycle-status.md.
- `00reaper-identity/`:
    - `identity.md`: Documentation of the 00reaper identity.
    - `00os-integration.md`: Documentation of 00reaper's integration with 00OS.
- `testing/`:
    - `testing-guide.md`: Detailed testing procedures and best practices.
    - `testing-framework.md`: Structure for test implementation and automation.

#### `research-cursor/`
Contains research notes and findings specifically related to Cursor rules implementation and behavior:
- `research-cursor-project-rules.md`: Research on Cursor project rules.
- `research-cursor-rules-manipulation.md`: Research on manipulating Cursor rules.
- `research-cursor-tool-call.md`: Research on Cursor tool calls.
- `research-cursor-user-rules.md`: Research on Cursor user rules.

#### `user-directed/`
Tracks user requests and contains specific instructions for the AI agent operating within this workflow (Used in Cycle Step 1):
- `user-requests.md`: Catalog of feature requests and implementation tracking.
- `user-rules-00OS-commands.md`: Specific rules for the 00reaper agent when working in this directory.

## Implementing the Cyclical Workflow

To begin a new development cycle:

1. **Initialize**: Run `> reaper-read-files 00reaper/00OS-commands` to load the full context.
2. **Identify Focus**: Determine which REQ to address from user-directed/user-requests.md.
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
   - Populated at the beginning of the cycle with REQ title and requirements
   - Structured as a pure requirements document with no metadata or status
   - Updated ONLY during step 1, or if the fundamental requirements change
   - Serves as a stable reference point throughout the cycle
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

## Workflow File Standardization

To ensure consistency and alignment across development cycles, the three core workflow files follow standardized templates:

### Core Workflow Files and Templates

| Workflow File | Purpose | Template Location |
|---------------|---------|-------------------|
| active-request.md | Defines requirements for the current request | documentation/00reaper-templates/active-request-template.md |
| implementation-plan.md | Details the implementation approach and phases | documentation/00reaper-templates/implementation-plan-template.md |
| cycle-status.md | Tracks the current progress through the workflow | documentation/00reaper-templates/cycle-status-template.md |

### Template Usage

When beginning a new development cycle (Step 1), use tool calls to access the appropriate templates:

```
> reaper-read-files 00reaper/00OS-commands/documentation/00reaper-templates/active-request-template.md
```

Then copy the template content to create the core workflow files in the root directory:
1. Use the active-request-template.md to create/update active-request.md
2. Use the implementation-plan-template.md to create/update implementation-plan.md
3. Use the cycle-status-template.md to create/update cycle-status.md

When filling out templates:
- Replace all placeholder text in [brackets]
- Use standardized status indicators: ✅ (Complete), ⏳ (In Progress), ⬜ (Not Started)
- Follow the established update patterns for each file

### Template Features

#### Active Request Template
- Simple requirements-focused structure with no metadata or status indicators
- Focused exclusively on what needs to be done (requirements and completion criteria)
- Minimal context references for relevant directories and files
- Designed to be updated only during step 1, then remain static
- Omits cycle tracking information which is maintained in cycle-status.md

#### Implementation Plan Template
- Clear mapping between workflow steps and implementation phases
- Structured phase definitions with task checklists
- Implementation details section for component/process specifications
- Testing and verification strategy section
- Dependencies, blockers, and rollback plan

#### Cycle Status Template
- Comprehensive progress tracking for all 6 workflow steps
- Current findings and focus sections
- Next actions prioritization
- Implementation highlights tracking
- Blockers and decisions documentation
- Previous cycle summary
- Notes for next cycle

### Reset State Guidelines

At the end of step 6 (Reset Core Workflow Files & Sync Changes), reset the core workflow files to a minimal state for the next cycle:

#### Reset State for active-request.md
```markdown
# No Active Request

// File reset at end of REQ-[PREVIOUS-ID] cycle. Awaiting next user request. //
```

#### Reset State for implementation-plan.md
```markdown
# Implementation Plan

No active cycle
```

#### Reset State for cycle-status.md
```markdown
# Cycle Status

No active cycle
```

This minimal reset state:
- Clearly indicates there is no active cycle
- Preserves the file structure for the next cycle
- Shows which REQ was just completed
- Keeps the workflow ready for the next request

### Standardization Benefits

1. **Consistent Structure**: All files use the same section headings and status indicators
2. **Clear Cross-References**: Each file contains links to the other workflow files
3. **Aligned Tracking**: Implementation phases are explicitly mapped to workflow steps
4. **Temporal Alignment**: All files include timestamps for last update


## Critical Implementation Requirements for Changes to 00OS

### Highest Priority Requirements for changes to 00OS
1. **Command Prefix**: The '>' prefix for commands is hardcoded in the command handler and is not configurable.
2. **Mandatory fetch_rules**: Every command MUST trigger a fetch_rules call to retrieve its process definition.
3. **No Self-Execution**: Commands should NEVER attempt to execute themselves via run_terminal_cmd.
4. **Process-Driven Execution**: Allow the fetched process to control the execution flow.

### Tool Call Framework

The 00OS command system is built on a tool call-based architecture that leverages Cursor's native capabilities:

```
Command Detection → Process Rule Fetching → Parameter Parsing → Tool Call Execution → Response Formatting
```

This directory contains all the resources needed to maintain and extend this architecture with reliability and consistency.

## 00OS Process Categorization Architecture

All 00OS processes are organized into three distinct categories:

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

### 00OS Command alignment with 00OS Processes
When you read an 00OS command prefixed with >, you will immediately make a fetch_rules tool call to the process with the same 00OS command name. This is to simplify the cognitive load for 00OS commands, so that all logic is abstracted to the process file. There is no registry for 00OS commands. 00OS commands are simply utilized to invoke 00OS processes. Each 00OS process has a one-to-one relationship with its 00OS command. An 00OS process can only be invoked upon the utilization of an 00OS command with the exact same filename as the 00OS process.


