<#
.SYNOPSIS
    Intelligently generates index.md files only for key directories in 1000xbrain.

.DESCRIPTION
    This script analyzes the 1000xbrain directory structure and generates index.md
    files only for important directories that serve as major entry points, category 
    directories, or knowledge hubs. It prevents cognitive overload by limiting 
    the number of index files to only those that provide significant navigational value.

.PARAMETER TargetPath
    The path to the 1000xbrain directory.
    Default is 1000xbrain in the parent directory of the script.

.PARAMETER DryRun
    If specified, the script will only report what would be changed without making actual changes.

.EXAMPLE
    .\Update-IndexFiles-Smart.ps1
    
.EXAMPLE
    .\Update-IndexFiles-Smart.ps1 -DryRun
#>

param(
    [string]$TargetPath = (Join-Path (Split-Path $PSScriptRoot -Parent) "1000xbrain"),
    [switch]$DryRun
)

# Define the key directories that should have index.md files
# These are the most important directories for navigation and knowledge access
$keyDirectories = @(
    "",                                   # Root directory
    "knowledge",                          # Main knowledge entry point
    "knowledge/rules",                    # Rules entry point
    "knowledge/rules/patterns",           # Patterns directory
    "knowledge/rules/reference",          # Reference directory
    "parameters",                         # Parameters entry point
    "parameters/rules",                   # Rules parameters
    "core"                                # Core directory
)

Write-Host "=========================================="
Write-Host "Smart Index.md Generator"
Write-Host "=========================================="
Write-Host "Target Path: $TargetPath"
Write-Host "Dry Run: $DryRun"
Write-Host "Key Directories: $($keyDirectories.Count)"
Write-Host "=========================================="
Write-Host ""

# Track results
$created = 0
$updated = 0
$skipped = 0

