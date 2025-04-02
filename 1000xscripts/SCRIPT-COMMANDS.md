---
description: 
globs: 
alwaysApply: false
type: manual
---
# 1000xscripts Command Guide

## Quick Reference

### Most Common Commands

1. **Full Sync (Master Script)**
```powershell
.\Fix-PathMatchingAndSync.ps1 -Force
```
This is the master script that:
- Preserves all rule types
- Syncs frontmatter
- Syncs content
- Generates reports

2. **Check Sync Status**
```powershell
.\Test-SyncProcess.ps1
```
This will show:
- Which files are not synced
- Which files have different content
- Which files have incorrect paths

3. **Validate Project-Rule-Parameters**
```powershell
.\Validate-ProjectRuleParameters.ps1
```
This will:
- Scan all markdown files for project-rule-parameters
- Validate correct extension usage (.mdc)
- Verify referenced files exist
- Generate a validation report

## Detailed Command Reference

### 1. Fix-PathMatchingAndSync.ps1 (Master Sync Script)

**Basic Usage:**
```powershell
.\Fix-PathMatchingAndSync.ps1
```

**Common Options:**
```powershell
# Force sync without prompts
.\Fix-PathMatchingAndSync.ps1 -Force

# Show what would happen without making changes
.\Fix-PathMatchingAndSync.ps1 -WhatIf

# Show detailed progress
.\Fix-PathMatchingAndSync.ps1 -Verbose

# Run with dry run (no changes made)
.\Fix-PathMatchingAndSync.ps1 -DryRun

# Run with prompts, preserving rule types
.\Fix-PathMatchingAndSync.ps1 -PreserveRuleType
```

**Note**: Rule types are ALWAYS preserved during sync. The script will not modify any rule types.

### 2. Test-SyncProcess.ps1 (Check Sync Status)

**Basic Usage:**
```powershell
.\Test-SyncProcess.ps1
```

**Common Options:**
```powershell
# Generate detailed report
.\Test-SyncProcess.ps1 -GenerateReport

# Check specific directories
.\Test-SyncProcess.ps1 -TargetDirectory "core"
```

### 3. Validate-ProjectRuleParameters.ps1 (Validate Project-Rule-Parameters)

**Basic Usage:**
```powershell
.\Validate-ProjectRuleParameters.ps1
```

This script:
- Scans all markdown files in 1000xbrain for project-rule-parameters
- Validates the correct use of .mdc extension in project-rule-parameters
- Verifies that referenced files exist
- Ignores examples of incorrect usage (for teaching purposes)
- Generates a detailed validation report

**Output:**
- Console summary of validation results
- Markdown report file: `project-rule-parameter-validation-report.md`
- Lists of valid, invalid, and missing references

### 4. Auto-SyncAfterEdits.ps1 (Continuous Sync)

**Start Auto-Sync:**
```powershell
.\Start-AutoSync.bat
```
This will:
- Monitor for changes in 1000xbrain
- Automatically sync to .cursor/rules (preserving rule types)
- Generate sync reports

### 5. Sync-All.bat (Quick Full Sync)

**Basic Usage:**
```powershell
.\Sync-All.bat
```
This runs:
1. Validate-ProjectRuleParameters.ps1 (validates all project-rule-parameters)
2. Fix-PathMatchingAndSync.ps1 (preserving rule types)
3. Test-SyncProcess.ps1
4. Generates reports

**Common Options:**
```powershell
# Skip project-rule-parameter validation
.\Sync-All.bat -SkipValidation

# Detect orphaned Cursor Rules
.\Sync-All.bat -DetectOrphans

# Remove orphaned Cursor Rules
.\Sync-All.bat -RemoveOrphans

# Skip validation and remove orphans
.\Sync-All.bat -SkipValidation -RemoveOrphans
```

### 6. Update-WorkflowCheatsheets.ps1 (Workflow Cheatsheet Generator)

**Basic Usage:**
```powershell
.\report-scripts\Update-WorkflowCheatsheets.ps1
```

