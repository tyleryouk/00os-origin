# USE WHEN assessing planning complexity, determining folder structures for features, managing component dependencies, organizing planning documentation, or estimating implementation phases

# Planning Complexity Assessment Patterns

## Purpose and Usage

This file contains implementation patterns for assessing planning complexity. Use these patterns to determine:

1. How to structure planning folders for complex features
2. When to split planning documentation across multiple files or directories
3. How to manage dependencies between planning components
4. How to evaluate testing requirements for implementation

## Subsystem Impact Assessment

### Detection Patterns

Use these patterns to assess how many subsystems a feature affects:

```typescript
// Subsystem Impact Detection
function detectSubsystemImpact(feature) {
  const impacts = {
    ui: checkUIImpact(feature),
    data: checkDataImpact(feature),
    api: checkAPIImpact(feature),
    auth: checkAuthImpact(feature),
    // Add other subsystems as needed
  };
  
  return Object.entries(impacts)
    .filter(([_, hasImpact]) => hasImpact)
    .map(([subsystem, _]) => subsystem);
}

// Threshold-based splitting decision
function shouldSplitBySubsystem(impactedSubsystems) {
  return impactedSubsystems.length > 1;
}
```

### Implementation Pattern

When a feature affects multiple subsystems, implement this folder structure:

```
planning/
├── feature-name/
│   ├── requirements.md                # Core requirements
│   ├── context-architecture.md        # System-wide context
│   ├── implementation-core.md         # Core implementation plan
│   ├── subsystem-1/                   # Subsystem-specific folder
│   │   ├── context-subsystem-1.md     # Subsystem context
│   │   └── implementation-subsystem-1.md # Subsystem implementation
│   └── subsystem-2/                   # Another subsystem folder
│       ├── context-subsystem-2.md     # Subsystem context
│       └── implementation-subsystem-2.md # Subsystem implementation
```

## Dependency Mapping System

### Detection Patterns

Use these patterns to map dependencies between components:

```typescript
// Component Dependency Mapping
function mapComponentDependencies(feature) {
  const components = identifyComponents(feature);
  
  const dependencyMap = {};
  
  components.forEach(component => {
    dependencyMap[component] = {
      requires: identifyRequirements(component),
      requiredBy: identifyDependents(component),
      priority: calculatePriority(component)
    };
  });
  
  return dependencyMap;
}

// Implementation order determination
function determineImplementationOrder(dependencyMap) {
  // Sort by dependencies (least dependent first)
  return Object.keys(dependencyMap).sort((a, b) => {
    return dependencyMap[a].requires.length - dependencyMap[b].requires.length;
  });
}
```

### Implementation Pattern

Document dependencies in a dependency-mapping.md file:

```markdown
# Dependency Mapping

## Component Dependencies

| Component | Requires | Required By | Priority |
|-----------|----------|------------|----------|
| Auth Service | Config System | User System, API | High |
| User System | Auth Service | UI, API | High |
| UI Components | User System | None | Medium |

## Implementation Order

1. Config System (no dependencies)
2. Auth Service (depends on Config)
3. User System (depends on Auth)
4. UI Components (depends on User System)
5. API (depends on Auth and User)
```

## Phase Requirement Analysis

### Detection Patterns

Use these patterns to determine phase requirements:

```typescript
// Phase Complexity Assessment
function assessPhaseRequirements(feature) {
  const components = identifyComponents(feature);
  const dependencyMap = mapComponentDependencies(feature);
  
  // Group components into phases
  const phases = [];
  let remainingComponents = [...components];
  
  while (remainingComponents.length > 0) {
    // Find components with satisfied dependencies
    const implementableComponents = remainingComponents.filter(component => {
      const dependencies = dependencyMap[component].requires;
      return dependencies.every(dep => !remainingComponents.includes(dep));
    });
    
    if (implementableComponents.length === 0) {
      // Circular dependency detected
      phases.push({
        components: remainingComponents,
        type: 'circular-dependency'
      });
      break;
    }
    
    phases.push({
      components: implementableComponents,
      type: 'sequential'
    });
    
    remainingComponents = remainingComponents.filter(
      component => !implementableComponents.includes(component)
    );
  }
  
  return phases;
}
```

