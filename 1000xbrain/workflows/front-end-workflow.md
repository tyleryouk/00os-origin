# Workflow Documentation: Front-End Workflow

## Template Reference
- **Template**: [workflows/templates/workflow-template.md](../templates/workflow-template.md)

## Overview
The Front-End Workflow provides a structured process for developing, testing, and optimizing user interface components and client-side functionality. It specializes in React, TypeScript, and modern web development patterns.

## Workflow Type
- **Name**: front-end-workflow
- **Domain**: User Interface
- **Purpose**: Development of web-based user interfaces

## Parameters
### Required Parameters
- **workflow-type**: Must be "front-end-workflow"

### Optional Parameters
- **@template-basic.mdc**: Basic front-end component template
- **@template-advanced.mdc**: Advanced component architecture
- **@react-component.mdc**: React component implementation
- **@typescript-patterns.mdc**: TypeScript implementation patterns
- **@plan-mode-performance.mdc**: Performance optimization planning
- **@dev-mode-performance.mdc**: Performance optimization implementation

## Parameter Sequence
1. workflow-type (front-end-workflow)
2. Optional project-rule parameters

## Validation Rules
### Parameter Validation
- workflow-type must be "front-end-workflow"
- Project-rule parameters must be compatible with front-end-workflow

### Sequence Validation
- plan-mode and dev-mode require workflow-type
- Project-rule parameters must follow workflow-type

## Integration Points
### System Components
- React component system
- TypeScript type system
- Front-end testing framework
- UI/UX design patterns

### Knowledge Components
- React implementation patterns
- TypeScript best practices
- Component architecture principles
- State management patterns

## Examples
### Basic Usage
```typescript
// Basic front-end workflow planning
plan-mode: front-end-workflow

// Front-end workflow with component template
plan-mode: front-end-workflow @react-component.mdc

// Front-end workflow implementation
dev-mode: front-end-workflow
```

### Advanced Usage
```typescript
// Component implementation with TypeScript patterns
dev-mode: front-end-workflow @react-component.mdc @typescript-patterns.mdc

// Performance optimization planning
plan-mode: front-end-workflow @plan-mode-performance.mdc

// Performance optimization implementation
dev-mode: front-end-workflow @dev-mode-performance.mdc
```

### Error Handling
```typescript
// Error recovery for interrupted implementation
continue-implementation: @error-recovery.mdc

// Verification handling for incomplete planning
verify-planning: @verification-advanced.mdc
```

## Notes
- Front-end workflow focuses on client-side implementation
- React and TypeScript are primary implementation technologies
- Component patterns emphasize reusability and maintainability
- Testing is integrated throughout implementation

## Related Workflows
- **back-end-workflow**: For server-side implementations
- **rules-workflow**: For cognitive architecture development
- **documentation-workflow**: For official documentation

## Version History
- **1.0.0**: Initial workflow definition
- **1.0.1**: Added React component templates
- **1.0.2**: Added TypeScript pattern integration
- **1.0.3**: Updated to new workflow template format 