# Cognitive Architecture Mapping for Steam Web API Integration

## Architecture Overview

This document maps the relevant components of the 1000xbrain cognitive architecture that will be affected by the Steam Web API integration. It provides a comprehensive view of the interconnections between various subsystems and how they will interact with Steam-related functionality.

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                                                                              │
│                     STEAM WEB API INTEGRATION ARCHITECTURE                   │
│                                                                              │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────────────┐  │
│  │                 │    │                 │    │                         │  │
│  │  KNOWLEDGE      │───▶│  PARAMETERS     │───▶│  WORKFLOWS              │  │
│  │  COMPONENTS     │    │  COMPONENTS     │    │  COMPONENTS             │  │
│  │                 │    │                 │    │                         │  │
│  └─────────────────┘    └─────────────────┘    └─────────────────────────┘  │
│          │                      │                         │                  │
│          │                      │                         │                  │
│          ▼                      ▼                         ▼                  │
│  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────────────┐  │
│  │                 │    │                 │    │                         │  │
│  │  FRONT-END      │◀──▶│  BACK-END       │◀──▶│  RULES ENHANCEMENT      │  │
│  │  INTEGRATION    │    │  INTEGRATION    │    │  COMPONENTS             │  │
│  │                 │    │                 │    │                         │  │
│  └─────────────────┘    └─────────────────┘    └─────────────────────────┘  │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

## Component Relationships and Dependencies

### Knowledge Components

The knowledge components form the foundational understanding of Steam Web API functionality:

1. **Primary Knowledge Components**:
   - `knowledge/front-end/steam-web-api/` - Front-end specific Steam knowledge
   - `knowledge/back-end/steam-web-api/` - Back-end specific Steam knowledge
   
2. **Knowledge Component Dependencies**:
   - Dependent on existing `knowledge/rules/` structure for access patterns
   - Referenced by parameter files for specific implementation guidance
   - Used by workflows for behavior specialization

### Parameter Components

Parameter components provide behavior specialization across different workflows:

1. **Front-end Parameters**:
   - `parameters/front-end/plan-mode/steam-web-api.md`
   - `parameters/front-end/dev-mode/steam-web-api.md`
   - `parameters/front-end/direct-mode/steam-web-api.md`

2. **Back-end Parameters**:
   - `parameters/back-end/plan-mode/steam-web-api.md`
   - `parameters/back-end/dev-mode/steam-web-api.md`
   - `parameters/back-end/direct-mode/steam-web-api.md`

3. **Parameter Relationships**:
   - Access knowledge components for implementation guidance
   - Referenced by workflows for message-command processing
   - Used in rules enhancement for pathway specialization

### Workflow Components

Workflow components define auto-attached behavior patterns for specific file types:

1. **Front-end Workflow Components**:
   - Updates to existing `workflows/front-end/` files
   - New specialized workflow files for Steam-specific behaviors

2. **Back-end Workflow Components**:
   - Creation of new `workflows/back-end/` files
   - Implementation of Steam-specific workflow patterns

3. **Workflow Relationships**:
   - Auto-attached based on file matching patterns
   - Provide specialized behavior for Steam-related files
   - Reference knowledge components for context

## Cross-System Integration Points

The Steam Web API integration spans multiple subsystems with these key integration points:

### Front-end and Back-end Integration

1. **API Communication Layer**:
   - Front-end components make requests to back-end endpoints
   - Back-end provides Steam data processing and caching
   - Shared data structures and contracts

2. **Authentication Flow**:
   - Login with Steam functionality spans front and back end
   - Security token management across components
   - Session handling and user identification

### Rules Enhancement Integration

1. **Cognitive Architecture Enhancement**:
   - Mode handling for Steam-specific operations
   - Cross-workflow communication patterns
   - Specialized knowledge access patterns for Steam data

2. **Pathway Management**:
   - Creation of Steam-specific pathways
   - Integration of pathways with existing workflow patterns
   - Context passing between pathways

## Dependency Map

The following dependency map shows the relationships between components:

```
                    ┌─────────────────────────────────────┐
                    │                                     │
                    │     KNOWLEDGE COMPONENTS            │
                    │                                     │
┌───────────────────┼─────────────────────────────────────┼───────────────────┐
│                   │                                     │                   │
│  knowledge/       │ knowledge/                          │ knowledge/        │
│  front-end/       │ rules/                              │ back-end/         │
│  steam-web-api/   │ guides/                             │ steam-web-api/    │
│                   │ patterns/                           │                   │
└───────────────────┼─────────────────────────────────────┼───────────────────┘
                    │                 ▲                   │
                    │                 │                   │
                    └─────────────────┼───────────────────┘
                                      │
                    ┌─────────────────┼───────────────────┐
                    │                 │                   │
                    │    PARAMETER COMPONENTS             │
                    │                                     │
┌───────────────────┼─────────────────────────────────────┼───────────────────┐
│                   │                                     │                   │
│  parameters/      │ parameters/                         │ parameters/       │
│  front-end/       │ rules/                              │ back-end/         │
│  */steam-web-api   │ */steam-web-api                     │ */steam-web-api   │
│                   │                                     │                   │
└───────────────────┼─────────────────────────────────────┼───────────────────┘
                    │                 ▲                   │
                    │                 │                   │
                    └─────────────────┼───────────────────┘
                                      │
                    ┌─────────────────┼───────────────────┐
                    │                 │                   │
                    │    WORKFLOW COMPONENTS              │
                    │                                     │
┌───────────────────┼─────────────────────────────────────┼───────────────────┐
│                   │                                     │                   │
│  workflows/       │ workflows/                          │ workflows/        │
│  front-end/       │ rules/                              │ back-end/         │
│                   │                                     │                   │
└───────────────────┴─────────────────────────────────────┴───────────────────┘
```

## Key Architecture Considerations

1. **File Location Consistency**:
   - All Steam-related files must follow existing directory structures
   - Knowledge files in appropriate knowledge directories
   - Parameter files in mode-specific parameter directories
   - Workflow files in appropriate workflow directories

2. **Naming Consistency**:
   - Use `steam-web-api` identifier consistently across all files
   - Follow existing naming patterns for all new files
   - Maintain consistent pathway naming across workflows

3. **Header Requirements**:
   - Knowledge files: `# USE WHEN [description-of-file]`
   - Parameter files: `# workflow: [workflow-type] | pathway: [pathway-name] | message-command: [message-command] | standard-parameter(s): [standard-parameter] | project-rule-parameter-filepath: [project-rule-parameter-filepath]`

4. **Reference Patterns**:
   - References to knowledge must use fetch_rules with proper format
   - References to parameters must use `@` symbol with .mdc extension
   - All `@` symbols must be wrapped in backticks in documentation

## Integration Success Metrics

Successful architecture integration will be measured by:

1. **Structural Integrity**:
   - All files properly placed in the cognitive architecture
   - Consistent naming and structure across components
   - Proper header formatting for all files

2. **Functional Integrity**:
   - Knowledge components properly accessible through fetch_rules
   - Parameter files accessible through message-commands
   - Workflow components properly auto-attached based on file patterns

3. **Cross-System Cohesion**:
   - Seamless transitions between Steam-related workflows
   - Consistent behavior across modes when working with Steam data
   - Effective knowledge sharing between front-end and back-end components 