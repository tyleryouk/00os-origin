# Update-MdcRuleTypes.ps1
<#
.SYNOPSIS
    Updates rule types for all .mdc files in the .cursor/rules directory.

.DESCRIPTION
    This script analyzes all .mdc files and updates their rule types based on their
    existing frontmatter properties (description, globs, alwaysApply), ensuring
    that all files have the correct type field set.

.PARAMETER CursorRulesPath
    The path to the Cursor Rules directory.

.PARAMETER WhatIf
    If specified, the script will only show what would be changed without making actual changes.

.PARAMETER Force
    If specified, the script will not prompt for confirmation before making changes.

.EXAMPLE
    .\Update-MdcRuleTypes.ps1 -WhatIf

.EXAMPLE
    .\Update-MdcRuleTypes.ps1 -Force

.NOTES
    Author: 00reaper
    Version: 1.0
#>

param(
    [string]$CursorRulesPath = (Join-Path (Join-Path (Split-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) -Parent) ".cursor") "rules"),
    [switch]$WhatIf,
    [switch]$Force
)

# Import required module
$moduleFile = Join-Path $PSScriptRoot "CursorRules.psm1"
if (Test-Path $moduleFile) {
    Import-Module $moduleFile -Force
} else {
    Write-Error "Required module not found: $moduleFile"
    exit 1
}

# Display banner
Write-Host "==============================================="
Write-Host "Cursor Rules Type Updater"
Write-Host "==============================================="
Write-Host ""
Write-Host "Options:"
Write-Host "- Cursor Rules Path: $CursorRulesPath"
Write-Host "- Dry Run: $($WhatIf.ToString())"
Write-Host "==============================================="
Write-Host ""

# Check if we need to prompt for confirmation
if (-not $Force -and -not $WhatIf) {
    Write-Host "`nWARNING: This will directly update rule types in .mdc files." -ForegroundColor Yellow
    Write-Host "These files are typically edited through the Cursor Settings UI." -ForegroundColor Yellow
    $confirm = Read-Host "Are you sure you want to continue? (Y/N)"
    
    if ($confirm -ne "Y" -and $confirm -ne "y") {
        Write-Host "Update canceled." -ForegroundColor Yellow
        return
    }
}

# Get all .mdc files in the Cursor Rules directory
$mdcFiles = Get-ChildItem -Path $CursorRulesPath -Filter "*.mdc" -Recurse -File
Write-Host "Found $($mdcFiles.Count) .mdc files to process." -ForegroundColor Green

# Initialize tracking variables
$updatedFiles = @()
$unchangedFiles = @()
$errorFiles = @()

