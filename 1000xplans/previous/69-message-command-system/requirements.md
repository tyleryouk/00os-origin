# Message Command System Update

## Context
The PolygonExpress project uses two key scripts for maintaining message-command documentation:
- `Update-Cheatsheets.bat`: A batch script that triggers the update of workflow cheatsheets. It provides a user-friendly interface for initiating the update process and handles the execution of the PowerShell script.
- `Update-WorkflowCheatsheets.ps1`: A PowerShell script that:
  1. Scans the parameters directory for project-rule-parameters
  2. Categorizes parameters by message-command type (plan-mode, dev-mode, continue-planning, continue-implementation, templates, other)
  3. Updates workflow cheatsheets with the latest information
  4. Formats the output in a clean, table-based format

## Current Issue
The message-command system needs standardization to ensure accurate cheatsheet generation. Currently:

1. **Parameter Detection Issues**: The `Update-Cheatsheets.bat` script fails to detect newly added standard-parameters because:
   - No standardized format exists for defining standard-parameters
   - The script relies on filename patterns for categorization
   - New parameters aren't consistently documented in a machine-readable format

2. **Inconsistent Parameter Usage**: When using project-rule-parameters like `template-past-chat-hallucination`, the standard-parameters vary:
   ```
   create-template: rules-workflow @past-chat-folder @planning-folder project-rule-parameter
   create-template: rules-workflow @67-filepath-migration @planning/67-filepath-migration project-rule-parameter
   ```

3. **Missing Parameter Documentation**: Standard-parameters aren't documented in a way that allows the script to:
   - Identify valid parameter combinations
   - Understand parameter relationships
   - Validate parameter usage

## Required Changes

1. **Parameter Definition System**:
   - Create a standardized format for defining standard-parameters
   - Implement a machine-readable parameter definition file
   - Document parameter relationships and valid combinations

2. **Script Enhancement**:
   - Update `Update-WorkflowCheatsheets.ps1` to read from parameter definition files
   - Enhance parameter categorization logic
   - Implement parameter validation during cheatsheet generation

3. **Documentation Structure**:
   - Define a consistent format for documenting message-commands
   - Create clear guidelines for parameter usage
   - Establish naming conventions for all parameter types

The goal is to ensure that when `Update-Cheatsheets.bat` is run, it accurately reflects all message-commands, standard-parameters, and project-rule-parameters in the system.