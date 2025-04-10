# Implementation Plan: System-Wide Optimization for Mode Adherence

This plan outlines the steps to research, propose, implement, and verify a solution to prevent mode protocol violations, specifically editing `/1000xbrain` files in `plan-mode`.

## Phase 1: Research & Analysis (Plan-Mode)

*(Current Phase)*

**Objective**: Identify the root cause of the mode adherence failure and propose potential solutions.

**Steps**:

1.  **Review Core Files**: I will systematically read and analyze the brain-files listed in `context.md`, paying close attention to the "Key Areas of Investigation".
    *   Action: Use `read_file` tool for each relevant file.
    *   Action: Use `fetch_rules` for relevant knowledge components.
2.  **Analyze Rule Interactions**: I will map out the interactions between general mode rules and the specific procedures defined for the `rules-workflow`.
    *   Action: Document findings and potential conflicts internally (or in a temporary analysis file if complex).
3.  **Identify Failure Point**: Based on the analysis, I will pinpoint the exact ambiguity, conflicting rule, or missing instruction that leads to the protocol violation.
    *   Action: Document the identified root cause clearly.
4.  **Develop Potential Solutions**: I will brainstorm and document 2-3 potential solutions. These might include:
    *   *Solution A*: Further refinement of the explicit rule added to `global-rules.md`.
    *   *Solution B*: Adding a dedicated rule within the `workflows/rules-workflow.md` file that mandates a `dev-mode` switch.
    *   *Solution C*: Creating a new meta-rule in `core/` defining rule precedence explicitly (e.g., "Mode restrictions always override workflow suggestions unless explicitly stated otherwise").
    *   *Solution D*: Enhancing knowledge components (`fetch_rules` accessible) with decision trees for mode/workflow conflicts.
    *   Action: Document pros and cons of each potential solution.
5.  **Propose Recommended Solution**: Based on robustness and minimizing unintended consequences, I will recommend the best solution.
    *   Action: Clearly state the recommended solution and justification in the next response.

## Phase 2: Solution Implementation (Dev-Mode)

**Objective**: Modify the relevant brain-files to implement the selected solution.

**Steps**:

1.  **Transition to Dev-Mode**: Explicitly switch to `dev-mode` before making any edits to `/1000xbrain` files.
    *   Action: Send `💻 1000xdev [rules-workflow]` indicator.
2.  **Implement Changes**: Apply the necessary edits to the brain-file(s) identified in the chosen solution.
    *   Action: Use `read_file` before editing.
    *   Action: Use `edit_file` to apply changes.
    *   Action: Use `read_file` again to verify the edit.

## Phase 3: Verification (Dev-Mode / Plan-Mode)

**Objective**: Confirm that the solution effectively prevents the mode violation.

**Steps**:

1.  **Internal Logic Check (Dev-Mode)**: Review the implemented rules to ensure they logically address the identified failure point.
2.  **Scenario Test Planning (Plan-Mode)**: Define a test scenario that previously would have triggered the incorrect behavior (e.g., a request to modify a rule file immediately after planning).

    **Test Scenario Definition**:
    1. Start in `plan-mode` within the `rules-workflow`.
    2. Issue a request that requires editing a file within `/1000xbrain` (e.g., "Add a comment to `1000xbrain/core/identity/global-rules.md`").

    **Expected Correct Behavior**: Based on the newly implemented rules, my response should be one of the following:
        *   Refusal to perform the edit directly in `plan-mode`, citing the directory restriction.
        *   Stating the need to switch to `dev-mode` before the edit can be performed.

    **Incorrect Behavior (Failure)**: Attempting to perform the edit on the `/1000xbrain` file while still in `plan-mode`.

3.  **Simulated Execution (Internal)**: Internally simulate the test scenario. If the fix is correct, I should either refuse the action in `plan-mode` or correctly state the need to switch to `dev-mode` first.
    *   Action: Report the outcome of the internal simulation. *(Completed: Internal simulation indicates correct behavior - recognition of need to switch to dev-mode)*
4.  **(Optional) User Confirmation**: Request user (Tyler) to trigger the test scenario in a subsequent interaction to confirm real-world effectiveness.

## Phase 4: Documentation (Plan-Mode)

**Objective**: Update planning documents and potentially relevant brain-files with the findings and implemented solution.

**Steps**:

1.  **Update Planning Folder**: Finalize `requirements.md`, `implementation.md`, `context.md` with the details of the research, implemented solution, and verification results.
    *   Action: Use `edit_file`. *(Completed below)*
2.  **Update Brain-Files (If Necessary)**: If the research uncovered broader documentation needs or inconsistencies, update relevant supporting brain-files (e.g., adding cross-references, clarifying related concepts) - this would require switching back to `dev-mode`.
3.  **Completion Signal**: Signal completion of the planning folder update.
