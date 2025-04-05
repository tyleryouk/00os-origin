# Planning Mode Patterns

## Overview

This file provides comprehensive implementation patterns and guidelines for Planning Mode. It contains the consolidated knowledge previously spread across multiple files in the core/modes/plan-mode directory.

## Planning Mode Essentials

Planning Mode is the documentation and preparation phase of the workflow, focused on creating comprehensive planning documents that serve as the foundation for implementation. In this mode, 1000xdev analyzes requirements and develops detailed implementation plans.

## Core Planning Mode Responsibilities

1. **Documentation Creation**: Develop comprehensive planning documentation
2. **Planning & Analysis**: Analyze requirements and plan implementation approach
3. **Knowledge Documentation**: Document knowledge and insights for implementation
4. **Context Building**: Establish essential context for implementation

## Knowledge Access Patterns

### Basic Knowledge Access Patterns

```typescript
// Access architecture understanding for planning
fetch_rules(["knowledge/rules/guides/architecture"], 
           "Understanding system architecture for planning implementation")

// Access implementation patterns for planning
fetch_rules(["knowledge/rules/patterns/impl/implementation-patterns"], 
           "Finding implementation patterns for planning approach")

// Access multiple related knowledge components
fetch_rules([
  "knowledge/rules/guides/architecture",
  "knowledge/rules/patterns/impl/implementation-patterns"
], "Understanding both architecture and patterns for comprehensive planning")
```

### Planning-Specific Knowledge Components

When creating planning documentation, use these knowledge components:

| Knowledge Type | fetch_rules Path | Planning Usage |
|---------------|-----------------|---------------|
| Architecture Guides | `knowledge/rules/guides/architecture` | Understanding system structure |
| Implementation Patterns | `knowledge/rules/patterns/impl/implementation-patterns` | Planning implementation approaches |
| Tool Patterns | `knowledge/rules/patterns/tool/search-patterns` | Planning efficient search strategies |
| Documentation Patterns | `knowledge/rules/patterns/doc/file-standards` | Creating standardized documentation |
| Domain Maps | `knowledge/rules/reference/maps/domain-map` | Understanding knowledge relationships |
| Cognitive Enhancement | `knowledge/rules/guides/cognitive-enhancement` | Planning system improvements |
| Architecture Patterns | `knowledge/rules/patterns/impl/architecture-patterns` | Planning architectural changes |

### Knowledge Access Best Practices

1. **Access Architecture Understanding First**:
   ```typescript
   fetch_rules(["knowledge/rules/guides/architecture"], 
              "Understanding system architecture for planning")
   ```

2. **Research Implementation Patterns**:
   ```typescript
   fetch_rules(["knowledge/rules/patterns/impl/implementation-patterns"], 
              "Researching implementation patterns for planning")
   ```

3. **Document Knowledge Dependencies**:
   ```markdown
   ## Implementation Approach
   
   This implementation uses patterns from:
   - Architecture guides for system understanding
   - Implementation patterns for standard approaches
   ```

## Documentation Patterns

### Planning Folder Structure

A simplified planning folder needs only two essential files:

| File | Purpose | Creator | Primary Audience |
|------|---------|---------|-----------------|
| `requirements.md` | Core requirements and objectives | Tyler provides outline, 1000xdev enhances | Both |
| `implementation.md` | Implementation approach and guidance | 1000xdev | 1000xdev |

### Optional Files

Additional files for complex projects:

| Optional File | Purpose | When to Include |
|--------------|---------|----------------|
| `context.md` | Technical context and architecture | For complex features requiring detailed context |
| `test-cheatsheet.md` | Testing scenarios | For features requiring extensive testing |
| `README.md` | Overview and quick reference | For larger planning folders with multiple files |

### Requirements Document Structure
```markdown
# Requirements

## Objective
[Clear statement of what needs to be accomplished]

## Success Criteria
[List of specific measurable outcomes]

## Technical Requirements
[List of essential technical requirements]
```

### Implementation Document Structure
```markdown
# Implementation Plan

## Target Files
[List of files to modify]

## Implementation Approach
[Clear implementation guidance]

## Verification Approach
[How to verify the implementation is correct]
```

### Documentation Creation and Editing

- **Primary Tool**: `edit_file` for creating and modifying documentation files
- **Usage Pattern**: Create comprehensive files in single edits
- **Best Practice**: Focus on essential content

```typescript
// Create implementation document
edit_file("planning/feature-name/implementation.md", 
          "Create implementation plan",
          "# Implementation Plan\n\n## Target Files\n\n...")
```

## Verification Patterns

### Essential Planning Verification Checklist

Before signaling planning completion, verify these key aspects:

### Requirements Verification
- [ ] Objectives are clearly defined
- [ ] Success criteria are established
- [ ] Core technical requirements are documented

### Implementation Verification
- [ ] Target files are identified
- [ ] Implementation approach is clear
- [ ] Verification method is established

### Overall Planning Folder Verification
- [ ] Essential files are present and complete
- [ ] Documentation provides sufficient guidance for implementation
- [ ] No critical information gaps exist

### Knowledge Access Verification
- [ ] Proper fetch_rules tool usage documented if needed
- [ ] Clear explanation parameters for knowledge access
- [ ] Appropriate knowledge components referenced

### Documentation Standards Verification
- [ ] `requirements.md` exists and is complete
- [ ] `implementation.md` exists and is complete
- [ ] Optional files are included when needed

### Content Quality Verification
- [ ] Documentation is clear and focused
- [ ] Implementation guidance is actionable
- [ ] Success criteria are measurable
- [ ] Technical requirements are specific

## Completion Patterns

### Planning Completion Verification

Before signaling planning completion, verify:

### Completeness Verification
- [ ] Essential files contain required information
- [ ] Implementation guidance is clear and actionable
- [ ] Documentation provides enough context for autonomous implementation
- [ ] Knowledge access is properly documented

### Quality Verification
- [ ] Documentation is clear and focused
- [ ] Implementation steps are well-defined
- [ ] Success criteria are measurable
- [ ] Technical requirements are specific

### Implementation Readiness
- [ ] Target files are identified
- [ ] Implementation approach is clear
- [ ] Verification methods are established
- [ ] Dependencies are documented

### Planning Completion Signal

When planning is complete and verified, send the `planning-document-complete` signal:

```
📋 1000xdev [workflow-type]

planning-document-complete

Planning is complete with:
- Requirements document with clear objectives and success criteria
- Implementation plan with detailed approach
- Context files with essential system information
```

### Signal Requirements
- Must begin with mode indicator
- Must include `planning-document-complete` signal
- Must summarize completed documentation
- Must confirm verification completion

### Essential Files
- `requirements.md`: Complete with clear objectives
- `implementation.md`: Complete with detailed guidance
- Optional files: Complete if included

## Mode-Specific Rules

All file modifications in Planning Mode must follow these rules:

1. **Mandatory Mode Indicator**: Always begin with 📋 1000xdev [workflow-type]
2. **Tool Usage Requirement**: Always use edit_file tool for file modifications
3. **Direct Editing**: Make changes directly in files rather than suggesting them
4. **Edit Verification**: Always verify changes were successfully applied
5. **Focus on Essentials**: Include only necessary information
6. **Knowledge Access**: Use fetch_rules for specialized knowledge

## Planning Mode Communication Style

- **Focus**: Documentation clarity, completeness, and planning folder structure
- **Tone**: Analytical and thorough
- **Detail Level**: Comprehensive with clear organization
- **Emphasis**: Architecture, relationships, planning, and implementation guidance 