---
description: 
globs: 
alwaysApply: false
type: manual
---
# Scripts Summary

This document provides a comprehensive list of scripts in the 1000xscripts directory and their functions.

## Core Synchronization Scripts

| Script | Description | Usage |
|--------|-------------|-------|
| `Sync-CursorRules.ps1` | Main synchronization script for 1000xbrain to Cursor Rules. | `.\Sync-CursorRules.ps1 -DryRun` or `.\Sync-CursorRules.ps1 -CreateBackups` |
| `Sync-All.bat` | One-click solution for running the complete synchronization process. | `.\Sync-All.bat` |
| `Update-Cheatsheets.bat` | Updates workflow cheatsheets with the latest message-commands and project-rule-parameters. | `.\Update-Cheatsheets.bat` |

## Rules Scripts

| Script | Description | Usage |
|--------|-------------|-------|
| `rules-scripts\CursorRules.psm1` | PowerShell module providing utility functions for Cursor Rules. | Import in other scripts |
| `rules-scripts\Sync-1000xbrainToCursor.ps1` | Analyzes differences between 1000xbrain and Cursor Rules. | `.\rules-scripts\Sync-1000xbrainToCursor.ps1` |
| `rules-scripts\Edit-CursorRule.ps1` | Allows editing Cursor Rule files using VS Code. | `.\rules-scripts\Edit-CursorRule.ps1 -FilePath ".cursor/rules/path/to/file.mdc"` |
| `rules-scripts\Resolve-NameConflicts.ps1` | Identifies and resolves file name conflicts. | `.\rules-scripts\Resolve-NameConflicts.ps1 -WhatIf` |
| `rules-scripts\Update-RuleTypeDropdown.ps1` | Updates rule type dropdown in Cursor UI. | `.\rules-scripts\Update-RuleTypeDropdown.ps1` |

## Maintenance Scripts

| Script | Description | Usage |
|--------|-------------|-------|
| `maintenance-scripts\Validate-PathMatching.ps1` | Validates path matching between 1000xbrain and Cursor Rules. | `.\maintenance-scripts\Validate-PathMatching.ps1` |

## Report Scripts

| Script | Description | Usage |
|--------|-------------|-------|
| `report-scripts\Update-WorkflowCheatsheets.ps1` | Scans and categorizes project-rule-parameters to update workflow cheatsheets. | `.\report-scripts\Update-WorkflowCheatsheets.ps1` |

## Utility Scripts

| Script | Description | Usage |
|--------|-------------|-------|
| `utility-scripts\Clean-Backups.ps1` | Cleans up old backup files. | `.\utility-scripts\Clean-Backups.ps1 -DaysToKeep 7` |

## Key Features of Synchronization

1. **Frontmatter Preservation**: Always preserves existing frontmatter in .mdc files
2. **README.md Exclusion**: README.md files are explicitly excluded from synchronization
3. **Path Matching**: Uses strict path matching to preserve directory structure
4. **Directory Structure Preservation**: Files created maintain proper directory structure

## Recommended Workflow

1. Check for differences between 1000xbrain and Cursor Rules:
   ```
   .\rules-scripts\Sync-1000xbrainToCursor.ps1
   ```

2. Perform a dry run to see what changes would be made:
   ```
   .\Sync-CursorRules.ps1 -DryRun
   ```

3. Perform actual synchronization with backups:
   ```
   .\Sync-CursorRules.ps1 -CreateBackups
   ```

4. Alternatively, use the one-click solution:
   ```
   .\Sync-All.bat
   ```

5. If you need to update workflow cheatsheets (separate from sync process):
   ```
   .\Update-Cheatsheets.bat
   ```

## Important Notes

- Always run with `-DryRun` first to preview changes before applying them
- Review generated reports carefully before proceeding with actual changes
- Be cautious when updating .mdc files as these are typically edited through Cursor UI
- README.md files are explicitly excluded from synchronization
- Frontmatter in .mdc files is always preserved during synchronization

## Common Parameters

Most scripts support these common parameters:

| Parameter | Purpose | Example |
|---|---|---|
| `-DryRun` or `-WhatIf` | Preview changes without making them | `.\script.ps1 -DryRun` |
| `-Force` | Skip confirmation prompts | `.\script.ps1 -Force` |
| `-Verbose` | Show detailed output | `.\script.ps1 -Verbose` |
| `-Path` | Specify path for operations | `.\script.ps1 -Path "custom/path"` |

## Synchronization Process

The synchronization process can be performed in several ways:

1. **One-Click Solution**: Run `.\Sync-All.bat` for a complete synchronization with all validations
2. **Direct Synchronization**: Run `.\Sync-CursorRules.ps1` for basic synchronization
3. **Path Matching Fix**: Run `.\Sync-CursorRules.ps1 -CreateBackups` to fix path matching issues and sync

## Troubleshooting

If you encounter issues with synchronization:

1. **Run with -DryRun**: Use the `-DryRun` flag to preview changes
2. **Check path matching**: Validate path matching with `maintenance-scripts\Validate-PathMatching.ps1`
3. **Monitor logs**: Check synchronization logs for issues
4. **Keep rule types consistent**: Rule types are preserved in the frontmatter

## Best Practices

For optimal synchronization results:

1. **Always run with -DryRun first**: Preview changes before applying them
2. **Create backups**: Use the `-CreateBackups` parameter when making changes
3. **Maintain proper directory structure**: Keep 1000xbrain and Cursor Rules directories aligned
4. **Review reports**: Check synchronization reports after each operation
5. **Exclude README.md files**: README.md files are automatically excluded and should not be synchronized

