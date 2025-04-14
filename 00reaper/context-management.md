# 00OS Context Management System

## Overview

This document outlines the standardized approach for managing context in 00OS, particularly focusing on maintaining continuity of knowledge and understanding between sessions. The system provides commands for initializing context, conducting research, and focusing on specific enhancements.

## Core Commands

### Context Initialization

```
> reaper-init
```

**Purpose**: Load the full 00reaper context to ensure the assistant has comprehensive understanding of the 00OS system, its architecture, and current development status.

**Behavior**:
1. Loads key files from the 00reaper directory
2. Reviews enhancement-tracker.md for current status
3. Rebuilds understanding of 00OS architecture and goals
4. Confirms successful context loading with a summary of available knowledge

**Use Case**: Start each new conversation or session with this command to establish proper context.

### Research Integration

```
> reaper-research [topic]
```

**Purpose**: Conduct targeted research while maintaining the existing 00reaper context.

**Parameters**:
- `topic`: The specific area to research (written in plain English)

**Behavior**:
1. Maintains existing 00reaper context
2. Executes web searches focused on the specified topic
3. Integrates findings with the 00OS knowledge base
4. Reports research results while preserving established context
5. Documents insights in a standardized research format

**Use Case**: When you need to expand knowledge on a specific topic relevant to 00OS enhancements.

### Enhancement Focus

```
> reaper-enhance [enhancement-id]
```

**Purpose**: Focus context on a specific enhancement from the tracker.

**Parameters**:
- `enhancement-id`: The ID number from the enhancement tracker (e.g., 007)

**Behavior**:
1. Loads relevant enhancement documentation from 00reaper/enhancements/
2. Orients response and planning around that specific feature
3. Maintains overall 00OS understanding while focusing on the specific task

**Use Case**: When working on implementing or planning a specific enhancement.

## Context Management Strategy

### Session Initialization

Each new conversation session should begin with context initialization to ensure continuity:

1. Load 00reaper directory into conversation context
2. Execute `> reaper-init` to establish system understanding
3. Specify the focus area for the current session

### Knowledge Persistence

To maintain knowledge continuity:

1. Document all significant insights in the enhancement tracker
2. Create detailed enhancement proposals for new features
3. Update documentation files to reflect the current understanding
4. Use the context commands to rebuild context when needed

### Research Documentation

Research findings should be documented in a standardized format:

1. Create a research document in 00reaper/research/YYYY-MM-DD-topic.md
2. Include:
   - Clear problem/question statement
   - Summary of findings
   - Relevant information sources
   - Implications for 00OS development
   - Recommended actions

## Implementation

These commands will be implemented as formal processes in the 00OS structure:

- `00os/processes/system/reaper-init.md`
- `00os/processes/system/reaper-research.md`
- `00os/processes/system/reaper-enhance.md`

Each process will follow the standard 00OS process format with proper metadata, initialization, execution, and output blocks.

## Command Nomenclature

These commands are part of the "00OS commands" system, which uses the `>` prefix to distinguish command mode from conversational mode. This naming convention aligns with the overall system architecture and maintains consistency with existing components.

## Usage Examples

### Context Initialization Example

```
> reaper-init
```

Expected output:
```
✅ 00reaper context initialized

Loaded system knowledge:
- 00OS architecture and components
- Current enhancements (8 total, 5 completed)
- Development workflow processes
- Rule type management guidelines

Ready for system administration tasks.
```

### Research Example

```
> reaper-research cursor rules frontmatter requirements
```

Expected output:
```
✅ Research completed: cursor rules frontmatter requirements

Key findings:
1. Frontmatter must be enclosed in triple-dash lines (---)
2. Required fields: description, globs (can be empty), alwaysApply
3. The first frontmatter block takes precedence when multiple exist
4. Descriptions with "USE WHEN" prefix improve rule activation accuracy

Research saved to: 00reaper/research/2023-06-10-cursor-rules-frontmatter.md
```

### Enhancement Focus Example

```
> reaper-enhance 007
```

Expected output:
```
✅ Enhancement context loaded: 007 - Command Composition

Status: Planned
Description: Support for chaining and piping commands
Implementation approach:
- Update parser to recognize pipe (|), chain (&&), and redirection (>) operators
- Modify executor to support sequential and piped execution
- Implement output capture and redirection mechanism

Ready to proceed with implementation planning.
``` 