# Process each .mdc file
foreach ($mdcFile in $mdcFiles) {
    $mdcFilePath = $mdcFile.FullName
    Write-Host "Processing: $($mdcFile.Name)" -ForegroundColor Cyan
    
    try {
        # Read file content
        $content = Get-Content -Path $mdcFilePath -Raw
        
        # Extract frontmatter
        $frontmatterMatch = $content -match "(?sm)^---\r?\n(.*?)\r?\n---\r?\n"
        if (-not $frontmatterMatch) {
            Write-Host "  No frontmatter found in $($mdcFile.Name), skipping" -ForegroundColor Yellow
            $unchangedFiles += "No frontmatter found: $($mdcFile.Name)"
            continue
        }
        
        $frontmatterRaw = $matches[1] # Store original raw frontmatter
        $frontmatterHash = ConvertFrom-Frontmatter -Frontmatter $frontmatterRaw
        
        # Check if type is already set
        # $originalType = $frontmatterHash["type"] # No longer needed for comparison here
        
        # Determine the correct rule type based on PATH first
        $forceAlways = $false
        $relativeMdcPath = $mdcFilePath.Replace($CursorRulesPath, "").TrimStart("\", "/")
        $relativePathNormalized = $relativeMdcPath -replace '\\', '/' # Normalize separators - Corrected regex
        
        # Check if path forces 'always'
        if ($relativePathNormalized -match "^core/" -or `
            $relativePathNormalized -match "^config/" -or `
            (-not ($relativePathNormalized -match "/"))) { # Check if it's in the root
            
            $forceAlways = $true
        }
        
        # Determine the final target type
        $newType = $null
        if ($forceAlways) {
            $newType = "always"
            Write-Host "  Rule type forced to 'always' based on path: $relativeMdcPath" -ForegroundColor Magenta
        } 
        # NEW: Check if path is processes/
        elseif ($relativePathNormalized -match "^processes/") {
            $newType = "agent"
            Write-Host "  Rule type forced to 'agent' based on path: $relativeMdcPath" -ForegroundColor Cyan
            
            # Ensure description exists and follows USE WHEN format if empty
            if (-not $frontmatterHash.ContainsKey("description") -or [string]::IsNullOrWhiteSpace($frontmatterHash["description"])) {
                $fileNameOnly = $mdcFile.BaseName # Get filename without extension
                $newDescription = "USE WHEN you want to execute $fileNameOnly"
                $frontmatterHash["description"] = $newDescription
                Write-Host "  Populating empty description with: $newDescription" -ForegroundColor Yellow
            }
        }
        
        # Always set the final calculated type in the hash
        $frontmatterHash["type"] = $newType

        # Re-generate the frontmatter string using the potentially updated hash
        $newFrontmatterString = ConvertTo-Frontmatter -FrontmatterHash $frontmatterHash

        # Compare the NEW frontmatter string with the ORIGINAL raw frontmatter string
        if ($newFrontmatterString -eq $frontmatterRaw) {
            Write-Host "  Frontmatter is already correct." -ForegroundColor Gray
            $unchangedFiles += "Frontmatter already correct: $($mdcFile.Name)"
            continue
        }
        
        # If frontmatter differs, construct new content and update file
        Write-Host "  Frontmatter requires update." -ForegroundColor Yellow

        # Replace frontmatter in the content
        $newContent = $content -replace "(?sm)^---\r?\n.*?\r?\n---\r?\n", "---`n$newFrontmatterString`n---`n"
        
        # Update the file
        if (-not $WhatIf) {
            Set-Content -Path $mdcFilePath -Value $newContent -NoNewline
            Write-Host "  Updated frontmatter in $($mdcFile.Name)" -ForegroundColor Green
        } else {
            Write-Host "  Would update frontmatter in $($mdcFile.Name)" -ForegroundColor Yellow
        }
        
        $updatedFiles += "Updated frontmatter: $($mdcFile.Name)" # Log update
    } 
    catch {
        Write-Host "  Error processing file: $_" -ForegroundColor Red
        $errorFiles += "Error processing $($mdcFile.Name): $_"
    }
}

# Generate summary
Write-Host ""
Write-Host "Rule Type Update Complete!"
Write-Host "=========================="
Write-Host "Total files processed: $($mdcFiles.Count)"
Write-Host "Files updated: $($updatedFiles.Count)" -ForegroundColor $(if ($updatedFiles.Count -gt 0) { "Green" } else { "Gray" })
Write-Host "Files unchanged: $($unchangedFiles.Count)" -ForegroundColor Gray
Write-Host "Errors: $($errorFiles.Count)" -ForegroundColor $(if ($errorFiles.Count -gt 0) { "Red" } else { "Gray" })

# Display detailed list of updated files if any
if ($updatedFiles.Count -gt 0) {
    Write-Host ""
    Write-Host "Updated Files:" -ForegroundColor Cyan
    foreach ($file in $updatedFiles) {
        Write-Host "- $file" -ForegroundColor Green
    }
}

# Display errors if any
if ($errorFiles.Count -gt 0) {
    Write-Host ""
    Write-Host "Errors:" -ForegroundColor Red
    foreach ($error in $errorFiles) {
        Write-Host "- $error" -ForegroundColor Red
    }
}

# Return results object
return @{
    ProcessedCount = $mdcFiles.Count
    UpdatedCount = $updatedFiles.Count
    UnchangedCount = $unchangedFiles.Count
    ErrorCount = $errorFiles.Count
    UpdatedFiles = $updatedFiles
    ErrorFiles = $errorFiles
} 