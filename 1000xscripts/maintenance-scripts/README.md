---
description: 
globs: 
alwaysApply: false
type: manual
---
# Maintenance Scripts

This directory contains scripts for ongoing maintenance and health checks of the 1000xbrain cognitive architecture.

## Scripts

| Script | Purpose | Parameters |
|--------|---------|------------|
| `Validate-PathMatching.ps1` | Proactively validates path matching between 1000xbrain and Cursor Rules | None |
| `Verify-Frontmatter.ps1` | Verifies frontmatter across all 1000xbrain files | `-RootPath`, `-ReportPath` |
| `Clean-OrphanedFiles.ps1` | Identifies and optionally removes orphaned files | `-WhatIf`: Preview without changes |

## Path Matching Validation

The `Validate-PathMatching.ps1` script provides proactive validation of path matching:

- Identifies files with the same name in different directories
- Detects case sensitivity issues in filenames
- Validates special handling for README.md files
- Checks for directory structure mismatches
- Generates a detailed report without making any changes

### Usage

```powershell
# Run path matching validation
.\Validate-PathMatching.ps1
```

### Validation Checks

The script performs these key validation checks:

1. **Same Name Conflicts**: Files with identical names in different directories
2. **Case Sensitivity Issues**: Files with inconsistent case (like README.mdc vs. readme.mdc)
3. **Directory Mismatches**: Files that exist in both systems but in different directory paths
4. **README Mapping Issues**: Problems with README.md to readme.mdc mapping
5. **Unmatched Files**: Files that exist in one system but not the other

### Report

The script generates a detailed report with:

- Summary of validation results
- Lists of each category of issue
- Specific recommendations for resolving each type of issue
- References to the appropriate fix scripts

## Frontmatter Verification

The `Verify-Frontmatter.ps1` script checks frontmatter across all 1000xbrain files:

- Validates required frontmatter fields
- Checks for proper formatting
- Ensures consistency across files

### Usage

```powershell
# Verify frontmatter
.\Verify-Frontmatter.ps1
```

## Orphaned File Cleanup

The `Clean-OrphanedFiles.ps1` script identifies and optionally removes orphaned files:

- Finds files no longer referenced in the architecture
- Identifies duplicate or obsolete files
- Provides options for cleaning up

### Usage

```powershell
# Preview orphaned files without removing them
.\Clean-OrphanedFiles.ps1 -WhatIf
```

## Available Scripts

- `Check-ArchitectureHealth.ps1` - Checks overall health of the cognitive architecture
- `Verify-DirectoryStructure.ps1` - Verifies the directory structure conforms to standards
- `Fix-CommonIssues.ps1` - Automatically fixes common issues in the architecture
- `Scan-DeprecatedPatterns.ps1` - Scans for deprecated patterns or references
- `Cleanup-TemporaryFiles.ps1` - Cleans up temporary files and artifacts

## Usage Examples

```powershell
# Run a complete health check of the architecture
.\Check-ArchitectureHealth.ps1

# Verify directory structure conformance
.\Verify-DirectoryStructure.ps1

# Clean up temporary files
.\Cleanup-TemporaryFiles.ps1
```

## Health Metrics

These scripts check the following health metrics:

- Directory structure conformance
- File naming convention adherence
- Frontmatter consistency
- Cross-reference integrity
- Documentation completeness

## Automated Fixes

The `Fix-CommonIssues.ps1` script can automatically fix:

- Missing frontmatter
- Inconsistent file naming
- Broken cross-references
- Directory structure issues
- Standard formatting problems

## Output

Scripts generate detailed reports in structured formats that can be easily reviewed to understand the current health of the cognitive architecture.

## Integration with Master Scripts

The maintenance scripts are integrated with the master synchronization scripts in the root directory:

- **Fix-PathMatchingAndSync.ps1** calls validation scripts as part of its comprehensive workflow
- **Sync-FrontmatterAndContent.ps1** can be run after validation to apply fixes

## Recommended Workflow

1. Run `Validate-PathMatching.ps1` to identify potential issues
2. Review the validation report
3. Run `Fix-PathMatchingAndSync.ps1` to fix identified issues
4. Verify results after synchronization

## Future Enhancements

Additional maintenance scripts planned for future development:

1. Directory structure verification
2. Cross-reference validation
3. Automatic health checks
4. Performance optimization 
