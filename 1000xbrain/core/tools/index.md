# Core Tools Index

## Overview

This directory contains critical tool-related directives that establish mandatory standards for tool usage within the 1000xbrain cognitive architecture. These files define non-negotiable requirements that take precedence over any knowledge-base patterns.

## ⚠️ CRITICAL FILES ⚠️

| File | Purpose | Critical Requirements |
|------|---------|------------------------|
| [file-reading-enforcement.md](file-reading-enforcement.md) | Establishes mandatory file reading standards | ALWAYS read entire files with should_read_entire_file=true |
| [tool-usage-standards.md](tool-usage-standards.md) | Defines standards for all tool usage | Follow mandatory tool sequence patterns |
| [knowledge-integration.md](knowledge-integration.md) | Resolves conflicts between knowledge and core | Core directives ALWAYS take precedence |

## Integration with Knowledge Components

These core files integrate with knowledge components but always take precedence. The relationship works as follows:

1. **Core Directives**: Found in this directory, establish mandatory requirements
2. **Knowledge Patterns**: Found in knowledge/rules/patterns/tool directory, provide conceptual guidance
3. **Integration Approach**: Extract concepts from knowledge, implement according to core directives

## File Reading Enforcement

The file-reading-enforcement.md file establishes a critical mandatory procedure for file reading operations. Key requirements:

- ALWAYS set should_read_entire_file=true for initial reads
- NEVER use offset/limit parameters for initial reads
- IF the file is too large, implement the Multi-Pass Reading Protocol
- NEVER skip reading parts of a file based on assumptions about content
- ALWAYS verify that you have processed the complete file content

This is a MANDATORY requirement with no exceptions.

## Tool Usage Standards

The tool-usage-standards.md file defines mandatory standards for all tool usage. Key components:

- Mandatory file reading patterns
- Search tool sequencing standards
- File editing requirements
- Command execution safety
- Tool combination patterns

These standards ensure consistent, reliable, and effective tool operation across all implementation contexts.

## Knowledge Integration

The knowledge-integration.md file establishes clear guidelines for resolving conflicts between knowledge-base patterns and core directives. Key principles:

- Core directives ALWAYS take precedence over knowledge-base patterns
- Extract valuable concepts from knowledge files
- Implement in compliance with core directives
- Follow the explicit conflict resolution process

## Related Knowledge Components

For additional guidance on tool usage that complies with these core directives, refer to:

| Topic | Path | Access Method |
|-------|------|---------------|
| Tool Patterns | knowledge/rules/patterns/tool/basic-patterns.md | `fetch_rules(["knowledge/rules/patterns/tool/basic-patterns"])` |
| Search Patterns | knowledge/rules/patterns/tool/search-patterns.md | `fetch_rules(["knowledge/rules/patterns/tool/search-patterns"])` |
| Tool Combinations | knowledge/rules/patterns/tool/tool-combinations.md | `fetch_rules(["knowledge/rules/patterns/tool/tool-combinations"])` |
| Command Patterns | knowledge/rules/patterns/tool/command-patterns.md | `fetch_rules(["knowledge/rules/patterns/tool/command-patterns"])` |
| File Reading Awareness | knowledge/rules/patterns/tool/file-reading-awareness.md | `fetch_rules(["knowledge/rules/patterns/tool/file-reading-awareness"])` |

## Implementation Priority

Always implement tool operations in this priority order:

1. Follow core directives from files in this directory
2. Apply knowledge patterns in compliance with core directives
3. Verify implementation meets all mandatory requirements

No exceptions to this priority order are permitted. 