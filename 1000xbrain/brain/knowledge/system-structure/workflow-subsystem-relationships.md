# USE WHEN understanding how workflows span across subsystems in the 1000xbrain system

# Workflow-Subsystem Relationships

## Overview

This knowledge file provides a comprehensive explanation of how workflows span across subsystems within the 1000xbrain cognitive architecture, clarifying the relationships between workflows and subsystems and providing guidance on cross-subsystem workflow implementation.

## Fundamental Relationship Principle

The relationship between workflows and subsystems follows a fundamental principle:

> **Each workflow is implemented across all four subsystems, with each subsystem contributing a different aspect of the workflow's functionality.**

This means that workflows are not contained within a single subsystem but rather extend across the entire cognitive architecture with specialized components in each subsystem.

## Cross-Cutting Workflow Structure

Workflows cut across subsystems in a structured way, forming a matrix organization:

```
                     ┌─────────────────────────────────────────────┐
                     │               WORKFLOWS                     │
                     ├─────────┬─────────┬─────────┬───────┬───────┤
                     │ rules   │ quality │front-end│back-end│scripts│
┌────────────────┐   │ workflow│ workflow│ workflow│workflow│workflow│
│                │   │         │         │         │        │        │
│   SUBSYSTEMS   │   │         │         │         │        │        │
│                │   │         │         │         │        │        │
├────────────────┼───┼─────────┼─────────┼─────────┼───────┼───────┤
│ Core           │   │    X    │    X    │    X    │   X    │   X    │
│ (Always)       │   │         │         │         │        │        │
├────────────────┼───┼─────────┼─────────┼─────────┼───────┼───────┤
│ Knowledge      │   │    X    │    X    │    X    │   X    │   X    │
│ (Agent Request)│   │         │         │         │        │        │
├────────────────┼───┼─────────┼─────────┼─────────┼───────┼───────┤
│ Parameters     │   │    X    │    X    │    X    │   X    │   X    │
│ (Manual)       │   │         │         │         │        │        │
├────────────────┼───┼─────────┼─────────┼─────────┼───────┼───────┤
│ Workflows      │   │    X    │    X    │    X    │   X    │   X    │
│ (Auto-Attached)│   │         │         │         │        │        │
└────────────────┴───┴─────────┴─────────┴─────────┴───────┴───────┘
```

Each "X" represents a unique intersection of workflow and subsystem, where specific aspects of the workflow are implemented according to that subsystem's role.

## Workflow Implementation by Subsystem

Each subsystem contributes a specific aspect to workflow implementation:

### 1. Core Subsystem Contribution

The core subsystem provides the fundamental principles for each workflow:

- **Identity Integration**: How the workflow aligns with 1000xdev's identity
- **Mode System Integration**: How the workflow operates in each mode
- **Communication Standards**: Workflow-specific communication patterns
- **Tool Usage Principles**: Fundamental tool usage standards for the workflow
- **Foundational Behavior**: Essential behavioral patterns for the workflow

Example: `1000xbrain/core/[workflow-type]/identity.md`

### 2. Knowledge Subsystem Contribution

The knowledge subsystem provides specialized knowledge for each workflow:

- **Implementation Patterns**: Reusable patterns specific to the workflow
- **Reference Information**: Canonical knowledge about workflow concepts
- **Domain-Specific Knowledge**: Specialized information for the workflow
- **Error Resolution**: Approaches for resolving workflow-specific errors
- **Best Practices**: Detailed best practices for the workflow

Example: `1000xbrain/knowledge/[workflow-type]/patterns/implementation.md`

### 3. Parameters Subsystem Contribution

The parameters subsystem provides execution frameworks for each workflow:

- **Pathway Definitions**: Defines pathways within the workflow
- **Execution Frameworks**: Detailed frameworks for specific tasks
- **Domain Access Control**: Defines domain access for the workflow
- **Tool Call Processes**: Structured processes for implementation
- **Completion Criteria**: Clear criteria for task completion

Example: `1000xbrain/parameters/[workflow-type]/plan-mode/system-wide.md`

### 4. Workflows Subsystem Contribution

The workflows subsystem provides implementation guidance for each workflow:

