# Implementation Plan: Project-Rule-Parameter Restructuring

## Overview

This document outlines the plan for restructuring the rules-workflow project-rule-parameters to create a streamlined, consistent set of parameters organized by clear pathways. The restructured parameters will leverage the single source of truth in the knowledge/system-structure/ directory rather than duplicating system structure information.

## Current State Analysis

### Existing Parameter Structure
- Current parameters are organized by mode (plan-mode, dev-mode, direct-mode)
- Parameter pathways are inconsistent and sometimes undefined
- Parameter content often duplicates system structure information
- No clear relationship between parameters and knowledge/system-structure/ files
- Varying levels of detail and structure across parameters

### Current Parameter Files
- **plan-mode parameters**:
  - `add-project-rule-parameter.md`
  - `enhance-planning.md`
  - `enhance-requirements.md`
  - `system-wide-optimization.md`
  - `system-wide.md`
- **dev-mode parameters**:
  - `knowledge-organization.md`
  - `enhance-documentation-perspective.md`
  - `system-wide-optimization.md`
  - `performance.md`
  - `system-wide.md`
  - `continue-implementation-system-wide-optimization.md`
- **direct-mode parameters**: Currently empty

### Problems with Current Approach
1. **Inconsistent Pathways**: No standardized pathway structure
2. **Duplicated Information**: System structure information duplicated across parameters
3. **Unclear Relationships**: Relationships between modes not clearly documented
4. **No Single Source Reference**: Parameters don't reference an authoritative source
5. **Inconsistent Structure**: Varying structure and content across parameters
6. **Undefined Domains**: Access domains not clearly defined for each parameter

## Target Structure

The implementation will restructure the parameters to a clear, consistent set organized by pathway:

### Pathway Structure

