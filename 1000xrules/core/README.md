# Core Directory (`1000xrules/core/`)

## Purpose

The Core directory defines the essential identity, communication, and operational standards for 1000xdev. These files provide the foundational guidelines for the entire cognitive architecture and are automatically synchronized to `.cursor/rules`.

## Rule Type: Always Rules

Files in this directory are Core Rule Files (`.md`) with the `Always` rule type, meaning their corresponding `.mdc` rules in `.cursor/rules` are automatically applied by Cursor to all conversations without explicit invocation.

## Relationship to Other Components

The Core directory provides foundational principles used by all other system components:

*   **`1000xcommands`**: Command definitions in `1000xrules/1000xcommands/` rely on core communication and tool standards for their structure and execution.
*   **`1000xbrain`**: Knowledge and process files in `1000xbrain` extend core principles but MUST remain compliant with them (Core Precedence).

## Key Components & Structure

The Core directory includes these essential components, defined using a third-person perspective describing 1000xdev's required behavior:

```
core/
├── identity/                          # Defines 1000xdev's persona and role
│   ├── core-identity.md               # Comprehensive identity (Jarvis archetype)
│   ├── ai-role.md                     # Role separation and authority matrix
│   ├── enhancement-capabilities.md    # Self-enhancement capabilities
│   ├── cognitive-principles.md        # High-level guiding principles
│   └── implementation-standards.md    # Technical implementation standards
├── communication/                     # Defines interaction and safety protocols
│   ├── file-editing-safety.md         # File editing safety guidelines (incl. sync)
│   ├── symbol-guidelines.md           # Symbol usage (@, extensions)
│   └── 1000xcommands-guidelines.md    # 1000xcommands system and interaction flow
├── tools/                             # Defines mandatory tool usage standards
│   └── file-reading-enforcement.md    # Mandatory 3-step file reading protocol
├── core-essentials.md                 # Condensed essential identity & standards
└── README.md                          # This file
```

**Note**: The previous `core-safety.md` has been deprecated, and its content merged into `file-editing-safety.md`, `file-reading-enforcement.md`, and `core-essentials.md`.
**Note**: The previous `modes/` directory and its contents have been removed as the mode system is deprecated in favor of `1000xcommands` and direct communication.

## System-Wide Impact

Core rules establish the foundational framework, define 1000xdev's essential operating principles, and standardize critical system-wide patterns.

## Key Features of Core Rules

1.  **Unified Identity**: Defines the consistent 1000xdev persona.
2.  **Command Integration**: Fully integrates with the `1000xcommands` system, replacing modes.
3.  **Safety Focus**: Emphasizes file editing safety and mandatory reading protocols.
4.  **Cognitive Foundation**: Establishes core cognitive principles and implementation standards.

## Modifying Core Files

Changes to `.md` files in `1000xrules/core/` impact the entire system and require careful consideration:

1.  **Consistency**: Verify changes align with the overall architecture and other core files.
2.  **Testing**: Mentally simulate the impact of changes on common workflows.
3.  **Documentation**: Update this README and related files if structure changes.

## Related Resources

*   **1000xcommands Guidelines**: `communication/1000xcommands-guidelines.md`
*   **File Editing Safety**: `communication/file-editing-safety.md`
*   **File Reading Enforcement**: `tools/file-reading-enforcement.md`
*   **Rules Structure Overview**: `1000xbrain/rules/1000xrules-structure.md` 