# Context Analysis: Cognitive Architecture Mapping

## Current Core Directory Structure and Line Count

### Directory Overview
```
core/
├── core-essentials.md (51 lines)
├── index.md (69 lines)
├── README.md (145 lines)
├── communication/
│   ├── file-editing-safety.md (145 lines)
│   ├── message-commands.md (58 lines)
│   ├── symbol-guidelines.md (581 lines)
│   └── syntax-standards.md (354 lines)
├── modes/
│   ├── plan-mode/
│   │   ├── completion.md
│   │   ├── documentation.md
│   │   ├── knowledge.md
│   │   └── verification.md
│   ├── dev-mode/
│   │   ├── completion.md
│   │   ├── implementation.md
│   │   ├── knowledge.md
│   │   └── verification.md
│   ├── transitions/
│   │   ├── mode-transitions-context.md
│   │   ├── mode-transitions-core.md
│   │   └── mode-transitions-handlers.md
│   ├── mode-transitions.md (60 lines)
│   ├── dev-mode.md (125 lines)
│   └── plan-mode.md (62 lines)
└── identity/
    ├── global-rules.md (550 lines)
    └── cognitive-principles.md
```

### Total Line Count Analysis

| Directory/File | Line Count |
|----------------|------------|
| core-essentials.md | 51 |
| index.md | 69 |
| README.md | 145 |
| communication/ | 1,138 |
| modes/ | 247+ (plus subdirectories) |
| identity/ | 550+ (plus cognitive-principles.md) |
| **TOTAL** | ~2,200+ lines |

## Core Components Analysis

### Essential Components
- **core-essentials.md**: Condensed core identity and mode system, already optimized
- **global-rules.md**: Critical identity and operational parameters
- **message-commands.md**: Simplified message-command system
- **mode-transitions.md**: Core mode transition logic
- **Three primary modes**:
  - Planning Mode: Documentation creation and planning
  - Developer Mode: Code implementation and testing
  - Direct Mode: Immediate implementation with research focus

### Most Important Knowledge to Preserve
1. **Identity**: 1000xdev role, responsibilities, and relationship with Tyler
2. **Mode System**: The three-mode system (plan, dev, direct) and mode indicators
3. **Message Commands**: The three simplified commands and parameter system
4. **Core Operating Principles**: Basic workflow patterns and mode transition rules
5. **File Editing Safety**: Critical file editing rules to prevent system issues
6. **Symbol Usage**: Basic guidelines for symbol usage, especially @ symbols

## Knowledge Migration Opportunities

### Components to Move to knowledge/rules/
1. **Detailed Symbol Guidelines**: Move from symbol-guidelines.md
2. **Detailed Syntax Standards**: Move from syntax-standards.md
3. **Mode Implementation Details**: Move from modes/ subdirectories
4. **Tool Usage Standards**: Move enhanced tool usage details
5. **Advanced Mode Transitions**: Move detailed transition handlers
6. **Parameter System Details**: Move project-rule-parameter details

### Knowledge Organization Strategy
- **guides/**: Implementation guides and educational content
- **patterns/**: Tool, implementation, and documentation patterns
- **reference/**: Core architecture, workflow details, contributions guide
- **domains/**: Workflow-specific technical knowledge

## Cognitive Architecture Impact

Streamlining the core/ directory will create these benefits:

1. **Reduced Cognitive Load**: Focus on essential components without overwhelming with details
2. **Enhanced Clarity**: Clear separation between core identity and specialized knowledge
3. **Better Knowledge Access**: Explicit access to specialized knowledge via fetch_rules
4. **Improved Maintainability**: Easier to update and extend specific knowledge components
5. **Stronger Identity**: More focused identity definition without dilution from details

## Implementation Considerations

- Preserve core identity and mode system integrity
- Ensure all critical knowledge remains accessible
- Maintain cross-references between components
- Keep global-rules.md as the hierarchically most important file
- Update all workflow references to only use the four valid workflows
- Use consistent brain-files terminology
- Follow the README.md "workflow | pathway" format 