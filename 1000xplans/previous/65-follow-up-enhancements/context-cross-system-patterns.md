# Context Analysis: Cross-System Patterns

## Overview

This document analyzes cross-system patterns for standardizing documentation across all README.md files to reflect the new 1000xbrain directory structure. The reorganization creates a clear, one-to-one mapping between directories and rule types, requiring consistent patterns for documenting each access method.

## New Knowledge Access Patterns

The reorganized 1000xbrain cognitive architecture now implements a clean mapping between directories and rule types:

### 1. Core Knowledge (Always Rules in /core)
- **Access Method**: Automatic inclusion in every conversation
- **Directory**: `/core`
- **Documentation Pattern**: Referenced as foundational, always-available knowledge
- **Example Format**: "See core-essentials.md for basic identity components"

### 2. Workflow Knowledge (Auto-Attached Rules in /workflows)
- **Access Method**: Automatic inclusion when matching files are referenced
- **Directory**: `/workflows`
- **Documentation Pattern**: Referenced as domain-specific workflows
- **Example Format**: "Follow front-end-workflow.md for React component implementation"

### 3. Parameter Knowledge (Manual Rules in /parameters)
- **Access Method**: Explicit reference with @ symbol in message-commands
- **Directory**: `/parameters`
- **Documentation Pattern**: Referenced as project-rule-parameters
- **Example Format**: "verify-planning: @parameters/rules/verify-planning.mdc"

### 4. Specialized Knowledge (Agent Requested Rules in /knowledge)
- **Access Method**: fetch_rules tool OR automatic inclusion
- **Directory**: `/knowledge`
- **Documentation Pattern**: Referenced via fetch_rules tool
- **Example Format**: "fetch_rules([\"knowledge/patterns/tool/search-patterns\"])"

## Target Cross-System Patterns

To ensure consistency across all README.md files, the following patterns should be implemented:

### 1. Directory-Purpose Section Structure

Each README.md should include a standardized section explaining the directory's purpose within the new structure:

```markdown
## Directory Purpose

The `[directory-name]` directory contains [rule-type] rules that are [access-method]:

- **Rule Type**: [Always/Auto-Attached/Manual/Agent Requested]
- **Access Method**: [Automatic/File-Triggered/Project-Rule-Parameter/fetch_rules]
- **When Active**: [When accessed/When relevant files are referenced/etc.]
```

### 2. Directory-Specific Access Documentation

Each README.md should include a directory-specific access section:

#### Core Directory Access (/core)
```markdown
## Always Rules Access

Files in the core directory are **Always Rules** that:

- Are automatically included in every conversation
- Provide fundamental cognitive capabilities
- Form the baseline of 1000xdev's operation
- Require no explicit access method
```

#### Workflows Directory Access (/workflows)
```markdown
## Auto-Attached Rules Access

Files in the workflows directory are **Auto-Attached Rules** that:

- Are automatically included when matching files are referenced
- Activate based on workflow type (file extensions/paths)
- Provide domain-specific workflow guidance
- Require no explicit access method
```

#### Parameters Directory Access (/parameters)
```markdown
## Manual Rules Access

Files in the parameters directory are **Manual Rules** that:

- Are accessed as project-rule-parameters in message-commands
- Must be explicitly referenced with the @ symbol
- Provide task-specific implementation details
- Follow this syntax: `message-command: @parameters/path/to/file.mdc`
```

#### Knowledge Directory Access (/knowledge)
```markdown
## Agent Requested Rules Access

Files in the knowledge directory are **Agent Requested Rules** that:

- Are accessed using the fetch_rules tool
- Can be automatically included when relevant to current task
- Provide specialized domain knowledge
- Follow this syntax: `fetch_rules(["knowledge/path/to/file"])`
```

### 3. Cross-Reference Pattern

README.md files should include standardized cross-references to other rule types:

```markdown
## Relationship to Other Rule Types

This directory works in conjunction with:

- **Core Knowledge** (/core): Provides foundational capabilities [Always Rules]
- **Workflow Knowledge** (/workflows): Provides domain-specific workflows [Auto-Attached Rules]
- **Parameter Knowledge** (/parameters): Provides task-specific details [Manual Rules]
- **Specialized Knowledge** (/knowledge): Provides domain expertise [Agent Requested Rules]
```

### 4. Access Method Comparison

Each README.md should include a standardized comparison of access methods:

```markdown
## Knowledge Access Methods

| Rule Type | Directory | Access Method | When to Use |
|-----------|-----------|---------------|------------|
| Always | /core | Automatic in every conversation | Fundamental capabilities |
| Auto-Attached | /workflows | Automatic when files match | Domain-specific tasks |
| Manual | /parameters | Explicit reference with @ | Task-specific details |
| Agent Requested | /knowledge | fetch_rules tool | Domain expertise |
```

### 5. Decision Guide Pattern

Each README.md should include a standardized decision guide for choosing the appropriate access method:

```markdown
## Choosing the Right Access Method

| If you need... | Then use... | From Directory | How to Access |
|----------------|-------------|----------------|---------------|
| Core identity or fundamental understanding | Always Rules | /core | Automatic |
| Domain-specific workflow guidance | Auto-Attached Rules | /workflows | Automatic when files match |
| Task-specific implementation details | Manual Rules | /parameters | message-command: @parameters/path.mdc |
| Specialized domain expertise | Agent Requested Rules | /knowledge | fetch_rules(["knowledge/path"]) |
```

