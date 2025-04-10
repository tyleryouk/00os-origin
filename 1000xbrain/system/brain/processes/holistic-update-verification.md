# Process: Holistic Update Verification

## Overview

This process should be invoked after a command, process, or knowledge file is created or updated. It performs checks to ensure related components are consistent.

## Input Context

*   **Parameter `changed_file_path`**: The full path of the file that was just modified/created.
*   **Knowledge**: Core architecture and command knowledge files.

## Steps

1.  **Identify Related Files (Conceptual)**:
    *   Based on `changed_file_path` and knowledge of system structure, identify potentially related files.
    *   If a command changed, find its process file.
    *   If a process changed, find commands that use it and knowledge it uses.
    *   If knowledge changed, find processes/commands that use it.
2.  **Review Related Files (Conceptual)**:
    *   Read the content of identified related files.
    *   Analyze for inconsistencies introduced by the change (e.g., command parameters don't match process context, process steps don't align with knowledge).
3.  **Propose/Flag Updates**: 
    *   If inconsistencies are found, report them clearly.
    *   (Future) Potentially propose specific edits to fix inconsistencies.
4.  **Report Results**: Summarize verification findings.

## Error Handling

*   Handle errors during file reading/analysis.

*(Placeholder: Highly conceptual. Requires sophisticated analysis and understanding of dependencies.)* 