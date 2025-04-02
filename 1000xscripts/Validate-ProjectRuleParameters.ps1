<#
.SYNOPSIS
    Validates project-rule-parameters across the 1000xbrain cognitive architecture.

.DESCRIPTION
    This script scans markdown files in the 1000xbrain directory to identify and validate
    project-rule-parameters. It checks for:
    - Correct extension usage (.mdc instead of .md)
    - Existence of referenced files
    - Consistent naming patterns

.NOTES
    File Name      : Validate-ProjectRuleParameters.ps1
    Author         : 1000xdev
    Prerequisite   : PowerShell 5.1 or later
    
.EXAMPLE
    .\Validate-ProjectRuleParameters.ps1
#>

# Script Configuration
$rootDirectory = Join-Path $PSScriptRoot ".." "1000xbrain"
$outputFile = Join-Path $PSScriptRoot "project-rule-parameter-validation-report.md"
$knowledgeRulesDir = Join-Path $rootDirectory "knowledge" "rules"

# Pattern to match project-rule-parameters (message-command pattern followed by @path/to/file.md or .mdc)
$projectRuleParameterPattern = '(?i)((?:[a-z0-9]+-)+[a-z0-9]+):\s+(?:@[^\s]+\s+)?@([^\s]+\.(md|mdc))'

# Pattern to ignore (correctly identifying incorrect examples)
$ignoreDemoPattern = '(?i)(incorrect|error).*@.+\.md'

# Initialize results array
$results = @{
    Valid = @()
    InvalidExtension = @()
    FileNotFound = @()
    IgnoredExamples = @()
}

# Output header information
Write-Host "Project-Rule-Parameter Validation"
Write-Host "============================="
Write-Host "Scanning directory: $rootDirectory"
Write-Host "Looking for pattern: $projectRuleParameterPattern"
Write-Host ""

# Get all markdown files
$files = Get-ChildItem -Path $rootDirectory -Filter "*.md" -Recurse

Write-Host "Found $($files.Count) markdown files to scan"
Write-Host ""

# Process each file
foreach ($file in $files) {
    Write-Host "Processing $($file.FullName)"
    
    $content = Get-Content -Path $file.FullName -Raw
    $matches = [regex]::Matches($content, $projectRuleParameterPattern)
    
    foreach ($match in $matches) {
        $fullMatch = $match.Groups[0].Value
        $messageCommand = $match.Groups[1].Value
        $filePath = $match.Groups[2].Value
        $extension = $match.Groups[3].Value.ToLower()
        
        # Check if this is an example of incorrect usage
        $lineContent = $content.Substring(0, $match.Index + $match.Length)
        $lastNewline = $lineContent.LastIndexOf("`n")
        $currentLine = $lineContent.Substring($lastNewline + 1)
        
        if ($currentLine -match $ignoreDemoPattern) {
            $results.IgnoredExamples += @{
                File = $file.FullName
                Line = $currentLine.Trim()
                Match = $fullMatch
            }
            continue
        }
        
        # Check if extension is correct
        if ($extension -ne "mdc") {
            $correctedPath = $filePath -replace "\.md$", ".mdc"
            $results.InvalidExtension += @{
                File = $file.FullName
                MessageCommand = $messageCommand
                FilePath = $filePath
                CorrectedPath = $correctedPath
                FullMatch = $fullMatch
            }
            continue
        }
        
        # Check if file exists (for knowledge/rules directory)
        if ($filePath -match "^knowledge/rules/(.+)$") {
            $actualPath = Join-Path $rootDirectory $filePath
            if (-not (Test-Path $actualPath)) {
                $results.FileNotFound += @{
                    File = $file.FullName
                    MessageCommand = $messageCommand
                    FilePath = $filePath
                    FullMatch = $fullMatch
                }
                continue
            }
        }
        
        # Valid project-rule-parameter
        $results.Valid += @{
            File = $file.FullName
            MessageCommand = $messageCommand
            FilePath = $filePath
            FullMatch = $fullMatch
        }
    }
}

# Generate summary report
$report = @"
# Project-Rule-Parameter Validation Report

Generated on: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

## Summary

- Total markdown files scanned: $($files.Count)
- Valid project-rule-parameters: $($results.Valid.Count)
- Invalid extensions (.md instead of .mdc): $($results.InvalidExtension.Count)
- Referenced files not found: $($results.FileNotFound.Count)
- Ignored examples of incorrect usage: $($results.IgnoredExamples.Count)

## Invalid Extensions

These project-rule-parameters use .md instead of .mdc extension:

"@

if ($results.InvalidExtension.Count -eq 0) {
    $report += "`r`n*No invalid extensions found*`r`n"
} else {
    $report += "`r`n"
    foreach ($item in $results.InvalidExtension) {
        $report += "- In file: $($item.File)`r`n"
        $report += "  - Found: `$($item.FullMatch)`r`n"
        $report += "  - Should use: @$($item.CorrectedPath)`r`n`r`n"
    }
}

$report += @"

## Files Not Found

These project-rule-parameters reference files that don't exist:

"@

if ($results.FileNotFound.Count -eq 0) {
    $report += "`r`n*No missing files found*`r`n"
} else {
    $report += "`r`n"
    foreach ($item in $results.FileNotFound) {
        $report += "- In file: $($item.File)`r`n"
        $report += "  - Referenced file not found: `$($item.FilePath)`r`n`r`n"
    }
}

$report += @"

## Valid Project-Rule-Parameters

These project-rule-parameters are correctly formatted and reference existing files:

"@

if ($results.Valid.Count -eq 0) {
    $report += "`r`n*No valid project-rule-parameters found*`r`n"
} else {
    $report += "`r`n"
    foreach ($item in $results.Valid) {
        $report += "- In file: $($item.File)`r`n"
        $report += "  - Valid reference: `$($item.FullMatch)`r`n`r`n"
    }
}

# Output results to file
$report | Out-File -FilePath $outputFile -Encoding utf8

# Display summary
Write-Host ""
Write-Host "Validation complete"
Write-Host "-----------------"
Write-Host "Valid project-rule-parameters: $($results.Valid.Count)"
Write-Host "Invalid extensions: $($results.InvalidExtension.Count)"
Write-Host "Referenced files not found: $($results.FileNotFound.Count)"
Write-Host "Ignored examples of incorrect usage: $($results.IgnoredExamples.Count)"
Write-Host ""
Write-Host "Full report written to: $outputFile" 