- **Activation Patterns**: Defines when the workflow is activated
- **Implementation Standards**: Standards specific to the workflow
- **Context-Specific Behavior**: Behavior tailored to specific contexts
- **Integration Guidance**: How to integrate with other workflows
- **Evolution Guidance**: How the workflow evolves over time

Example: `1000xbrain/workflows/[workflow-type]/implementation-guide.md`

## Workflow Type Implementation Examples

### Rules-Workflow Implementation

The rules-workflow is implemented across all four subsystems:

1. **Core Subsystem**: Defines fundamental principles for cognitive architecture enhancement
   - `1000xbrain/core/rules/identity.md`: How rules-workflow aligns with identity
   - `1000xbrain/core/rules/mode-integration.md`: How rules operate in different modes

2. **Knowledge Subsystem**: Provides specialized knowledge for cognitive enhancement
   - `1000xbrain/knowledge/rules/patterns/`: Implementation patterns for rules
   - `1000xbrain/knowledge/rules/system-structure/`: System structure documentation

3. **Parameters Subsystem**: Defines execution frameworks for rules tasks
   - `1000xbrain/parameters/rules/plan-mode/`: Planning parameters for rules
   - `1000xbrain/parameters/rules/dev-mode/`: Development parameters for rules

4. **Workflows Subsystem**: Provides implementation guidance for rules
   - `1000xbrain/workflows/rules/`: Implementation guides for rules workflow
   - `1000xbrain/workflows/rules/activation.md`: When rules workflow is activated

### Front-End Workflow Implementation

The front-end-workflow is implemented across all four subsystems:

1. **Core Subsystem**: Defines fundamental principles for front-end development
   - `1000xbrain/core/front-end/identity.md`: How front-end aligns with identity
   - `1000xbrain/core/front-end/tool-integration.md`: Core tool usage for front-end

2. **Knowledge Subsystem**: Provides specialized knowledge for front-end
   - `1000xbrain/knowledge/front-end/patterns/`: Front-end implementation patterns
   - `1000xbrain/knowledge/front-end/frameworks/`: Framework-specific knowledge

3. **Parameters Subsystem**: Defines execution frameworks for front-end tasks
   - `1000xbrain/parameters/front-end/plan-mode/`: Planning parameters for front-end
   - `1000xbrain/parameters/front-end/dev-mode/`: Development parameters for front-end

4. **Workflows Subsystem**: Provides implementation guidance for front-end
   - `1000xbrain/workflows/front-end/`: Implementation guides for front-end
   - `1000xbrain/workflows/front-end/standards.md`: Front-end implementation standards

## Cross-Subsystem Coordination

Effective workflow implementation requires coordination across subsystems:

### 1. Documentation-First Approach

Always start by updating knowledge subsystem files, particularly system-structure:

1. **Update System Structure**: Ensure system-structure documentation is updated first
2. **Then Update Core Files**: Update core subsystem files related to the workflow
3. **Next Update Parameter Files**: Update parameters subsystem files for the workflow
4. **Finally Update Workflow Files**: Update workflows subsystem files for the workflow

This sequence ensures that documentation is accurate before implementation.

### 2. Consistent Standards Across Subsystems

Maintain consistent standards across all subsystem implementations:

- **Terminology Consistency**: Use consistent terminology for workflow concepts
- **Pattern Consistency**: Apply consistent patterns across subsystems
- **Role Clarity**: Maintain clear separation of subsystem roles
- **Cross-References**: Include clear references to related files in other subsystems
- **Standard Structures**: Follow standard file structures for each subsystem

### 3. Workflow Evolution Coordination

When evolving a workflow, coordinate changes across all subsystems:

1. **Document Changes First**: Update system-structure documentation first
2. **Coordinate Updates**: Update all subsystems in the correct sequence
3. **Maintain Compatibility**: Ensure changes are compatible across subsystems
4. **Version Alignment**: Keep all subsystem implementations aligned
5. **Documentation Updates**: Update all documentation to reflect changes

## File Location Guidelines

When determining where files related to a workflow should be located:

### Core Principles Files