This script:
- Scans knowledge directories (front-end and rules) for project-rule-parameters
- Categorizes parameters by message-command type
- Updates workflow cheatsheets with current project-rule-parameters
- Formats cheatsheets in clean markdown tables

**Purpose:**
- Keep workflow cheatsheets up-to-date with the latest project-rule-parameters
- Ensure accurate documentation of message-commands and their parameters
- Maintain consistent formatting across all cheatsheets

**Note**: This script runs independently from Sync-All.bat and should be executed separately when workflow cheatsheets need to be updated.

### 7. Parameter Management Scripts

**Directory:** `parameters/`

#### Manage-AllParameters.ps1 (Main Interface)

**Basic Usage:**
```powershell
# List all parameters
.\parameters\Manage-AllParameters.ps1 -Operation list

# View details of a specific parameter
.\parameters\Manage-AllParameters.ps1 -Operation list -Name "template-basic"

# Add a new parameter
.\parameters\Manage-AllParameters.ps1 -Operation add -Name "parameter-name" -Path "parameters/rules/category/parameter-name.md" -Description "Parameter description" -Category "category"

# Remove a parameter
.\parameters\Manage-AllParameters.ps1 -Operation remove -Name "parameter-name"

# Update a parameter
.\parameters\Manage-AllParameters.ps1 -Operation update -Name "parameter-name" -Description "Updated description"

# Verify parameter references
.\parameters\Manage-AllParameters.ps1 -Operation verify
```

This script provides a unified interface for all parameter management operations. It internally calls the specialized scripts for each operation.

#### Individual Scripts

These scripts can be called directly for specific operations:

##### Add-ProjectRuleParameter.ps1
```powershell
.\parameters\Add-ProjectRuleParameter.ps1 -Name "parameter-name" -Path "parameters/rules/category/parameter-name.md" -Description "Parameter description" -Category "category"
```

Optional parameters:
- `-UsageExamples` - Array of usage examples
- `-RelatedParameters` - Array of related parameter names

##### Remove-ProjectRuleParameter.ps1
```powershell
.\parameters\Remove-ProjectRuleParameter.ps1 -Name "parameter-name"
```

##### Update-ProjectRuleParameter.ps1
```powershell
.\parameters\Update-ProjectRuleParameter.ps1 -Name "parameter-name" -Description "Updated description"
```

Optional parameters:
- `-Path` - New parameter file path
- `-Category` - New parameter category
- `-UsageExamples` - New usage examples
- `-RelatedParameters` - New related parameter names

##### Verify-ParameterReferences.ps1
```powershell
.\parameters\Verify-ParameterReferences.ps1
```

This script:
- Scans all markdown files in 1000xbrain for parameter references
- Verifies that references match registry entries
- Identifies broken or inconsistent references
- Reports findings with detailed information

## Common Workflows

### 1. Initial Setup
```powershell
# 1. Run full sync
.\Fix-PathMatchingAndSync.ps1 -Force

# 2. Verify sync status
.\Test-SyncProcess.ps1 -GenerateReport

# 3. Start auto-sync
.\Start-AutoSync.bat
```

### 2. Manual Rule Type Updates
```powershell
# 1. Update rule type using Cursor UI
# 2. Run full sync to preserve the change
.\Fix-PathMatchingAndSync.ps1 -Force
```

### 3. Check for Problems
```powershell
# 1. Test sync status
.\Test-SyncProcess.ps1 -GenerateReport

# 2. Run project-rule-parameter validation
.\Validate-ProjectRuleParameters.ps1

# 3. Review reports in sync-reports/ directory
```

### 4. Validate and Sync
```powershell
# Comprehensive sync with validation
.\Sync-All.bat
```

### 5. Update Workflow Cheatsheets
```powershell
# 1. Add or modify project-rule-parameters in knowledge directory
# 2. Update workflow cheatsheets with the latest parameters
.\report-scripts\Update-WorkflowCheatsheets.ps1

# 3. Review updated cheatsheets
notepad .\1000xbrain\workflows\front-end-workflow\front-end-workflow-cheatsheet.md
notepad .\1000xbrain\workflows\rules-workflow\rules-workflow-cheatsheet.md
```