## Cross-System Implementation Guide

The implementation across all README.md files should follow these principles:

1. **Consistent Directory-Rule Type Mapping**: Clearly associate each directory with exactly one rule type
2. **Access Method Clarity**: Provide consistent documentation of access methods for each rule type
3. **Terminology Standardization**: Use the exact same terms for each rule type and access method
4. **Example Consistency**: Use standardized examples for each access method
5. **Visual Hierarchy**: Use consistent headings, tables, and formatting

## Directory-Specific Documentation Patterns

### Root README.md (/1000xbrain/README.md)

The root README.md should include a comprehensive overview of the new structure:

```markdown
## Directory Structure and Rule Types

The 1000xbrain cognitive architecture is organized by rule type:

| Directory | Rule Type | Access Method | Purpose |
|-----------|-----------|---------------|---------|
| /core | Always | Automatic | Fundamental cognitive capabilities |
| /workflows | Auto-Attached | File matching | Domain-specific workflows |
| /parameters | Manual | @-reference | Task-specific implementation details |
| /knowledge | Agent Requested | fetch_rules | Specialized domain knowledge |
```

### Core README.md (/1000xbrain/core/README.md)

Focus on Always rules and their automatic nature:

```markdown
## Always Rules

Files in the core directory are **Always Rules** that form the foundation of 1000xbrain's cognitive architecture:

- Automatically included in every conversation
- Define core identity and mode system
- Require no explicit access method

For specialized knowledge, use fetch_rules to access files from the knowledge directory:

```typescript
fetch_rules(["knowledge/guides/architecture"], 
           "Understanding system architecture")
```
```

### Parameters README.md (/1000xbrain/parameters/README.md)

Focus on Manual rules and project-rule-parameters:

```markdown
## Manual Rules as Project-Rule-Parameters

Files in the parameters directory are **Manual Rules** accessed through project-rule-parameters:

```
message-command: @parameters/path/to/file.mdc
```

Example:
```
verify-planning: @parameters/rules/verify-planning.mdc
```

For specialized knowledge, use fetch_rules to access files from the knowledge directory:

```typescript
fetch_rules(["knowledge/patterns/tool/search-patterns"], 
           "Optimizing file searching")
```
```

### Knowledge README.md (/1000xbrain/knowledge/README.md)

Focus on Agent Requested rules and fetch_rules access:

```markdown
## Agent Requested Rules

Files in the knowledge directory are **Agent Requested Rules** accessed through the fetch_rules tool:

```typescript
fetch_rules(["knowledge/patterns/tool/search-patterns"])
```

With explanation:
```typescript
fetch_rules(["knowledge/patterns/tool/search-patterns"], 
           "Fetching search patterns to optimize file searching")
```

Available Agent Requested rules can be found in the <available_instructions> section.
```

### Workflows README.md (/1000xbrain/workflows/README.md)

Focus on Auto-Attached rules and file matching:

```markdown
## Auto-Attached Rules

Files in the workflows directory are **Auto-Attached Rules** that activate automatically when matching files are referenced:

- front-end-workflow.md activates when working with *.ts, *.tsx files
- back-end-workflow.md activates when working with *.py files
- rules-workflow.md activates when working with 1000xbrain files

For specialized knowledge, use fetch_rules to access files from the knowledge directory:

```typescript
fetch_rules(["knowledge/patterns/impl/implementation-patterns"], 
           "Accessing implementation patterns")
```
```

## Standard README.md Organization Template

All README.md files should follow this standardized organization:

```
1. Title and Introduction
2. Directory Purpose and Rule Type
3. Access Method Documentation
4. Relationship to Other Rule Types
5. File Organization
6. Examples of Usage
7. Cross-References
```

## Cross-System Visual Elements

All README.md files should use these consistent visual elements:

1. **Directory-Rule Type Table**: Standard table linking directories to rule types
2. **Access Method Comparison**: Standard table comparing access methods
3. **Code Examples**: Consistent formatting for access method examples
4. **Decision Guide**: Standard format for access method selection guide
5. **Relationship Diagram**: Standard diagram showing relationships between rule types

## Common Terminology Reference

To ensure consistency, these terms should be used across all README.md files:

| Term | Definition | Usage Context |
|------|------------|---------------|
| Always Rules | Rules automatically included in every conversation | When referring to /core files |
| Auto-Attached Rules | Rules automatically included when matching files | When referring to /workflows files |
| Manual Rules | Rules explicitly referenced with @ symbol | When referring to /parameters files |
| Agent Requested Rules | Rules accessed via fetch_rules tool | When referring to /knowledge files |
| project-rule-parameters | Parameters in message-commands | When discussing @parameters references |
| fetch_rules | Tool to access Agent Requested rules | When discussing knowledge directory access |
| message-command | Command sent from Tyler to 1000xdev | When discussing parameters references |

## Related Patterns

This cross-system standardization relates to these existing patterns:

1. **Directory Organization Pattern**: One directory per rule type
2. **Access Method Pattern**: Distinct access method per rule type
3. **Documentation Pattern**: Consistent documentation structure
4. **Cross-Reference Pattern**: Standard references between rule types
5. **Visual Element Pattern**: Consistent visual elements across files