# Change Request Details

**Date Requested**: 2024-07-09
**Requestor**: Tyler Youk
**Status**: Analysis Completed
**Directive**: Enhancement
**Target Cycle**: cycle-manager
**Priority**: High

## Request Description

Implement a new directive system for simplified cycle analysis and management within the cycle-manager itself.

## Requirements

1.  Enhance `1000xbrain/system/cycle-manager/processes/cycle-analysis-process.md` to include specific checks for analyzing the cycle-manager cycle.
2.  Modify `1000xbrain/system/cycle-manager/processes/requirement-analysis-process.md` to support parsing the new directive format (e.g., `# Directive: Enhancement`, `# Target Cycle: {cycle-name}`).
3.  Create a new script `1000xscripts/system/list-cycles.ps1` that dynamically lists available cycles by inspecting the `1000xcommands/` directory structure (system, front-end, back-end domains).
4.  Update the template within the USER REQUEST SECTION in `1000xplans/system/notes.md` to:
    *   Be more efficient.
    *   Include references to available directives (e.g., Enhancement, Fix, Refactor).
    *   Include references/instructions on how to specify target cycles dynamically, potentially using the output of the `list-cycles.ps1` script or suggesting the cycle folder path convention (e.g., `system/cycle-manager`).

## Scope

-   Modifications to two core process files within `1000xbrain/system/cycle-manager/processes/`.
-   Creation of one new script in `1000xscripts/system/`.
-   Update to one planning file template (`1000xplans/system/notes.md`).
-   Documentation of the new directive system (implied, likely within relevant process/guideline files).

## Success Criteria

-   The `requirement-analysis-process.md` correctly parses the `# Directive:` and `# Target Cycle:` lines.
-   The `cycle-analysis-process.md` includes logic specific to analyzing the `cycle-manager` cycle.
-   The `list-cycles.ps1` script correctly identifies and lists cycle command folders (e.g., `system/autonomous`, `system/cycle-manager`, `system/major-changes`).
-   The USER REQUEST SECTION template in `notes.md` is updated with the new format, directive info, and cycle referencing guidance.

## Special Considerations

-   The `list-cycles.ps1` script needs robust logic to handle different domain folders (system, front-end, back-end) and potential variations in naming.
-   The update to the USER REQUEST SECTION template should be clear and easy for the user (Tyler) to follow. 