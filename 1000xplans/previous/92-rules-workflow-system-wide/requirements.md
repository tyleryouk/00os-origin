# System-Wide Optimization of 1000xbrain

## Overview

This is a full cleanse and re-implementation of 1000xbrain designed to create a more efficient, streamlined cognitive architecture. We will implement a comprehensive system-wide optimization across four sequential planning folders (92-95), with each building upon the previous one to create a cohesive, optimized cognitive system.

## Implementation Structure

The system-wide optimization will be implemented across four planning folders:

1. **92-rules-workflow-system-wide (Current)**: Planning and preparation for system-wide optimization
   - Create the new system-wide-optimization pathway
   - Design project-rule-parameters for the pathway
   - Analyze the current system and identify optimization targets
   - **IMPORTANT**: During plan-mode for this folder, you must create the planning folders 93, 94, and 95 as described below

2. **93-rules-workflow-system-wide-optimization**: Part 1 of implementation
   - Focus on core subsystem optimization
   - Streamline core brain-files to under 2000 lines total
   - Implement new message-command format
   - Standardize common-words

3. **94-rules-workflow-system-wide-optimization**: Part 2 of implementation
   - Focus on knowledge and parameters subsystems
   - Reorganize knowledge-base-files by pathway
   - Enhance project-rule-parameters to leverage knowledge-base
   - Convert README.md files to index.md (except root)

4. **95-rules-workflow-system-wide-optimization**: Future enhancements
   - Requirements.md only (no implementation)
   - Identify additional optimization opportunities
   - Plan for ongoing evolution of the cognitive architecture

## Cross-Planning Folder Requirements

**CRITICAL**: The requirements outlined in this document apply across all four planning folders (92-95). When working in plan-mode for folder 92:

1. You must create complete planning documentation for folder 92
2. You must also create the planning folders 93, 94, and 95 with their respective requirements.md files and other necessary planning documents
3. Each planning folder builds upon the previous one, implementing the system-wide optimization in stages
4. All planning folders must follow the standards and guidelines outlined in this document

This approach ensures a cohesive, progressive implementation of the system-wide optimization across all four planning folders.

## Project-Rule-Parameters to Create

We will create two new project-rule-parameters for the system-wide-optimization pathway:

1. **Plan-Mode Parameter**:
   ```
   1000xbrain/parameters/rules/plan-mode/system-wide-optimization.md
   ```
   Header:
   ```
   # workflow: rules-workflow | pathway: system-wide-optimization | message-command: plan-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/rules/plan-mode/system-wide-optimization.mdc
   ```

2. **Dev-Mode Parameter**:
   ```
   1000xbrain/parameters/rules/dev-mode/system-wide-optimization.md
   ```
   Header:
   ```
   # workflow: rules-workflow | pathway: system-wide-optimization | message-command: dev-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/rules/dev-mode/system-wide-optimization.mdc
   ```

Note: No direct-mode project-rule-parameter will be created for the system-wide-optimization pathway.

## 1000xbrain and Cursor Rules Relationship

The optimization must maintain and enhance the critical relationship between brain-files and cursor-rules:

1. **Brain-Files (.md)**:
   - Editable markdown files in the 1000xbrain directory
   - Serve as the source of truth for cognitive architecture
   - Directly shape how 1000xdev thinks and operates
   - Can be edited, version-controlled, and collaboratively developed

2. **Cursor Rules (.mdc)**:
   - Actual rules that Cursor applies to shape AI behavior
   - Located in the `.cursor/rules` directory
   - Include frontmatter with rule types and configurations
   - Synchronized from brain-files
   - **NEVER** directly edited (only edited by Tyler through Cursor UI)

The synchronization process:
- Brain-files (.md) are edited to modify cognitive patterns
- Content is copied to cursor-rules (.mdc)
- Rule type and configuration set in Cursor UI
- Applied rules directly impact AI behavior

## Cognitive Architecture: Subsystem Structure

1000xbrain consists of four primary subsystems that work together in harmony:

1. **Core (`core/`)**: Foundational identity and modes
   - Contains essential files that define 1000xdev identity and operation
   - Subdirectories: `communication/`, `identity/`, and `modes/`
   - **Target**: Reduce to under 2000 lines total
   - **Specific Optimization**: Identify redundancies between files and consolidate content
   - **Rule Type**: Always rules automatically included in every conversation

