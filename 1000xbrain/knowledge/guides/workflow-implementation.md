# USE WHEN implementing workflow features, developing workflow types, or enhancing workflow systems

# Implementation Guide: Workflow Implementation

## Overview
This guide provides standardized practices for implementing workflow types within the 1000xbrain cognitive architecture. It covers workflow definition, parameter validation, integration patterns, and specialized behavior implementation.

## Implementation Strategy
### Strategy Type
- **Name**: Workflow Implementation
- **Purpose**: Standardized workflow type implementation
- **Use Cases**: Adding new workflow types, enhancing existing workflows, implementing specialized behavior

### Components
- Workflow definition files
- Parameter validation rules
- Mode indicator integration
- Message-command processing
- Documentation templates

## Templates
### Primary Template
Implementation follows the workflow-template.md structure for consistency and completeness.

### Supporting Templates
- parameter-template.md for parameter definition
- implementation-guide-template.md for implementation guidance

## Implementation Steps
1. Define the workflow with clear name, domain, and purpose
2. Establish required and optional parameters
3. Create parameter sequence and validation rules
4. Document integration points with system components
5. Provide comprehensive usage examples
6. Update related documentation for consistency

## Error Recovery
### Recovery Strategies
- Workflow errors should provide clear context and guidance
- Invalid workflow transitions should be prevented with validation
- Parameter incompatibilities should be detected early

### Fallback Mechanisms
- When workflows encounter errors, provide recovery suggestions
- When transitions are invalid, explain the proper sequence
- When parameters are incompatible, suggest valid combinations

## Integration Points
### System Integration
- Message-command system for workflow activation
- Mode transition system for workflow state management
- Knowledge access system for workflow-specific information

### Component Integration
- Parameter validation for workflow parameters
- Project rule parameters for specialized behavior
- Implementation strategies for execution guidance

## Examples
### Basic Implementation
```typescript
// Basic workflow definition
{
  name: "example-workflow",
  domain: "Example Domain",
  purpose: "Demonstrates workflow implementation",
  parameters: {
    required: ["workflow-type"],
    optional: ["@template.mdc", "@implementation-strategy.mdc"]
  },
  validation: {
    workflow_type: "example-workflow",
    parameter_compatibility: {
      "@template.mdc": ["basic", "advanced"]
    }
  }
}
```

### Advanced Implementation
```typescript
// Advanced workflow with specialized behavior
{
  name: "specialized-workflow",
  domain: "Specialized Domain",
  purpose: "Implements specialized behavior",
  parameters: {
    required: ["workflow-type", "@specialized-template.mdc"],
    optional: ["@implementation-strategy.mdc", "@error-recovery.mdc"]
  },
  validation: {
    workflow_type: "specialized-workflow",
    parameter_sequence: ["workflow-type", "@specialized-template.mdc", "..."],
    knowledge_components: ["domain-knowledge", "specialized-patterns"]
  },
  behavior: {
    mode_indicators: {
      planning: "📋 1000xdev [specialized-workflow]",
      implementation: "💻 1000xdev [specialized-workflow]"
    }
  }
}
```

### Error Handling
```typescript
// Workflow validation error handling
try {
  validateWorkflow(workflow, parameters);
} catch (error) {
  handleWorkflowError(error, {
    invalid_type: "Workflow type must be valid",
    incompatible_parameters: "Parameters are not compatible with workflow",
    invalid_sequence: "Parameters must follow proper sequence"
  });
}
```

## Validation
### Implementation Validation
- Verify all required sections are present in workflow definition
- Ensure parameter validation rules are complete
- Confirm examples cover both basic and advanced usage
- Check integration with system components

### Integration Testing
- Test workflow activation with different parameters
- Verify mode transitions work correctly
- Confirm error handling provides useful guidance
- Test knowledge component access

## Notes
- Workflows should follow consistent naming conventions
- Each workflow should have clear domain boundaries
- Mode indicators must match workflow types
- Documentation must align with workflow-template.md structure

## Related Documentation
- Workflow template in workflows/templates/workflow-template.md
- Message-command system documentation
- Mode transition system documentation
- Knowledge access documentation

## Version History
- **1.0.0**: Initial implementation guide
- **1.0.1**: Enhanced workflow validation patterns
- **1.0.2**: Updated with specialized behavior examples 