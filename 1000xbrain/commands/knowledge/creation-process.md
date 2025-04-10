# 1000xcommand: Creation Process

## Overview

This document outlines the standard process 1000xdev follows when tasked with creating a new `1000xcommand` definition file (`.md`) within the `1000xbrain/commands/` directory structure.

## Process Steps

1.  **Understand Requirements**: 
    *   Thoroughly read the requirements provided by Tyler Youk (e.g., in a planning file like `requirements.md`).
    *   Identify the specific goal, scope, and intended outcome of the new command.

2.  **Determine Domain**: 
    *   Based on the command's purpose, determine the correct functional domain (`brain`, `frontend`, `backend`, `rules`, `scripts`).
    *   Refer to `1000xbrain/brain/knowledge/commands/directory-organization.md` for domain definitions.

3.  **Define Command Name**: 
    *   Choose a clear, descriptive, action-oriented name in `kebab-case`.
    *   Example: If the goal is to analyze log files, a name like `analyze-log-files.md` is appropriate.
    *   Verify the name follows the convention described in `directory-organization.md`.

4.  **Design Tool Call Sequence**: 
    *   Determine the precise sequence of tool calls required to achieve the command's goal.
    *   Prioritize efficiency and logical flow (e.g., read before edit, gather context first).
    *   Consult `1000xrules/core/tools/tool-usage-standards.mdc` for correct tool usage.
    *   **Crucially**: Abstract complex logic or detailed instructions into `1000xbrain` knowledge files. The command itself should only contain the tool calls necessary to *initiate* the process, often starting by reading relevant knowledge files.

5.  **Construct Command File**: 
    *   Create the `.md` file in the correct location: `1000xbrain/commands/<domain>/<command-name>.md`.
    *   Adhere strictly to the format defined in `1000xbrain/brain/knowledge/commands/command-structure.md`:
        *   Line 1: H1 Header (`# Descriptive Command Name`).
        *   Subsequent lines: Valid tool calls, one per line.
        *   No other text (optional single-line comments before tools are allowed).

6.  **Verify Syntax and Structure**: 
    *   Review the created file against `command-structure.md`.
    *   Ensure tool call syntax is correct according to each tool's schema.
    *   Confirm the file is placed in the correct domain directory (`directory-organization.md`).

7.  **Test Tool Calls (Mental Walkthrough)**: 
    *   Perform a mental walkthrough of the tool call sequence.
    *   Verify that the sequence logically achieves the command's goal.
    *   Check for potential errors or missing steps.
    *   Refer to `1000xbrain/brain/knowledge/commands/testing-procedures.md`.

8.  **Document (If Necessary)**: 
    *   If the command is complex or part of a larger workflow, briefly document its creation and purpose in the relevant planning or progress file.

## Example Command Invocation during Creation

The command `` `run command:brain/create-1000xcommand` `` itself is designed to follow this process, using tool calls to read requirements, read these knowledge files, and finally use `edit_file` to create the new command definition `.md` file in the correct location.

## Related Documents

*   `1000xrules/core/communication/1000xcommands-guidelines.md`
*   `1000xbrain/brain/knowledge/commands/command-structure.md`
*   `1000xbrain/brain/knowledge/commands/directory-organization.md`
*   `1000xbrain/brain/knowledge/commands/testing-procedures.md`
*   `1000xrules/core/tools/tool-usage-standards.mdc` 