2. **Knowledge (`knowledge/`)**: Specialized implementation knowledge
   - Contains detailed knowledge organized by workflow-type and pathway
   - Accessible through fetch_rules tool explicitly called in project-rule-parameters
   - **Target**: Reorganize by pathway and reduce redundancy
   - **Specific Optimization**: Create clear pathway organization structure in knowledge/rules directory
   - **Rule Type**: Agent Requested rules, loaded at AI's discretion through fetch_rules

3. **Parameters (`parameters/`)**: Implementation control
   - Contains project-rule-parameters that guide workflow execution
   - Organized by workflow-type/mode
   - **Target**: Enhance to immediately fetch relevant knowledge
   - **Specific Optimization**: Implement standardized fetch_rules pattern at the beginning of each parameter
   - **Rule Type**: Manual rules, explicitly referenced with @ symbol in message-commands

4. **Workflows (`workflows/`)**: Process definitions
   - Contains workflow-specific guidelines
   - Auto-attached when appropriate content is in Context Pills
   - **Target**: Ensure accurate description of workflow process and Context Pills
   - **Specific Optimization**: Standardize workflow documentation across all workflow types
   - **Rule Type**: Auto-Attached rules, attached when matching files are referenced

## Message-Command System

### Updated Format
```
mode: workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)
```

### Parsing Process
1. Ensure `mode` is one of the three valid modes (plan-mode, dev-mode, direct-mode)
2. Use fetch_rules to read the project-rule-parameter.mdc IN FULL
3. Validate that mode, workflow-type and pathway-name align with the project-rule-parameter header
4. Implement error checking for syntax errors (treat as terminal commands requiring exact syntax)

### Mode System

1. **plan-mode**: Planning Mode (📋)
   - Focus on documentation and planning
   - Indicated by 📋 emoji in responses
   - Format: `plan-mode: workflow-type pathway-name @project-rule-parameter.mdc`
   - Mandatory response indicator: `📋 1000xdev [workflow-type | pathway-name]`

2. **dev-mode**: Developer Mode (💻)
   - Focus on code implementation and testing
   - Indicated by 💻 emoji in responses
   - Format: `dev-mode: workflow-type pathway-name @project-rule-parameter.mdc`
   - Mandatory response indicator: `💻 1000xdev [workflow-type | pathway-name]`

3. **direct-mode**: Direct Mode (⚡)
   - Focus on immediate implementation with research
   - Indicated by ⚡ emoji in responses
   - Format: `direct-mode: workflow-type pathway-name @project-rule-parameter.mdc`
   - Mandatory response indicator: `⚡ 1000xdev [workflow-type | pathway-name]`

## Common-Words Standardization

Common-words are kebab-case terms with specific meanings in the 1000x development communication protocol:

| Common-Word | Definition | Context | Rule Type Association |
|-------------|------------|---------|------------|
| brain-file | Markdown file within 1000xbrain/ | Contains no frontmatter; editable mirror of cursor rules | N/A - Source files |
| cursor-rule | .mdc cursor rule within .cursor/rules/ | Contains frontmatter with rule type | Applied rules in Cursor |
| core-brain-files | Brain-files within 1000xbrain/core/ | Always rule type | Always |
| knowledge-base-files | Brain-files within 1000xbrain/knowledge/ | Agent Requested rule type accessed via fetch_rules | Agent Requested |
| knowledge-base | The subsystem 1000xbrain/knowledge/ | - | N/A - Directory |
| project-rule-parameters | Brain-files within 1000xbrain/parameters/ | Manual rule type that guides dev-mode, plan-mode, or direct-mode processes | Manual |
| workflow-files | Brain-files within 1000xbrain/workflows/ | Auto Attached when root README.md is in Context Pills | Auto-Attached |
| workflow-type | Name of workflow (e.g., rules-workflow) | - | N/A - Concept |
| pathway-name | Name of specific pathway within a workflow-type | - | N/A - Concept |
| workflow | Autonomous process with guidelines in workflows/ and parameters/ | Utilizes knowledge from knowledge/ | N/A - Process |
| subsystem | One of the four main directories in 1000xbrain | core, knowledge, parameters, workflows | N/A - Structure |
| context-files | Context files within the planning folder | Provide background and analysis | N/A - Documentation |
| implementation-files | Implementation files within the planning folder | Provide specific implementation guidance | N/A - Documentation |
| context-pills | Content automatically loaded into the conversation | Planning folder + root README.md of workflow domain | N/A - Mechanism |
| cognitive-loop | Four-stage process: perception, reasoning, action, learning | Mirrors human thought process | N/A - Process |
| synchronization-process | Copying content from brain-files to cursor-rules | Ensures cognitive changes are applied | N/A - Process |

