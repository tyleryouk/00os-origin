# USE WHEN creating planning folder structures, organizing complex feature documentation, implementing subsystem-specific documentation, or managing cross-references between planning documents

# Folder Structure Implementation Patterns

## Purpose and Usage

This file contains implementation patterns for creating and managing planning folder structures. Use these patterns to:

1. Organize planning documentation for complex features
2. Create subsystem-specific implementation plans
3. Implement cross-references between planning documents
4. Manage dependencies between planning components

## Folder Splitting Logic

### Detection Patterns

Use these patterns to determine when to split planning folders:

```typescript
// Planning Complexity Detection
function shouldSplitPlanningFolder(feature) {
  const subsystems = detectSubsystemImpact(feature);
  const components = identifyComponents(feature);
  const estimatedDocSize = estimateDocumentationSize(feature);
  
  return (
    subsystems.length > 1 ||
    components.length > 5 ||
    estimatedDocSize > 1000
  );
}

// Folder Structure Recommendation
function recommendFolderStructure(feature) {
  const subsystems = detectSubsystemImpact(feature);
  const complexity = calculateComplexity(feature);
  
  if (subsystems.length <= 1 && complexity <= 2) {
    return 'flat-structure';
  } else if (subsystems.length > 1 && complexity <= 3) {
    return 'subsystem-structure';
  } else {
    return 'full-hierarchical-structure';
  }
}
```

### Implementation Patterns

#### Flat Structure (Simple Features)

```
planning/
└── feature-name/
    ├── requirements.md
    ├── context.md
    ├── implementation.md
    └── test-cheatsheet.md
```

#### Subsystem Structure (Multi-Subsystem Features)

```
planning/
├── feature-name/
│   ├── requirements.md
│   ├── context-architecture.md
│   ├── implementation-core.md
│   ├── subsystem-1/
│   │   ├── context-subsystem-1.md
│   │   └── implementation-subsystem-1.md
│   └── subsystem-2/
│       ├── context-subsystem-2.md
│       └── implementation-subsystem-2.md
```

#### Full Hierarchical Structure (Complex Features)

```
planning/
├── feature-name/
│   ├── core/
│   │   ├── requirements.md
│   │   ├── architecture.md
│   │   └── implementation-strategy.md
│   ├── subsystems/
│   │   ├── subsystem-1/
│   │   │   ├── context.md
│   │   │   ├── components.md
│   │   │   └── implementation.md
│   │   └── subsystem-2/
│   │       ├── context.md
│   │       ├── components.md
│   │       └── implementation.md
│   ├── phases/
│   │   ├── phase-1.md
│   │   ├── phase-2.md
│   │   └── phase-3.md
│   └── testing/
│       ├── test-strategy.md
│       ├── test-cheatsheet.md
│       └── test-data.md
```

## Subsystem Organization

### Implementation Patterns

Use these patterns to organize subsystem documentation:

#### Subsystem Context File Template

```markdown
# Subsystem Context: [Subsystem Name]

## Overview
Brief description of the subsystem and its role in the feature.

## Components
- Component 1: Description
- Component 2: Description

## External Dependencies
- Dependency 1: How it's used
- Dependency 2: How it's used

## System Interactions
Describe how this subsystem interacts with other subsystems.

## Technical Constraints
List any technical limitations or considerations.
```

#### Subsystem Implementation File Template

```markdown
# Subsystem Implementation: [Subsystem Name]

## Components to Implement
1. Component 1
2. Component 2

## Implementation Steps
1. Step 1: Details
2. Step 2: Details

## Integration Points
- Integration with Subsystem X: Details
- Integration with External System Y: Details

## Verification Steps
- Verification 1: How to verify
- Verification 2: How to verify
```

## Dependency Tracking

### Implementation Patterns

Use these patterns to track dependencies between components:

#### Dependency Mapping File Template

