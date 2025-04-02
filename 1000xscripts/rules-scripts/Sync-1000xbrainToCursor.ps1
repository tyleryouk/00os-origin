<#
.SYNOPSIS
    Synchronizes content from 1000xbrain markdown files to Cursor Project Rules.

.DESCRIPTION
    This script analyzes differences between 1000xbrain markdown files and their
    corresponding Cursor Project Rules (.mdc files), generating a report of files
    that need to be manually synchronized.

.PARAMETER RootPath
    The root path of the 1000xbrain directory. Defaults to "../1000xbrain" relative to the script location.

.PARAMETER CursorRulesPath
    The path to the Cursor Rules directory. Defaults to "../.cursor/rules" relative to the script location.

.PARAMETER ReportPath
    The path where reports will be saved. Defaults to the current directory.

.PARAMETER StrictPathMatching
    Indicates whether strict path matching should be used when finding corresponding .mdc files.

.EXAMPLE
    .\Sync-1000xbrainToCursor.ps1

.NOTES
    Author: 1000xdev
    Version: 1.0
    Important: This script identifies files that need to be synchronized but does not modify
    the .mdc files directly, as they should be edited through the Cursor UI.
#>

param(
    [string]$RootPath = (Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) "1000xbrain"),
    [string]$CursorRulesPath = (Join-Path (Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) ".cursor") "rules"),
    [string]$ReportPath = $PSScriptRoot,
    [switch]$StrictPathMatching
)

# Ensure the reports directory exists
if (-not (Test-Path $ReportPath)) {
    New-Item -ItemType Directory -Path $ReportPath -Force | Out-Null
    Write-Host "Created reports directory: $ReportPath"
}

# Initialize arrays for tracking files
$allMarkdownFiles = @()
$matchingMdcFiles = @()
$unmatchedMarkdownFiles = @()
$unmatchedMdcFiles = @()
$outdatedMdcFiles = @()

# Function to extract content without frontmatter
function Get-ContentWithoutFrontmatter {
    param([string]$filePath)
    
    $content = Get-Content -Path $filePath -Raw
    
    # Remove frontmatter if it exists - updated regex pattern
    if ($content -match "(?s)^---\s*\r?\n(.*?)\r?\n---\s*\r?\n") {
        $content = $content -replace "(?s)^---\s*\r?\n.*?\r?\n---\s*\r?\n", ""
    }
    
    return $content.Trim()
}

# Function to compare content of files
function Compare-FileContent {
    param([string]$file1, [string]$file2)
    
    $content1 = Get-ContentWithoutFrontmatter -filePath $file1
    $content2 = Get-ContentWithoutFrontmatter -filePath $file2
    
    # Normalize line endings before comparison
    $content1 = $content1 -replace "\r\n", "`n"
    $content2 = $content2 -replace "\r\n", "`n"
    
    return $content1 -eq $content2
}

