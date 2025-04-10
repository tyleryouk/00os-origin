# Process: Verify System Integrity

## Overview

Performs a series of checks across different system components (`rules`, `commands`, `brain`, `plans`, `scripts`) to identify potential inconsistencies or structural issues.

## Input Context

*   (Optional) Parameters to control the scope of verification (e.g., `check_rules=true`, `check_commands=true`).
*   **Knowledge**: All core knowledge files created in Phase 1 (architecture, command structure, etc.).

## Steps

1.  **Initialize Report**: Prepare a structure to hold verification results.
2.  **Verify Rule Structure (Conceptual)**:
    *   Iterate through `1000xrules/` files.
    *   For each rule, conceptually invoke `verify-rule-process.md` logic.
    *   Log results.
3.  **Verify Command Structure (Conceptual)**:
    *   Iterate through `1000xcommands/` files (all domains/components).
    *   For each command, conceptually invoke `verify-command-process.md` logic (checking paths, structure, referenced file existence).
    *   Log results.
4.  **Verify Brain Structure (Conceptual)**:
    *   Iterate through `1000xbrain/` knowledge and process files.
    *   Conceptually invoke `verify-knowledge-process.md` and `verify-process-process.md` logic.
    *   Check for orphaned files (e.g., processes not referenced by any command).
    *   Log results.
5.  **Verify Plan Structure (Conceptual)**:
    *   Iterate through `1000xplans/` files.
    *   Conceptually invoke `verify-plan-process.md` logic.
    *   Log results.
6.  **Verify Script Structure (Conceptual)**:
    *   Iterate through `1000xscripts/` files.
    *   Conceptually invoke `verify-script-process.md` logic.
    *   Log results.
7.  **Cross-Component Checks (Conceptual)**:
    *   Check if commands reference valid processes/knowledge.
    *   Check if processes reference valid knowledge/guidelines.
8.  **Synthesize & Report**: Aggregate all results into a final integrity report, highlighting errors and warnings.

## Error Handling

*   Handle errors during file listing/reading gracefully and log them in the report.

*(Placeholder: Highly conceptual. Requires significant development to implement the iterative checks and cross-component analysis. Would likely involve invoking the specific verify commands created in Phase 2.)* 