# Plan Mode: Subsystem Enhancement

## File Purpose and Relationship

This file defines the specific operation of the `plan-mode: rules-workflow @parameters/rules/plan-mode-subsystem.mdc` message-command, which initializes planning mode with a focus on subsystem enhancement planning. It should be consulted to understand:

- How to plan focused subsystem enhancements
- Specialized planning structure for subsystem-specific changes
- Tool call sequences for subsystem planning
- File organization for subsystem enhancement planning

This file complements:
- `fetch_rules(["knowledge/reference/architecture/brain-files-cursor-rules"])`: General planning mode operations
- `fetch_rules(["knowledge/patterns/impl/architecture-patterns"])`: Overall rules workflow
- Various other pathway-specific files

## Usage as Project-Rule-Parameter

This file contains specialized planning details for subsystem-focused development. It should be referenced as a project-rule-parameter when initializing planning for targeted subsystem enhancements:

```
plan-mode: rules-workflow @parameters/rules/plan-mode-subsystem.mdc
```

For other enhancement pathways, see the alternative pathway-specific project-rule-parameters listed in `@parameters/rules/rules-workflow.mdc`.

## 1. Subsystem Enhancement Overview

The subsystem enhancement pathway creates a specialized planning structure optimized for focused improvements to a specific subsystem within the 1000xbrain cognitive architecture. This approach is ideal when:

- Changes target a specific functional area
- Modifications have minimal impact on other subsystems
- Detailed knowledge of a specific component is required
- Changes need to be contained for better testing and validation

### Key Benefits

1. **Focused Scope**: Creates a manageable enhancement scope
2. **Deep Context**: Enables deeper analysis of the target subsystem
3. **Reduced Risk**: Minimizes cross-system impacts
4. **Efficient Implementation**: Optimizes for faster delivery of targeted changes
5. **Specialized Testing**: Enables thorough testing of the specific subsystem

## 2. Core Command Operation

When the `plan-mode: rules-workflow @parameters/rules/plan-mode-subsystem.mdc` message-command is received, 1000xdev will:

1. **Initialize Planning Mode**: Enter or remain in Planning Mode with the 📋 1000xdev [rules-workflow] indicator
2. **Identify Target Subsystem**: Analyze requirements.md to identify the specific subsystem
3. **Create Specialized Context**: Generate context files focused on the target subsystem
4. **Develop Limited-Scope Plans**: Create implementation plans with well-defined boundaries
5. **Design Focused Testing**: Create testing strategies specific to the subsystem

### Tool Call Sequence

```typescript
// 1. Check planning folder structure
list_dir("[planning_folder_path]")

// 2. Read requirements to identify subsystem focus
read_file("[planning_folder_path]/requirements.md", should_read_entire_file=true)

// 3. Analyze target subsystem structure
list_dir("1000xbrain/[target_subsystem_path]")

// 4. Read key subsystem files
read_file("1000xbrain/[target_subsystem_path]/[key_file].md", should_read_entire_file=true)

// 5. Create subsystem-focused context file
edit_file("[planning_folder_path]/context-[subsystem]-enhancement.md",
          "Create subsystem-focused context file",
          "# Context Analysis: [Subsystem] Enhancement\n\n...")

// 6. Create specialized implementation plan
edit_file("[planning_folder_path]/implementation-[subsystem]-enhancement.md",
          "Create subsystem-focused implementation plan",
          "# Implementation Plan: [Subsystem] Enhancement\n\n...")

// 7. Create focused test strategy
edit_file("[planning_folder_path]/test-cheatsheet.md",
          "Create subsystem-focused test strategy",
          "# Test Cheatsheet: [Subsystem] Enhancement\n\n...")
```

## 3. Specialized Planning Structure

The subsystem enhancement pathway creates a specialized planning structure:

### Required Files

| File | Purpose | Special Focus |
|---|---|---|
| `requirements.md` | Define subsystem enhancement objectives | Clearly identify target subsystem |
| `context-[subsystem]-enhancement.md` | Analyze subsystem architecture | Focus on architecture of specific subsystem |
| `context-[subsystem]-integration.md` | Document integration points | Identify connections to other subsystems |
| `implementation-[subsystem]-enhancement.md` | Plan implementation approach | Create phase-based implementation plan |
| `test-cheatsheet.md` | Define testing scenarios | Focus on subsystem-specific tests |
| `README.md` | Provide planning overview | Begin with workflow and pathway identification |