Place in the core subsystem when the file:
- Defines fundamental identity aspects of the workflow
- Establishes core principles that apply across the workflow
- Defines mode-specific behavior for the workflow
- Establishes communication standards for the workflow

Example: `1000xbrain/core/[workflow-type]/principles.md`

### Knowledge Files

Place in the knowledge subsystem when the file:
- Provides specialized, detailed knowledge about the workflow
- Defines implementation patterns for the workflow
- Provides reference information about workflow concepts
- Documents best practices for the workflow
- Provides error resolution guidance for the workflow

Example: `1000xbrain/knowledge/[workflow-type]/patterns/implementation.md`

### Parameter Files

Place in the parameters subsystem when the file:
- Defines specific execution frameworks for workflow tasks
- Establishes pathways within the workflow
- Defines domain access controls for the workflow
- Specifies tool call processes for the workflow
- Establishes completion criteria for workflow tasks

Example: `1000xbrain/parameters/[workflow-type]/plan-mode/system-wide.md`

### Workflow Guidance Files

Place in the workflows subsystem when the file:
- Provides implementation guidance specific to the workflow
- Defines activation patterns for the workflow
- Establishes implementation standards for the workflow
- Provides context-specific behavior guidance
- Documents workflow integration with other workflows

Example: `1000xbrain/workflows/[workflow-type]/implementation-guide.md`

## Common Cross-Cutting Implementation Scenarios

### 1. Implementing a New Feature Across Subsystems

When implementing a new feature that spans multiple subsystems:

1. **Document in Knowledge**: Create comprehensive documentation in knowledge/system-structure
2. **Define Core Principles**: Establish core principles in the core subsystem
3. **Create Parameters**: Define execution frameworks in the parameters subsystem
4. **Provide Implementation Guidance**: Create implementation guides in the workflows subsystem

### 2. Enhancing an Existing Workflow

When enhancing an existing workflow:

1. **Update Documentation**: Enhance documentation in knowledge/system-structure
2. **Refine Core Principles**: Update core principles in the core subsystem
3. **Enhance Parameters**: Improve execution frameworks in the parameters subsystem
4. **Update Implementation Guidance**: Enhance implementation guides in the workflows subsystem

### 3. Creating a New Workflow Type

When creating a new workflow type:

1. **Document Structure**: Document the workflow in knowledge/system-structure
2. **Establish Core Principles**: Define core principles in the core subsystem
3. **Create Parameters**: Develop execution frameworks in the parameters subsystem
4. **Provide Implementation Guidance**: Create implementation guides in the workflows subsystem
5. **Coordinate Activation**: Ensure proper activation patterns across all subsystems

## Common Questions and Answers

### Q: How do I know which subsystem should contain a particular file?
A: Determine the file's primary purpose - fundamental principles (core), specialized knowledge (knowledge), execution frameworks (parameters), or implementation guidance (workflows).

### Q: Can workflows exist only in some subsystems but not others?
A: No, each workflow must have appropriate implementation across all four subsystems to ensure complete functionality.

### Q: How do I ensure consistency across subsystem implementations?
A: Always start by updating system-structure documentation, then update each subsystem in sequence while maintaining consistent terminology and patterns.

### Q: What's the relationship between a workflow's pathway and its subsystem implementations?
A: Pathways are defined within the parameters subsystem but affect how the workflow is implemented across all subsystems.

### Q: How do I handle conflicts between different subsystem implementations?
A: Core subsystem implementations take precedence, followed by knowledge, parameters, and workflows subsystems.

## Related Knowledge Files

For more detailed information on related aspects of the system:

- For overall system architecture, see `knowledge/system-structure/system-architecture.md`
- For subsystem vs. system relationships, see `knowledge/system-structure/system-vs-subsystem.md`
- For core subsystem details, see `knowledge/system-structure/subsystem-core.md`
- For knowledge subsystem details, see `knowledge/system-structure/subsystem-knowledge.md`
- For parameters subsystem details, see `knowledge/system-structure/subsystem-parameters.md`
- For workflows subsystem details, see `knowledge/system-structure/subsystem-workflows.md`
- For pathway organization, see `knowledge/system-structure/pathway-organization.md` 