# rules-workflow | system-wide-optimization

## Overview

This planning and implementation process will create a streamlined, highly efficient rules-workflow system with a single source of truth architecture. Your editing domain for this planning and implementation process is:

- `1000xbrain/knowledge/system-structure/**` - Primary focus, create comprehensive single source of truth
- `1000xbrain/parameters/rules/**` - Secondary focus, streamline project-rule-parameters
- `1000xbrain/knowledge/**` - Supporting focus, reorganize knowledge files as needed
- `1000xbrain/README.md` - Update as needed for system-wide consistency

## Core Objective

Create a **single source of truth** for the 1000xbrain system structure within `knowledge/system-structure/`. This documentation will serve as the foundation for all rules-workflow project-rule-parameters. The primary principles are:

1. All system structure documentation belongs in `knowledge/system-structure/`
2. All changes to system structure MUST first update this single source of truth
3. Project-rule-parameters will fetch this knowledge rather than duplicating it
4. This creates a maintainable, consistent documentation system

## System Structure Context

To ensure clarity, here is the system hierarchy that must be documented and maintained:

- **system**: 1000xbrain/** - The complete cognitive architecture
- **subsystem-core**: 1000xbrain/core/** (Always rule types, core-brain-files)
- **subsystem-knowledge**: 1000xbrain/knowledge/** (Agent Requested rule types, knowledge-base-files)
- **subsystem-parameters**: 1000xbrain/parameters/** (Manual rule types, project-rule-parameters)
- **subsystem-workflows**: 1000xbrain/workflows/** (Auto Attached rule types, workflow-files)

## Project-Rule-Parameter Restructuring

After implementation, the rules-workflow project-rule-parameters will be streamlined to this structure:

| Pathway | Project-Rule-Parameters | Optional Standard Parameter(s) | Domain Access |
|---------|-------------------------|--------------------------------|---------------|
| system-wide | parameters/rules/plan-mode/system-wide.mdc parameters/rules/dev-mode/system-wide.mdc | none | All of 1000xbrain/** |
| system-wide-optimization | parameters/rules/plan-mode/system-wide-optimization.mdc parameters/rules/dev-mode/system-wide-optimization.mdc | none | All of 1000xbrain/** |
| subsystem-core | parameters/rules/plan-mode/subsystem-core.mdc parameters/rules/dev-mode/subsystem-core.mdc | none | Read: All of 1000xbrain in plan-mode<br>Edit: 1000xbrain/knowledge/system-structure/ and 1000xbrain/core/ in dev-mode |
| subsystem-knowledge | parameters/rules/plan-mode/subsystem-knowledge.mdc parameters/rules/dev-mode/subsystem-knowledge.mdc | none | Read: All of 1000xbrain in plan-mode<br>Edit: 1000xbrain/knowledge/system-structure/ and 1000xbrain/knowledge/ in dev-mode |
| subsystem-parameters | parameters/rules/plan-mode/subsystem-parameters.mdc parameters/rules/dev-mode/subsystem-parameters.mdc | none | Read: All of 1000xbrain in plan-mode<br>Edit: 1000xbrain/knowledge/system-structure/ and 1000xbrain/parameters/ in dev-mode |
| subsystem-workflows | parameters/rules/plan-mode/subsystem-workflows.mdc parameters/rules/dev-mode/subsystem-workflows.mdc | none | Read: All of 1000xbrain in plan-mode<br>Edit: 1000xbrain/knowledge/system-structure/ and 1000xbrain/workflows/ in dev-mode |
| workflows | parameters/rules/plan-mode/workflows.mdc parameters/rules/dev-mode/workflows.mdc | [workflow-type] | Depends on the workflow-type, following subsystem domain access patterns |

## Key Architectural Principles

1. **Workflow Alignment**: There will be only one pathway for workflows to ensure alignment across all workflow types. The project-rule-parameters for plan-mode/workflows and dev-mode/workflows will take one standard-parameter: [workflow-type].

2. **Thorough Analysis Requirement**: To avoid confusion, there will be no direct-mode for any project-rule-parameter in rules-workflow. Every rules-workflow pathway needs to be thoroughly thought out and analyzed in plan-mode and dev-mode. The rules-workflow is primarily for major structural changes, like changing message-command syntax or creating new 1000xdevelopment processes.

3. **Parameter Encapsulation**: Details of pathways should not be documented in any other subsystem besides the subsystem parameters, and should only be known to you when manually referenced in the chat as project-rule-parameters. This structure allows easy addition or removal of new project-rule-parameters categorized by pathway, without needing to change any other subsystems.

4. **Subsystem Independence**: Changes to the parameters subsystem should not affect any other subsystem. Do not create any specific detailed documentation on pathways anywhere in other subsystems. If pathways are mentioned, it must be high-level and not specific to any workflow.

5. **Pathway Categories Focus**: The categorization of processes within workflows is mainly for the scripts, so that when I run the script to list all the project-rule-parameters, I can categorize them by workflow-type and pathway-name. The pathway does not affect your development nor planning pathway, as only the content within the project-rule-parameter actually guides your planning and development processes.

6. **Domain Access Control**: Each pathway's project-rule-parameters has specific domain access rules that define what can be read and edited in different modes. This ensures proper encapsulation and maintains the single source of truth architecture.

## Implementation Steps

### 1. System Structure Knowledge Base
Plan the implementation of `1000xbrain/knowledge/system-structure/` to contain comprehensive knowledge-base-files for the 1000xbrain system and each subsystem. This knowledge-base folder will be the most important folder in 1000xbrain and must include:

- System-level documentation explaining the overall architecture
- Subsystem-level documentation for each of the four subsystems
- Clear explanations of the relationships between subsystems
- Comprehensive documentation of how workflows span across subsystems
- Documentation of how pathways operate within workflows

### 2. System-Wide Tool Call Process
Plan the implementation of system-wide and system-wide-optimization project-rule-parameters to adhere to this strict tool call process:

1. `fetch_rules` to read relevant system-structure knowledge-base-files
2. `edit_file` to EDIT the relevant system-structure knowledge-base-files FIRST
3. Any other tool calls to make structural changes to the 1000xbrain system as a whole

This ensures the single source of truth is always updated before any other changes.

### 3. Subsystem-Specific Tool Call Process
Plan the implementation of each subsystem pathway to adhere to this strict tool call process:

1. `fetch_rules` to read relevant system-structure knowledge-base-files
2. `edit_file` to EDIT the relevant system-structure knowledge-base-files FIRST
3. Any other tool calls to make structural changes to the specific subsystem

This ensures that documentation for each subsystem is updated before making changes.

### 4. Workflow Project-Rule-Parameters
Plan the implementation of the workflow project-rule-parameters to adhere to this strict tool call process:

1. `fetch_rules` to read relevant system-structure knowledge-base-files
2. `edit_file` to EDIT relevant knowledge-base-files specific to the workflow
3. Any other tool calls to make changes to the workflow-specific brain-files throughout the subsystems (should go one subsystem at a time for consistency)

The workflow pathway must be able to accommodate any workflow, even if we create new workflows. The process of understanding the system and subsystems must be the same. This is because each workflow-type has distinct documentation in three subsystems: knowledge, parameters, and workflows. When making changes to a workflow, you MUST adhere to the subsystem requirements when making changes to the workflow files within the subsystems.

## Domain Access Specifications

Each pathway's project-rule-parameters has specific domain access rules:

### system-wide and system-wide-optimization
- **Domain Access**: Full read and edit access to all of 1000xbrain/**
- **Rationale**: These pathways affect the entire cognitive architecture and require comprehensive access

### subsystem-core
- **Plan-Mode Domain Access**: Read access to all of 1000xbrain
- **Dev-Mode Domain Access**: Edit access to 1000xbrain/knowledge/system-structure/ and 1000xbrain/core/
- **Rationale**: Updates to documentation first, then implementation in the core subsystem

### subsystem-knowledge
- **Plan-Mode Domain Access**: Read access to all of 1000xbrain
- **Dev-Mode Domain Access**: Edit access to 1000xbrain/knowledge/system-structure/ and 1000xbrain/knowledge/
- **Rationale**: Updates to documentation first, then implementation in the knowledge subsystem

### subsystem-parameters
- **Plan-Mode Domain Access**: Read access to all of 1000xbrain
- **Dev-Mode Domain Access**: Edit access to 1000xbrain/knowledge/system-structure/ and 1000xbrain/parameters/
- **Rationale**: Updates to documentation first, then implementation in the parameters subsystem

### subsystem-workflows
- **Plan-Mode Domain Access**: Read access to all of 1000xbrain
- **Dev-Mode Domain Access**: Edit access to 1000xbrain/knowledge/system-structure/ and 1000xbrain/workflows/
- **Rationale**: Updates to documentation first, then implementation in the workflows subsystem

### workflows
- **Domain Access**: Follows the relevant subsystem access patterns based on the workflow-type
- **Rationale**: Workflow-specific documentation spans multiple subsystems and requires coordinated updates

## Success Criteria

The implementation will be successful when:

1. The knowledge/system-structure directory contains comprehensive documentation that serves as the single source of truth
2. All project-rule-parameters are restructured according to the defined pathways
3. All project-rule-parameters properly reference the knowledge/system-structure files
4. The workflow pathway can accommodate any workflow with a consistent process
5. All tool call processes strictly follow the defined sequence
6. System-wide consistency is maintained across all subsystems
7. Domain access specifications are clearly documented and enforced for each parameter