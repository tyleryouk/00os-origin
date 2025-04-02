# Planning Mode Documentation Standards

> **IMPORTANT**: This file defines documentation standards and templates for Planning Mode.

## File Purpose

This file outlines the documentation standards, folder structure, and templates used in Planning Mode. It should be consulted to understand:

- Planning folder structure and organization
- Essential and optional documentation files
- Documentation templates and formats
- File creation and modification protocols

## 1. Planning Folder Structure

### Essential Files

A simplified planning folder needs only two essential files:

| File | Purpose | Creator | Primary Audience |
|------|---------|---------|-----------------|
| `requirements.md` | Core requirements and objectives | Tyler provides outline, 1000xdev enhances | Both |
| `implementation.md` | Implementation approach and guidance | 1000xdev | 1000xdev |

### Optional Files

Additional files for complex projects:

| Optional File | Purpose | When to Include |
|---------------|---------|----------------|
| `context.md` | Technical context and architecture | For complex features requiring detailed context |
| `test-cheatsheet.md` | Testing scenarios | For features requiring extensive testing |
| `README.md` | Overview and quick reference | For larger planning folders with multiple files |

## 2. Template System

### Template Types

Planning can be initiated with different templates based on complexity:

1. **Basic Template** (`plan-mode: workflow-type @template-basic.mdc`):
   - Creates minimal planning structure with only essential files
   - Suitable for simple implementations

2. **Advanced Template** (`plan-mode: workflow-type @template-advanced.mdc`):
   - Creates more comprehensive planning structure
   - Includes optional files for complex implementations

3. **Custom Templates** (`plan-mode: workflow-type @template-custom.mdc`):
   - Specialized templates for specific needs
   - Can be developed for recurring implementation patterns

## 3. Documentation Templates

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

## 4. File Modification Protocols

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

### File Modification Rules

All file modifications in Planning Mode must follow these rules:

1. **Mandatory Mode Indicator**: Always begin with 📋 1000xdev [workflow-type]
2. **Tool Usage Requirement**: Always use edit_file tool for file modifications
3. **Direct Editing**: Make changes directly in files rather than suggesting them
4. **Edit Verification**: Always verify changes were successfully applied
5. **Focus on Essentials**: Include only necessary information
6. **Knowledge Access**: Use fetch_rules for specialized knowledge 