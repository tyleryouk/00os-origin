# README.md Policy and Guidelines

## Overview

This guideline defines the official policy for README.md file usage across the system, standardizing when and how these files should be implemented to ensure consistency while maintaining their exclusion from Cursor rules synchronization.

## Core Principles

1. **Purpose of README.md Files**:
   * README.md files serve as navigational aids and context providers for directories
   * They are explicitly excluded from synchronization to `.cursor/rules`
   * They provide documentation at the directory level rather than implementing rules or functionality

2. **Directory-Based Policy**:
   * README.md files should be included in specific directory types based on their function
   * Content should follow standardized templates based on directory type
   * Implementation should be consistent across parallel directory structures

## Directory Types and README Requirements

| Directory Type | README Required | Primary Purpose | Template to Use |
|----------------|----------------|-----------------|-----------------|
| Top-level Components | ✅ Required | Explain component purpose and structure | Component Overview Template |
| Workflow Command Directories | ✅ Required | Document workflow sequence and relationship to other workflows | Workflow Overview Template |
| Process Directories | ❌ Not Required | N/A | N/A |
| Knowledge Directories | ❌ Not Required | N/A | N/A |
| Specialized Command Directories | ✅ Required | Explain command grouping purpose | Command Group Template |
| Implementation Directories | ✅ Required | Describe implementation approach | Implementation Overview Template |
| Operational Feedback Directories | ❌ Not Required | N/A | N/A |

## Standard README Templates

### Component Overview Template
```markdown
# [Component Name]

This directory contains [brief description of component purpose].

## Structure

* `subdirectory1/` - [purpose]
* `subdirectory2/` - [purpose]
* `file.md` - [purpose]

## Relationship to Other Components

This component [describe relationship to other main system components].
```

### Workflow Overview Template
```markdown
# [Workflow Name]

This directory contains command files for the [workflow description].

## Purpose

[Explain the workflow's purpose and when/how it should be used]

## Command Sequence

1. `1.md` ([name]) - [brief description]
2. `2.md` ([name]) - [brief description]
[etc.]

## Usage

Commands should be executed in sequence using the standard invocation format:
`run command:[domain]/[name]/[number]`

## State Management

The workflow maintains state between commands in:
`[path to operational_feedback directory]`
```

### Command Group Template
```markdown
# [Command Group Name]

This directory contains command files for [purpose of command group].

## Available Commands

* `command-name.md` - [brief description]
* `another-command.md` - [brief description]
[etc.]

## Usage

Commands can be executed using:
`run command:[domain]/[group]/[command-name]`
```

### Implementation Overview Template
```markdown
# [Implementation Name]

This directory contains implementation files for [brief description].

## Components

* `file1.md` - [purpose]
* `file2.md` - [purpose]
[etc.]

## Integration

These implementation files are used by [describe where and how the implementation is used].
```

## Implementation Guidelines

1. **Creation Process**:
   * Create README.md files during initial directory creation
   * Follow the appropriate template based on directory type
   * Customize content to accurately reflect the specific component

2. **Maintenance Responsibilities**:
   * README.md files should be updated whenever directory structure or purpose changes
   * Content should evolve alongside the component it documents
   * References to other components should be kept current

3. **Content Quality Standards**:
   * Keep descriptions concise but informative
   * Focus on structural information rather than implementation details
   * Maintain consistent style and formatting

## Exclusion from Synchronization

README.md files are explicitly excluded from synchronization to `.cursor/rules` via:
* Explicit exclusion in Sync-CursorRules.ps1
* Pattern matching in sync scripts

This ensures they serve their documentation purpose without cluttering the rules engine.

## Implementation Schedule

As part of the standardization effort, README.md files should be:
1. Added to required directories that currently lack them
2. Updated in existing directories to match the new templates
3. Removed from directories where they are not required by this policy

## Related References

* Sync Scripts: `1000xscripts/Sync-CursorRules.ps1`
* File Editing Safety: `1000xrules/core/communication/file-editing-safety.md` 