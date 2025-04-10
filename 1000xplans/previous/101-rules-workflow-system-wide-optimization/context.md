# Context: Mode Adherence Optimization

## 1. Relevant Core Brain-Files

This research phase will primarily focus on analyzing the content and interactions of the following core brain-files within `/1000xbrain`:

*   `core/identity/global-rules.md`: Defines the overall mode system, editing domains, mode transition protocols, and workflows. *Crucial for understanding the intended separation of concerns.*
*   `core/modes/plan-mode.md`: Details the specific responsibilities, requirements, and prohibited actions within Planning Mode. *Need to verify how strictly the `/planning` directory limitation is defined.*
*   `core/modes/dev-mode.md`: Details the specific responsibilities and requirements within Developer Mode. *Need to verify how the scope of editing domains (including `/1000xbrain`) is defined based on workflow.*
*   `core/modes/mode-transitions.md`: (If exists, or relevant sections in `global-rules.md`) Governs the logic for switching between modes. *Key to understanding triggers and conditions for mode changes.*
*   `workflows/rules-workflow.md`: (Or equivalent file defining the rules-workflow) Outlines the specific process for enhancing cognitive architecture. *Critical for understanding how this specific workflow might interact with or override general mode rules.*
*   `core/communication/message-commands.md`: Defines the command structure, which might influence mode interpretation.
*   `knowledge/rules/system-wide/mode-patterns.md`: (Via `fetch_rules`) Contains patterns and behaviors for modes. *May hold implicit assumptions or patterns relevant to the issue.*
*   `knowledge/rules/reference/architecture/brain-files-cursor-rules.md`: (Via `fetch_rules`) Maps brain-files to cursor rules, understanding this link is important.

## 2. Key Areas of Investigation

-   **Rule Hierarchy & Precedence**: How are conflicts between general mode rules (e.g., `plan-mode` restrictions) and workflow-specific actions (e.g., `rules-workflow` editing `/1000xbrain`) currently resolved? Is there an explicit precedence defined?
-   **Mode Definition Rigidity**: How strictly are the directory limitations for `plan-mode` enforced in the rules? Is there ambiguity that allows for exceptions, particularly for the `rules-workflow`?
-   **Transition Logic**: Does the logic for initiating the `rules-workflow` implicitly override the need to switch to `dev-mode` before editing `/1000xbrain` files?
-   **Self-Correction Mechanisms**: What internal checks or mechanisms should be triggering an error or correction when I attempt to violate mode protocols? Why are these failing?
-   **Impact of Previous Edits**: Did the recent additions to `plan-mode.md`, `dev-mode.md`, and `global-rules.md` inadvertently create conflicting instructions?

## 3. Potential Failure Points

-   Lack of explicit rule stating `rules-workflow` requires `dev-mode` for `/1000xbrain` edits.
-   Ambiguous language in mode definitions.
-   Implicit assumptions in workflow definitions overriding explicit mode rules.
-   Flawed internal logic for prioritizing conflicting rules.
