# Front-End Workflow Subsystem

## Workflow & Pathway
**Workflow**: front-end-workflow
**Pathway**: Multiple pathways available for UI/UX component development and integration

## Overview

The front-end workflow subsystem is responsible for managing the front-end development process for the GigaSwap project. It provides standardized processes, validation mechanisms, and implementation guidance.

## Core Subsystem Files

| File | Purpose |
|------|---------|
| `front-end-workflow-reference.md` | Core workflow process and standards |
| `component-patterns.md` | UI component implementation patterns |
| `ux-situation-guide.md` | UX testing and validation processes |
| `log-based-process.md` | Log-based development approach |
| `front-end-workflow-cheatsheet.md` | AUTO-GENERATED quick reference for key workflow steps |
| `parameter-cheatsheet.md` | AUTO-GENERATED reference for parameters |

## Message-Command System

> **IMPORTANT UPDATE**: The tracking of message-commands has been moved to a self-documenting header system in each project-rule-parameter. The front-end-workflow-cheatsheet.md and parameter-cheatsheet.md files are automatically generated and provide a current list of all available message-commands and parameters.

The front-end workflow now uses a self-documenting header system for project-rule-parameters. Each project-rule-parameter file includes a standardized header that explicitly defines its relationship to message-commands:

```
# workflow: front-end-workflow | pathway: error-recovery | message-command: dev-mode | standard-parameter(s): none | project-rule-parameter-path: parameters/front-end/dev-mode/continue-implementation-error-recovery.mdc
```

This self-documenting approach:
1. Makes each project-rule-parameter self-describing
2. Eliminates the need for centralized tracking
3. Ensures information is always up-to-date
4. Reduces the risk of inconsistencies

## Workflow Overview

The front-end workflow follows a structured process:

1. **Planning Phase** (📋 1000xdev [front-end-workflow]):
   - Create comprehensive planning documentation
   - Document component structure and state flow
   - Define API integration approach
   - Create test scenarios

2. **Implementation Phase** (💻 1000xdev [front-end-workflow]):
   - Implement components based on plan
   - Add strategic logging
   - Test with UX situations
   - Analyze logs and fix issues

3. **Completion and Transition**:
   - Signal completion with `implementation-complete`
   - Transition back to planning mode when directed
   - Update documentation based on implementation learnings

## Log-Based Development

The front-end workflow uses a log-based development approach:

1. **Strategic Logging**: Add logs at key component lifecycle points
2. **Observable Behavior**: Monitor component behavior through logs
3. **Evidence-Based Debugging**: Debug based on concrete log evidence
4. **Performance Analysis**: Use logs to identify and fix performance issues

## UX Situation Testing

Component testing is done through UX situation requests:

1. **Request UX Testing**: Ask for specific user interactions to be tested
2. **Analyze Results**: Examine logs produced during testing
3. **Fix Issues**: Address any issues identified in logs
4. **Verify Fixes**: Confirm fixes with additional testing

## Mode Indicators

All communication in the front-end workflow must begin with the appropriate mode indicator:

- Planning Mode: 📋 1000xdev [front-end-workflow]
- Developer Mode: 💻 1000xdev [front-end-workflow]

## Integration with Other Workflows

The front-end workflow is designed to integrate with:

- **back-end-workflow**: For API integration
- **documentation-workflow**: For component documentation
- **scripts-workflow**: For automation scripts
- **rules-workflow**: For project rule development 