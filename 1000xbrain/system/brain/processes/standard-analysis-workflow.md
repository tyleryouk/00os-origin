# Standard Analysis Workflow Process

## Overview

This process outlines a general workflow for analyzing aspects of the 1000x system or target applications.

## Steps

1.  **Define Goal**: Clearly state the objective of the analysis (e.g., "Identify inconsistencies in rule file paths", "Analyze usage patterns of command X", "Assess front-end component complexity").
2.  **Identify Scope**: Determine the relevant files, directories, or components to analyze (e.g., `1000xrules/core/`, specific command logs, `/frontend/src/components/`).
3.  **Gather Context**: Use appropriate tools (`read_file`, `list_dir`, `grep_search`, `codebase_search`) to gather the necessary information from the defined scope.
4.  **Analyze Information**: Process the gathered context based on the analysis goal.
    *   Look for patterns, discrepancies, metrics, or specific keywords.
    *   Compare against standards or guidelines (`1000xbrain/system/guidelines/`).
    *   Utilize relevant domain knowledge (`1000xbrain/<domain>/knowledge/`).
5.  **Synthesize Findings**: Summarize the results of the analysis.
6.  **Determine Next Actions**: Based on the findings, decide on the next steps:
    *   Document findings (e.g., update `notes.md` or `implementation-progress.md`).
    *   Propose changes (e.g., plan edits to files).
    *   Trigger corrective commands.
    *   Conclude analysis if no action is needed.

*(Placeholder: This process needs further refinement and specialization for specific analysis tasks)* 