### 6. Parameter Management Workflow

```powershell
# 1. List all parameters
.\parameters\Manage-AllParameters.ps1 -Operation list

# 2. Add a new parameter (after creating the file in 1000xbrain)
.\parameters\Manage-AllParameters.ps1 -Operation add -Name "new-parameter" -Path "parameters/rules/category/new-parameter.md" -Description "New parameter description" -Category "category"

# 3. Verify parameter references
.\parameters\Manage-AllParameters.ps1 -Operation verify

# 4. Run full sync to update Cursor Rules
.\Sync-All.bat
```

## Report Locations

- **Sync Reports**: `sync-reports/`
- **Log Files**: Root directory with pattern `fix-path-matching-sync-*.log`
- **Project-Rule-Parameter Validation Report**: `project-rule-parameter-validation-report.md`
- **Parameter Reference Verification Report**: `parameter-reference-verification-report.md`
- **Workflow Cheatsheets**: `1000xbrain/workflows/front-end-workflow/front-end-workflow-cheatsheet.md` and `1000xbrain/workflows/rules-workflow/rules-workflow-cheatsheet.md`

## Common Issues

1. **Multiple Frontmatter Blocks**
   ```powershell
   # Fix with force sync
   .\Fix-PathMatchingAndSync.ps1 -Force
   ```

2. **Content Not Syncing**
   ```powershell
   # Check sync status
   .\Test-SyncProcess.ps1 -GenerateReport
   
   # Force full sync
   .\Fix-PathMatchingAndSync.ps1 -Force -Verbose
   ```

3. **Incorrect Project-Rule-Parameters**
   ```powershell
   # Run validation to identify issues
   .\Validate-ProjectRuleParameters.ps1
   
   # Review report and fix issues
   # Run comprehensive sync after fixing
   .\Sync-All.bat
   ```

4. **Parameter Reference Inconsistencies**
   ```powershell
   # Verify parameter references
   .\parameters\Verify-ParameterReferences.ps1
   
   # Fix inconsistencies using the update command
   .\parameters\Manage-AllParameters.ps1 -Operation update -Name "parameter-name" -Path "correct/path/parameter-name.md"
   ```

## Important Notes

1. **Rule Type Preservation**
   - All scripts now ALWAYS preserve rule types
   - Rule types can only be changed through the Cursor UI
   - Sync operations will never modify rule types

2. **Sync Process**
   - Use `Fix-PathMatchingAndSync.ps1` for all sync operations
   - Always preserves rule types
   - Maintains path matching
   - Generates detailed reports

3. **Monitoring**
   - Use `Test-SyncProcess.ps1` to check sync status
   - Use `Start-AutoSync.bat` for continuous monitoring
   - Review reports in `sync-reports/` directory 

4. **Parameter Validation**
   - Run `Validate-ProjectRuleParameters.ps1` before syncing
   - Fix all reported issues to ensure correct operation
   - Ensure all project-rule-parameters use .mdc extension

5. **Parameter Management**
   - Always use the parameter management scripts for adding, removing, or updating parameters
   - Never manually edit the parameter registry file
   - Run verification regularly to ensure consistency across all references

## Rules Management Scripts

### 1. Fix-DuplicateFrontmatter.ps1

Fixes .mdc files with multiple frontmatter blocks by consolidating them into a single, correct frontmatter.

```powershell
# Show what would be fixed without making changes
.\rules-scripts\Fix-DuplicateFrontmatter.ps1 -WhatIf

# Fix all files with duplicate frontmatter without prompting
.\rules-scripts\Fix-DuplicateFrontmatter.ps1 -Force
```

This script:
1. Scans all .mdc files in the Cursor Rules directory
2. Identifies files with multiple frontmatter blocks
3. Merges all frontmatter blocks while preserving the most complete information
4. Fixes rule type inconsistencies during the merge
5. Generates a report of all fixed files

Use this script when you encounter errors with duplicate frontmatter blocks.