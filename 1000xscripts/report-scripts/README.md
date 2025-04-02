---
description: 
globs: 
alwaysApply: false
type: manual
---
# Report Scripts

This directory contains scripts for generating reports and analytics about the 1000xbrain cognitive architecture.

## Available Scripts

- `Generate-ArchitectureReport.ps1` - Generates a comprehensive report on the cognitive architecture
- `Analyze-FileCoverage.ps1` - Analyzes coverage of features in the cognitive architecture
- `Generate-DirectoryStats.ps1` - Generates statistics for each directory
- `Compare-VersionChanges.ps1` - Compares changes between different versions of the architecture
- `Export-ArchitectureVisualization.ps1` - Exports visualizations of the architecture

### Update-WorkflowCheatsheets.ps1

**Purpose**: Automatically updates workflow cheatsheets with the latest message-commands and project-rule-parameters.

**Usage**:
```powershell
.\Update-WorkflowCheatsheets.ps1
```

**What it does**:
- Scans the knowledge directories for project-rule-parameters
- Categorizes parameters by message-command type (plan-mode, dev-mode, continue-planning, continue-implementation, no-planning-folder, other)
- Generates updated cheatsheets for front-end-workflow and rules-workflow
- Formats the output in a clean, simple table format

**Output**:
- Updated front-end-workflow-cheatsheet.md
- Updated rules-workflow-cheatsheet.md
- Updated planning/cs.md (consolidated cheatsheet)

**Supported Message-Commands**:
- `plan-mode`: Planning phase initialization
- `dev-mode`: Development phase initialization
- `continue-planning`: Planning continuation
- `continue-implementation`: Implementation continuation
- `no-planning-folder`: Direct implementation without planning phase
- Template-related commands (create-template)
- Other helper message-commands

**When to use**:
- After adding new project-rule-parameters
- After making changes to the structure of message-commands
- When you need to refresh the cheatsheets with the latest information

## Usage Examples

```powershell
# Generate a comprehensive architecture report
.\Generate-ArchitectureReport.ps1

# Analyze file coverage across the architecture
.\Analyze-FileCoverage.ps1

# Generate directory statistics
.\Generate-DirectoryStats.ps1
```

## Report Types

These scripts can generate several types of reports:

- **Comprehensive Reports**: Complete analysis of the entire cognitive architecture
- **Coverage Reports**: Analysis of how well features are covered in documentation
- **Directory Reports**: Focused analysis of specific directories
- **Comparison Reports**: Analysis of changes between versions
- **Visualization Reports**: Visual representations of the architecture

## Report Formats

Reports can be generated in multiple formats:

- Markdown files
- HTML reports
- JSON data
- CSV data for spreadsheet analysis
- Visual diagrams (requires GraphViz)

## Output

Reports are saved to a dedicated reports directory with timestamped filenames for easy historical tracking and comparison. 

## Running the Scripts

To run any of the report scripts:

1. Navigate to the report-scripts directory
2. Execute the script with PowerShell

```powershell
cd 1000xscripts/report-scripts
.\Update-WorkflowCheatsheets.ps1
```

Or run from the root directory:

```powershell
.\1000xscripts\report-scripts\Update-WorkflowCheatsheets.ps1
```
