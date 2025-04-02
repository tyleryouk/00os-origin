---
description: 
globs: 
alwaysApply: false
type: manual
---
# Rules Scripts

This directory contains scripts for managing and synchronizing Cursor Project Rules.

## Overview

The scripts in this directory help maintain the relationship between the 1000xbrain cognitive architecture (markdown files) and Cursor Project Rules (.mdc files). They provide tools for analyzing differences, updating content, and ensuring proper synchronization between these two components.

## Available Scripts

### Sync-1000xbrainToCursor.ps1

This script analyzes differences between 1000xbrain markdown files and their corresponding Cursor Project Rules (.mdc files), generating a report of files that need to be synchronized.

```powershell
# Basic usage
.\Sync-1000xbrainToCursor.ps1

# Custom paths
.\Sync-1000xbrainToCursor.ps1 -RootPath "C:\path\to\1000xbrain" -CursorRulesPath "C:\path\to\.cursor\rules"
```

## CursorRules.psm1

This PowerShell module provides common functions used by the scripts in this directory, including:

- Extracting and parsing frontmatter
- Finding corresponding files between 1000xbrain and Cursor Rules
- Comparing file content
- Backing up files before modifications
- Creating and updating .mdc files

The module has been simplified to always preserve frontmatter in .mdc files during synchronization, ensuring that rule types are maintained.

## Common Workflow

The simplified workflow for maintaining synchronization between 1000xbrain and Cursor Project Rules is:

1. Make changes to 1000xbrain markdown files
2. Run `Sync-1000xbrainToCursor.ps1` to analyze differences
3. Review the generated report to understand what needs to be updated
4. Run `Sync-CursorRules.ps1` (in the root directory) with the `-DryRun` flag to preview changes
5. If the changes look good, run `Sync-CursorRules.ps1` to apply them

## Key Synchronization Features

1. **Frontmatter Preservation**: Always preserves existing frontmatter in .mdc files
2. **README.md Exclusion**: README.md files are explicitly excluded from synchronization
3. **Path Matching**: Uses strict path matching to preserve directory structure
4. **Clear Reporting**: Generates detailed reports of all changes

## Important Notes

1. **Use Caution**: These scripts modify .mdc files, which are typically edited through the Cursor Settings UI.
2. **Always Back Up**: Use the `-CreateBackups` flag to create backups automatically when making changes.
3. **Dry Run First**: Always use the `-DryRun` flag first to see what changes would be made.
4. **README.md Files**: README.md files are explicitly excluded from synchronization as they serve as directory navigation and documentation in 1000xbrain, not as Cursor Rules.

## Required Permissions

These scripts require:
- Read/write access to the 1000xbrain directory
- Read/write access to the .cursor/rules directory

## Usage in Development Workflow

1. Make changes to markdown files in the 1000xbrain directory
2. Run `Sync-1000xbrainToCursor.ps1` to get a report of files that need synchronizing
3. Run `Sync-CursorRules.ps1` (in the root directory) to automatically update .mdc files with changes

When editing .mdc files directly through Cursor UI, ensure you make the same changes to the corresponding markdown files in 1000xbrain to maintain consistency.

## Getting Started

### Using the Module

To use the PowerShell module, import it first:

```powershell
Import-Module .\CursorRules.psm1
```

Then you can use the functions:

```powershell
# Find corresponding mdc file
Find-CorrespondingMdcFile -markdownFile "path/to/1000xbrain/file.md" -rootPath "path/to/1000xbrain" -cursorRulesPath "path/to/.cursor/rules"

# Update mdc file with content from markdown file
Update-MdcFile -mdcFile "path/to/.cursor/rules/file.mdc" -mdFile "path/to/1000xbrain/file.md" -WhatIf
```

### Using Individual Scripts

You can also run the scripts directly:

```powershell
# Generate a synchronization report
.\Sync-1000xbrainToCursor.ps1

# From the root directory, update .mdc files
..\Sync-CursorRules.ps1 -DryRun
..\Sync-CursorRules.ps1 -CreateBackups
```

## Requirements

- PowerShell 5.1 or newer

## Technical Details

The scripts work by:

1. Locating corresponding files between 1000xbrain and .cursor/rules using strict path matching
2. Preserving frontmatter from .mdc files when updating content
3. Extracting content from .md files (removing any frontmatter)
4. Combining preserved frontmatter with new content
5. Generating comprehensive reports of changes made
6. Explicitly excluding README.md files from synchronization
