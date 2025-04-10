# Plan: Implement Hybrid Explicit/Dynamic 1000xcommand Execution

## 1. Goals

- Define a clear standard for how `1000xcommands` (`.md` files) can specify both explicit tool call sequences and trigger dynamic AI execution based on `1000xbrain` process/knowledge files.
- Refactor existing commands across relevant domains (`brain`, `commands`, `rules`, `plans`) to adhere to this hybrid standard.
- Ensure `1000xbrain` process files provide sufficient detail for the AI to dynamically determine necessary tool calls.
- Update relevant `1000xrules` and `1000xbrain` knowledge files to document this hybrid model clearly.
- Verify the changes through logical walkthroughs and potentially updated verification scripts.

## 2. Implementation Steps

**Phase 1: Plan Definition & Context Gathering (Current Phase)**
    - [X] Initialize planning artifacts (`notes.md`, `plan.md`, `implementation-progress.md`).
    - [ ] Review Core Guidelines (`1000xcommands-guidelines.md`, `best-practices.md`, `implementation-standards.md`).
    - [ ] Review Example Process File (`system-change-workflow.md`).

**Phase 2: Define Hybrid Model Standard**
    - [ ] Propose a clear convention within command `.md` files to signal the transition from explicit calls to dynamic execution (e.g., a specific comment marker like `# --- Begin Dynamic Execution ---`).
    - [ ] Define the AI's expected behavior when encountering this marker (i.e., stop executing explicit calls, load specified process file, interpret context, execute dynamically).
    - [ ] Document this standard in `1000xbrain/commands/knowledge/command-structure.md` and potentially update `1000xrules/core/communication/1000xcommands-guidelines.md`.

**Phase 3: Refactor Commands**
    - [ ] Re-review and refactor commands (`brain`, `commands`, `rules`, `plans`) identifying where explicit steps (like simple edits or verification reads) are appropriate and where dynamic execution should take over. Apply the standard marker.
    - [ ] Ensure commands load the *correct* process and knowledge files needed for the dynamic phase.

**Phase 4: Review Process Files**
    - [ ] Review key `1000xbrain/{domain}/processes/` files to ensure they contain actionable steps (e.g., "Analyze X using codebase_search", "Edit file Y to include Z", "Verify change by reading section A-B") suitable for AI interpretation during dynamic execution.
    - [ ] Enhance process files where necessary to provide clearer guidance.

**Phase 5: Update Documentation & Verification**
    - [ ] Update `1000xbrain/commands/knowledge/best-practices.md` to reflect the hybrid approach.
    - [ ] Update `1000xrules/core/identity/implementation-standards.md` if needed.
    - [ ] Perform logical walkthroughs of refactored commands.
    - [ ] Consider updates to verification scripts (like `generate_brain_command_index.ps1`) if feasible to check for the new standard.

**Phase 6: Finalize**
    - [ ] Update `implementation-progress.md` with final status.
    - [ ] Signal completion.

## 3. Verification Plan

- Manual review of refactored command files against the defined standard.
- Manual review of updated knowledge/rule files.
- Logical walkthrough: Simulate AI execution of key refactored commands, checking if the explicit/dynamic flow makes sense.
- Review changes to process files for clarity.

## Dependencies / Considerations

- Requires careful definition of the marker/convention for switching to dynamic mode.
- Assumes AI capability to parse process files and translate steps into tool calls.
- Need to balance explicitness vs. abstraction appropriately.
