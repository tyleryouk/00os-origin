<#
.SYNOPSIS
    Validates path matching between 1000xbrain files and Cursor Rules.

.DESCRIPTION
    This script performs proactive validation of path matching between 1000xbrain files
    and Cursor Rules, detecting potential issues that could cause synchronization problems:
    
    1. Files with the same name in different directories
    2. Case sensitivity issues in filenames
    3. README.md files without corresponding readme.mdc files
    4. Discrepancies in directory structure between 1000xbrain and Cursor Rules

.PARAMETER RootPath
    The root path of the 1000xbrain directory. Defaults to "./1000xbrain" relative to the script location.

.PARAMETER CursorRulesPath
    The path to the Cursor Rules directory. Defaults to "./.cursor/rules" relative to the script location.

.PARAMETER ReportPath
    The path where the validation report will be saved. Defaults to "./sync-reports".

.PARAMETER IgnoreCase
    If specified, the script will ignore case differences in filenames.

.EXAMPLE
    .\Validate-PathMatching.ps1

.EXAMPLE
    .\Validate-PathMatching.ps1 -IgnoreCase

.NOTES
    Author: 1000xdev
    Version: 1.0
#>

param(
    [string]$RootPath = (Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) "1000xbrain"),
    [string]$CursorRulesPath = (Join-Path (Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) ".cursor") "rules"),
    [string]$ReportPath = (Join-Path (Split-Path $PSScriptRoot -Parent) "sync-reports"),
    [switch]$IgnoreCase
)

# Create report directory if it doesn't exist
if (-not (Test-Path $ReportPath)) {
    New-Item -ItemType Directory -Path $ReportPath -Force | Out-Null
    Write-Host "Created report directory: $ReportPath" -ForegroundColor Green
}

$reportFile = Join-Path $ReportPath "path-validation-report.md"
$timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Initialize report content
$reportContent = "# Path Matching Validation Report`n`n"
$reportContent += "Generated: $timeStamp`n`n"
$reportContent += "## Summary`n`n"

# Display banner
Write-Host "==============================================="
Write-Host "Path Matching Validation Tool"
Write-Host "==============================================="
Write-Host ""
Write-Host "Options:"
Write-Host "- Root Path: $RootPath"
Write-Host "- Cursor Rules Path: $CursorRulesPath"
Write-Host "- Ignore Case: $($IgnoreCase.ToString())"
Write-Host "==============================================="
Write-Host ""

