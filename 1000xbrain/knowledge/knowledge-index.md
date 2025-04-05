# USE WHEN navigating the knowledge subsystem to find relevant knowledge files

# Knowledge Subsystem Index

## Overview

This index serves as a comprehensive navigation guide for the Knowledge Subsystem of the 1000xbrain cognitive architecture. It provides a hierarchical map to all knowledge domains and specific knowledge files, enabling efficient discovery and access to specialized knowledge.

## How to Use This Index

This index is designed to help locate relevant knowledge quickly:

1. **Browse by Workflow Type**: Find knowledge related to specific workflows
2. **Browse by Cross-Cutting Concern**: Find knowledge that spans multiple workflows
3. **Browse by Knowledge Category**: Find knowledge based on its category (standards, patterns, etc.)
4. **Access Knowledge**: Use the provided fetch_rules patterns to access specific knowledge

## Workflow-Specific Knowledge

### Rules Workflow Knowledge

**Standards and Guidelines**
- `knowledge/rules/standards/rules-standards.md` - Core standards for rules workflow
- `knowledge/rules/standards/cognitive-enhancement-standards.md` - Standards for cognitive enhancement

**Common Patterns**
- `knowledge/rules/patterns/modes/plan-mode-patterns.md` - Patterns for plan-mode implementation
- `knowledge/rules/patterns/modes/dev-mode-patterns.md` - Patterns for dev-mode implementation
- `knowledge/rules/patterns/modes/direct-mode-patterns.md` - Patterns for direct-mode implementation
- `knowledge/rules/patterns/modes/common-mode-patterns.md` - Common patterns across all modes

**Reference Information**
- `knowledge/rules/reference/syntax/message-command-syntax.md` - Detailed message command syntax
- `knowledge/rules/reference/syntax/mode-indicator-syntax.md` - Mode indicator syntax requirements

**Implementation Guides**
- `knowledge/rules/guides/cognitive-enhancement-guide.md` - Guide for cognitive architecture enhancement
- `knowledge/rules/guides/system-navigation-guide.md` - Guide for navigating the system structure

### Quality Workflow Knowledge

**Standards and Guidelines**
- `knowledge/quality/standards/quality-standards.md` - Comprehensive quality standards

**Monitoring Frameworks**
- `knowledge/quality/monitoring/monitoring-frameworks.md` - Quality monitoring frameworks
- `knowledge/quality/monitoring/quality-monitoring-guide.md` - Guide for implementing quality monitoring

**Assessment Tools**
- `knowledge/quality/templates/quality-assessment-template.md` - Templates for quality assessment
- `knowledge/quality/templates/issue-reporting-template.md` - Templates for issue reporting

**Enhancement Patterns**
- `knowledge/quality/enhancement/quality-enhancement-patterns.md` - Patterns for quality enhancement
- `knowledge/quality/enhancement/issue-resolution-patterns.md` - Patterns for resolving quality issues

**Analysis Methods**
- `knowledge/quality/analysis/quality-analysis-methods.md` - Methods for quality analysis
- `knowledge/quality/analysis/root-cause-analysis.md` - Methods for root cause analysis

### Scripts Workflow Knowledge

**Standards and Guidelines**
- `knowledge/scripts/standards/script-standards.md` - Standards for script implementation

**Common Patterns**
- `knowledge/scripts/patterns/common-patterns.md` - Common script implementation patterns

**Classification Systems**
- `knowledge/scripts/taxonomy/script-classification.md` - Script classification system

### Front-End Workflow Knowledge

**Standards and Guidelines**
- `knowledge/front-end/standards/front-end-standards.md` - Standards for front-end implementation

**Component Patterns**
- `knowledge/front-end/patterns/component-patterns.md` - Common component implementation patterns

**Integration Patterns**
- `knowledge/front-end/integration/api-integration-patterns.md` - Patterns for API integration

### Back-End Workflow Knowledge

**Standards and Guidelines**
- `knowledge/back-end/standards/back-end-standards.md` - Standards for back-end implementation

**API Patterns**
- `knowledge/back-end/patterns/api-patterns.md` - Common API implementation patterns

**Data Handling**
- `knowledge/back-end/data/data-handling-patterns.md` - Patterns for data handling

## Cross-Cutting Knowledge

### System Structure Knowledge

**System Organization**
- `knowledge/system-structure/system-vs-subsystem.md` - Clarification of system vs. subsystem structure

### Common Knowledge

**Shared Standards**
- `knowledge/common/standards/shared-standards.md` - Standards applicable across all workflows

**Shared Patterns**
- `knowledge/common/patterns/shared-patterns.md` - Patterns applicable across all workflows

## Knowledge Categories

### Standards Knowledge

Standards knowledge defines quality benchmarks and implementation requirements:

- `knowledge/quality/standards/quality-standards.md`
- `knowledge/scripts/standards/script-standards.md`
- `knowledge/front-end/standards/front-end-standards.md`
- `knowledge/back-end/standards/back-end-standards.md`
- `knowledge/common/standards/shared-standards.md`

### Pattern Knowledge

Pattern knowledge defines reusable implementation patterns:

- `knowledge/rules/patterns/modes/plan-mode-patterns.md`
- `knowledge/rules/patterns/modes/dev-mode-patterns.md`
- `knowledge/rules/patterns/modes/direct-mode-patterns.md`
- `knowledge/quality/enhancement/quality-enhancement-patterns.md`
- `knowledge/scripts/patterns/common-patterns.md`
- `knowledge/front-end/patterns/component-patterns.md`
- `knowledge/back-end/patterns/api-patterns.md`
- `knowledge/common/patterns/shared-patterns.md`

### Reference Knowledge

Reference knowledge provides detailed reference information:

- `knowledge/rules/reference/syntax/message-command-syntax.md`
- `knowledge/rules/reference/syntax/mode-indicator-syntax.md`

### Guide Knowledge

Guide knowledge provides step-by-step guidance for implementation:

- `knowledge/rules/guides/cognitive-enhancement-guide.md`
- `knowledge/rules/guides/system-navigation-guide.md`
- `knowledge/quality/monitoring/quality-monitoring-guide.md`

### Template Knowledge

Template knowledge provides reusable templates:

- `knowledge/quality/templates/quality-assessment-template.md`
- `knowledge/quality/templates/issue-reporting-template.md`

### Analysis Knowledge

Analysis knowledge provides methods for analysis:

- `knowledge/quality/analysis/quality-analysis-methods.md`
- `knowledge/quality/analysis/root-cause-analysis.md`

## Accessing Knowledge

To access specific knowledge, use the fetch_rules tool with the appropriate path:

```typescript
// To access quality standards
fetch_rules(["knowledge/quality/standards/quality-standards"], 
           "Understanding quality standards for implementation")

// To access multiple related knowledge files
fetch_rules([
  "knowledge/rules/patterns/modes/plan-mode-patterns",
  "knowledge/rules/patterns/modes/common-mode-patterns"
], "Understanding plan-mode patterns and common patterns")
```

## Knowledge Organization Evolution

The Knowledge Subsystem is continuously evolving:

1. **Expansion**: New knowledge files are added as needed
2. **Refinement**: Existing knowledge is improved based on usage
3. **Restructuring**: Organization is optimized for efficient access
4. **Integration**: Knowledge is integrated across domains
5. **Standardization**: Structure and formatting are standardized

This index is updated regularly to reflect the current state of the Knowledge Subsystem. 