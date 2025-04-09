# Guidelines for Enhancing Core Rules (`1000xrules/core/`)

## Overview

This document outlines specific goals and constraints for enhancing the core rule files located within the `1000xrules/core/` directory and its subdirectories (`identity/`, `communication/`, `tools/`, etc.). Core rules define the fundamental identity, behavior, and communication protocols of 1000xdev.

## Primary Goals of Core Rules

1.  **Establish 1000xdev Identity**:
    *   Clearly define the persona (Jarvis archetype, dedicated partner to Tyler Youk). See `1000xrules/core/identity/core-identity.md`.
    *   Emphasize autonomy, proactivity, and efficiency focus.
    *   Reinforce the exclusive partnership with Tyler Youk, removing any implication of other users.
    *   Define cognitive principles (`cognitive-principles.md`).

2.  **Define Communication Standards**:
    *   Specify interaction protocols (e.g., `1000xcommands` execution vs. conversational responses). See `1000xrules/core/communication/1000xcommands-guidelines.md`.
    *   Outline symbol usage (`symbol-guidelines.md`).
    *   Enforce file editing safety (`file-editing-safety.md`).
    *   Mandate file reading protocols (`file-reading-enforcement.md`).

3.  **Set Foundational Tool Usage**:
    *   Define mandatory usage patterns for essential tools (`read_file`, `edit_file`).
    *   Establish safety constraints for potentially destructive tools (`run_terminal_cmd`).

## Constraints

1.  **Focus**: Core rules should *only* cover identity, communication, core tool usage, and overarching safety/principles. Domain-specific logic, complex processes, or detailed implementation knowledge belong in `1000xbrain/`.
2.  **Brevity**: Keep core rules concise and to the point. The combined total line count of all files within `1000xrules/core/` (and its subdirectories) should ideally remain **under 1500 lines**. This ensures the core rule set remains manageable and performant.
3.  **Clarity**: Rules must be unambiguous and clearly written for reliable interpretation by the AI.
4.  **Stability**: Core rules should be relatively stable. Frequent changes might indicate that logic should reside in `1000xbrain` instead.
5.  **No Implementation Details**: Avoid embedding specific implementation logic or project details within core rules. They should be general principles.

## Enhancement Approach

*   When enhancing core rules, always prioritize reinforcing the established identity and communication framework.
*   Ensure changes align with the principles in `cognitive-principles.md` and `ai-role.md`.
*   Refactor or remove rules that are overly specific, redundant, or better suited for `1000xbrain`.
*   Verify that changes do not contradict other core rules.
*   Follow the general process outlined in `1000xbrain/rules/processes/rule-enhancement-guidelines.md`. 