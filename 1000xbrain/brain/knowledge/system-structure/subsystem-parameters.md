# USE WHEN understanding the parameters subsystem of the 1000xbrain system

# Subsystem: Parameters

## Overview

This knowledge file provides comprehensive documentation of the parameters subsystem within the 1000xbrain cognitive architecture, including its organization, pathway structure, and relationships with other subsystems.

## Parameters Subsystem Purpose

The parameters subsystem serves as the execution framework component of the 1000xbrain cognitive architecture, providing:

1. **Task-Specific Guidance**: Detailed execution frameworks for specific tasks
2. **Pathway Organization**: Structured approach to task implementation
3. **Mode-Specific Implementation**: Different parameters for planning vs. development
4. **Manual Reference**: Explicitly referenced in message-commands
5. **Domain Access Control**: Defines what can be accessed and modified in each mode
6. **Workflow-Pathway Integration**: Maps workflows to specific implementation pathways

As the execution framework component, this subsystem provides specific, detailed guidance for particular tasks when explicitly referenced.

## Rule Type: Manual

Files in the parameters subsystem are designated as **Manual** rule type, meaning:

- **Explicit Reference**: Only activated when explicitly referenced with @ symbol
- **Message-Command Activation**: Referenced in the message-command format
- **Task-Specific Application**: Applied only for specific implementation tasks
- **Mode-Dependent Variants**: Plan-mode and dev-mode variants for each pathway
- **Domain-Controlled Access**: Enforces specific domain access restrictions

This rule type ensures that execution frameworks are applied only when specifically requested for particular tasks.

## Parameters Directory Structure

The parameters subsystem is organized primarily by workflow and mode:

```
1000xbrain/parameters/
├── rules/                     # Parameters for rules-workflow
│   ├── plan-mode/             # Planning parameters for rules-workflow
│   │   ├── system-wide.md     # Plan-mode system-wide pathway
│   │   ├── subsystem-core.md  # Plan-mode subsystem-core pathway
│   │   └── ...                # Other plan-mode pathways
│   ├── dev-mode/              # Development parameters for rules-workflow
│   │   ├── system-wide.md     # Dev-mode system-wide pathway
│   │   ├── subsystem-core.md  # Dev-mode subsystem-core pathway
│   │   └── ...                # Other dev-mode pathways
│   └── direct-mode/           # Direct parameters for rules-workflow (limited)
├── quality/                   # Parameters for quality-workflow
├── front-end/                 # Parameters for front-end-workflow
├── back-end/                  # Parameters for back-end-workflow
└── scripts/                   # Parameters for scripts-workflow
```

This organization enables clear, consistent access to execution frameworks through message-commands.

## Access Method: @project-rule-parameter.mdc

The parameters subsystem is accessed through direct reference in message-commands:

```
mode workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)
```

For example:
```
plan-mode rules-workflow system-wide @parameters/rules/plan-mode/system-wide.mdc none
dev-mode rules-workflow subsystem-core @parameters/rules/dev-mode/subsystem-core.mdc none
```

This explicit reference ensures that parameters are applied only when specifically requested.

## Pathway Organization

The parameters subsystem is organized around the concept of pathways, which define specific implementation contexts within each workflow.

### Core Pathways for Rules-Workflow

The rules-workflow includes these core pathways:

| Pathway | Purpose | Domain Access |
|---------|---------|---------------|
| system-wide | System-wide changes affecting all subsystems | All of 1000xbrain/** |
| system-wide-optimization | Optimizing the entire system architecture | All of 1000xbrain/** |
| subsystem-core | Changes affecting the core subsystem | 1000xbrain/knowledge/system-structure/ and 1000xbrain/core/ |
| subsystem-knowledge | Changes affecting the knowledge subsystem | 1000xbrain/knowledge/system-structure/ and 1000xbrain/knowledge/ |
| subsystem-parameters | Changes affecting the parameters subsystem | 1000xbrain/knowledge/system-structure/ and 1000xbrain/parameters/ |
| subsystem-workflows | Changes affecting the workflows subsystem | 1000xbrain/knowledge/system-structure/ and 1000xbrain/workflows/ |
| workflows | Workflow-specific changes across subsystems | Depends on workflow-type, following subsystem patterns |

Each pathway has specific plan-mode and dev-mode parameter files that define the execution framework for that pathway.

### Mode-Specific Parameter Variants

Each pathway has mode-specific parameter variants:

- **Plan-Mode Parameters**: Focus on documentation, planning, and analysis
- **Dev-Mode Parameters**: Focus on implementation, testing, and verification

This mode separation ensures clear distinction between planning and implementation phases.

## Parameter File Structure

Each parameter file follows a standardized structure:

1. **Header**: Mode, workflow, pathway, and parameter specifications
2. **Purpose**: Clear explanation of the parameter's purpose
3. **Knowledge Access**: Guidance on accessing relevant knowledge
4. **Implementation Guidance**: Specific guidance for the pathway
5. **Command Operation**: Details on message-command operation
6. **Domain Access Specifications**: What can be read and modified in each mode
7. **Tool Call Processes**: Structured steps for implementation
8. **Completion Criteria**: Clear definition of when implementation is complete

This standardized structure ensures consistency and clarity across all parameters.

## Parameter Header Format

Each parameter file begins with a standardized header:

```markdown
# mode: [mode] | workflow: [workflow-type] | pathway: [pathway-name] | filepath: @[filepath].mdc | optional-standard-parameter(s): [params]
```

For example:
```markdown
# mode: dev-mode | workflow: rules-workflow | pathway: system-wide-optimization | filepath: @parameters/rules/dev-mode/system-wide-optimization.mdc | optional-standard-parameter(s): none
```

This header provides essential metadata about the parameter's purpose and usage.

## Manual Rule Behavior

As Manual rule type, parameters subsystem files:

1. **Activate on Reference**: Only applied when explicitly referenced
2. **Task-Specific Guidance**: Provide detailed guidance for specific tasks
3. **Domain Control**: Define what can be accessed and modified
4. **Mode-Dependent Operation**: Behave differently in plan-mode vs. dev-mode
5. **Message-Command Integration**: Designed for the message-command system

This explicit activation ensures focused, contextual application of execution frameworks.

## Domain Access Control

A key responsibility of the parameters subsystem is enforcing domain access control:

### Plan-Mode Domain Access

In plan-mode, parameters typically provide:
- Read access to all of 1000xbrain
- Edit access limited to the /planning directory
- No implementation outside planning documents

### Dev-Mode Domain Access

In dev-mode, domain access varies by pathway:
- system-wide/system-wide-optimization: Edit access to all of 1000xbrain/**
- subsystem-core: Edit access to 1000xbrain/knowledge/system-structure/ and 1000xbrain/core/
- subsystem-knowledge: Edit access to 1000xbrain/knowledge/system-structure/ and 1000xbrain/knowledge/
- subsystem-parameters: Edit access to 1000xbrain/knowledge/system-structure/ and 1000xbrain/parameters/
- subsystem-workflows: Edit access to 1000xbrain/knowledge/system-structure/ and 1000xbrain/workflows/

This structured domain access control ensures appropriate encapsulation and maintains the single source of truth architecture.

## Interaction with Other Subsystems

The parameters subsystem interacts with other subsystems in these specific ways:

### Parameters → Core Interaction

The parameters subsystem applies core principles to specific tasks:

- Follows core identity and behavioral principles
- Implements core mode specifications
- Applies core communication standards
- Follows core tool usage standards

### Parameters → Knowledge Interaction

The parameters subsystem uses knowledge through fetch_rules:

- Accesses system structure documentation
- References implementation patterns
- Retrieves domain-specific knowledge
- Applies specialized patterns

### Parameters → Workflows Interaction

The parameters subsystem guides workflow implementation:

- Defines workflow-specific pathways
- Provides implementation frameworks for each workflow
- Guides workflow-specific tool call processes
- Enforces workflow standards

## Implementation Patterns

When implementing changes to the parameters subsystem:

1. **Pathway Consistency**: Maintain consistent pathway structure across workflows
2. **Mode Separation**: Ensure clear separation between plan-mode and dev-mode
3. **Domain Access Clarity**: Clearly define domain access restrictions
4. **Knowledge Integration**: Reference system structure knowledge first
5. **Tool Call Processes**: Define structured tool call processes
6. **Completion Criteria**: Establish clear completion criteria

These patterns ensure effective parameter organization and implementation.

## Tool Call Process

The parameters subsystem enforces structured tool call processes:

### System-Wide Tool Call Process
1. `fetch_rules` to read relevant system-structure knowledge-base-files
2. `edit_file` to EDIT the relevant system-structure knowledge-base-files FIRST
3. Any other tool calls to make structural changes to the 1000xbrain system as a whole

### Subsystem-Specific Tool Call Process
1. `fetch_rules` to read relevant system-structure knowledge-base-files
2. `edit_file` to EDIT the relevant system-structure knowledge-base-files FIRST
3. Any other tool calls to make structural changes to the specific subsystem

### Workflow Tool Call Process
1. `fetch_rules` to read relevant system-structure knowledge-base-files
2. `edit_file` to EDIT relevant knowledge-base-files specific to the workflow
3. Any other tool calls to make changes to the workflow-specific brain-files throughout the subsystems

This documentation-first approach ensures that the single source of truth is always updated before making any system changes.

## Best Practices

### Parameter Organization

When organizing parameters:

1. **Workflow-First**: Organize by workflow type first
2. **Mode-Second**: Within workflows, organize by mode
3. **Consistent Pathways**: Maintain consistent pathway structure
4. **Clear Headers**: Include complete headers with all components
5. **Domain Specifications**: Clearly specify domain access restrictions
6. **Knowledge References**: Include clear knowledge references

### Parameter Creation

When creating new parameters:

1. **Follow Header Format**: Use the standard header format
2. **Document Purpose**: Clearly explain the parameter's purpose
3. **Specify Knowledge Access**: Include guidance on accessing relevant knowledge
4. **Define Tool Call Process**: Establish clear tool call processes
5. **Specify Domain Access**: Define domain access restrictions
6. **Include Completion Criteria**: Establish clear completion criteria

### Parameter Reference

When referencing parameters in message-commands:

1. **Use Full Paths**: Include the complete path to the parameter
2. **Include .mdc Extension**: Always use .mdc extension in references
3. **Follow Mode-Workflow-Pathway Pattern**: Use consistent pattern
4. **Specify All Components**: Include all five required components
5. **Use "none" Placeholders**: Use "none" for unused components

## Common Questions and Answers

### Q: What's the difference between pathways and workflows?
A: Workflows are broad domains of operation, while pathways are specific implementation contexts within a workflow.

### Q: When should I use direct-mode vs. plan-mode and dev-mode?
A: Direct-mode is appropriate for immediate, self-contained tasks, while plan-mode and dev-mode provide a more structured approach with clear separation between planning and implementation.

### Q: How do I determine which pathway to use?
A: Select the pathway that most closely matches the scope and focus of your task, considering domain access requirements.

### Q: What's the relationship between parameters and knowledge files?
A: Parameters define execution frameworks and reference knowledge files to provide detailed guidance without duplicating information.

## Related Knowledge Files

For more detailed information on related aspects of the system:

- For overall system architecture, see `knowledge/system-structure/system-architecture.md`
- For subsystem vs. system relationships, see `knowledge/system-structure/system-vs-subsystem.md`
- For core subsystem details, see `knowledge/system-structure/subsystem-core.md`
- For knowledge subsystem details, see `knowledge/system-structure/subsystem-knowledge.md`
- For workflows subsystem details, see `knowledge/system-structure/subsystem-workflows.md`
- For workflow relationships, see `knowledge/system-structure/workflow-subsystem-relationships.md`
- For pathway organization, see `knowledge/system-structure/pathway-organization.md` 