# Process each key directory
foreach ($relativeDir in $keyDirectories) {
    $dirPath = if ([string]::IsNullOrEmpty($relativeDir)) {
        $TargetPath
    } else {
        Join-Path -Path $TargetPath -ChildPath $relativeDir
    }
    
    # Skip if directory doesn't exist
    if (-not (Test-Path $dirPath -PathType Container)) {
        Write-Host "Directory not found, skipping: $dirPath" -ForegroundColor Yellow
        continue
    }
    
    $indexPath = Join-Path $dirPath "index.md"
    $dirName = if ([string]::IsNullOrEmpty($relativeDir)) {
        Split-Path $TargetPath -Leaf
    } else {
        Split-Path $dirPath -Leaf
    }
    
    Write-Host "Processing key directory: $dirPath" -ForegroundColor Cyan
    
    # Get markdown files in this directory
    $mdFiles = Get-ChildItem -Path $dirPath -File | Where-Object { 
        $_.Extension -eq ".md" -and $_.Name -ne "index.md" -and $_.Name -ne "README.md" 
    }
    
    # Get direct subdirectories (first level only)
    $subdirs = Get-ChildItem -Path $dirPath -Directory | Where-Object {
        $_.Name -notin @(".cursor", "node_modules", ".git", ".vscode", "planning")
    }
    
    # Format the directory name for display
    $formattedName = $dirName -replace '-', ' '
    $formattedName = (Get-Culture).TextInfo.ToTitleCase($formattedName)
    
    # Add context-specific descriptions
    $contextDescription = switch ($relativeDir) {
        "" { "This is the root directory of the 1000xbrain cognitive architecture, containing primary subsystems and core knowledge directories." }
        "knowledge" { "This directory contains specialized knowledge components for the 1000xbrain cognitive architecture." }
        "knowledge/rules" { "This directory contains rule-specific knowledge components organized by category." }
        "knowledge/rules/patterns" { "This directory contains implementation patterns for different domains and tools." }
        "knowledge/rules/reference" { "This directory contains reference documentation for the cognitive architecture." }
        "parameters" { "This directory contains project-rule-parameters organized by domain and mode." }
        "parameters/rules" { "This directory contains rules-specific parameters organized by mode." }
        "core" { "This directory contains core identity files and fundamental cognitive capabilities." }
        default { "This directory contains resources for the 1000xbrain cognitive architecture." }
    }
    
    # Generate content
    $content = @"
# $formattedName Index

## Overview

$contextDescription

"@
    
    # Add files section
    if ($mdFiles.Count -gt 0) {
        $content += @"

## Files

"@
        foreach ($file in $mdFiles | Sort-Object Name) {
            $fileName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
            $fileLink = $file.Name
            
            # Get file description from file if possible
            $desc = ""
            try {
                $fileContent = Get-Content -Path $file.FullName -Raw
                $titleMatch = [regex]::Match($fileContent, '^#\s+(.+?)(\r?\n|$)')
                if ($titleMatch.Success) {
                    $afterTitle = $fileContent.Substring($titleMatch.Index + $titleMatch.Length)
                    $paragraphMatch = [regex]::Match($afterTitle, '(?<=(\r?\n){1,2})[^#\r\n].+?(?=(\r?\n){2}|$)')
                    if ($paragraphMatch.Success) {
                        $desc = $paragraphMatch.Groups[0].Value.Trim()
                        if ($desc.Length > 100) { $desc = $desc.Substring(0, 97) + "..." }
                    }
                }
            } catch {
                # If extraction fails, use default
            }
            
            # If no description was found, use file name as fallback
            if ([string]::IsNullOrWhiteSpace($desc)) {
                $formattedFileName = $fileName -replace '-', ' '
                $formattedFileName = (Get-Culture).TextInfo.ToTitleCase($formattedFileName)
                $desc = "Documentation for $formattedFileName"
            }
            
            $content += @"
- [$fileName]($fileLink): $desc
"@
        }
    }
    
    # Add directories section
    if ($subdirs.Count -gt 0) {
        $content += @"

## Categories

"@
        foreach ($subdir in $subdirs | Sort-Object Name) {
            $subdirName = $subdir.Name -replace '-', ' '
            $subdirName = (Get-Culture).TextInfo.ToTitleCase($subdirName)
            
            # Check if this subdirectory has content
            $hasMdFiles = (Get-ChildItem -Path $subdir.FullName -File -Filter "*.md" | 
                Where-Object { $_.Name -ne "index.md" -and $_.Name -ne "README.md" }).Count -gt 0
            
            # Create a description for each subdirectory
            $subdirDesc = switch ($subdir.Name) {
                "core" { "Core identity and cognitive system files" }
                "knowledge" { "Knowledge base and specialized domains" }
                "parameters" { "Project-rule-parameters for different modes" }
                "workflows" { "Workflow definitions and guides" }
                "rules" { "Rules-specific components" }
                "patterns" { "Implementation patterns for different domains" }
                "reference" { "Reference documentation and architecture guides" }
                "guides" { "Process and implementation guides" }
                "pathways" { "Specialized organizational pathways" }
                "dev-mode" { "Developer Mode implementation parameters" }
                "plan-mode" { "Planning Mode implementation parameters" }
                "direct-mode" { "Direct Mode implementation parameters" }
                default { "Components for $subdirName" }
            }
            
            $content += @"
- [$subdirName]($($subdir.Name)): $subdirDesc
"@
        }
    }
    
    # Add knowledge access section
    $relativePath = $dirPath.Replace((Split-Path $PSScriptRoot -Parent), "").TrimStart("\")
    $relativePath = $relativePath.Replace("\", "/")
    
    $content += @"

## Knowledge Access

To access this directory via fetch_rules:

```typescript
fetch_rules(["$relativePath"], "Understanding $($formattedName.ToLower()) components and structure")
```
"@
    
    # Check if we need to create or update the file
    $needsUpdate = $true
    if (Test-Path $indexPath) {
        $existingContent = Get-Content -Path $indexPath -Raw
        if ($existingContent -eq $content) {
            Write-Host "  No changes needed" -ForegroundColor Gray
            $needsUpdate = $false
            $skipped++
        } else {
            $updated++
        }
    } else {
        $created++
    }
    
    # Create or update the file if needed
    if ($needsUpdate) {
        try {
            if (-not $DryRun) {
                Set-Content -Path $indexPath -Value $content
                if (Test-Path $indexPath) {
                    if ((Test-Path $indexPath -OlderThan (Get-Date).AddSeconds(-2))) {
                        Write-Host "  Updated index.md" -ForegroundColor Green
                    } else {
                        Write-Host "  Created index.md" -ForegroundColor Green
                    }
                } else {
                    Write-Host "  Failed to create index.md" -ForegroundColor Red
                }
            } else {
                if (Test-Path $indexPath) {
                    Write-Host "  Would update index.md" -ForegroundColor Yellow
                } else {
                    Write-Host "  Would create index.md" -ForegroundColor Yellow
                }
            }
        } catch {
            Write-Host "  Error: $_" -ForegroundColor Red
        }
    }
}

# Report stats
Write-Host ""
Write-Host "Smart Index Generation Complete"
Write-Host "------------------------------"
if ($DryRun) {
    Write-Host "Would create: $created" -ForegroundColor Yellow
    Write-Host "Would update: $updated" -ForegroundColor Yellow
    Write-Host "Would skip: $skipped" -ForegroundColor Yellow
} else {
    Write-Host "Created: $created" -ForegroundColor Green
    Write-Host "Updated: $updated" -ForegroundColor Green
    Write-Host "Skipped: $skipped" -ForegroundColor Gray
}
Write-Host "Total directories processed: $($keyDirectories.Count)" -ForegroundColor Cyan 