# Function to find corresponding mdc file for a markdown file
function Find-CorrespondingMdcFile {
    param(
        [string]$markdownFile
    )
    
    $relativePath = $markdownFile.Replace($RootPath, "").TrimStart("\", "/")
    $mdcFileName = [System.IO.Path]::GetFileNameWithoutExtension($relativePath) + ".mdc"
    
    # Always use strict path matching to preserve the directory structure
    $directoryPath = [System.IO.Path]::GetDirectoryName($relativePath)
    if (-not [string]::IsNullOrEmpty($directoryPath)) {
        $expectedMdcPath = Join-Path $CursorRulesPath (Join-Path $directoryPath $mdcFileName)
        
        # Return the path if it exists
        if (Test-Path $expectedMdcPath) {
            return $expectedMdcPath
        }
    }
    
    # Do not fallback to simple name matching
    return $null
}

# Get all markdown files in 1000xbrain
$mdFiles = Get-ChildItem -Path $RootPath -Filter "*.md" -Recurse -File -Exclude "README.md"
$allMarkdownFiles = $mdFiles | ForEach-Object { $_.FullName }

# Get all mdc files in .cursor/rules
$mdcFiles = Get-ChildItem -Path $CursorRulesPath -Filter "*.mdc" -Recurse -File
$allMdcFiles = $mdcFiles | ForEach-Object { $_.FullName }

# Process each markdown file with StrictPathMatching
foreach ($mdFile in $allMarkdownFiles) {
    $correspondingMdcFile = Find-CorrespondingMdcFile -markdownFile $mdFile
    
    if ($correspondingMdcFile) {
        $matchingMdcFiles += $correspondingMdcFile
        
        # Check if content is different
        if (-not (Compare-FileContent -file1 $mdFile -file2 $correspondingMdcFile)) {
            $outdatedMdcFiles += @{
                MarkdownFile = $mdFile
                MdcFile = $correspondingMdcFile
            }
        }
    }
    else {
        $unmatchedMarkdownFiles += $mdFile
    }
}

# Find mdc files without corresponding markdown files
$unmatchedMdcFiles = $allMdcFiles | Where-Object { $_ -notin $matchingMdcFiles }

# Generate the report
$timestamp = Get-Date -Format "yyyy-MM-dd-HHmmss"
$reportFile = Join-Path $ReportPath "1000xbrain-cursor-sync-report-$timestamp.md"

# Helper function to safely join arrays
function Join-StringArray {
    param (
        [string]$separator,
        [array]$array,
        [string]$prefix = ""
    )
    
    if ($null -eq $array -or $array.Count -eq 0) {
        return "None"
    }
    
    return [string]::Join($separator, ($array | ForEach-Object { "$prefix$_" }))
}

$report = @"
# 1000xbrain to Cursor Sync Report - $timestamp

## Summary
- 1000xbrain markdown files: $($allMarkdownFiles.Count)
- Cursor .mdc files: $($allMdcFiles.Count)
- Matched files: $($matchingMdcFiles.Count)
- 1000xbrain files without matching Cursor rules: $($unmatchedMarkdownFiles.Count)
- Cursor rules without matching 1000xbrain files: $($unmatchedMdcFiles.Count)
- Outdated Cursor rules (content differs): $($outdatedMdcFiles.Count)

## Files That Need Manual Synchronization

### Outdated Cursor Rules
$(if ($outdatedMdcFiles.Count -gt 0) {
    Join-StringArray -separator "`n" -array ($outdatedMdcFiles | ForEach-Object { "1000xbrain: $($_.MarkdownFile.Replace($RootPath, "1000xbrain")) → Cursor: $($_.MdcFile.Replace($CursorRulesPath, ".cursor/rules"))" }) -prefix "- "
} else { "None" })

### 1000xbrain Files Without Matching Cursor Rules
$(if ($unmatchedMarkdownFiles.Count -gt 0) {
    Join-StringArray -separator "`n" -array ($unmatchedMarkdownFiles | ForEach-Object { "$_".Replace($RootPath, "1000xbrain") }) -prefix "- "
} else { "None" })

### Cursor Rules Without Matching 1000xbrain Files
$(if ($unmatchedMdcFiles.Count -gt 0) {
    Join-StringArray -separator "`n" -array ($unmatchedMdcFiles | ForEach-Object { "$_".Replace($CursorRulesPath, ".cursor/rules") }) -prefix "- "
} else { "None" })

## Recommended Actions

1. Update outdated Cursor rules with content from corresponding 1000xbrain files
2. Create new Cursor rules for 1000xbrain files without matching rules
3. Review Cursor rules without matching 1000xbrain files (they may be obsolete)

**Note**: Cursor Project Rules must be edited through the Cursor Settings UI. This report identifies
which files need to be manually updated but does not modify the .mdc files directly.
"@

Set-Content -Path $reportFile -Value $report

# Create a symlink to the latest report
$latestReportFile = Join-Path $ReportPath "1000xbrain-cursor-sync-report.md"
Set-Content -Path $latestReportFile -Value $report

# Output results to console
Write-Host "`nSync Report Summary:"
Write-Host "- 1000xbrain markdown files: $($allMarkdownFiles.Count)"
Write-Host "- Cursor .mdc files: $($allMdcFiles.Count)"
Write-Host "- Matched files: $($matchingMdcFiles.Count)" -ForegroundColor Green
Write-Host "- 1000xbrain files without matching Cursor rules: $($unmatchedMarkdownFiles.Count)" -ForegroundColor $(if ($unmatchedMarkdownFiles.Count -gt 0) { "Yellow" } else { "Green" })
Write-Host "- Cursor rules without matching 1000xbrain files: $($unmatchedMdcFiles.Count)" -ForegroundColor $(if ($unmatchedMdcFiles.Count -gt 0) { "Yellow" } else { "Green" })
Write-Host "- Outdated Cursor rules (content differs): $($outdatedMdcFiles.Count)" -ForegroundColor $(if ($outdatedMdcFiles.Count -gt 0) { "Red" } else { "Green" })
Write-Host "`nDetailed sync report written to: $reportFile"
Write-Host "Latest report symlink: $latestReportFile" 