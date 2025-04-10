# rules-workflow | system-wide-optimization

## System-Wide Optimization: Core Subsystem (Phase 2)

This planning folder (93-rules-workflow-system-wide-optimization) is the second in a four-part system-wide optimization of the 1000xbrain cognitive architecture. This phase focuses on streamlining the core subsystem and implementing foundational improvements identified in Phase 1.

## Implementation Focus

This phase will implement:

1. **Core Subsystem Optimization**
   - Reduce total lines in core-brain-files to under 2000 lines
   - Consolidate redundant information across core files
   - Move implementation details to knowledge-base-files
   - Ensure essential identity and behavior are preserved

2. **Message-Command Format Enhancement**
   - Implement the updated message-command format with pathway-name component
   - Update documentation to reflect the new format
   - Create consistent error checking mechanisms
   - Ensure backward compatibility during transition

3. **Common-Words Standardization**
   - Create a comprehensive common-words registry
   - Standardize terminology across all documentation
   - Ensure consistent usage in all core files
   - Document relationships between terms

## Implementation Status Update

Initial analysis of the core files has been completed with the following findings:

- Current total line count: 1,592 lines (already under the 2,000 target)
- The modes directory is the only area over target at 850 lines (target: 800 lines)
- Key optimization opportunity: Consolidate mode-specific files

## Target Files

The primary focus will be on optimizing these core files:

- `1000xbrain/core/core-essentials.md`
- `1000xbrain/core/index.md`
- `1000xbrain/core/README.md`
- `1000xbrain/core/communication/*.md`
- `1000xbrain/core/identity/*.md`
- `1000xbrain/core/modes/*.md` (priority focus)

## Modes Directory Optimization Plan

Since the modes directory is the only area over target, our immediate focus will be:

1. Consolidate redundant content across mode-specific files
2. Move detailed implementation guidance to knowledge files
3. Standardize documentation structure across all mode files
4. Reduce total line count from 850 to under 800 lines

The modes directory structure to optimize:
- modes/dev-mode.md
- modes/plan-mode.md
- modes/direct-mode.md
- modes/dev-mode/* (556 lines total in 4 files)
- modes/plan-mode/* (459 lines total in 4 files)
- modes/direct-mode/* (files to be analyzed)

## Success Criteria

1. Core-brain-files total under 2000 lines
2. Message-command format updated and documented
3. Common-words standardized across documentation
4. Backward compatibility maintained
5. Essential identity and behaviors preserved
6. Clear documentation with consistent terminology
7. Modes directory reduced to under 800 lines

## Relationship to Other Phases

- **Phase 1 (92)**: Provided analysis and planning
- **Phase 2 (93) - Current**: Focuses on core subsystem optimization
- **Phase 3 (94)**: Will build on these changes to optimize knowledge and parameters
- **Phase 4 (95)**: Will document future enhancement opportunities 