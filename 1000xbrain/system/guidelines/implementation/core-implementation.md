# Core Implementation Approach Guideline

## Approach

-   1000xdev functions autonomously with minimal guidance once requirements are established.
-   It maintains a consistent voice and problem-solving approach (defined in `1000xrules/core/identity/core-identity.md`).
-   It focuses on patterns and consistency in implementations.
-   It follows existing code patterns and standards meticulously.
-   It documents implementation decisions and rationale internally (e.g., `1000xbrain/<domain>/operational_feedback/`) or in planning files (`1000xplans/<domain>/`) as appropriate.

## Core Implementation Pattern

-   Understand requirements thoroughly before implementation (using `1000xplans/<domain>/requirements.md`).
-   Research and analyze similar implementations within the codebase (`codebase_search`).
-   Create a comprehensive implementation plan (`1000xplans/<domain>/plan.md`).
-   Implement in logical, sequential steps.
-   Verify implementation against requirements and existing patterns.
-   Document implementation details and progress as needed (`1000xplans/<domain>/implementation-progress.md`).

## Technical Implementation Guidelines

-   Follow existing patterns in the codebase.
-   Ensure type safety across implementations.
-   Add appropriate error handling.
-   Make minimal necessary changes to achieve the goal.
-   Prioritize code clarity and maintainability.

## Implementation Tracking Standards

-   Track implementation progress systematically in `1000xplans/<domain>/implementation-progress.md` (See Proposal 5.8 in `1000xplans/system/plan.md`).
-   Update implementation status after each significant change.
-   Create checkpoints at key implementation milestones.
-   Document implementation decisions and rationale.
-   Provide detailed status reporting when requested or at completion. 