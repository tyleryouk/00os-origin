# 1000xscripts

This directory contains various PowerShell scripts for managing the GigaSwap project.

## Available Scripts

### Report Scripts

Scripts used for generating reports and documentation:

| Script | Description |
|--------|-------------|
| `report-scripts/Update-WorkflowCheatsheets.ps1` | Updates workflow cheatsheets based on project-rule-parameters organization |
| `report-scripts/Generate-DomainMap.ps1` | Generates domain relationship maps |
| `report-scripts/Generate-KnowledgeIndex.ps1` | Generates knowledge index files |

### Utility Scripts

Scripts used for various utility functions:

| Script | Description |
|--------|-------------|
| `utility-scripts/Format-ProjectRules.ps1` | Formats project rule markdown files |
| `utility-scripts/Sync-FrontmatterAndContent.ps1` | Synchronizes frontmatter and content between files |
| `utility-scripts/Generate-FileTemplate.ps1` | Generates file templates based on templates |
| `utility-scripts/Sync-Readmes.ps1` | Synchronizes README.md files across the project |

### Wrapper Scripts

Scripts that serve as wrappers for other scripts:

| Script | Description |
|--------|-------------|
| `Update-Cheatsheets.ps1` | Wrapper for Update-WorkflowCheatsheets.ps1 |
| `Generate-Documentation.ps1` | Wrapper for documentation generation scripts |
| `Sync-ProjectRules.ps1` | Wrapper for synchronization scripts |

## Script Documentation

### Update-Cheatsheets.ps1

A wrapper script that calls `report-scripts/Update-WorkflowCheatsheets.ps1` to update workflow cheatsheets.

#### Recent Updates

The cheatsheet generation script has been updated to:

1. **Organize by Subdirectory**: Parameters are now organized in the cheatsheet based on their subdirectory structure:
   - `PLAN-MODE project-rule-parameters`
   - `DEV-MODE project-rule-parameters` 
   - `DIRECT-MODE project-rule-parameters`
   - `HELPERS project-rule-parameters` (with further subdivisions)

2. **Improved Command Detection**: Enhanced message-command detection using multiple strategies:
   - Explicit "Loyal to:" statements
   - "Message-Command:" sections
   - Command format examples
   - File name inference

3. **Better Parameter Handling**: Improved standard parameter detection and handling
   
4. **Eliminated ROOT Section**: The ROOT section has been removed for better organization

This structure reflects the actual organization of the parameters in the 1000xbrain/parameters directory, making the cheatsheet easier to navigate and understand.

### Generate-Documentation.ps1

A wrapper script that calls various documentation generation scripts.

### Sync-ProjectRules.ps1

A wrapper script that calls various synchronization scripts.

## Usage Examples

### Update Workflow Cheatsheets

```powershell
# Update all workflow cheatsheets
.\Update-Cheatsheets.ps1
```

### Generate Documentation

```powershell
# Generate all documentation
.\Generate-Documentation.ps1
```

### Synchronize Project Rules

```powershell
# Synchronize all project rules
.\Sync-ProjectRules.ps1
```

## Directory Structure

- `report-scripts/` - Scripts for generating reports and documentation
- `utility-scripts/` - Utility scripts for various project needs
- `maintenance-scripts/` - Scripts for validation and maintenance
- `sync-reports/` - Storage for synchronization reports

## Important Notes

1. **Always run with -DryRun first** when using synchronization scripts to preview changes
2. **Review generated reports** carefully before proceeding with actual changes
3. **Be cautious when updating .mdc files** as these are typically edited through Cursor UI
4. **Check execution permissions** if encountering access issues