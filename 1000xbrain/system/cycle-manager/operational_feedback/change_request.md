# Change Request Details

**Requestor**: Tyler Youk
**Status**: Analysis Completed
**Directive**: Fix
**Target Cycle**: system/cycle-manager
**Enhancement Name**: Delete all legacy files
**Priority**: High

## Request Description

Delete all legacy files from system/cycle-manager. Engrain the "less is more" principle for all cycles. There are concerns about adding too many files, with many being unused. This creates cognitive load and increases the likelihood of hallucinations. The request focuses on optimizing by reducing the number of files in the system.

## Requirements

1. Identify and delete all legacy files that are no longer needed in the system/cycle-manager
2. Apply the "less is more" principle across the codebase
3. Reduce the total number of files to minimize cognitive load
4. Ensure remaining files are actively used and necessary
5. Maintain system functionality while reducing complexity
6. Avoid creating new files unless absolutely necessary

## Scope

* Primary Focus Areas:
  * 1000xbrain/system/cycle-manager - Process files, knowledge files, and operational feedback
  * 1000xcommands/system/cycle-manager - Command files and related documentation
  * 1000xbrain/system/guidelines - Guidelines related to cycle-manager

* File Types to Consider:
  * Deprecated process files (especially those with .deprecated extension)
  * Redundant documentation files
  * Unused knowledge files
  * Historical operational feedback that's no longer relevant
  * Any files marked as legacy from previous cycles

## Success Criteria

* Significant reduction in the total number of files in the system/cycle-manager
* No functionality loss despite file reduction
* Clear documentation of which files were removed and why
* Implementation of guidelines to prevent future file proliferation
* Remaining system adheres to the "less is more" principle
* System operations remain stable with fewer files

## Special Considerations

* Some files may be referenced by other components and require careful handling before deletion
* Consider redirects or consolidation for content that might still be valuable
* This request aligns with the previously completed ENH-CM-007 (Update Legacy Enhancement File References)
* The request specifically mentions "Delete all legacy files" but requires analysis to identify which files are truly legacy versus essential
* Focus on reducing complexity while maintaining full functionality 