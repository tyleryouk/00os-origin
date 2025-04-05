# USE WHEN understanding the organization of the knowledge subsystem within 1000xbrain

# Knowledge Subsystem Organization

## Overview

The Knowledge Subsystem is one of the four major subsystems within the 1000xbrain cognitive architecture. It contains specialized knowledge accessible through the `fetch_rules` tool and is organized to provide efficient, targeted access to information when needed.

## Purpose and Access

**Purpose**: Provide specialized domain knowledge that can be accessed on demand through the `fetch_rules` tool.

**Rule Type**: Agent Requested rules (accessed only when explicitly requested).

**Required Header**: All knowledge files must begin with the header: `# USE WHEN [usage guidance]`

**Access Pattern**:
```typescript
fetch_rules(["knowledge/[path-to-knowledge-file]"], 
           "Explanation of why the knowledge is being accessed")
```

## Knowledge Organization Principles

The Knowledge Subsystem follows these core organizational principles:

1. **Workflow-Based Organization**: Primary organization by workflow type (rules, quality, front-end, back-end, scripts).
2. **Domain-Specific Categorization**: Within each workflow type, further categorization by domain.
3. **Targeted Knowledge Files**: Each file focused on a specific knowledge domain with clear usage guidance.
4. **Consistent Formatting**: Standard markdown formatting with proper headings, examples, and code blocks.
5. **Minimal Dependencies**: Knowledge files should minimize references to other knowledge files.
6. **Clear Usage Guidance**: Each file begins with clear guidance on when to use the information.
7. **Implementation Examples**: Where appropriate, files include practical implementation examples.

## Top-Level Knowledge Structure

The Knowledge Subsystem is organized with the following top-level directories:

1. **workflow-specific directories** - Knowledge related to specific workflows
   - `rules/` - Knowledge related to cognitive architecture enhancement
   - `quality/` - Knowledge related to quality assurance and monitoring
   - `front-end/` - Knowledge related to front-end development
   - `back-end/` - Knowledge related to back-end development
   - `scripts/` - Knowledge related to scripts and automation development

2. **cross-cutting directories** - Knowledge that spans multiple workflows
   - `system-structure/` - Knowledge about the overall system structure and organization
   - `common/` - Knowledge common to all workflows
   - `patterns/` - Reusable patterns applicable across workflows

## Knowledge File Types

Knowledge files are categorized into several types based on their purpose:

1. **Concept Files**: Explain fundamental concepts and principles
   - Example: `knowledge/system-structure/system-vs-subsystem.md`

2. **Pattern Files**: Document reusable implementation patterns
   - Example: `knowledge/rules/patterns/modes/plan-mode-patterns.md`

3. **Reference Files**: Provide comprehensive reference information
   - Example: `knowledge/rules/reference/syntax/message-command-syntax.md`

4. **Standard Files**: Define standards and requirements
   - Example: `knowledge/scripts/standards/script-standards.md`

5. **Taxonomy Files**: Provide classification systems
   - Example: `knowledge/scripts/taxonomy/script-classification.md`

6. **Guide Files**: Provide step-by-step guidance for specific tasks
   - Example: `knowledge/quality/standards/quality-standards.md`

## Access Patterns

### Direct Access Pattern
Used to access a specific knowledge file directly:

```typescript
fetch_rules(["knowledge/rules/patterns/modes/plan-mode-patterns"], 
           "Understanding plan-mode implementation patterns")
```

### Related Knowledge Access Pattern
Used to access multiple related knowledge files:

```typescript
fetch_rules([
  "knowledge/rules/patterns/modes/plan-mode-patterns",
  "knowledge/rules/patterns/doc/documentation-patterns"
], "Understanding plan-mode implementation and documentation patterns")
```

### Domain Knowledge Access Pattern
Used to access knowledge about a specific domain:

```typescript
fetch_rules(["knowledge/scripts/standards/script-standards"], 
           "Understanding script standards for implementation")
```

## Standard Knowledge Directory Structure

Each workflow-specific knowledge directory follows a standard structure:

```
knowledge/[workflow-type]/
├── standards/         # Defines standards and requirements
├── patterns/          # Documents reusable implementation patterns
├── reference/         # Provides comprehensive reference information
├── taxonomy/          # Provides classification systems
└── guides/           # Provides guidance for specific tasks
```

## Knowledge File Structure

Each knowledge file follows a standard structure:

1. **Use When Header**: `# USE WHEN [usage guidance]`
2. **Title**: `# [Title]`
3. **Overview**: Brief explanation of the file's purpose
4. **Main Content**: Organized with clear headings and subheadings
5. **Examples**: Where appropriate, practical implementation examples
6. **Conclusion/Summary**: Recap of key points

## Enhancing the Knowledge Subsystem

The Knowledge Subsystem is continuously enhanced through:

1. **Expansion**: Adding new knowledge files for emerging domains
2. **Refinement**: Improving existing knowledge based on usage patterns
3. **Restructuring**: Optimizing organization for more efficient access
4. **Cross-Referencing**: Establishing clearer relationships between knowledge domains
5. **Standardization**: Ensuring consistent formatting and structure

## Knowledge Quality Standards

Knowledge files are expected to meet these quality standards:

1. **Accuracy**: Information must be accurate and up-to-date
2. **Clarity**: Content must be clear and unambiguous
3. **Completeness**: Coverage must be comprehensive within the file's scope
4. **Consistency**: Terminology and concepts must be used consistently
5. **Accessibility**: Content must be organized for efficient comprehension
6. **Practicality**: Where appropriate, practical examples must be included
7. **Proper Formatting**: Standard markdown formatting must be followed
8. **Clear Usage Guidance**: Usage contexts must be clearly specified

## Conclusion

The Knowledge Subsystem provides specialized, on-demand knowledge to enhance the 1000xbrain cognitive architecture. By following the organizational principles and standards outlined here, we ensure that knowledge is efficiently accessible, consistently structured, and effectively utilized throughout the system. 