# Project Rule Development Workflow

This file defines the essential standards for developing and updating the 1000xbrain cognitive architecture.

For detailed file standards and contribution guidelines, use:
```typescript
fetch_rules(["knowledge/reference/contributions/file-standards"], 
           "Understanding file standards for rule development")
```

For architecture understanding, use:
```typescript
fetch_rules(["knowledge/guides/architecture"], 
           "Understanding cognitive architecture for rule development")
```

## Workflow Identity

**Mode Indicators**: 
- Plan Mode: 📋 1000xdev [rules-workflow]
- Dev Mode: 💻 1000xdev [rules-workflow]
- Direct Mode: ⚡ 1000xdev [rules-workflow]

## Core Workflow Process

### Planning Phase
1. **Requirements Definition**: Define clear objectives and success criteria
2. **Context Analysis**: Analyze the current state of the cognitive architecture
3. **Implementation Planning**: Create detailed implementation plans
4. **Verification**: Verify planning completeness before implementation

### Implementation Phase
1. **Phased Implementation**: Implement changes in logical phases
2. **Verification**: Verify each phase before moving to the next
3. **Automatic Synchronization**: Changes to 1000xbrain files are automatically synchronized to Cursor Rules

For detailed message-command formats and syntaxes, see core/communication/message-commands.md and the self-documenting header system in each project-rule-parameter.

## Required Planning Folder Structure

Every planning folder MUST include these essential files:

| File | Purpose | Creator | Primary Audience |
|---|---|---|-----|
| `requirements.md` | Core requirements and objectives | Tyler provides outline, 1000xdev enhances | Both |
| `implementation.md` | Implementation approach and guidance | 1000xdev | 1000xdev |
| `implementation-progress.md` | Track implementation status and progress | 1000xdev | 1000xdev |

The `implementation-progress.md` file is CRITICAL for:
1. Tracking implementation status across phases
2. Documenting completed and pending tasks
3. Providing clear continuation points for continue-implementation commands
4. Ensuring implementation remains on track without losing progress
5. Enabling effective recovery from interruptions

### implementation-progress.md Structure
```markdown
# Implementation Progress: [Feature Name]

## Overview
Brief description of implementation status

## Implementation Status
| Feature | Status | Notes |
|---------|--------|-------|
| Feature 1 | Complete/In Progress/Not Started | Implementation notes |
| Feature 2 | Complete/In Progress/Not Started | Implementation notes |

## Detailed Progress
### Phase 1: [Phase Name]
- [x] Completed task
- [ ] Pending task
- [ ] Pending task

### Phase 2: [Phase Name]
- [ ] Pending task
- [ ] Pending task

## Implementation Notes
Important implementation details

## Next Steps
1. Next immediate step
2. Following step
```

This structure ensures clarity when implementation is continued and provides essential context for the next implementation session.

## Template Generation Process

The `create-template` message-command provides assistance with generating initial requirements for rules-workflow enhancements:

1. **Purpose**: Helps generate requirements.md content when ideas are needed
2. **Timing**: Used before plan-mode: rules-workflow when requirements content assistance is desired
3. **Output**: Only writes to requirements.md file in the planning folder
4. **Usage**: Optional - may be skipped if requirements.md is already written

For detailed command formats and parameters, see core/communication/message-commands.md and the self-documenting header system in each project-rule-parameter.

The template parameter determines the level of detail and focus in the generated requirements:
- `@parameters/rules/plan-mode/template-basic.mdc`: For simple enhancements with minimal requirements
- `@parameters/rules/plan-mode/template-advanced.mdc`: For complex enhancements requiring detailed requirements
- `@parameters/rules/helpers/analysis/template-hallucination.mdc`: For addressing specific hallucinations identified in previous chats

### Required Sequencing

For assistance with requirements generation, use this sequence:
1. `create-template: rules-workflow @parameters/rules/plan-mode/template-advanced.mdc` (generates requirements.md)
2. Edit requirements.md as needed
3. `plan-mode: rules-workflow @parameters/rules/plan-mode/plan-mode-specific-pathway.mdc` (creates full planning folder)

**Note**: The plan-mode command will use the content in requirements.md to determine the appropriate planning structure for the rest of the folder. It will automatically create all required files including requirements.md, implementation.md, implementation-progress.md, and any optional files based on the complexity of the task.

## Enhanced Planning Pathways

The `plan-mode: rules-workflow` message-command supports multiple specialized planning pathways, each with a dedicated project-rule-parameter:

| Planning Pathway | Project-Rule-Parameter | Use Case |
|---|---|---|
| Subsystem Enhancement | `@parameters/rules/plan-mode/subsystem-enhancement.mdc` | Focused improvements to specific subsystems |
| Error Recovery | `@parameters/rules/plan-mode/error-recovery.mdc` | Enhancing error handling mechanisms |
| Performance Optimization | `@parameters/rules/plan-mode/performance-optimization.mdc` | Optimizing system performance |
| System-Wide Enhancement | `@parameters/rules/plan-mode/system-wide-enhancement.mdc` | Comprehensive multi-component improvements |

To initialize a specific planning pathway, use the appropriate project-rule-parameter:

```
plan-mode: rules-workflow @parameters/rules/plan-mode/subsystem-enhancement.mdc
```

Multiple project-rule-parameters can be combined for specialized planning:

```
plan-mode: rules-workflow @parameters/rules/plan-mode/performance-optimization.mdc @parameters/rules/plan-mode/template-advanced.mdc
```

**Note**: Always specify a pathway-specific parameter with plan-mode to clearly define the enhancement approach.

