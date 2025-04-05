# 1000xbrain System Organization

## System Overview

The 1000xbrain cognitive architecture is organized as a hierarchical system with four distinct subsystems, each containing documentation for all workflow types.

## System Hierarchy

1. **1000xbrain SYSTEM** - The overall cognitive architecture
   
2. **Four SUBSYSTEMS** - Major functional divisions:
   - Core Subsystem
   - Knowledge Subsystem
   - Parameters Subsystem
   - Workflows Subsystem
   
3. **Workflow Documentation** - Each subsystem contains documentation for all workflow types:
   - rules-workflow
   - quality-workflow
   - front-end-workflow
   - back-end-workflow
   - scripts-workflow

## Subsystem Purposes and Rule Types

### Core Subsystem
- **Purpose**: Defines essential identity, modes, communication standards, and tools
- **Files**: core-brain-files
- **Rule Type**: Always rules (automatically applied to all conversations)
- **Example Files**: core/identity/global-rules.md, core/modes/plan-mode.md

### Knowledge Subsystem
- **Purpose**: Contains specialized knowledge accessible through fetch_rules
- **Files**: knowledge-base-files
- **Rule Type**: Agent Requested rules (accessed only when explicitly requested)
- **Required Header**: # USE WHEN [usage guidance]
- **Example Files**: knowledge/rules/patterns/modes/plan-mode-patterns.md

### Parameters Subsystem
- **Purpose**: Defines specialized execution parameters for specific operations
- **Files**: project-rule-parameters
- **Rule Type**: Manual rules (accessed only when explicitly referenced in message-commands)
- **Required Header**: # mode: [mode] | workflow: [workflow-type] | pathway: [pathway-name] | filepath: @[filepath].mdc | optional-standard-parameter(s): [params]
- **Example Files**: parameters/quality/plan-mode/quality-system.md

### Workflows Subsystem
- **Purpose**: Provides workflow-specific guidance and implementation patterns
- **Files**: workflow-files
- **Rule Type**: Auto Attached rules (automatically attached when relevant workspace is loaded)
- **Example Files**: workflows/quality/quality-workflow.md

## File Organization Within Subsystems

Each subsystem organizes its files hierarchically by workflow type:

```
1000xbrain/                         # SYSTEM
├── core/                           # SUBSYSTEM
│   ├── modes/                      # Category
│   │   ├── plan-mode.md            # Core file for all workflows
│   │   └── ...
├── knowledge/                      # SUBSYSTEM
│   ├── rules/                      # Workflow type
│   │   └── ...
│   ├── quality/                    # Workflow type
│   │   └── ...
│   └── ...
├── parameters/                     # SUBSYSTEM
│   ├── rules/                      # Workflow type 
│   │   └── ...
│   ├── quality/                    # Workflow type
│   │   └── ...
│   └── ...
└── workflows/                      # SUBSYSTEM
    ├── rules/                      # Workflow type
    │   └── ...
    ├── quality/                    # Workflow type
    │   └── ...
    └── ...
```

## Critical System-Subsystem Distinctions

1. **The System is NOT a Workflow**: The 1000xbrain system contains all workflows but is not itself a workflow.
2. **Subsystems are NOT Workflows**: Each subsystem contains documentation for all workflows but is not itself a workflow.
3. **Workflows Exist Across Subsystems**: Each workflow type has documentation in all four subsystems.
4. **Rule Types Differ by Subsystem**: Each subsystem has a specific rule type and activation mechanism.

## Cross-Subsystem Interactions

The subsystems interact in specific ways:
1. **Core → All**: Core files define the foundational principles used by all other subsystems
2. **Knowledge ← All**: Knowledge files are accessed by fetch_rules from any subsystem
3. **Parameters ← Workflows**: Parameter files are referenced in message-commands
4. **Workflows → Parameters**: Workflow files guide the implementation of parameters

## Proper Mental Model

Think of the 1000xbrain system as a university with four colleges (subsystems), each containing departments for five different disciplines (workflows). Each college approaches the disciplines from its own perspective:

- Core College: Foundational principles for all disciplines
- Knowledge College: Specialized knowledge for each discipline
- Parameters College: Execution frameworks for specific tasks in each discipline
- Workflows College: Practical implementation guides for each discipline

Each discipline (workflow) exists across all colleges (subsystems), but with different purposes and approaches in each.

## Visual System Map

```
                                  1000xbrain SYSTEM
                                          │
                ┌──────────────┬──────────┴───────────┬──────────────┐
                │              │                      │              │
         Core Subsystem Knowledge Subsystem   Parameters Subsystem Workflows Subsystem
                │              │                      │              │
    ┌───────────┼──────────────┼──────────────┬──────┴───────┐      │
    │           │              │              │              │      │
rules-workflow quality-workflow front-end-workflow back-end-workflow scripts-workflow
```

The above diagram illustrates the hierarchical organization of the 1000xbrain system, with the four subsystems at the top level and the five workflow types spanning across all subsystems.

## Common Misconceptions

1. **Mistaking "system" for a workflow component**: When you see "system" in message-commands like `quality-workflow system`, it refers to system-wide quality assessment of the entire 1000xbrain cognitive architecture, not a component within the quality workflow.

2. **Treating subsystems as separate systems**: The four subsystems (core, knowledge, parameters, workflows) are integral parts of the single 1000xbrain system, not independent systems.

3. **Confusing subsystems with workflows**: Subsystems are structural divisions of the system, while workflows are functional domains that span across all subsystems.

## Implementation Guidance

When implementing changes to the 1000xbrain cognitive architecture:

1. **Identify the subsystem**: Determine which subsystem the file belongs to based on its purpose and access pattern.
2. **Apply the correct rule type**: Use the appropriate rule type based on the subsystem.
3. **Organize by workflow**: Within each subsystem, organize files by workflow type where appropriate.
4. **Maintain cross-subsystem consistency**: Ensure consistent terminology and concepts across subsystems.
5. **Use correct file references**: Reference files with the appropriate extension (.md for editing, .mdc for message-commands).

By maintaining a clear understanding of the system structure, we can prevent hallucinations and implementation errors that arise from conceptual confusion. 