# Function to get relative path
function Get-RelativePath {
    param (
        [string]$FullPath,
        [string]$BasePath
    )
    
    if ($FullPath.StartsWith($BasePath)) {
        return $FullPath.Substring($BasePath.Length).TrimStart('\', '/')
    }
    return $FullPath
}

# Validate directory existence
$directoryValidation = $true
if (-not (Test-Path $RootPath)) {
    Write-Host "1000xbrain directory not found: $RootPath" -ForegroundColor Red
    $directoryValidation = $false
}

if (-not (Test-Path $CursorRulesPath)) {
    Write-Host "Cursor Rules directory not found: $CursorRulesPath" -ForegroundColor Red
    $directoryValidation = $false
}

if (-not $directoryValidation) {
    $reportContent += "ERROR: One or more directories not found. Validation cannot proceed.`n"
    $reportContent | Out-File -FilePath $reportFile -Encoding utf8
    exit 1
}

# Find all .md files in 1000xbrain
Write-Host "Finding .md files in 1000xbrain directory..."
$mdFiles = Get-ChildItem -Path $RootPath -File -Recurse -Filter "*.md"
Write-Host "Found $($mdFiles.Count) .md files." -ForegroundColor Green

# Find all .mdc files in Cursor Rules
Write-Host "Finding .mdc files in Cursor Rules directory..."
$mdcFiles = Get-ChildItem -Path $CursorRulesPath -File -Recurse -Filter "*.mdc"
Write-Host "Found $($mdcFiles.Count) .mdc files." -ForegroundColor Green

# Initialize issue trackers
$nameConflicts = @()
$caseIssues = @()
$readmeIssues = @()
$directoryMismatches = @()

# Function to get filename without extension
function Get-FilenameWithoutExtension {
    param (
        [string]$FilePath
    )
    
    $filename = Split-Path $FilePath -Leaf
    return [System.IO.Path]::GetFileNameWithoutExtension($filename)
}

# Group md files by name to detect conflicts
$mdFilesByName = $mdFiles | Group-Object { Get-FilenameWithoutExtension -FilePath $_.FullName }

# Check for name conflicts
Write-Host "Checking for files with the same name in different directories..."
foreach ($group in $mdFilesByName) {
    if ($group.Count -gt 1) {
        Write-Host "Found name conflict: $($group.Name) appears in $($group.Count) locations:" -ForegroundColor Yellow
        $locations = $group.Group | ForEach-Object {
            $relativePath = Get-RelativePath -FullPath $_.FullName -BasePath $RootPath
            Write-Host "  - $relativePath" -ForegroundColor Yellow
            $relativePath
        }
        
        $nameConflicts += @{
            Name = $group.Name
            Count = $group.Count
            Locations = $locations
        }
    }
}

# Check for README.md and readme.mdc mapping issues
Write-Host "Checking for README.md mapping issues..."
$readmeMdFiles = $mdFiles | Where-Object { $_.Name -eq "README.md" }
foreach ($readmeMd in $readmeMdFiles) {
    $relativePath = Get-RelativePath -FullName $readmeMd.FullName -BasePath $RootPath
    $directory = Split-Path $relativePath -Parent
    
    # Construct expected mdc path
    $expectedMdcPath = if ([string]::IsNullOrEmpty($directory)) {
        Join-Path $CursorRulesPath "readme.mdc"
    } else {
        Join-Path (Join-Path $CursorRulesPath $directory) "readme.mdc"
    }
    
    if (-not (Test-Path $expectedMdcPath)) {
        # Check for case variations
        $directoryPath = Split-Path $expectedMdcPath -Parent
        $potentialFiles = Get-ChildItem -Path $directoryPath -File -ErrorAction SilentlyContinue | Where-Object { $_.Name -match "^[Rr][Ee][Aa][Dd][Mm][Ee]\.mdc$" }
        
        if ($potentialFiles.Count -eq 0) {
            Write-Host "  Missing readme.mdc for: $relativePath" -ForegroundColor Yellow
            $readmeIssues += @{
                MdFile = $relativePath
                ExpectedMdc = $expectedMdcPath
                Issue = "Missing"
            }
        }
        else {
            Write-Host "  Case sensitivity issue with readme.mdc for: $relativePath" -ForegroundColor Yellow
            $readmeIssues += @{
                MdFile = $relativePath
                ExpectedMdc = $expectedMdcPath
                ActualMdc = $potentialFiles[0].FullName
                Issue = "Case"
            }
        }
    }
}

# Check for directory structure mismatches
Write-Host "Checking for directory structure mismatches..."
foreach ($mdFile in $mdFiles) {
    $relativePath = Get-RelativePath -FullName $mdFile.FullName -BasePath $RootPath
    $directory = Split-Path $relativePath -Parent
    $filename = Split-Path $relativePath -Leaf
    
    # Skip README.md files as they were already checked
    if ($filename -eq "README.md") {
        continue
    }
    
    # Construct expected mdc path
    $mdcFilename = $filename -replace "\.md$", ".mdc"
    $expectedMdcPath = if ([string]::IsNullOrEmpty($directory)) {
        Join-Path $CursorRulesPath $mdcFilename
    } else {
        Join-Path (Join-Path $CursorRulesPath $directory) $mdcFilename
    }
    
    if (-not (Test-Path $expectedMdcPath)) {
        # Try to find the file by name anywhere in the Cursor Rules directory
        $nameMatch = $mdcFiles | Where-Object { 
            $mdcName = Split-Path $_.FullName -Leaf
            if ($IgnoreCase) {
                $mdcName -eq $mdcFilename -or $mdcName.ToLower() -eq $mdcFilename.ToLower()
            } else {
                $mdcName -eq $mdcFilename
            }
        }
        
        if ($nameMatch.Count -gt 0) {
            Write-Host "  Directory structure mismatch for: $relativePath" -ForegroundColor Yellow
            Write-Host "    Expected: $expectedMdcPath" -ForegroundColor Yellow
            Write-Host "    Found at: $($nameMatch[0].FullName)" -ForegroundColor Yellow
            
            $directoryMismatches += @{
                MdFile = $relativePath
                ExpectedMdc = $expectedMdcPath
                ActualMdc = $nameMatch[0].FullName
            }
        }
    }
}

# Update report with findings
$totalIssues = $nameConflicts.Count + $caseIssues.Count + $readmeIssues.Count + $directoryMismatches.Count

$reportContent += "- 1000xbrain files found: $($mdFiles.Count)`n"
$reportContent += "- Cursor Rules files found: $($mdcFiles.Count)`n"
$reportContent += "- Total issues found: $totalIssues`n"
$reportContent += "  - Name conflicts: $($nameConflicts.Count)`n"
$reportContent += "  - Case sensitivity issues: $($caseIssues.Count)`n"
$reportContent += "  - README.md mapping issues: $($readmeIssues.Count)`n"
$reportContent += "  - Directory structure mismatches: $($directoryMismatches.Count)`n`n"

# Add detailed sections for each issue type
if ($nameConflicts.Count -gt 0) {
    $reportContent += "## Name Conflicts`n`n"
    $reportContent += "Files with the same name in different directories may cause synchronization problems.`n`n"
    
    foreach ($conflict in $nameConflicts) {
        $reportContent += "### $($conflict.Name)`n`n"
        $reportContent += "Found in $($conflict.Count) locations:`n`n"
        foreach ($location in $conflict.Locations) {
            $reportContent += "- $location`n"
        }
        $reportContent += "`n"
    }
}

if ($readmeIssues.Count -gt 0) {
    $reportContent += "## README.md Mapping Issues`n`n"
    $reportContent += "**Important Note**: README.md files are not meant to be synchronized to Cursor Rules. They serve as directory navigation and documentation in 1000xbrain, not as Cursor Rules.`n`n"
    
    foreach ($issue in $readmeIssues) {
        $reportContent += "- $($issue.MdFile): $($issue.Issue) readme.mdc`n"
    }
    
    $reportContent += "`n**Note**: README.md files should NOT be synchronized. This information is provided for documentation purposes only.`n`n"
}

if ($directoryMismatches.Count -gt 0) {
    $reportContent += "## Directory Structure Mismatches`n`n"
    $reportContent += "| 1000xbrain File | Expected Cursor Rule | Actual Location |`n"
    $reportContent += "|----------------|---------------------|----------------|`n"
    
    foreach ($mismatch in $directoryMismatches) {
        $reportContent += "| $($mismatch.MdFile) | $($mismatch.ExpectedMdc) | $($mismatch.ActualMdc) |`n"
    }
    $reportContent += "`n"
}

# Generate recommendations based on issues found
$reportContent += "## Recommended Actions`n`n"

if ($nameConflicts.Count -gt 0) {
    $reportContent += "1. Resolve name conflicts by renaming files or organizing them into appropriate subdirectories.`n"
}

if ($directoryMismatches.Count -gt 0) {
    $reportContent += "1. Fix directory structure mismatches to ensure proper path-based matching.`n"
}

# Note about README.md files
$reportContent += "`n**Important Note**: README.md files are explicitly excluded from synchronization. README.md files in 1000xbrain serve as directory navigation and documentation, not as Cursor Rules.`n"

# Save the report
$reportContent | Out-File -FilePath $reportFile -Encoding utf8

# Display summary
Write-Host "`nValidation completed." -ForegroundColor Green
Write-Host "- 1000xbrain files: $($mdFiles.Count)" -ForegroundColor Green
Write-Host "- Cursor Rules files: $($mdcFiles.Count)" -ForegroundColor Green
Write-Host "- Total issues found: $totalIssues" -ForegroundColor $(if ($totalIssues -gt 0) { "Yellow" } else { "Green" })

if ($totalIssues -gt 0) {
    Write-Host "  - Name conflicts: $($nameConflicts.Count)" -ForegroundColor $(if ($nameConflicts.Count -gt 0) { "Yellow" } else { "Green" })
    Write-Host "  - README.md mapping issues: $($readmeIssues.Count)" -ForegroundColor $(if ($readmeIssues.Count -gt 0) { "Yellow" } else { "Green" })
    Write-Host "  - Directory structure mismatches: $($directoryMismatches.Count)" -ForegroundColor $(if ($directoryMismatches.Count -gt 0) { "Yellow" } else { "Green" })
    
    Write-Host "`nRecommended action: Run Fix-PathMatchingAndSync.ps1 to resolve these issues." -ForegroundColor Cyan
}
else {
    Write-Host "`nNo path matching issues found. The directory structure is consistent between 1000xbrain and Cursor Rules." -ForegroundColor Green
}

Write-Host "Report saved to: $reportFile" -ForegroundColor Green
