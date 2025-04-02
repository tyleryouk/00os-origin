# Front-End Workflow Reference

## File Purpose and Relationship

This file provides guidance on the front-end workflow for GigaSwap. It establishes the fundamental patterns, processes, and architecture for front-end development using React, TypeScript, and related technologies.

> **IMPORTANT UPDATE**: The tracking of message-commands has been moved to a self-documenting header system in each project-rule-parameter. The front-end-workflow-cheatsheet.md file is automatically generated and provides a current list of all available message-commands and parameters.

## Message-Command Header System

The front-end workflow now uses a self-documenting header system for project-rule-parameters. Each project-rule-parameter file includes a standardized header that explicitly defines its relationship to message-commands:

```
# workflow: front-end-workflow | pathway: error-recovery | message-command: dev-mode | standard-parameter(s): none | project-rule-parameter-path: parameters/front-end/dev-mode/continue-implementation-error-recovery.mdc
```

This self-documenting approach:
1. Makes each project-rule-parameter self-describing
2. Eliminates the need for centralized tracking
3. Ensures information is always up-to-date
4. Reduces the risk of inconsistencies

### Accessing Message-Command Information

To understand the available message-commands for front-end-workflow:

1. Look at the header of the specific project-rule-parameter you're using
2. Refer to the front-end-workflow-cheatsheet.md file for a complete list
3. Use the fetch_rules tool to access relevant patterns:

```typescript
fetch_rules(["knowledge/rules/patterns/tool/command-patterns"], 
           "Understanding command patterns for front-end-workflow")
```

## Front-End Architecture

The front-end follows a structured architecture:

```
front-end/
  ├── src/
  │   ├── components/ (React components)
  │   ├── hooks/ (Custom React hooks)
  │   ├── contexts/ (React context providers)
  │   ├── services/ (API services)
  │   ├── utils/ (Utility functions)
  │   └── pages/ (Route components)
```

## Development Process

### Planning Phase

During plan-mode:
1. Create comprehensive context files for components, hooks, and state flow
2. Document implementation approach in phase-based implementation files
3. Create detailed test scenarios in test-cheatsheet.md
4. Complete planning before transitioning to dev-mode
5. Use `enhance-planning` or `enhance-requirements` when planning needs refinement

### Implementation Phase

During dev-mode:
1. Implement components based on planning documentation
2. Add strategic logging for observability
3. Autonomously run terminal commands to analyze logs
4. Request UX testing from Tyler when necessary using `recreate-ux-situation`
5. Analyze logs to identify and fix issues
6. Complete all implementation before returning to plan-mode

## Core Workflow Patterns

### Log Analysis-Based Development

- Run terminal commands to review logs and identify issues
- Implement targeted fixes based on log patterns
- Verify through additional log analysis
- Focus on observable behavior through logs

### Essential Tool Commands

| Tool Command | Purpose | Autonomous Execution |
|--------------|---------|----------------------|
| `run_terminal_cmd` for log analysis | Analyze front-end logs for issues | 100% autonomous by 1000xdev |
| `grep_search` for log patterns | Search for specific patterns in logs | 100% autonomous by 1000xdev |
| `recreate-ux-situation` | Request UX test scenarios from Tyler | Requested by 1000xdev, executed by Tyler |
| `run_terminal_cmd` for tool verification | Verify tools are functioning | 100% autonomous by 1000xdev |

## Essential Coding Standards

- Use functional components with hooks
- Implement TypeScript interfaces for props
- Follow error handling patterns with proper logging
- Use context for state management
- Apply performance optimization with memoization

## Detailed Implementation Guidance

For detailed implementation guides, see:
- @workflows/front-end-workflow/log-based-process.mdc (Log analysis patterns)
- @workflows/front-end-workflow/ux-situation-guide.mdc (UX testing protocols)
- @workflows/front-end-workflow/component-patterns.mdc (Component implementation patterns)

## Mode Transition Protocol

1. **Planning to Implementation**: Transition occurs via direct `dev-mode` message-command
2. **Implementation Completion**: Signal with `implementation-complete` and remain in dev-mode
3. **Return to Planning**: Only when explicitly commanded to switch modes