### Implementation Pattern

Document phase requirements in an implementation-phases.md file:

```markdown
# Implementation Phases

## Phase 1: Foundation
Components:
- Config System
- Auth Service

Dependencies: None

## Phase 2: Core Services
Components:
- User System
- Data Access Layer

Dependencies: Auth Service

## Phase 3: Front-End
Components:
- UI Components
- User Flows

Dependencies: User System, Data Access Layer
```

## Testing Complexity Assessment

### Detection Patterns

Use these patterns to assess testing complexity:

```typescript
// Testing Complexity Assessment
function assessTestingComplexity(feature) {
  const components = identifyComponents(feature);
  
  const testingRequirements = components.map(component => {
    return {
      component,
      unitTests: assessUnitTestRequirements(component),
      integrationTests: assessIntegrationTestRequirements(component),
      e2eTests: assessE2ETestRequirements(component),
      complexity: calculateTestingComplexity(component)
    };
  });
  
  return {
    overallComplexity: calculateOverallTestingComplexity(testingRequirements),
    componentRequirements: testingRequirements
  };
}
```

### Implementation Pattern

Document testing requirements in a test-cheatsheet.md file:

```markdown
# Testing Cheatsheet

## Overall Testing Strategy
Complexity: Medium
Approach: Focus on integration testing with essential unit tests

## Component-Specific Testing

### Auth Service
- **Unit Tests**: Token validation, permission checks
- **Integration Tests**: Authentication flow with Config System
- **Test Data Required**: Mock user credentials, tokens

### User System
- **Unit Tests**: User object validation
- **Integration Tests**: User creation, login flows
- **Test Data Required**: Mock user profiles

### UI Components
- **Unit Tests**: Component rendering
- **Integration Tests**: User interactions
- **E2E Tests**: Complete authentication flow
```

## Documentation Requirements Assessment

### Detection Patterns

Use these patterns to assess documentation needs:

```typescript
// Documentation Requirements Assessment
function assessDocumentationRequirements(feature) {
  const subsystems = detectSubsystemImpact(feature);
  const componentCount = identifyComponents(feature).length;
  const complexity = calculateComplexity(feature);
  
  return {
    requiresArchitectureDiagram: complexity > 2 || subsystems.length > 2,
    requiresAPIDocumentation: subsystems.includes('api'),
    requiresUserFlowDocumentation: subsystems.includes('ui'),
    requiresDataModelDocumentation: subsystems.includes('data'),
    requiresComponentBreakdown: componentCount > 3
  };
}
```

### Implementation Pattern

Document documentation requirements in a documentation-requirements.md file:

```markdown
# Documentation Requirements

## Architecture Documentation
- [x] System Architecture Diagram
- [x] Component Relationship Diagram
- [ ] Sequence Diagrams for Key Flows

## Technical Documentation
- [x] API Specifications
- [x] Data Model Documentation
- [ ] Configuration Reference

## Implementation Documentation
- [x] Component Breakdown
- [x] Phase Implementation Plan
- [ ] Testing Strategy
```

## Usage in Planning Files

Incorporate these patterns into your planning files:

```markdown
# Implementation Plan

## Complexity Assessment

This feature has been analyzed with the Planning Complexity Assessment system:

- **Subsystem Impact**: 3 subsystems (UI, Auth, Data)
- **Component Count**: 7 components
- **Dependency Complexity**: Medium (2 levels deep)
- **Testing Requirements**: Integration-focused with E2E for critical paths
- **Documentation Needs**: Architecture diagrams and detailed component documentation

Based on this assessment, we will implement a multi-folder structure with subsystem-specific implementation plans.
``` 