# Requirements: Update System Documentation

## Goal

Ensure all primary `1000x*` systems (`1000xrules`, `1000xbrain`, `1000xcommands`, `1000xscripts`, `1000xplans`) and their core subdirectories have accurate and informative `README.md` files. Additionally, update key structural documentation within `1000xbrain` to reflect the latest architecture.

## Scope

1.  **Create/Update Root READMEs:** Ensure `README.md` files exist at the root of: `/1000xrules`, `/1000xbrain`, `/1000xcommands`, `/1000xscripts`, `/1000xplans`.
2.  **Create/Update Core Subdirectory READMEs:** Ensure `README.md` files exist for primary subdirectories (e.g., `/1000xrules/core`, `/1000xbrain/brain`, `/1000xbrain/rules`, `/1000xcommands/brain`, `/1000xcommands/rules`, etc.).
3.  **Update Structural Documentation:** Review and update key definition files like `1000xbrain/brain/1000xbrain-structure.md`, `1000xbrain/rules/1000xrules-structure.md`, etc., for accuracy.
4.  **Ensure Consistency:** Documentation should consistently reflect the purpose and structure of each system/directory.

## Rationale

*   **Clarity & Onboarding:** Accurate documentation makes the system easier to understand and maintain.
*   **AI Context:** Well-defined READMEs provide valuable context for AI operations.
*   **Maintainability:** Reduces confusion and errors when modifying the system.

## Out of Scope

*   Documenting individual files beyond READMEs (unless updating existing structural docs).
*   Documenting application code (`/front-end`, `/back-end`).
*   Deep refactoring of existing documentation content beyond ensuring structural accuracy. 