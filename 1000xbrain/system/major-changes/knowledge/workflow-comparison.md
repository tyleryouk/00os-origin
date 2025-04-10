# Knowledge: Workflow Comparison

## Overview

This knowledge file compares the autonomous workflow and the major changes workflow, highlighting their differences, similarities, and appropriate use cases.

## Workflow Comparison

| Aspect | Autonomous Workflow | Major Changes Workflow |
|--------|---------------------|------------------------|
| **Initiation** | Self-initiated by 1000xdev based on research | Explicitly initiated by Tyler based on specific change request |
| **Focus** | System optimization, incremental improvements | Significant, explicitly requested changes to functionality |
| **Scope** | Usually limited to specific subsystems | Can span multiple subsystems or introduce entirely new features |
| **Human Input** | Minimal, primarily for verification | Substantial, especially in requirement definition and assessment |
| **Documentation** | Internally focused | Both internal and user-facing |
| **Timeline** | Regular, scheduled cycles | Ad-hoc, based on explicit requests |
| **Change Size** | Generally smaller, incremental changes | Potentially large, transformative changes |
| **Risk Level** | Lower, due to incremental nature | Potentially higher, requiring more verification |

## Command Sequence Comparison

| Autonomous Workflow | Major Changes Workflow | Purpose |
|---------------------|------------------------|---------|
| `1` (initiate-cycle) | `1` (initiate-explicit-cycle) | Start a new cycle and initialize tracking |
| `2` (research-enhancements) | `2` (assess-change-request) | Gather information about required changes |
| `3` (plan-enhancements) | `3` (plan-implementation) | Create detailed implementation plan |
| `4` (implement-enhancements) | `4` (implement-changes) | Execute the planned changes |
| `5` (verify-enhancements) | `5` (verify-changes) | Ensure changes meet requirements |
| `6` (refine-enhancements) | `6` (refine-changes) | Address issues identified during verification |
| `7` (complete-cycle) | `7` (complete-change-cycle) | Finalize cycle and update documentation |

## When to Use Each Workflow

### Autonomous Workflow
* For ongoing system optimization
* For addressing technical debt
* For implementing patterns identified by 1000xdev
* For incremental improvements to existing functionality
* When changes are well-understood and require minimal human input

### Major Changes Workflow
* For implementing new features explicitly requested by Tyler
* For significant architectural changes
* For changes that require substantial human input or direction
* For changes that affect multiple subsystems
* When requirements need detailed discussion and clarification

## Transition Between Workflows

The workflows can be complementary:

1. **Major Changes → Autonomous**: After implementing a major change, the autonomous workflow can optimize and refine the implementation.

2. **Autonomous → Major Changes**: The autonomous workflow might identify a need for a significant change that requires explicit direction from Tyler.

## Integration Points

* Both workflows share similar verification and refinement processes
* Both maintain operational feedback in similar structures
* Both update the same implementation progress tracking system
* Both can leverage the same knowledge and process files where appropriate 