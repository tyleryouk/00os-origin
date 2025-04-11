# Cycle Structure: Standard 7-Step Sequential Command Model

## Overview

This document defines the standardized structure for all cycles within the 1000x system. The 7-step sequential command model provides a consistent approach to handling complex workflows across all domains (system, front-end, back-end). This structure applies to all cycles regardless of domain or specific purpose.

## Standard Cycle Components

### 1. Command Files

All cycles must implement the following 7 sequential command files, placed in the appropriate domain directory (`1000xcommands/<domain>/<cycle-name>/`):

1. **1.md**: Cycle Initiation
   * Creates initial feedback structure
   * Sets up USER REQUEST SECTION if not exists
   * Initializes cycle tracking
   * No substantive work performed

2. **2.md**: Requirement Analysis
   * Checks for user input in USER REQUEST SECTION
   * If user input exists, analyzes requirements
   * If no user input exists, retrieves documented potential enhancements
   * Documents analysis results

3. **3.md**: Planning
   * Creates implementation plan based on analysis
   * Defines tasks, phases, and success criteria
   * Documents dependencies and constraints

4. **4.md**: Implementation
   * Executes the implementation plan
   * Creates or modifies files as needed
   * Documents implementation progress

5. **5.md**: Verification
   * Verifies that implementation meets requirements
   * Checks files for integrity and correctness
   * Documents verification results

6. **6.md**: Refinement (Optional)
   * Addresses issues found during verification
   * Makes necessary adjustments
   * Re-verifies changes

7. **7.md**: Completion
   * Finalizes cycle documentation
   * Updates cycle status
   * Archives results and feedback
   * Suggests next actions

Additionally, each cycle must include:
* **README.md**: Documents the cycle's purpose, workflow, and usage

### 2. Brain Components

Each cycle must have corresponding knowledge and process files in the appropriate brain directory (`1000xbrain/<domain>/<cycle-name>/`):

1. **Knowledge Directory** (`knowledge/`):
   * Domain-specific knowledge relevant to the cycle
   * Conceptual information needed for execution

2. **Processes Directory** (`processes/`):
   * Step-by-step processes for each command
   * Named consistently (e.g., `initiate-cycle-process.md`, `analyze-requirements-process.md`, etc.)

3. **Operational Feedback Directory** (`operational_feedback/`):
   * Status tracking for current cycle (`current_cycle.md`)
   * User request storage (if applicable)
   * Implementation logs and verification reports

### 3. Dynamic Execution Structure

Each command file (1.md through 7.md) must use the dynamic execution structure:

```
# Command Name | Part N

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/<domain>/<cycle-name>/processes/<process-name>.md
# --- END DYNAMIC EXECUTION ---

# This command [brief description of purpose]

# Placeholder: [brief description of operations]
# (Tool calls to be added within the dynamic process)

# Next Step: Invoke `run command:<domain>/<cycle-name>/N+1`
# (Actual invocation requires external orchestration - will be handled by Tyler)
```

## Unified Model: Autonomous and User-Directed Operation

All cycles must implement the unified model where:

1. Every cycle can operate in two modes:
   * **Autonomous Mode**: When no user input is provided, uses documented potential enhancements
   * **User-Directed Mode**: When user input is provided, processes according to requirements

2. The mode determination happens in command 2 (Requirement Analysis) based on:
   * Checking if USER REQUEST SECTION contains valid user input
   * If yes, process as user-directed
   * If no, retrieve potential enhancements for autonomous operation

3. USER REQUEST SECTION format must be standardized and created in command 1

## Naming Conventions

1. **Cycle Names**: Use kebab-case (e.g., `cycle-manager`, `component-creator`)
2. **Command Files**: Use numeric sequence (1.md through 7.md, plus README.md)
3. **Process Files**: Use kebab-case based on purpose (e.g., `analyze-requirements-process.md`)
4. **Knowledge Files**: Use kebab-case based on content (e.g., `naming-conventions.md`)

## Implementation Standards

All cycles must adhere to:

1. **Command Invocation**: Use `run command:<domain>/<cycle-name>/N` format
2. **File Structure**: Follow the directory layout defined above
3. **Process Structure**: Use standard process format with clear steps
4. **Feedback Mechanism**: Create and update operational feedback files consistently
5. **Error Handling**: Include appropriate error handling in all processes

## References

* Cycle Standardization Guidelines: `1000xbrain/system/guidelines/cycle-standardization.md`
* Unified Model Documentation: `1000xbrain/system/cycle-manager/knowledge/unified-model.md`
* Naming Conventions: `1000xbrain/system/cycle-manager/knowledge/naming-conventions.md`