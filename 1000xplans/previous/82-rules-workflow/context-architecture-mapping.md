# Context Analysis: Project-Rule-Parameter System Architecture Mapping

## Cognitive Architecture Overview

The project-rule-parameter system is a critical component of the PolygonExpress cognitive architecture, enabling structured access to specialized implementation knowledge across different workflows. The system currently consists of two primary management components that need enhancement:

- `parameter-manager.md`: For managing single parameters
- `cross-workflow-parameter-manager.md`: For managing parameters across workflows

## Core Subsystems

### Parameter Registry System

The current parameter registry system uses two different approaches:
- Single parameter registry at `1000xscripts/parameters/parameter-registry.json`
- Cross-workflow alias registry at `1000xscripts/parameters/alias-registry.json`

These registries store metadata about parameters but follow different structures and management approaches, creating inconsistency.

### Parameter Management Commands

Current parameter management relies on two project-rule-parameters:
- `@parameters/rules/helpers/parameter-management/parameter-manager.mdc`: Handles basic parameter operations
- `@parameters/rules/helpers/parameter-management/cross-workflow-parameter-manager.mdc`: Handles cross-workflow operations

These commands do not provide a complete pathway for planning and implementing parameter changes, leading to one-off command usage patterns.

### Parameter Reference System

Parameters are currently referenced in two ways:
- Direct path references: `@parameters/rules/plan-mode/template-basic.mdc`
- Alias references: `@alias:rules:template-basic` (newer system)

The transition between these systems is incomplete, with both formats currently in use.

## Workflow Subsystems

Each workflow type in the system requires specialized parameters:

| Workflow | Parameter Directory | Focus | Current Management |
|----------|---------------------|-------|-------------------|
| rules-workflow | parameters/rules/ | Cognitive architecture | Inconsistent |
| front-end-workflow | parameters/front-end/ | UI implementation | Inconsistent |
| back-end-workflow | parameters/back-end/ | API implementation | Inconsistent |
| documentation-workflow | parameters/documentation/ | Documentation standards | Inconsistent |
| scripts-workflow | parameters/scripts/ | Script automation | Inconsistent |

Each workflow requires dedicated parameter management pathways that don't currently exist.

## Knowledge Subsystems

The parameter system connects to these knowledge components:

- `knowledge/guides/parameter-implementation`: Implementation guidance for parameters
- `knowledge/guides/parameter-standardization`: Standards for parameter creation
- `knowledge/patterns/doc/parameter-template`: Templates for parameter documentation

These knowledge subsystems need to be integrated with the enhanced parameter management system.

## Integration Points

Key integration points in the current architecture:

1. **Message-Command System**: Parameters are referenced in message-commands
2. **1000xscripts Automation**: Parameter management relies on PowerShell scripts
3. **Cursor Rules System**: Parameters must be synchronized with .mdc files
4. **Knowledge Access System**: Parameters should integrate with fetch_rules

## Enhancement Impact

The planned enhancement will impact the following areas:

1. **Parameter Registry**: Unifying the registry system
2. **Command Structure**: Creating dedicated pathways for parameter management
3. **Reference System**: Standardizing on the alias reference system
4. **Workflow Integration**: Providing workflow-specific parameter management
5. **Cross-System Consistency**: Ensuring parameters follow consistent patterns
6. **Parameter Creation Workflow**: Establishing a clear planning → implementation pathway

## System Gaps

Current system gaps that need addressing:

1. **No Planning Pathway**: Missing structured approach for planning parameter changes
2. **Implementation Fragmentation**: Parameter implementation is scattered across scripts
3. **Inconsistent Management**: Different approaches used for different parameter types
4. **Missing Management Commands**: No specific commands for creating rule parameters
5. **Workflow Isolation**: No dedicated parameter management for each workflow type
6. **Incomplete Migration**: Partial transition to alias-based references 