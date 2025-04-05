<#
.SYNOPSIS
    Generates or updates index.md files in the 1000xbrain directory.

.DESCRIPTION
    Creates or updates index.md files in the 1000xbrain directory to provide
    organized listings of files and subdirectories. Planning directories are skipped.

.PARAMETER TargetPath
    Path to process. Defaults to 1000xbrain directory.

.PARAMETER Recursive
    Process subdirectories recursively.

.PARAMETER DryRun
    Show what would change without making changes.

.PARAMETER SpecificDirectory
    Process only a specific directory.

.EXAMPLE
    .\Update-IndexFiles.ps1 -TargetPath "1000xbrain" -Recursive
#>

param(
    [string]$TargetPath = (Join-Path (Split-Path $PSScriptRoot -Parent) "1000xbrain"),
    [switch]$Recursive,
    [switch]$DryRun,
    [string]$SpecificDirectory
)

# Initialize tracking
$created = @()
$updated = @()
$skipped = @()
$errors = @()

# Banner
Write-Host "== Index.md Generator for 1000xbrain =="
Write-Host "Target: $TargetPath"
Write-Host "Recursive: $Recursive"
Write-Host "Dry Run: $DryRun"
if ($SpecificDirectory) { Write-Host "Specific Directory: $SpecificDirectory" }
Write-Host "========================================="

# Skip planning directories
function Test-IsPlanning {
    param([string]$path)
    return $path -match "(^|\\)planning(\\|$)"
}

