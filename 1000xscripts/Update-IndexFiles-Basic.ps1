<#
.SYNOPSIS
    Basic script to generate index.md files for 1000xbrain directories.
#>

param(
    [string]$TargetPath = "1000xbrain",
    [switch]$Recursive
)

# Convert relative path to absolute if needed
if (-not [System.IO.Path]::IsPathRooted($TargetPath)) {
    $TargetPath = Join-Path (Split-Path $PSScriptRoot -Parent) $TargetPath
}

Write-Host "Generating index.md files for $TargetPath"
if ($Recursive) { Write-Host "Processing recursively" }

# Get directories to process
$directories = @()
if ($Recursive) {
    $directories = Get-ChildItem -Path $TargetPath -Directory -Recurse |
                   Where-Object { $_.Name -notin @(".cursor", "node_modules", ".git", ".vscode", "planning") }
} else {
    $directories = Get-ChildItem -Path $TargetPath -Directory |
                   Where-Object { $_.Name -notin @(".cursor", "node_modules", ".git", ".vscode", "planning") }
}

# Add the target directory itself
$directories = @([PSCustomObject]@{FullName = $TargetPath}) + $directories

# Track stats
$created = 0
$updated = 0
$skipped = 0

foreach ($dir in $directories) {
    $dirPath = $dir.FullName
    $indexPath = Join-Path $dirPath "index.md"
    $dirName = Split-Path $dirPath -Leaf
    
    # Skip planning directories
    if ($dirPath -match "(^|\\)planning(\\|$)") {
        Write-Host "Skipping planning directory: $dirPath" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "Processing: $dirPath" -ForegroundColor Cyan
    
    # Get markdown files in this directory
    $mdFiles = Get-ChildItem -Path $dirPath -File | Where-Object { 
        $_.Extension -eq ".md" -and $_.Name -ne "index.md" -and $_.Name -ne "README.md" 
    }
    
    # Get subdirectories
    $subdirs = Get-ChildItem -Path $dirPath -Directory | Where-Object {
        $_.Name -notin @(".cursor", "node_modules", ".git", ".vscode", "planning") -and
        $_.FullName -notmatch "(^|\\)planning(\\|$)"
    }
    
    # Format the directory name for display
    $formattedName = $dirName -replace '-', ' '
    $formattedName = (Get-Culture).TextInfo.ToTitleCase($formattedName)
    
    # Generate content
    $content = @"
# $formattedName Index

## Overview

This directory contains the following resources for the 1000xbrain cognitive architecture.

"@

    # Add files section
    if ($mdFiles.Count -gt 0) {
        $content += @"

## Files

"@
        foreach ($file in $mdFiles | Sort-Object Name) {
            $fileName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
            $fileLink = $file.Name
            $desc = "Documentation for $fileName"
            
            $content += @"
- [$fileName]($fileLink): $desc
"@
        }
    }
    
    # Add subdirectories section
    if ($subdirs.Count -gt 0) {
        $content += @"

## Categories

"@
        foreach ($subdir in $subdirs | Sort-Object Name) {
            $subdirName = $subdir.Name -replace '-', ' '
            $subdirName = (Get-Culture).TextInfo.ToTitleCase($subdirName)
            
            $content += @"

### $subdirName

"@
            $subdirFiles = Get-ChildItem -Path $subdir.FullName -File | Where-Object { 
                $_.Extension -eq ".md" -and $_.Name -ne "index.md" -and $_.Name -ne "README.md" 
            }
            
            if ($subdirFiles.Count -gt 0) {
                foreach ($file in $subdirFiles | Sort-Object Name) {
                    $fileName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
                    $fileLink = Join-Path -Path $subdir.Name -ChildPath $file.Name
                    $desc = "Documentation for $fileName"
                    
                    $content += @"
- [$fileName]($fileLink): $desc
"@
                }
            } else {
                $content += @"
- No markdown files found in this category.
"@
            }
        }
    }
    
    # Add knowledge access section
    $relativePath = $dirPath.Replace((Split-Path $PSScriptRoot -Parent), "").TrimStart("\")
    $relativePath = $relativePath.Replace("\", "/")
    
    $content += @"

## Knowledge Access

To access this knowledge directory via fetch_rules:

```typescript
fetch_rules(["$relativePath"], "Understanding $($formattedName.ToLower()) resources")
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
            Set-Content -Path $indexPath -Value $content
            if (Test-Path $indexPath) {
                Write-Host "  Created/Updated index.md" -ForegroundColor Green
            } else {
                Write-Host "  Failed to create index.md" -ForegroundColor Red
            }
        } catch {
            Write-Host "  Error: $_" -ForegroundColor Red
        }
    }
}

# Report stats
Write-Host ""
Write-Host "Index Generation Complete"
Write-Host "------------------------"
Write-Host "Created: $created" -ForegroundColor Green
Write-Host "Updated: $updated" -ForegroundColor Green
Write-Host "Skipped: $skipped" -ForegroundColor Gray
Write-Host "Total: $($created + $updated + $skipped)" -ForegroundColor Cyan 