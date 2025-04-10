# Context Analysis: Architecture Mapping

## Overview

This document maps the architecture of the 1000xbrain directory structure, which has been reorganized to create a clear mapping between directories and rule types. The purpose is to identify all README.md files that need updates to reflect this new organization, document integration points, and analyze the current state of documentation versus required enhancements.

## New 1000xbrain Directory Structure

The 1000xbrain directory has been reorganized into a clean structure where each directory corresponds to exactly one rule type:

- `/core` - Always rule types (automatically included in every conversation)
- `/knowledge` - Agent Request rule types (accessible through fetch_rules tool call)
- `/parameters` - Manual rule types (accessible as project-rule-parameters for message-commands)
- `/workflows` - Auto Attached rule types (automatically attached based on the workflow-type)

This reorganization creates a direct one-to-one mapping between directories and rule types, requiring comprehensive documentation updates to all README.md files.

## README.md Files Inventory

The following README.md files need to be updated to reflect the new directory structure and proper fetch_rules tool documentation:

1. **Root README.md** (`/1000xbrain/README.md`)
   - Primary overview of the entire cognitive architecture
   - Needs comprehensive documentation of the new directory structure
   - Must document all four rule types and their access methods

2. **Core README.md** (`/1000xbrain/core/README.md`)
   - Documents Always rules in the core directory
   - Needs clarification of its relationship to other rule types
   - Must reference fetch_rules for accessing specialized knowledge

3. **Knowledge README.md** (`/1000xbrain/knowledge/README.md`)
   - Documents Agent Requested rules
   - Needs comprehensive fetch_rules documentation
   - Must explain the difference between automatic inclusion and direct access

4. **Patterns README.md** (`/1000xbrain/knowledge/patterns/README.md`)
   - Documents patterns organized as Agent Requested rules
   - Needs specific fetch_rules examples for pattern access
   - Must explain how patterns relate to other knowledge types

5. **Reference README.md** (`/1000xbrain/knowledge/reference/README.md`)
   - Documents reference materials organized as Agent Requested rules
   - Needs specific fetch_rules examples for reference access
   - Must explain how reference materials support other knowledge types

6. **Workflows README.md** (`/1000xbrain/workflows/README.md`)
   - Documents Auto-Attached rules in the workflows directory
   - Needs clarification of workflow activation mechanisms
   - Must reference fetch_rules for accessing specialized knowledge

7. **Parameters README.md** (`/1000xbrain/parameters/README.md`)
   - Documents Manual rules accessed as project-rule-parameters
   - Needs clarification of message-command syntax
   - Must reference fetch_rules for accessing specialized knowledge

## Directory to Rule Type Mapping

The reorganization establishes this clear mapping:

| Directory | Rule Type | Access Method | Documentation Focus |
|-----------|-----------|---------------|---------------------|
| `/core` | Always | Automatic inclusion | Identity, mode system, core capabilities |
| `/knowledge` | Agent Requested | fetch_rules tool | Specialized domain expertise |
| `/parameters` | Manual | project-rule-parameters | Task-specific implementation details |
| `/workflows` | Auto-Attached | File matching | Domain-specific workflow guidance |

## Current Documentation State vs. Required Updates

### Root README.md

**Current State**: 
- General overview of the brain-files structure
- Basic documentation of knowledge organization
- Limited explanation of rule types

**Required Updates**:
- Document the new four-directory structure
- Explain the one-to-one mapping between directories and rule types
- Provide access method documentation for all rule types
- Include cross-reference patterns between directories
- Document fetch_rules tool usage for accessing Agent Requested rules

### Core README.md

**Current State**:
- Focuses on core identity components
- Limited reference to other knowledge types
- No fetch_rules documentation

**Required Updates**:
- Identify directory as containing Always rules
- Explain automatic inclusion mechanism
- Document relationship to other rule types
- Include fetch_rules examples for accessing specialized knowledge
- Add directory purpose section with rule type identification

### Knowledge README.md

**Current State**:
- General overview of knowledge organization
- Limited guidance on knowledge access
- No comprehensive fetch_rules documentation