# Generate index for a directory
function Update-IndexFile {
    param([string]$dir, [switch]$dryRun)
    
    # Skip planning directories
    if (Test-IsPlanning -path $dir) {
        Write-Host "Skipping planning directory: $dir" -ForegroundColor Yellow
        return
    }
    
    $indexPath = Join-Path $dir "index.md"
    $hasIndex = Test-Path $indexPath
    $dirName = Split-Path $dir -Leaf
    $formattedName = (Get-Culture).TextInfo.ToTitleCase(($dirName -replace '-', ' '))
    
    Write-Host "Processing: $dir" -ForegroundColor Cyan
    
    # Get files and directories
    $mdFiles = Get-ChildItem -Path $dir -File | Where-Object { 
        $_.Extension -eq ".md" -and $_.Name -ne "index.md" -and $_.Name -ne "README.md" 
    }
    
    $subdirs = Get-ChildItem -Path $dir -Directory | Where-Object {
        -not (Test-IsPlanning -path $_.FullName) -and 
        $_.Name -notin @(".cursor", "node_modules", ".git", ".vscode", "planning")
    }
    
    # Build content
    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.AppendLine("# $formattedName Index")
    [void]$sb.AppendLine("")
    [void]$sb.AppendLine("## Overview")
    [void]$sb.AppendLine("")
    [void]$sb.AppendLine("This directory contains the following resources for the 1000xbrain cognitive architecture.")
    [void]$sb.AppendLine("")
    
    # Add files section
    if ($mdFiles.Count -gt 0) {
        [void]$sb.AppendLine("## Files")
        [void]$sb.AppendLine("")
        
        foreach ($file in $mdFiles | Sort-Object Name) {
            $fileName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
            $fileLink = $file.Name
            
            # Get file description from content when possible
            $desc = ""
            try {
                $content = Get-Content -Path $file.FullName -Raw
                $titleMatch = [regex]::Match($content, '^#\s+(.+?)(\r?\n|$)')
                if ($titleMatch.Success) {
                    $afterTitle = $content.Substring($titleMatch.Index + $titleMatch.Length)
                    $descMatch = [regex]::Match($afterTitle, '(?<=(\r?\n){1,2})[^#\r\n].+?(?=(\r?\n){2}|$)')
                    if ($descMatch.Success) {
                        $desc = $descMatch.Groups[0].Value.Trim()
                        if ($desc.Length > 100) { $desc = $desc.Substring(0, 97) + "..." }
                    }
                }
                
                if ([string]::IsNullOrWhiteSpace($desc)) {
                    $desc = "Documentation for $formattedName"
                }
            }
            catch {
                $desc = "Documentation for $formattedName"
            }
            
            [void]$sb.AppendLine("- [$fileName]($fileLink): $desc")
        }
        
        [void]$sb.AppendLine("")
    }
    
    # Add subdirectories section
    if ($subdirs.Count -gt 0) {
        [void]$sb.AppendLine("## Categories")
        [void]$sb.AppendLine("")
        
        foreach ($subdir in $subdirs | Sort-Object Name) {
            $subdirName = (Get-Culture).TextInfo.ToTitleCase(($subdir.Name -replace '-', ' '))
            [void]$sb.AppendLine("### $subdirName")
            [void]$sb.AppendLine("")
            
            $subdirFiles = Get-ChildItem -Path $subdir.FullName -File | Where-Object { 
                $_.Extension -eq ".md" -and $_.Name -ne "index.md" -and $_.Name -ne "README.md" 
            }
            
            if ($subdirFiles.Count -gt 0) {
                foreach ($file in $subdirFiles | Sort-Object Name) {
                    $fileName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
                    $fileLink = Join-Path -Path $subdir.Name -ChildPath $file.Name
                    
                    # Basic description
                    $desc = "Documentation for $fileName"
                    [void]$sb.AppendLine("- [$fileName]($fileLink): $desc")
                }
            }
            else {
                [void]$sb.AppendLine("- No markdown files found in this category.")
            }
            
            [void]$sb.AppendLine("")
        }
    }
    
    # Add knowledge access section
    [void]$sb.AppendLine("## Knowledge Access")
    [void]$sb.AppendLine("")
    [void]$sb.AppendLine("To access this knowledge directory via fetch_rules:")
    [void]$sb.AppendLine("")
    [void]$sb.AppendLine("```typescript")
    $relativePath = $dir.Replace((Split-Path $PSScriptRoot -Parent), "").Trim("\").Replace("\", "/")
    [void]$sb.AppendLine("fetch_rules([`"$relativePath`"], `"Understanding $($formattedName.ToLower()) resources`")")
    [void]$sb.AppendLine("```")
    [void]$sb.AppendLine("")
    
    # Update or create file
    $newContent = $sb.ToString()
    
    try {
        if (-not $dryRun) {
            Set-Content -Path $indexPath -Value $newContent
            
            if ($hasIndex) {
                Write-Host "  Updated index.md" -ForegroundColor Green
                $script:updated += $indexPath
            }
            else {
                Write-Host "  Created index.md" -ForegroundColor Green
                $script:created += $indexPath
            }
        }
        else {
            if ($hasIndex) {
                Write-Host "  Would update index.md" -ForegroundColor Yellow
            }
            else {
                Write-Host "  Would create index.md" -ForegroundColor Yellow
            }
        }
    }
    catch {
        Write-Host "  Error: $_" -ForegroundColor Red
        $script:errors += "$indexPath`: $_"
    }
}

# Main execution
try {
    # Process specific directory if specified
    if ($SpecificDirectory) {
        $fullPath = $SpecificDirectory
        if (-not [System.IO.Path]::IsPathRooted($fullPath)) {
            $fullPath = Join-Path (Split-Path $PSScriptRoot -Parent) $SpecificDirectory
        }
        
        if (Test-Path $fullPath -PathType Container) {
            if (Test-IsPlanning -path $fullPath) {
                Write-Host "Warning: Explicitly processing planning directory (normally skipped)" -ForegroundColor Yellow
            }
            Update-IndexFile -dir $fullPath -dryRun:$DryRun
        }
        else {
            Write-Host "Directory not found: $fullPath" -ForegroundColor Red
            exit 1
        }
    }
    # Process target path
    else {
        if (-not (Test-Path $TargetPath -PathType Container)) {
            Write-Host "Target path not found: $TargetPath" -ForegroundColor Red
            exit 1
        }
        
        # Process root directory
        if (-not (Test-IsPlanning -path $TargetPath)) {
            Update-IndexFile -dir $TargetPath -dryRun:$DryRun
        }
        
        # Process subdirectories if recursive
        if ($Recursive) {
            $directories = Get-ChildItem -Path $TargetPath -Directory -Recurse | Where-Object {
                -not (Test-IsPlanning -path $_.FullName) -and
                $_.Name -notin @(".cursor", "node_modules", ".git", ".vscode", "planning")
            }
            
            foreach ($dir in $directories) {
                Update-IndexFile -dir $dir.FullName -dryRun:$DryRun
            }
        }
    }
    
    # Summary
    Write-Host ""
    Write-Host "Index File Update Complete!"
    Write-Host "=========================="
    if ($DryRun) { Write-Host "DRY RUN - No changes made" -ForegroundColor Yellow }
    Write-Host "Created: $($created.Count)" -ForegroundColor Green
    Write-Host "Updated: $($updated.Count)" -ForegroundColor Green
    Write-Host "Skipped: $($skipped.Count)" -ForegroundColor Gray
    Write-Host "Errors: $($errors.Count)" -ForegroundColor $(if ($errors.Count -gt 0) { "Red" } else { "Gray" })
    
    # Return results
    return @{
        CreatedCount = $created.Count
        UpdatedCount = $updated.Count
        SkippedCount = $skipped.Count
        ErrorCount = $errors.Count
    }
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
    exit 1
} 
