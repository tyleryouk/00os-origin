# 1000xrules Structure

## Overview

This document defines the organization and structure of the 1000xrules system, which contains the core identity rules and 1000xcommands. The 1000xrules directory is automatically synchronized to the Cursor Rules system.

## Directory Structure

```
1000xrules/
│
├── core/                       # Core identity and communication rules
│   ├── identity/               # Identity definition files
│   │   ├── core-identity.md    # Core identity definition
│   │   ├── ai-role.md          # Role separation and authority
│   │   ├── enhancement-capabilities.md  # Self-enhancement capabilities
│   │   ├── cognitive-core.md   # Core cognitive principles
│   │   └── implementation-standards.md  # Implementation standards
│   │
│   ├── communication/          # Communication guidelines
│   │   ├── file-editing-safety.md       # File editing safety guidelines
│   │   ├── symbol-guidelines.md         # Symbol usage guidelines
│   │   └── 1000xcommands-guidelines.md  # Command system guidelines
│   │
│   ├── core-essentials.md      # Essential identity components
│   ├── core-safety.md          # Core safety guidelines
│   └── README.md               # Core directory documentation
│
└── 1000xcommands/              # Domain-specific command files
    ├── brain/                  # Brain domain commands
    │   ├── enhance-cognitive-architecture.md
    │   ├── analyze-system-structure.md
    │   └── create-documentation.md
    │
    ├── front-end/              # Front-end domain commands
    │   ├── explore-component-structure.md
    │   ├── implement-ui-component.md
    │   └── analyze-front-end-architecture.md
    │
    ├── back-end/               # Back-end domain commands
    │   ├── explore-api-structure.md
    │   ├── implement-api-endpoint.md
    │   └── analyze-database-models.md
    │
    ├── rules/                  # Rules domain commands
    │   ├── explore-rule-structure.md
    │   ├── update-rule-content.md
    │   └── create-new-rule.md
    │
    └── scripts/                # Scripts domain commands
        ├── explore-synchronization-scripts.md
        ├── implement-new-script.md
        └── analyze-script-patterns.md
```

## Component Types

### Core Identity Files

Core identity files define the fundamental aspects of the 1000xdev cognitive architecture:

- **core-essentials.md**: Essential identity and cognitive foundation
- **core-safety.md**: File editing safety and knowledge access
- **identity/core-identity.md**: Comprehensive identity definition
- **identity/ai-role.md**: Role separation and authority matrix
- **identity/enhancement-capabilities.md**: Self-enhancement capabilities
- **identity/cognitive-core.md**: Core cognitive principles
- **identity/implementation-standards.md**: Implementation standards

### Communication Guidelines

Communication files define how the system communicates and processes information:

- **communication/file-editing-safety.md**: File editing safety rules
- **communication/symbol-guidelines.md**: Symbol usage standards
- **communication/1000xcommands-guidelines.md**: 1000xcommands system definition

### 1000xcommands

1000xcommands define domain-specific tool call sequences:

```markdown
# Command Name

tool_call("parameters")
tool_call("parameters")
tool_call("parameters")
```

## Synchronization Process

The 1000xrules directory is automatically synchronized to Cursor Rules:

1. Brain-files (.md) in 1000xrules are synchronized to Cursor Rules (.mdc)
2. Synchronization is handled by scripts in the 1000xscripts directory
3. Only Tyler can edit .mdc files directly through the Cursor Settings UI
4. All AI edits must target the .md files in 1000xrules

## Command Invocation

1000xcommands are invoked using the following syntax:

```
@1000xcommands/domain/command-name
```

For example:
```
@1000xcommands/brain/enhance-cognitive-architecture
```

## Relationship to 1000xbrain

- 1000xrules contains the core rules that are synchronized to Cursor Rules
- 1000xbrain/rules contains the knowledge and processes related to the rules domain
- The rules domain is responsible for managing and enhancing the 1000xrules system

## Implementation Guidelines

When working with the 1000xrules system:

1. **Always edit .md files**: Never attempt to edit .mdc files directly
2. **Maintain file structure**: Follow the established directory structure
3. **Command format**: Ensure all commands follow the standard format
4. **Synchronization awareness**: Understand how files are synchronized
5. **Domain separation**: Respect the separation between domains

