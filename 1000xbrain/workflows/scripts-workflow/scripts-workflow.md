# Scripts Workflow: Essential Guide

## Workflow Purpose

The Scripts Workflow focuses on developing and enhancing PowerShell automation scripts for the GigaSwap project's cognitive architecture maintenance. This file contains essential patterns, while detailed implementation guidance is available in referenced files.

## Workflow Identification

**Active Workflow**: scripts-workflow
**Mode Indicators**: 
- Plan Mode: 📋 1000xdev [scripts-workflow]
- Dev Mode: 💻 1000xdev [scripts-workflow]

**⚠️ CRITICAL REQUIREMENT**: 1000xdev MUST begin EVERY message with the appropriate mode indicator shown above. There are NO exceptions to this rule.

## Core Workflow Patterns

### 1. Test-Driven Script Development

- Design script functionality with specific outcomes
- Implement scripts with robust error handling
- Test with various input scenarios
- Verify outputs match expected results

### 2. Implementation Flow

- Create or enhance PowerShell scripts
- Test script functionality in dry-run mode
- Verify synchronization between brain-files and cursor-rules
- Document script usage and parameters

### 3. Essential Message-Commands

| Message-Command | Purpose | Project-Rule-Parameter |
|-----------------|---------|------------------------|
| `verify-script-enhancement` | Verify script enhancement plan | @workflows/scripts-workflow/script-verification.mdc |
| `update-script` | Update an existing script | @workflows/scripts-workflow/script-update.mdc |
| `create-script` | Create a new script | @workflows/scripts-workflow/script-creation.mdc |
| `sync-verification` | Verify synchronization status | @workflows/scripts-workflow/sync-verification.mdc |
| `script-test` | Test script functionality | @workflows/scripts-workflow/script-testing.mdc |

## Scripts Architecture

The scripts follow a structured architecture:

```
1000xscripts/
  ├── Sync-CognitiveArchitecture.ps1 (Master synchronization script)
  ├── Sync-FrontmatterAndContent.ps1 (Content synchronization)
  ├── Fix-PathMatchingAndSync.ps1 (Path matching and fix script)
  ├── frontmatter-scripts/ (Frontmatter management scripts)
  ├── rules-scripts/ (Cursor Rules management scripts)
  ├── maintenance-scripts/ (System maintenance scripts)
  ├── report-scripts/ (Report generation scripts)
  ├── utility-scripts/ (General utility scripts)
  ├── frontmatter-reports/ (Frontmatter reports storage)
  └── sync-reports/ (Synchronization reports storage)
```

## Script Development Standards

- Comprehensive help section for each script
- Parameter validation and error handling
- DryRun/WhatIf parameter for safe testing
- Detailed logging for operation tracking
- Modular design with reusable functions

## File Structure Requirements

All 1000xbrain files MUST follow these structure requirements:

1. **No Frontmatter**: Files should NEVER contain frontmatter (the --- enclosed metadata sections)
2. **Direct Content**: All markdown content should begin directly with headers or text
3. **Standard Markdown**: Use only standard markdown formatting
4. **Header First**: Typically start with a level 1 header (# Title) followed by content

## Planning Process

During plan-mode:
1. Create comprehensive context files for script functionality
2. Document implementation approach in phase-based implementation files
3. Create detailed test scenarios in test-cheatsheet.md
4. Complete planning before transitioning to dev-mode

## Implementation Process

During dev-mode:
1. Implement scripts based on planning documentation
2. Add comprehensive error handling and logging
3. Test script functionality with various scenarios
4. Verify synchronization results
5. Complete all implementation before returning to plan-mode

## Detailed Implementation Guidance

For detailed implementation guides, see:
- @workflows/scripts-workflow/script-verification.mdc (Verification protocols)
- @workflows/scripts-workflow/script-update.mdc (Script update patterns)
- @workflows/scripts-workflow/script-creation.mdc (Script creation standards)
- @workflows/scripts-workflow/sync-verification.mdc (Synchronization verification)
- @parameters/tool/powershell-patterns.mdc (PowerShell best practices)
- @parameters/scripts/scripts-architecture.mdc (Architecture documentation)