## Context Pills Structure

For every message-command, the Context Pills automatically load:
1. The planning folder titled `{n}-workflow-type-pathway-name`
2. The root README.md file of the workflow-type domain folder

This provides the necessary context for autonomous operation within both the planning folder and the workflow-type domain.

## Current Issues to Address

1. **Terminology and Structure Inconsistency**: Common-word terminology is not consistently known or applied throughout the system.

2. **Inefficient Knowledge Access**: Too many fetch_rules calls in core/ and workflows/ that aren't used effectively. Project-rule-parameters should immediately fetch necessary knowledge.

3. **README.md Synchronization**: README.md files don't get synced to cursor-rules. Convert to index.md files except for the root README.md.

4. **Underutilized Knowledge-Base**: Valuable knowledge-base-files not being effectively accessed and used.

5. **Inconsistent Context Pills**: Structure of Context Pills not clearly defined across workflows.

6. **Knowledge-Base Organization**: Too many knowledge-base-files in rules-workflow not organized by pathway.

7. **Pathway Utilization**: Better understanding and organization around pathways needed.

8. **Cognitive Load Management**: Current architecture leads to excessive cognitive load with too much information in Always rules.

9. **Rule Type Alignment**: Files are not consistently aligned with their intended rule types across the architecture.

10. **File Size Optimization**: Some files are unnecessarily large, consuming valuable context space.

## Success Criteria

1. **Core Optimization**: Total core-brain-files under 2000 lines (ideally closer to 1000 lines).

2. **Workflow Documentation**: Auto Attached rules accurately describe the autonomous workflow cycle: run terminal commands → make changes → run terminal commands → make changes.

3. **Context Pills Documentation**: Auto Attached rules clearly describe what's loaded in Context Pills for each message and conversation thread.

4. **Planning Folder Structure**: Standardized planning folder with at minimum:
   - implementation-progress.md
   - README.md
   - Terminal command cheatsheet
   - Implementation file(s)
   - Context file(s)
   - requirements.md

5. **1000x Development Principles**: Preserve core 1000x development principles and AI augmented development approach.

6. **Identity Preservation**: Maintain 1000xdev identity and goal to achieve true 1000x AI augmented development.

7. **Role Clarity**: Maintain clear distinction between 1000xdev and Tyler Youk roles and domains.

8. **Cognitive Efficiency**: Improved cognitive performance through better organization and reduced duplication.

9. **Knowledge Accessibility**: More effective knowledge access patterns with clear pathways.

10. **System Cohesion**: Better integration between subsystems with clear responsibilities.

11. **Self-Enhancement Capability**: Maintained ability for 1000xdev to enhance its own cognitive architecture.

## Implementation Approach

The implementation will follow these guiding principles:

1. **Progressive Enhancement**: Each planning folder builds on the previous one
2. **Modularity**: Changes are organized by subsystem for clarity
3. **Backward Compatibility**: Ensure existing workflows continue to function
4. **Knowledge-First**: Prioritize better knowledge organization and access
5. **Minimal Core**: Keep core brain-files focused and concise
6. **Pathway Centrality**: Organize around clear pathways
7. **Documentation Clarity**: Ensure clear, consistent documentation
8. **Rule Type Alignment**: Align files with appropriate rule types for optimal loading
9. **Cognitive Efficiency**: Optimize for reduced cognitive load and better performance
10. **Self-Enhancement Support**: Maintain and improve self-improvement capabilities

## Writing Perspective

Write all rules as if from Tyler Youk's perspective, addressing 1000xdev:
- When writing "you", refer to 1000xdev
- When writing "I", refer to Tyler Youk

This maintains the proper relationship and communication structure throughout the cognitive architecture.