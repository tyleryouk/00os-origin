# Parameter-Knowledge Mapping

## Overview

This component provides a comprehensive mapping between project-rule-parameters and knowledge components, documenting the relationships and integration patterns between these critical subsystems of the 1000xbrain cognitive architecture.

## Core Principles

### 1. Knowledge Integration

Parameters should integrate with knowledge through these core principles:

1. **Immediate Knowledge Access**: Parameters must access relevant knowledge components at the beginning
2. **Targeted Knowledge Fetching**: Each knowledge component fetched should serve a specific purpose
3. **Clear Integration Purpose**: Purpose for accessing each knowledge component should be explicit
4. **Standardized Access Pattern**: All parameters should follow consistent fetch_rules patterns
5. **Relationship Documentation**: Parameter-knowledge relationships should be documented

### 2. Knowledge Coverage

Parameters should ensure appropriate knowledge coverage:

1. **Pathway-Specific Knowledge**: Parameters should access pathway-specific knowledge first
2. **Cross-Pathway Support**: Secondary knowledge from related pathways should be included
3. **Common Knowledge Access**: Standardization knowledge from common pathway when needed
4. **Comprehensive Coverage**: All knowledge necessary for implementation should be accessed
5. **Minimal Redundancy**: Each knowledge component should serve a unique purpose

### 3. Knowledge Synchronization

Parameters and knowledge components should remain synchronized:

1. **Consistent Terminology**: Use consistent terminology across parameters and knowledge
2. **Structural Alignment**: Maintain consistent structure between parameters and knowledge
3. **Update Synchronization**: When knowledge changes, update parameters accordingly
4. **Unified Access Patterns**: Use standardized access patterns across all parameters
5. **Documentation Consistency**: Maintain consistent documentation standards

## Parameter-Knowledge Map

### Direct Mode Parameters

| Parameter | Primary Knowledge Components | Secondary Knowledge Components |
|-----------|------------------------------|--------------------------------|
| add-project-rule-parameter.md | common/parameter-structure.md<br>common/file-standards.md | common/symbol-guidelines.md<br>system-wide/brain-files-cursor-rules.md |
| major-key-message-commands.md | system-wide/message-commands.md<br>common/parameter-structure.md | common/symbol-guidelines.md<br>system-wide/brain-files-cursor-rules.md |

### Dev Mode Parameters

| Parameter | Primary Knowledge Components | Secondary Knowledge Components |
|-----------|------------------------------|--------------------------------|
| continue-implementation-system-wide-optimization.md | system-wide/brain-files-cursor-rules.md<br>system-wide-optimization/cognitive-load-optimization.md | performance/implementation-performance.md |
| knowledge-organization.md | knowledge-organization/pathway-organization.md<br>common/file-standards.md | system-wide/brain-files-cursor-rules.md<br>system-wide/knowledge-access.md |
| performance.md | performance/implementation-performance.md<br>performance/performance-optimization.md | system-wide-optimization/cognitive-load-optimization.md<br>system-wide/brain-files-cursor-rules.md |
| system-wide.md | system-wide/brain-files-cursor-rules.md<br>system-wide/mode-patterns.md<br>system-wide/message-commands.md | system-wide-optimization/cognitive-load-optimization.md<br>performance/implementation-performance.md |
| system-wide-optimization.md | system-wide/brain-files-cursor-rules.md<br>system-wide-optimization/cognitive-load-optimization.md | performance/implementation-performance.md |

### Plan Mode Parameters

| Parameter | Primary Knowledge Components | Secondary Knowledge Components |
|-----------|------------------------------|--------------------------------|
| enhance-planning.md | system-wide/mode-patterns.md<br>common/file-standards.md | knowledge-organization/pathway-organization.md |
| enhance-requirements.md | system-wide/mode-patterns.md<br>common/file-standards.md | system-wide/brain-files-cursor-rules.md<br>knowledge-organization/pathway-organization.md |
| performance.md | performance/implementation-performance.md<br>performance/performance-optimization.md | system-wide-optimization/cognitive-load-optimization.md<br>system-wide/brain-files-cursor-rules.md |
| system-wide.md | system-wide/brain-files-cursor-rules.md<br>system-wide/mode-patterns.md<br>system-wide/message-commands.md | system-wide-optimization/cognitive-load-optimization.md<br>common/file-standards.md |
| system-wide-optimization.md | system-wide/brain-files-cursor-rules.md<br>system-wide-optimization/cognitive-load-optimization.md | performance/implementation-performance.md<br>system-wide-optimization/tool-optimization.md |

## Integration Patterns

### Standard Knowledge Access Pattern

All parameters follow this standardized knowledge access pattern:

```typescript
// Access primary pathway-specific knowledge
fetch_rules(["knowledge/rules/[primary-pathway]/[component-name]"], 
           "Understanding [specific aspect] for [specific purpose]")

// Access secondary knowledge from related pathways
fetch_rules(["knowledge/rules/[related-pathway]/[component-name]"], 
           "Understanding [related aspect] for [specific purpose]")
```

### Common Knowledge Combinations

These knowledge component combinations frequently appear together:

1. **System Architecture Integration**:
   - system-wide/brain-files-cursor-rules.md
   - common/symbol-guidelines.md

2. **Performance Optimization Integration**:
   - performance/implementation-performance.md
   - system-wide-optimization/cognitive-load-optimization.md

3. **Knowledge Organization Integration**:
   - knowledge-organization/pathway-organization.md
   - common/file-standards.md

4. **Message Command Integration**:
   - system-wide/message-commands.md
   - common/parameter-structure.md

## Integration with Other Components

This parameter-knowledge mapping integrates with:

- **Parameter Structure Standards**: Documents knowledge relationships in parameters
- **Knowledge Access Patterns**: Defines standardized access patterns across parameters
- **Pathway Organization**: Aligns parameter and knowledge pathway structures
- **Documentation Standards**: Ensures consistent documentation across systems

## Access and Usage

```typescript
// Access parameter-knowledge mapping
fetch_rules(["knowledge/rules/knowledge-organization/parameter-knowledge-mapping"], 
           "Understanding relationship between parameters and knowledge components")

// Usage examples
// 1. When creating or updating parameters
// 2. When modifying knowledge components
// 3. When verifying knowledge integration
// 4. When planning system-wide changes
```

## Related Components

- [Parameter Structure](../common/parameter-structure.md): Standards for parameter structure
- [Knowledge Access](../system-wide/knowledge-access.md): Knowledge access patterns
- [Pathway Organization](pathway-organization.md): Pathway organization principles
- [Brain-Files and Cursor-Rules](../system-wide/brain-files-cursor-rules.md): Brain-files and cursor-rules relationship 