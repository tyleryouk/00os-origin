# Rules Workflow Scenario Selection

This document provides guidance for selecting the appropriate scenario type and project-rule-parameter based on the nature of the enhancement.

For detailed scenario patterns, use:
```typescript
fetch_rules(["knowledge/rules/patterns/impl/implementation-patterns"], 
           "Understanding scenario selection patterns")
```

## Scenario Types

For scenario type patterns, use:
```typescript
fetch_rules(["knowledge/rules/patterns/impl/architecture-patterns"], 
           "Understanding different scenario types and their usage")
```

### Targeted Rule Modifications

- **Usage**: For making specific changes to defined files
- **Scope**: Narrow focus on specific improvements
- **Project-Rule-Parameter**: `@parameters/rules/plan-mode.mdc`
- **Typical Changes**: Syntax updates, format improvements, error handling enhancements

### Conversation Analysis

- **Usage**: For improvements based on conversation analysis
- **Scope**: Varies based on conversation content
- **Project-Rule-Parameter**: `@parameters/rules/plan-mode.mdc`
- **Typical Changes**: Addressing observed usage patterns, resolving confusion points

### System-Wide Enhancement

- **Usage**: For broad improvements to the architecture
- **Scope**: Multiple components and subsystems
- **Project-Rule-Parameter**: `@parameters/rules/plan-mode-system-wide.mdc`
- **Typical Changes**: Standardization across components, integration improvements

### Subsystem Enhancement

- **Usage**: For focused improvement of specific cognitive components
- **Scope**: Single subsystem or component set
- **Project-Rule-Parameter**: `@parameters/rules/plan-mode-subsystem.mdc`
- **Typical Changes**: Component refinement, feature additions, subsystem optimization

## Scenario Selection Guide

For selection guidance patterns, use:
```typescript
fetch_rules(["knowledge/rules/patterns/impl/basic-patterns"], 
           "Understanding scenario selection decision making")
```

The scenario selection should be based on:

1. **Scope of Changes**: 
   - Specific files and changes → **Targeted Rule Modifications** (`@parameters/rules/plan-mode.mdc`)
   - Past conversation analysis → **Conversation Analysis** (`@parameters/rules/plan-mode.mdc`)
   - Specific component focus → **Subsystem Enhancement** (`@parameters/rules/plan-mode-subsystem.mdc`)
   - General enhancement goals → **System-Wide Enhancement** (`@parameters/rules/plan-mode-system-wide.mdc`)

2. **Tradeoff Considerations**:

| Scope Type | Scope | Implementation Speed | Scenario Type | Project-Rule-Parameter |
|------------|-------|----------------------|--------------|---------|
| Specific files | Narrow | High | Targeted Rule Modifications | `@parameters/rules/plan-mode.mdc` |
| Past conversation | Varies | Medium | Conversation Analysis | `@parameters/rules/plan-mode.mdc` |
| Specific component | Medium | Medium | Subsystem Enhancement | `@parameters/rules/plan-mode-subsystem.mdc` |
| Overall architecture | Broad | Low | System-Wide Enhancement | `@parameters/rules/plan-mode-system-wide.mdc` |

## Selection Process

For process implementation patterns, use:
```typescript
fetch_rules(["knowledge/rules/patterns/impl/implementation-patterns"], 
           "Understanding selection process implementation")
```

1. **Identify Enhancement Type**: Determine the primary goal of the enhancement
2. **Assess Scope**: Evaluate the breadth of changes required
3. **Consider Timeframe**: Account for implementation time requirements
4. **Choose Project-Rule-Parameter**: Select the appropriate parameter based on scope and type

## Example Message-Commands for Different Scenarios

> **NOTE**: All project-rule-parameters now use a self-documenting header system that explicitly defines their relationship to message-commands.

For message-command patterns, use:
```typescript
fetch_rules(["knowledge/rules/patterns/tool/command-patterns"], 
           "Understanding message-command usage for different scenarios")
```

```
# Targeted Rule Modifications
plan-mode: rules-workflow @parameters/rules/plan-mode.mdc

# Conversation Analysis
plan-mode: rules-workflow @parameters/rules/plan-mode.mdc

# Subsystem Enhancement
plan-mode: rules-workflow @parameters/rules/plan-mode-subsystem.mdc

# System-Wide Enhancement
plan-mode: rules-workflow @parameters/rules/plan-mode-system-wide.mdc
```

## Implementation Implications

For implementation guidance, use:
```typescript
fetch_rules(["knowledge/rules/patterns/impl/implementation-patterns"], 
           "Understanding implementation implications")
```

The scenario selection impacts:

1. **Planning Depth**: More complex scenarios require more detailed planning
2. **Implementation Phasing**: Broader scenarios typically require more phases
3. **Verification Approach**: Different scenario types have different verification requirements
4. **Documentation Focus**: Documentation focus shifts based on scenario type

## Template Selection

For template selection patterns, use:
```typescript
fetch_rules(["knowledge/rules/patterns/doc/basic-patterns"], 
           "Understanding template selection and usage")
```

Based on the scenario type, different planning templates may be appropriate:

1. **Basic Template**: Suitable for Targeted Rule Modifications and Conversation Analysis
2. **Advanced Template**: Recommended for Subsystem Enhancement and System-Wide Enhancement

## Validation Requirements

For validation patterns, use:
```typescript
fetch_rules(["knowledge/rules/patterns/tool/basic-patterns"], 
           "Understanding validation requirements and patterns")
```

When processing workflow-selection message-commands:

1. **Verify syntax correctness**:
   - Ensure message-command is lowercase kebab-case
   - Confirm colon is present with a space after
   - Validate that standard-parameter is recognized

2. **Validate project-rule-parameter**:
   - Verify project-rule-parameter uses .mdc extension
   - Confirm project-rule-parameter exists
   - Check path format is correct

3. **If invalid**:
   - Provide clear error message
   - Explain the specific issue
   - Suggest the correct format

## Brain-File vs Project-Rule Understanding

For brain-file and project-rule relationships, use:
```typescript
fetch_rules(["knowledge/rules/reference/architecture/brain-files-cursor-rules"], 
           "Understanding brain-file and project-rule relationships")
```

Remember the critical distinction:
- All brain-files in 1000xbrain directory use the `.md` extension
- When referencing these files as project-rule-parameters, use the `.mdc` extension
- The automatic synchronization system maintains the mapping between these file types
- Always edit only `.md` files (brain-files), never `.mdc` files (Cursor Project Rules)



