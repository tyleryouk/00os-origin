# Planning Workflow and Directory Structure

## Overview

This document defines the standardized structure and purpose of files within the `1000xplans/{domain}/` directories. This structure supports a dynamic planning process where implementation plans evolve and are tracked alongside collaborative notes.

## Directory Structure (`1000xplans/{domain}/`)

Each domain-specific planning directory should contain the following core files:

1.  **`plan.md`**:
    *   **Purpose**: Contains the current, detailed implementation plan for the specific task or feature within the domain.
    *   **Lifecycle**: This file is actively modified and replaced by 1000xdev as the plan evolves during implementation. Previous versions are tracked via Git history. It represents the *latest* plan.
    *   **Content**: Should include steps, technical details, considerations, and potentially references to relevant knowledge files.

2.  **`implementation-progress.md`**:
    *   **Purpose**: Serves as a chronological log of actions taken, status updates, tool outputs (summarized), errors encountered, and decisions made during the implementation phase for the current `plan.md`.
    *   **Lifecycle**: Appended to by 1000xdev during the execution of a plan. A new log might be started when a significantly new `plan.md` is initiated.
    *   **Content**: MUST adhere to the standardized format defined in the section below ("Standard `implementation-progress.md` Format").

3.  **`notes.md`**:
    *   **Purpose**: A collaborative scratchpad for Tyler Youk and 1000xdev. Used for transient notes, questions, observations, quick feedback, or context relevant to the current `plan.md` and `implementation-progress.md`.
    *   **Lifecycle**: Can be edited by both Tyler Youk and 1000xdev. Content might be ephemeral or distilled into the `plan.md` or knowledge base later if valuable.
    *   **Content**: Informal notes, reminders, snippets for discussion, context pointers.

4.  **`(Optional) requirements.md`**:
    *   **Purpose**: If static requirements are provided upfront for a specific plan, they can be stored here.
    *   **Lifecycle**: Typically created at the start and referenced by `plan.md`. May be less common in a highly dynamic workflow.

## Standard `implementation-progress.md` Format

```markdown
# {Domain Name} Domain - Implementation Progress

## Status
*   [e.g., Planning, Implementing, Verifying, Blocked, Completed]

## Current Objective / Task
*   [Brief description of the immediate or overall goal related to the current plan.md]

## Implementation Status Summary
*   **Pending:** [List of high-level steps/components from plan.md not started]
*   **In Progress:** [List of high-level steps/components being worked on]
*   **Completed:** [List of high-level steps/components finished]

## Detailed Log & Decisions
*   **[Timestamp]** - [Entry detailing action taken, tool called, decision made, issue encountered, file modified, etc.]
*   **[Timestamp]** - [Another entry...]

## Blockers
*   [List any current blockers preventing progress]

## Verification Log
*   **[Timestamp]** - [Verification step performed and outcome]

## Next Steps
*   [List the immediate next actions based on the log]
```

## Workflow Integration

-   `1000xcommands` related to planning or implementation within a specific domain should expect and utilize this directory structure and the defined file formats.
-   Commands initiating a new plan should potentially clear or archive old `plan.md` and `implementation-progress.md` files (or rely on Git history) and create fresh versions adhering to these standards.
-   Commands should append updates to `implementation-progress.md` as they execute steps.
-   Both Tyler Youk and 1000xdev can reference `notes.md` for quick contextual exchange. 