| Pathway | Plan-Mode Parameter | Dev-Mode Parameter | Purpose | Domain Access |
|---------|---------------------|-------------------|---------|---------------|
| system-wide | system-wide.md | system-wide.md | System-wide changes affecting the entire architecture | All of 1000xbrain/** |
| system-wide-optimization | system-wide-optimization.md | system-wide-optimization.md | System-wide optimization of the architecture | All of 1000xbrain/** |
| subsystem-core | subsystem-core.md | subsystem-core.md | Changes specific to the core subsystem | Read: All of 1000xbrain in plan-mode<br>Edit: 1000xbrain/knowledge/system-structure/ and 1000xbrain/core/ in dev-mode |
| subsystem-knowledge | subsystem-knowledge.md | subsystem-knowledge.md | Changes specific to the knowledge subsystem | Read: All of 1000xbrain in plan-mode<br>Edit: 1000xbrain/knowledge/system-structure/ and 1000xbrain/knowledge/ in dev-mode |
| subsystem-parameters | subsystem-parameters.md | subsystem-parameters.md | Changes specific to the parameters subsystem | Read: All of 1000xbrain in plan-mode<br>Edit: 1000xbrain/knowledge/system-structure/ and 1000xbrain/parameters/ in dev-mode |
| subsystem-workflows | subsystem-workflows.md | subsystem-workflows.md | Changes specific to the workflows subsystem | Read: All of 1000xbrain in plan-mode<br>Edit: 1000xbrain/knowledge/system-structure/ and 1000xbrain/workflows/ in dev-mode |
| workflows | workflows.md | workflows.md | Changes to a specific workflow type (uses [workflow-type] parameter) | Depends on the workflow-type, following subsystem domain access patterns |

### Parameter Header Standardization

All parameters will follow this header format:

```markdown
# mode: [mode] | workflow: rules-workflow | pathway: [pathway-name] | filepath: @parameters/rules/[mode]/[parameter-name].mdc | optional-standard-parameter(s): [params]
```

### Parameter Content Structure

Each parameter will follow a consistent structure:

1. **Header**: Standard parameter header (as above)
2. **Overview**: Brief description of the parameter's purpose and when to use it
3. **Domain Access**: Clear specification of read/edit access domains for the parameter
4. **Knowledge Access**: Clear fetch_rules patterns to access relevant knowledge/system-structure/ files
5. **Implementation Approach**: Specific approach for the pathway
6. **Tool Call Process**: Step-by-step tool call process, always starting with fetch_rules
7. **Verification Framework**: Methods for verifying changes
8. **Success Criteria**: Clear criteria for successful implementation

## Domain Access Specifications

Each pathway has specific domain access rules that must be clearly documented in the parameters:

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

## Implementation Approach

The restructuring will follow these sequential steps:

### 1. Template Creation
- Create standardized templates for each pathway
- Ensure consistent structure across all templates
- Include proper fetch_rules patterns for the knowledge/system-structure/ files
- Design clear tool call processes that enforce documentation-first principles
- Include domain access specifications in each template

### 2. Parameter Planning
- Map existing parameters to the new pathway structure
- Identify content that can be reused
- Document parameters that need to be created from scratch
- Create migration plan for existing parameters
- Define domain access specifications for each parameter

### 3. Knowledge Reference Integration
- Define fetch_rules patterns for each parameter
- Document which knowledge/system-structure/ files each parameter should reference
- Create examples of proper knowledge integration
- Ensure knowledge references are consistent across parameters

### 4. Parameter Creation/Modification
- Create new parameters based on templates
- Modify existing parameters to match the new structure
- Ensure consistent headers and content structure
- Validate all parameters against the standardized format
- Include clear domain access specifications in each parameter

### 5. Testing and Verification
- Test fetch_rules patterns for each parameter
- Verify consistency across all parameters
- Ensure all parameters properly reference knowledge/system-structure/ files
- Validate tool call processes for correctness
- Verify domain access specifications are accurately documented

## Pathway-Specific Implementation Details

### system-wide Pathway

**Purpose**: Handle changes that affect the entire 1000xbrain system.

**Domain Access**: Full read and edit access to all of 1000xbrain/**

**Knowledge References**:
```typescript
fetch_rules([
  "knowledge/system-structure/system-architecture",
  "knowledge/system-structure/workflow-subsystem-relationships"
], "Understanding the system architecture and relationships")
```

**Tool Call Process**:
1. Access system architecture knowledge
2. Update relevant knowledge/system-structure/ files first
3. Then implement changes across the system

**Content Focus**:
- System-wide architectural changes
- Cross-subsystem concerns
- System-level organization principles
- Workflow integration across subsystems

### subsystem-core Pathway

**Purpose**: Handle changes specific to the core subsystem.

**Domain Access**: 
- Plan-Mode: Read access to all of 1000xbrain
- Dev-Mode: Edit access to 1000xbrain/knowledge/system-structure/ and 1000xbrain/core/

**Knowledge References**:
```typescript
fetch_rules([
  "knowledge/system-structure/subsystem-core",
  "knowledge/system-structure/workflow-subsystem-relationships"
], "Understanding the core subsystem and its relationships")
```

**Tool Call Process**:
1. Access core subsystem knowledge
2. Update subsystem-core.md in knowledge/system-structure/ first
3. Then implement changes to the core subsystem

**Content Focus**:
- Core subsystem structure and organization
- Core file types and purposes
- Core integration with other subsystems
- Core-specific workflows

[Similar details for each pathway...]

## Parameter Templates

### Plan-Mode Parameter Template

```markdown
# mode: plan-mode | workflow: rules-workflow | pathway: [pathway-name] | filepath: @parameters/rules/plan-mode/[parameter-name].mdc | optional-standard-parameter(s): [params]

## Overview

[Brief description of the parameter's purpose and when to use it]

## Domain Access

- **Read Access**: [Specify read access domains]
- **Edit Access**: [Specify edit access domains]

## Knowledge Access

For comprehensive understanding of the [relevant aspect], access these knowledge components:

```typescript
fetch_rules([
  "knowledge/system-structure/[relevant-file-1]",
  "knowledge/system-structure/[relevant-file-2]"
], "Understanding [relevant aspect] for planning")
```

## Implementation Approach

[Specific approach for this pathway]

## Tool Call Process

1. **Access Knowledge**:
   ```typescript
   fetch_rules(["knowledge/system-structure/[relevant-file]"], 
              "Understanding [relevant aspect]")
   ```

2. **Update Knowledge First**:
   ```typescript
   edit_file("1000xbrain/knowledge/system-structure/[relevant-file].md",
             "Update [relevant aspect] documentation",
             "Updated content...")
   ```

3. **Implement Changes**:
   [Specific implementation steps]

## Verification Framework

[Methods for verifying changes]

## Success Criteria

[Clear criteria for successful implementation]
```

### Dev-Mode Parameter Template

```markdown
# mode: dev-mode | workflow: rules-workflow | pathway: [pathway-name] | filepath: @parameters/rules/dev-mode/[parameter-name].mdc | optional-standard-parameter(s): [params]

## Overview

[Brief description of the parameter's purpose and when to use it]

## Domain Access

- **Read Access**: [Specify read access domains]
- **Edit Access**: [Specify edit access domains]

## Knowledge Access

For comprehensive understanding of the [relevant aspect], access these knowledge components:

```typescript
fetch_rules([
  "knowledge/system-structure/[relevant-file-1]",
  "knowledge/system-structure/[relevant-file-2]"
], "Understanding [relevant aspect] for implementation")
```

## Implementation Approach

[Specific approach for this pathway]

## Tool Call Process

1. **Access Knowledge**:
   ```typescript
   fetch_rules(["knowledge/system-structure/[relevant-file]"], 
              "Understanding [relevant aspect]")
   ```

2. **Update Knowledge First**:
   ```typescript
   edit_file("1000xbrain/knowledge/system-structure/[relevant-file].md",
             "Update [relevant aspect] documentation",
             "Updated content...")
   ```

3. **Implement Changes**:
   [Specific implementation steps]

## Verification Framework

[Methods for verifying changes]

## Success Criteria

[Clear criteria for successful implementation]
```

## Migration Approach

For existing parameters that need to be migrated:

1. **Content Preservation**: Preserve valuable content from existing parameters
2. **Structure Conversion**: Adapt content to the new standardized structure
3. **Knowledge Linking**: Replace duplicated information with fetch_rules references
4. **Header Standardization**: Update headers to match the new format
5. **Tool Call Process**: Update tool call processes to always update knowledge first
6. **Domain Access Documentation**: Add clear domain access specifications

## Parameter Update Order

To ensure consistency, parameters will be updated in this sequence:

1. Create pathway templates for both plan-mode and dev-mode
2. Update system-wide and system-wide-optimization parameters first
3. Create/update subsystem-specific parameters (core, knowledge, parameters, workflows)
4. Create/update the workflows parameters last
5. Verify cross-parameter consistency

## Success Criteria

The parameter restructuring will be successful when:

1. All parameters follow the consistent pathway structure
2. All parameters properly reference knowledge/system-structure/ files
3. All parameters enforce the documentation-first tool call process
4. Duplicate system structure information is eliminated
5. Each parameter has a clear, specific purpose
6. Navigation between modes and pathways is intuitive
7. Domain access specifications are clearly documented for each parameter

This implementation will create a streamlined, consistent set of parameters that leverage the single source of truth in the knowledge/system-structure/ directory, improving maintainability and consistency across the system. 