```markdown
# Dependency Mapping

## Component Dependencies

| Component | Requires | Required By | Implementation Order |
|-----------|----------|-------------|---------------------|
| Component A | None | Component B, C | 1 |
| Component B | Component A | Component D | 2 |
| Component C | Component A | None | 2 |
| Component D | Component B | None | 3 |

## Cross-Subsystem Dependencies

| Subsystem | Depends On | Implementation Order |
|-----------|------------|---------------------|
| Auth | Config | 1 |
| User | Auth | 2 |
| UI | User | 3 |
```

#### Implementation Progress Tracking Template

```markdown
# Implementation Progress

## Phase 1: Foundation
- [x] Component A
- [x] Component B

## Phase 2: Core Features
- [ ] Component C
- [ ] Component D

## Phase 3: Integration
- [ ] Integration A-B
- [ ] Integration C-D
```

## Navigation System

### Cross-Reference Patterns

Use these patterns to create navigation between planning documents:

#### Cross-Reference Syntax

```markdown
// Absolute reference
ref: /planning/feature-name/subsystem-1/implementation.md

// Relative reference (from current folder)
ref: ./context.md

// Relative reference (from parent folder)
ref: ../core/requirements.md

// Section reference
ref: ./implementation.md#component-1
```

#### Navigation Index Template

```markdown
# Planning Navigation Index

## Core Documents
- [Requirements](./core/requirements.md)
- [Architecture](./core/architecture.md)
- [Implementation Strategy](./core/implementation-strategy.md)

## Subsystems
- [Subsystem 1](./subsystems/subsystem-1/implementation.md)
- [Subsystem 2](./subsystems/subsystem-2/implementation.md)

## Implementation Phases
- [Phase 1](./phases/phase-1.md)
- [Phase 2](./phases/phase-2.md)

## Testing
- [Test Strategy](./testing/test-strategy.md)
```

#### README.md Template

```markdown
# Feature: [Feature Name]

## Overview
Brief description of the feature.

## Documentation Structure
This planning folder uses a [structure type] structure.

### Core Documents
- [Requirements](./core/requirements.md): Feature requirements
- [Architecture](./core/architecture.md): System architecture

### Subsystems
- [Subsystem 1](./subsystems/subsystem-1/): Component details
- [Subsystem 2](./subsystems/subsystem-2/): Component details

### Implementation
- [Implementation Strategy](./core/implementation-strategy.md): Overall approach
- [Phase 1](./phases/phase-1.md): Foundation implementation
- [Phase 2](./phases/phase-2.md): Core features implementation

### Testing
- [Test Strategy](./testing/test-strategy.md): Testing approach
- [Test Cheatsheet](./testing/test-cheatsheet.md): Test cases
```

## Implementation Best Practices

1. **Structure Selection**:
   - Assess feature complexity first
   - Choose appropriate folder structure
   - Document structure choice in README.md

2. **Dependency Management**:
   - Document all dependencies clearly
   - Establish implementation order
   - Track progress against dependencies

3. **Navigation**:
   - Create README.md with links to key documents
   - Use consistent cross-reference syntax
   - Maintain navigation as documentation evolves

4. **Subsystem Isolation**:
   - Keep subsystem documentation focused
   - Clearly document integration points
   - Use consistent file naming within subsystems

5. **Progress Tracking**:
   - Maintain implementation-progress.md
   - Update status as implementation proceeds
   - Document completion criteria for each component

## Usage in Implementation

When implementing a complex feature planning folder:

```typescript
// 1. Assess complexity and determine structure
const feature = analyzeFeature();
const structure = recommendFolderStructure(feature);

// 2. Create base folder structure
createPlanningFolderStructure(feature.name, structure);

// 3. Generate subsystem folders
const subsystems = detectSubsystemImpact(feature);
subsystems.forEach(subsystem => {
  createSubsystemFolder(feature.name, subsystem, structure);
});

// 4. Generate navigation aids
createNavigationIndex(feature.name, structure);
createReadme(feature.name, structure);

// 5. Document dependencies
createDependencyMapping(feature);
``` 