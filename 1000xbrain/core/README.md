# Core Subsystem

## Purpose

The Core subsystem defines the essential identity, modes, and communication standards for the 1000xbrain cognitive architecture.

## Rule Type: Always Rules

Files in this subsystem are core-brain-files with Always rule type, meaning they are automatically applied to all conversations without explicit invocation.

## Relationship to Other Subsystems

The Core subsystem provides foundational principles and standards used by all other subsystems:
- **Knowledge Subsystem**: References core standards and extends them with specialized knowledge
- **Parameters Subsystem**: Implements core principles in specific execution frameworks
- **Workflows Subsystem**: Applies core standards to domain-specific implementation

## Key Components

The Core subsystem includes these essential components:

1. **Identity**: Core identity and behavioral principles (`/identity/`)
2. **Modes**: Mode system for planning, development, and direct implementation (`/modes/`)
3. **Communication**: Standards for interaction and message processing (`/communication/`)
4. **Tools**: Guidelines for effective tool usage (`/tools/`)

## Core Files Structure

```
core/
├── identity/              # Who 1000xdev is
│   ├── global-rules.md    # Core operating parameters
│   └── cognitive-principles.md  # Cognitive implementation standards
├── modes/                 # How 1000xdev operates
│   ├── plan-mode.md       # Planning and documentation mode
│   ├── dev-mode.md        # Implementation and development mode
│   └── direct-mode.md     # Direct implementation mode
├── communication/         # How 1000xdev communicates
│   ├── message-commands.md # Message command processing
│   ├── syntax-standards.md # Communication syntax rules
│   └── symbol-guidelines.md # Symbol usage guidelines
├── tools/                 # How 1000xdev uses tools
│   └── tool-usage-standards.md # Standards for tool operation
├── system-organization.md # System architecture and structure
└── README.md-guidance.md  # Guidance for README.md files across the system
```

## System-Wide Impact

As the core subsystem, the files here have the most significant and widespread impact on the overall system:

1. They automatically apply to all conversations
2. They establish the foundational framework used by all other subsystems
3. They define the essential operating principles of 1000xdev
4. They standardize critical system-wide patterns and behaviors

## Modifying Core Files

Changes to core files should be made with careful consideration as they impact the entire system. When modifying core files:

1. Ensure changes maintain backward compatibility where possible
2. Verify changes are consistent with existing system architecture
3. Test changes against common use cases
4. Update related files in other subsystems if necessary
5. Document changes comprehensively

For detailed guidance on core file modifications, see:
- `knowledge/rules/patterns/core/modification-guidelines.md` 