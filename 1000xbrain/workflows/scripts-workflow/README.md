# Scripts-Workflow Guidelines

## Overview

The scripts-workflow is a specialized process for developing and maintaining the 1000xscripts automation tools. This workflow provides structured methods for planning, implementation, and verification of changes to the PowerShell scripts that support the cognitive architecture maintenance and development.

## Purpose & Relationship

This README provides a comprehensive guide to understanding and using the scripts-workflow. It defines the standards, processes, and tools used in script development and should be consulted when:

- Creating new automation scripts
- Updating existing scripts
- Enhancing script functionality
- Improving synchronization processes
- Verifying script operations

This file complements:
- **workflows/scripts-workflow/scripts-workflow.md**: Core workflow definition
- **parameters/scripts/*.md**: Task-specific implementation files
- **core/modes/mode-transitions.md**: Mode system documentation
- **core/communication/message-commands.md**: Message-command standards

## Workflow Overview

The scripts-workflow operates in two distinct modes: plan-mode for comprehensive planning and dev-mode for autonomous implementation. Each mode has specific indicators:

- **Plan Mode**: 📋 1000xdev [scripts-workflow]
- **Dev Mode**: 💻 1000xdev [scripts-workflow]

### Planning Process (Plan-Mode)

The planning process establishes the foundation for script development through these key steps:

1. **Requirements Analysis**: Define objectives and success criteria
2. **Context Analysis**: Analyze current state and dependencies 
3. **Implementation Planning**: Create detailed implementation approach
4. **Planning Verification**: Ensure planning is comprehensive
5. **Planning Completion**: Signal readiness for implementation

### Implementation Process (Dev-Mode)

The implementation process follows a structured approach to autonomously implement the planned changes:

1. **Direct Mode Transition**: Transition from planning to implementation
2. **Status Checking**: Monitor and report implementation progress
3. **Recovery Management**: Handle interrupted workflows
4. **Phased Implementation**: Execute changes in ordered phases
5. **Implementation Verification**: Ensure all requirements are met
6. **Implementation Completion**: Signal successful implementation

## Message-Commands

The scripts-workflow uses these standard message-commands:

| Command | Project-Rule-Parameter | Purpose |
|---------|----------------|---------|
| `plan-mode: scripts-workflow` | `@parameters/scripts/plan-mode.mdc` | Enter Planning Mode for scripts |
| `dev-mode: scripts-workflow` | `@parameters/scripts/dev-mode.mdc` | Direct transition to Developer Mode |
| `continue-planning:` | `@parameters/scripts/continue-planning.mdc` | Continue planning with additional guidance |
| `continue-implementation:` | `@parameters/scripts/continue-implementation.mdc` | Continue implementation with additional guidance |

## Mode Transition

The direct mode transition is the critical step for moving from planning to implementation:

```
dev-mode: scripts-workflow @parameters/scripts/dev-mode.mdc
```

This streamlined approach:
- Provides a simple, direct transition from planning to implementation
- Maintains context during the transition
- Enables focused implementation based on planning documentation

## Initialization Process

The scripts-workflow includes robust recovery mechanisms for handling interrupted sessions:

1. **Planning Recovery**:
   - Analyzes planning folder state
   - Resumes planning from detected point

2. **Implementation Recovery**:
   - Checks current implementation status
   - Continues implementation from the last completed step
   - Maintains accurate progress tracking

### Project-Rule-Parameter Standardization

All message-commands in the scripts-workflow must include their corresponding project-rule-parameter:

1. **Required Format**: 
   - `message-command: @parameters/scripts/message-command.mdc`
   - Project-rule-parameter must match the message-command name
   - Example: `verify-script-enhancement: @parameters/scripts/verify-script-enhancement.mdc`

2. **Validation Process**:
   - Every workflow-specific message-command is validated
   - Commands without proper parameters are rejected
   - Implementation continues only with validated commands

## Implementation Progress Tracking

The scripts-workflow maintains an implementation-progress.md file to track implementation progress with:

- Current phase and step
- Phase plan overview
- Detailed progress with checkmarks
- Timestamp of last update

## Script Enhancement Scenarios

The scripts-workflow supports various script enhancement scenarios:

1. **Script Creation**: Creating new scripts for specific automation tasks
2. **Script Enhancement**: Improving existing scripts with new features or fixes
3. **Synchronization Verification**: Ensuring proper synchronization between 1000xbrain and Cursor Rules
4. **Script Testing**: Testing script functionality in different scenarios

## Success Criteria

A successful scripts-workflow implementation meets these criteria:

1. All planning documents are complete and comprehensive
2. All implementation phases are executed correctly
3. Scripts maintain proper formatting and error handling
4. Recovery mechanisms function properly
5. Implementation progress is accurately tracked
6. Message-commands include proper project-rule-parameters 

