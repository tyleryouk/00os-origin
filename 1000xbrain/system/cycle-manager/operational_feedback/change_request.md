# Change Request Details

**Requestor**: Tyler Youk
**Status**: Analysis Completed
**Directive**: Fix
**Target Cycle**: system/major-changes
**Enhancement Name**: Completely fix system/major-changes
**Priority**: High

## Request Description

The system/major-changes cycle does not follow the same 7-step sequential command structure as cycle-manager. For example, major-changes/1 attempted to write the USER REQUEST to notes.md instead of user_request.md. The major-changes cycle requires significant updates to align with the standardized cycle approach.

User has indicated that the major-changes cycle should be designed for system-wide changes throughout ALL 1000xsystems. It should utilize 1000xbrain\system\guidelines\ and first make changes to the guidelines before making changes to the rest of the 1000xsystems. This approach provides backwards compatibility and maintainability for system-wide changes, centralizing all system configurations to 1000xbrain\system\guidelines\.

## Requirements

1. Restructure system/major-changes to follow the standardized 7-step sequential command structure (like cycle-manager)
2. Ensure major-changes uses user_request.md instead of notes.md for user input
3. Implement a workflow where major-changes first updates guidelines in 1000xbrain\system\guidelines\ before modifying other 1000xsystems
4. Create proper documentation and process files to support the restructuring
5. Ensure backward compatibility with existing 1000xsystems while implementing these changes
6. Validate that all steps in the cycle operate correctly after implementation

## Scope

This change will affect:
- 1000xcommands\system\major-changes\ - Complete restructuring of all command files
- 1000xbrain\system\major-changes\ - Updating processes, knowledge, and operational feedback
- 1000xbrain\system\guidelines\ - Ensuring guidelines support the major-changes operational model

The implementation will require:
- Analysis of the current major-changes structure
- Development of a new 7-step workflow model
- Creation/update of all supporting files and processes
- Verification testing of the updated cycle

## Success Criteria

1. The system/major-changes cycle follows the standardized 7-step sequential command structure
2. All commands (1-7) in major-changes function correctly and follow the same pattern as cycle-manager
3. The cycle uses user_request.md instead of notes.md for user input
4. The cycle first updates guidelines in 1000xbrain\system\guidelines\ before making system-wide changes
5. All documentation accurately reflects the updated implementation
6. The cycle can be successfully executed from start to finish

## Special Considerations

1. The current major-changes implementation appears to be significantly different from the cycle-manager standard, so a complete redesign may be more efficient than incremental fixes.
2. The implementation should maintain consistency with the cycle-manager pattern while supporting the unique requirements of system-wide changes.
3. Clear documentation will be needed to explain the purpose and usage of major-changes vs. other cycles. 