**Required Updates**:
- Identify directory as containing Agent Requested rules
- Provide comprehensive fetch_rules documentation
- Explain automatic inclusion vs. direct access
- Include examples for different knowledge domains
- Add directory purpose section with rule type identification

### Workflows README.md

**Current State**:
- Documents workflow-specific knowledge
- Limited explanation of activation mechanisms
- No fetch_rules documentation

**Required Updates**:
- Identify directory as containing Auto-Attached rules
- Explain file-matching activation mechanism
- Document relationship to other rule types
- Include fetch_rules examples for accessing specialized knowledge
- Add directory purpose section with rule type identification

### Parameters README.md

**Current State**:
- New directory requiring complete documentation
- No existing documentation of project-rule-parameters in this context

**Required Updates**:
- Create comprehensive documentation for Manual rules
- Explain project-rule-parameter syntax and usage
- Document relationship to other rule types
- Include fetch_rules examples for accessing specialized knowledge
- Add directory purpose section with rule type identification

## Integration Points for fetch_rules Documentation

### Visual Integration

Each README.md file should visually distinguish the four access methods:

```
┌───────────────────────────────────────────────────────────────────────┐
│                                                                       │
│  Directory-Rule Type Integration                                     │
│                                                                       │
│  ┌────────────────────┐ ┌────────────────────┐ ┌────────────────────┐ │
│  │                    │ │                    │ │                    │ │
│  │ /core              │ │ /workflows         │ │ /parameters        │ │
│  │ Always Rules       │ │ Auto-Attached Rules│ │ Manual Rules       │ │
│  │                    │ │                    │ │                    │ │
│  └────────────────────┘ └────────────────────┘ └────────────────────┘ │
│                                                                       │
│  ┌────────────────────────────────────────────────────────────────┐   │
│  │                                                                │   │
│  │ /knowledge                                                     │   │
│  │ Agent Requested Rules (accessed via fetch_rules)               │   │
│  │                                                                │   │
│  └────────────────────────────────────────────────────────────────┘   │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```

### Terminology Integration

The fetch_rules documentation should use consistent terminology across all README.md files:

- **Rule Types**: Always, Auto-Attached, Manual, Agent Requested
- **Access Methods**: Automatic inclusion, File matching, project-rule-parameters, fetch_rules tool
- **Directory Names**: /core, /workflows, /parameters, /knowledge

### Example Integration

Each README.md file should include examples appropriate to its context but following a consistent pattern:

- **Core README.md**: Examples of using fetch_rules to access specialized knowledge beyond core capabilities
- **Workflows README.md**: Examples of using fetch_rules to access implementation patterns related to workflows
- **Parameters README.md**: Examples of using fetch_rules to supplement manual rule access
- **Knowledge README.md**: Comprehensive examples of accessing various knowledge domains

## Standardization Needs

To ensure consistent documentation across all README.md files, the following elements need standardization:

1. **Directory Purpose Sections**: Standardized sections explaining the purpose of each directory and its rule type
2. **Access Method Documentation**: Consistent documentation of how to access each rule type
3. **Cross-Reference Patterns**: Standard patterns for cross-referencing between rule types
4. **Terminology**: Consistent use of terms for rule types and access methods
5. **Examples**: Standardized examples for each access method, adapted to directory context
6. **Visual Elements**: Consistent use of tables, code blocks, and formatting

## Enhancement Impact

The comprehensive directory structure change and corresponding documentation updates will have these impacts:

1. **Structural Clarity**: Clear association between directories and rule types
2. **Access Clarity**: Explicit documentation of how to access each rule type
3. **Consistency**: Uniform documentation across all README.md files
4. **User Experience**: Improved navigation and understanding of the cognitive architecture
5. **Self-Reference**: Better self-understanding for 1000xdev through clear documentation

## Related Components

This architectural mapping relates to:

1. **Knowledge Organization**: How knowledge is structured across the 1000xbrain directory
2. **Access Methods**: How different types of rules are accessed
3. **Documentation Standards**: Standard patterns for README.md files
4. **Cognitive Integration**: How 1000xdev integrates different rule types
5. **Tool Usage Patterns**: How the fetch_rules tool and project-rule-parameters are used 