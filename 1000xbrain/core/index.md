# Simplified Core System Index

## Overview

This file serves as a simplified index for the 1000xdev core system. It provides references to detailed information that has been moved to the knowledge directory to streamline the Always rules and reduce cognitive load.

## Core Essentials

The core-essentials.md file contains the essential information about 1000xdev's identity, mode system, and message-commands. For detailed information, refer to the following knowledge components:

| Topic | Path | Access Method |
|-------|------|---------------|
| Mode System | knowledge/rules/reference/architecture/modes.md | `fetch_rules(["knowledge/rules/reference/architecture/modes"])` |
| Message Commands | knowledge/rules/reference/architecture/message-commands.md | `fetch_rules(["knowledge/rules/reference/architecture/message-commands"])` |
| File Safety | knowledge/rules/reference/architecture/file-safety.md | `fetch_rules(["knowledge/rules/reference/architecture/file-safety"])` |
| 1000xdev Identity | knowledge/rules/reference/architecture/identity.md | `fetch_rules(["knowledge/rules/reference/architecture/identity"])` |
| Knowledge Access | knowledge/rules/reference/architecture/knowledge-access.md | `fetch_rules(["knowledge/rules/reference/architecture/knowledge-access"])` |
| Simplified Commands | knowledge/rules/guides/simplified-message-commands.md | `fetch_rules(["knowledge/rules/guides/simplified-message-commands"])` |

## ⚠️ MANDATORY Tool Usage Standards ⚠️

These core tool files contain MANDATORY requirements that take precedence over any knowledge files:

| Topic | Path | Description |
|-------|------|-------------|
| File Reading Enforcement | core/tools/file-reading-enforcement.md | Critical mandatory procedure for file reading operations |
| Tool Usage Standards | core/tools/tool-usage-standards.md | Mandatory standards for all tool usage |
| Knowledge Integration | core/tools/knowledge-integration.md | Guidelines for resolving conflicts between knowledge and core |

These standards are non-negotiable and must be followed in all implementation contexts, specifically:

1. **ALWAYS read entire files** with should_read_entire_file=true
2. **NEVER use partial reading** without first reading the entire file
3. **Core directives ALWAYS take precedence** over knowledge-base patterns

## Mode-Specific Information

For detailed information about each mode, refer to the following knowledge components:

| Mode | Path | Access Method |
|------|------|---------------|
| Planning Mode | knowledge/rules/reference/architecture/modes.md | `fetch_rules(["knowledge/rules/reference/architecture/modes"])` |
| Developer Mode | knowledge/rules/reference/architecture/modes.md | `fetch_rules(["knowledge/rules/reference/architecture/modes"])` |
| Direct Mode | knowledge/rules/reference/architecture/modes.md | `fetch_rules(["knowledge/rules/reference/architecture/modes"])` |

## Message Command Information

For detailed information about message commands, refer to the following knowledge components:

| Topic | Path | Access Method |
|-------|------|---------------|
| Basic Commands | knowledge/rules/reference/architecture/message-commands.md | `fetch_rules(["knowledge/rules/reference/architecture/message-commands"])` |
| Simplified System | knowledge/rules/guides/simplified-message-commands.md | `fetch_rules(["knowledge/rules/guides/simplified-message-commands"])` |
| Project Rule Parameters | knowledge/rules/reference/architecture/message-commands.md | `fetch_rules(["knowledge/rules/reference/architecture/message-commands"])` |

## File Safety Information

For detailed information about file editing safety, refer to the following knowledge components:

| Topic | Path | Access Method |
|-------|------|---------------|
| File Editing Safety | knowledge/rules/reference/architecture/file-safety.md | `fetch_rules(["knowledge/rules/reference/architecture/file-safety"])` |
| Brain-Files vs. Cursor-Rules | knowledge/rules/reference/architecture/file-safety.md | `fetch_rules(["knowledge/rules/reference/architecture/file-safety"])` |
| Symbol Protection | knowledge/rules/reference/architecture/file-safety.md | `fetch_rules(["knowledge/rules/reference/architecture/file-safety"])` |

## Knowledge Access Information

For detailed information about the knowledge access system, refer to the following knowledge components:

| Topic | Path | Access Method |
|-------|------|---------------|
| Knowledge System | knowledge/rules/reference/architecture/knowledge-access.md | `fetch_rules(["knowledge/rules/reference/architecture/knowledge-access"])` |
| fetch_rules Tool | knowledge/rules/reference/architecture/knowledge-access.md | `fetch_rules(["knowledge/rules/reference/architecture/knowledge-access"])` |
| Knowledge Directory | knowledge/rules/reference/architecture/knowledge-access.md | `fetch_rules(["knowledge/rules/reference/architecture/knowledge-access"])` |
| Best Practices | knowledge/rules/reference/architecture/knowledge-access.md | `fetch_rules(["knowledge/rules/reference/architecture/knowledge-access"])` |

## Tool Usage Information

For comprehensive information about tool usage beyond the mandatory requirements, refer to:

| Topic | Path | Access Method |
|-------|------|---------------|
| Tool Patterns | knowledge/rules/patterns/tool/basic-patterns.md | `fetch_rules(["knowledge/rules/patterns/tool/basic-patterns"])` |
| Search Patterns | knowledge/rules/patterns/tool/search-patterns.md | `fetch_rules(["knowledge/rules/patterns/tool/search-patterns"])` |
| Tool Combinations | knowledge/rules/patterns/tool/tool-combinations.md | `fetch_rules(["knowledge/rules/patterns/tool/tool-combinations"])` |
| Command Patterns | knowledge/rules/patterns/tool/command-patterns.md | `fetch_rules(["knowledge/rules/patterns/tool/command-patterns"])` |

## Why This Approach

This simplified approach offers several advantages:

1. **Reduced Cognitive Load**: Core system contains only essential information
2. **On-Demand Loading**: Detailed information loaded only when needed
3. **Improved Context Efficiency**: Context space used more efficiently
4. **Better Focused Cognition**: Core identity and mode system remain clear and focused
5. **Flexible Evolution**: Detailed implementation can evolve without modifying core rules
6. **Clear Precedence**: Explicit distinction between mandatory core directives and knowledge guidance
7. **Consistent Implementation**: Standardized approach to critical operations like file reading 