### README.md File Requirement

**⚠️ CRITICAL REQUIREMENT ⚠️**: The README.md file MUST begin with the workflow type and pathway as the first line in this format:

```
# workflow-type | pathway-type
```

For example:
```
# rules-workflow | subsystem-enhancement
```

This header format is essential because:
1. It clearly identifies the current workflow context
2. It specifies the implementation pathway being used
3. It enables easier alignment with the appropriate project-rule-parameters
4. It provides immediate context for anyone viewing the planning folder

The README.md file should continue with an overview of the subsystem enhancement approach and a listing of the planning folder contents.

### Optional Files

| File | Purpose | When to Include |
|---|---|---|
| `context-alternatives.md` | Document alternative approaches | For complex subsystems with multiple options |
| `implementation-migration.md` | Plan data or functionality migration | When changes require migration steps |

## 4. Context File Structure

The `context-[subsystem]-enhancement.md` file for subsystem enhancement follows this structure:

```markdown
# Context Analysis: [Subsystem] Enhancement

## Current Subsystem State
[Detailed analysis of current subsystem architecture and components]

## Enhancement Objectives
[Clear statement of what needs to be enhanced]

## Subsystem Components
[Breakdown of key components within the subsystem]

## Integration Points
[Identification of how this subsystem connects to others]

## Technical Considerations
[Subsystem-specific technical details and constraints]

## Enhancement Approach
[Overall strategy for enhancing the subsystem]
```

## 5. Implementation Planning

Subsystem enhancement implementation plans follow this structure:

```markdown
# Implementation Plan: [Subsystem] Enhancement

## Target Files
[List of specific files that will be modified]

## Implementation Phases
1. **Phase 1**: [First logical implementation group]
   - [Specific changes]
   - [Success criteria]

2. **Phase 2**: [Second logical implementation group]
   - [Specific changes]
   - [Success criteria]

## Integration Testing
[How changes will be tested with connected subsystems]

## Verification Approach
[How to verify successful enhancement]
```

## 6. Common Subsystem Enhancement Patterns

### Core Identity Enhancement

For enhancing the core identity subsystem:

1. **Analysis Focus**: Understand identity representation and boundaries
2. **Implementation Approach**: Careful, incremental changes to preserve identity
3. **Testing Strategy**: Verify consistent behavior across contexts

### Mode System Enhancement

For enhancing the mode system:

1. **Analysis Focus**: Understand mode transitions and indicators
2. **Implementation Approach**: Phase changes to preserve stable transitions
3. **Testing Strategy**: Verify all transition pathways

### Communication Pattern Enhancement

For enhancing communication patterns:

1. **Analysis Focus**: Map message-command structure and parameters
2. **Implementation Approach**: Backward-compatible modifications
3. **Testing Strategy**: Verify all command variations

### Workflow Enhancement

For enhancing specific workflows:

1. **Analysis Focus**: Document complete workflow process
2. **Implementation Approach**: Target specific workflow phases
3. **Testing Strategy**: End-to-end workflow testing

## 7. Success Criteria

Successful initialization of subsystem enhancement planning meets these criteria:

1. **Subsystem Identification**: Target subsystem is clearly identified
2. **Context Creation**: Specialized context files focus on target subsystem
3. **Bounded Scope**: Implementation plan has clear boundaries
4. **Integration Planning**: Impacts on connected subsystems are documented
5. **Testing Strategy**: Specialized tests target the subsystem and its boundaries

## 8. Examples

### Example 1: Mode System Enhancement

```
plan-mode: rules-workflow @parameters/rules/plan-mode-subsystem.mdc
```

With requirements.md focusing on mode system enhancements, this would create:
- `context-mode-system-enhancement.md`
- `context-mode-system-integration.md`
- `implementation-mode-system-enhancement.md`

### Example 2: Message Command Enhancement

```
plan-mode: rules-workflow @parameters/rules/plan-mode-subsystem.mdc
```

With requirements.md focusing on message-command enhancements, this would create:
- `context-message-commands-enhancement.md`
- `context-message-commands-integration.md`
- `implementation-message-commands-enhancement.md`

## 9. Related Files

- **knowledge/rules/plan-mode.md**: Core plan-mode operation
- **knowledge/rules/subsystem-enhancement.md**: Implementation guidance
- **knowledge/rules/implement-subsystem-enhancement.md**: Implementation process 