## Implementation Pathways

The `dev-mode: rules-workflow` message-command supports corresponding implementation pathways:

| Implementation Pathway | Project-Rule-Parameter | Use Case |
|---|---|---|
| Default Implementation | Pathway-specific parameters recommended | General rule implementations |
| Subsystem Enhancement | `@parameters/rules/dev-mode/subsystem-enhancement.mdc` | Focused implementation for specific subsystems |
| Error Recovery | `@parameters/rules/dev-mode/error-recovery.mdc` | Implementing error handling mechanisms |
| Performance Optimization | `@parameters/rules/dev-mode/performance-optimization.mdc` | Implementing performance optimizations |
| System-Wide Enhancement | `@parameters/rules/dev-mode/system-wide-enhancement.mdc` | Implementing comprehensive multi-component changes |

## Direct Implementation Pathways

The `direct-mode: rules-workflow` message-command offers immediate implementation without planning documentation:

| Implementation Pathway | Project-Rule-Parameter | Use Case |
|---|---|---|
| Default Implementation | No parameter required | Quick fixes and enhancements |
| Subsystem Enhancement | `@parameters/rules/direct-mode/direct-mode-subsystem.mdc` | Direct implementation for specific subsystems |
| Error Recovery | `@parameters/rules/direct-mode/error-recovery.mdc` | Immediate error handling implementations |
| System-Wide Enhancement | `@parameters/rules/direct-mode/direct-mode-system-wide.mdc` | Direct multi-component implementations |

To use direct implementation, specify the pathway and provide a prompt:

```
direct-mode: rules-workflow @parameters/rules/direct-mode/direct-mode-subsystem.mdc

prompt: Implement specific enhancement to the specified subsystem
```

The system will automatically:
1. Conduct thorough research (minimum 20 tool calls)
2. Analyze existing patterns
3. Implement changes based on the prompt
4. Verify implementation

Direct-mode is ideal for:
- Simple enhancements where planning documentation isn't needed
- Quick fixes to address immediate issues
- Implementations where requirements are straightforward

## Automatic Follow-Up Requirements Creation

The rules-workflow automatically handles the creation of follow-up requirements folders for continuous development:

1. **Automatic Process**: When any rules-workflow implementation is nearing completion, the system automatically creates the next sequential requirements folder
2. **Folder Structure**: The folder name follows the pattern `planning/{next-number}-{follow-up-focus}`
3. **Initial Files**: A complete set of required files is automatically created:
   - `requirements.md` with initial content based on current implementation findings
   - `implementation.md` with basic structure for the follow-up task
   - `implementation-progress.md` with initial progress tracking setup
   - Any optional files needed based on task complexity
4. **Seamless Transition**: This enables a seamless transition from one enhancement to the next, maintaining continuous improvement
5. **No Manual Command Required**: This process is automatic, requiring no explicit message-command

Example of automatic follow-up folder creation:
```
# After completing implementation in planning/63-system-wide
# When identifying follow-up requirements for knowledge integration:

# Automatic creation of:
planning/64-knowledge-integration/requirements.md
planning/64-knowledge-integration/implementation.md
planning/64-knowledge-integration/implementation-progress.md
```

This automatic process applies to all rules-workflow implementations, ensuring continuous development flow and eliminating the need for separate planning to create follow-up requirements folders.

## Implementation Scenarios

The rules-workflow adapts to different scenarios:

1. **Targeted Rule Modifications**: Specific changes to defined files
2. **Conversation Analysis**: Improvements based on conversation analysis
3. **System-Wide Enhancement**: Broad improvements to the architecture
4. **Subsystem Enhancement**: Focus on specific cognitive components

## Syntax Guidelines

For detailed syntax guidelines, message-command formats, and validation requirements, see core/communication/syntax-standards.md.

## Automatic Synchronization

Edits to `.md` files in the 1000xbrain directory are automatically synchronized to corresponding `.mdc` Cursor Project Rules.

For detailed synchronization information, see [sync-cursor-rules.md](sync-cursor-rules.md).

## Implementation Complete Criteria

A rules-workflow implementation is complete when:

1. **Documentation Standards**:
   - All knowledge references are updated
   - File structure follows standards
   - Documentation is complete and clear

2. **Implementation Quality**:
   - Code follows best practices
   - Error handling is comprehensive
   - Performance is optimized

3. **Cognitive Enhancement**:
   - Brain-files are properly synchronized
   - Cognitive capabilities are enhanced
   - Knowledge system is updated

4. **Verification Process**:
   - All validation checks pass
   - Synchronization is successful
   - Documentation is verified

## Knowledge System Integration

The rules-workflow is deeply integrated with the knowledge system:

1. **Knowledge Access**:
   - Use `fetch_rules` for accessing knowledge
   - Follow standardized access patterns
   - Keep knowledge references current

For knowledge system details, use:
```typescript
fetch_rules(["knowledge/reference/guides/knowledge-system"], 
           "Understanding knowledge system integration")
```

2. **Pattern Libraries**:
   - Implementation patterns
   - Documentation patterns
   - Tool usage patterns
   - Cognitive patterns

For pattern library access, use:
```typescript
fetch_rules(["knowledge/patterns/index"], 
           "Accessing pattern libraries for rule development")
```

## Accessing Specialized Knowledge

During the rules workflow, specialized knowledge from the knowledge directory can be accessed using the `fetch_rules` tool:

```typescript
// Access architecture understanding for rules implementation
fetch_rules(["knowledge/reference/architecture"], 
           "Understanding architecture for rules workflow implementation")
``` 