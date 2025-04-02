# Developer Mode System

> **IMPORTANT**: This file serves as the main index for the Developer Mode system.

## System Overview

The Developer Mode system is split into focused components for better maintainability and clarity:

1. **Core**: Fundamental purpose and responsibilities
2. **Implementation**: Implementation standards and protocols
3. **Knowledge**: Knowledge access patterns and requirements
4. **Verification**: Verification standards and requirements
5. **Completion**: Completion signals and requirements

## Component Files

Each aspect of Developer Mode is documented in a dedicated file:

| Component | File | Purpose |
|-----------|------|---------|
| Core | `core.md` | Defines fundamental purpose and responsibilities |
| Implementation | `implementation.md` | Details implementation standards and protocols |
| Knowledge | `knowledge.md` | Outlines knowledge access patterns |
| Verification | `verification.md` | Specifies verification requirements |
| Completion | `completion.md` | Defines completion signals |

## Usage Guide

### Accessing Components

Components can be referenced as project-rule-parameters in message-commands:

```typescript
// Access core definitions
@dev-mode/core.mdc

// Access implementation standards
@dev-mode/implementation.mdc

// Access knowledge patterns
@dev-mode/knowledge.mdc

// Access verification standards
@dev-mode/verification.mdc

// Access completion signals
@dev-mode/completion.mdc
```

### Component Dependencies

Components should be accessed in this order:

1. Core: Understand fundamental purpose
2. Knowledge: Access required knowledge
3. Implementation: Follow implementation standards
4. Verification: Verify implementation
5. Completion: Signal completion

## Mode Activation

Developer Mode is activated with:

```typescript
dev-mode: workflow-type @dev-mode/core.mdc
```

This activates Developer Mode with:
- Core definitions loaded
- Implementation standards active
- Knowledge access enabled
- Verification requirements set
- Completion signals ready

## Component Organization

The Developer Mode system is organized for optimal clarity and maintainability:

```
1000xbrain/
└── core/
    └── modes/
        └── dev-mode/
            ├── core.md           # Fundamental purpose
            ├── implementation.md # Implementation standards
            ├── knowledge.md      # Knowledge patterns
            ├── verification.md   # Verification standards
            └── completion.md     # Completion signals
```

## Mode Standards

Developer Mode operates under these standards:

1. **Mode Indicator**: 💻 1000xdev [workflow-type]
2. **Focus**: Implementation and verification
3. **Primary Tools**: edit_file, read_file, codebase_search
4. **Knowledge Access**: fetch_rules for patterns and guides
5. **Completion Signal**: implementation-complete

## Implementation Process

The standard implementation process in Developer Mode:

1. **Preparation**:
   - Access core definitions
   - Review implementation standards
   - Load knowledge patterns

2. **Implementation**:
   - Follow implementation standards
   - Use appropriate tools
   - Apply knowledge patterns

3. **Verification**:
   - Run verification checks
   - Test implementation
   - Ensure quality standards

4. **Completion**:
   - Complete all checklists
   - Verify all requirements
   - Signal completion

