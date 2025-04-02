# Update-RuleTypeDropdown.ps1
<#
.SYNOPSIS
    Updates the Rule Type dropdown setting in Cursor Rules.

.DESCRIPTION
    This script updates the Rule Type dropdown setting in Cursor Rules to match
    the frontmatter configuration. It specifically handles the conversion between
    Manual/Always settings in the UI.

.PARAMETER FilePath
    The path to the specific .mdc file to update.

.PARAMETER RuleType
    The desired Rule Type setting ("Manual" or "Always").

.PARAMETER Force
    If specified, the script will not prompt for confirmation before making changes.

.EXAMPLE
    .\Update-RuleTypeDropdown.ps1 -FilePath ".cursor/rules/core/identity/cognitive-principles.mdc" -RuleType "Always"

.NOTES
    Author: 1000xdev
    Version: 1.0
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$FilePath,
    
    [Parameter(Mandatory=$true)]
    [ValidateSet("Manual", "Always")]
    [string]$RuleType,
    
    [switch]$Force
)

# Verify the file exists
if (-not (Test-Path $FilePath)) {
    Write-Error "File not found: $FilePath"
    exit 1
}

# Read the file content
$content = Get-Content -Path $FilePath -Raw

# Extract frontmatter
if ($content -match '(?s)^---\s*\r?\n(.*?)\r?\n---') {
    $frontmatter = $Matches[1]
    $remainingContent = $content -replace '(?s)^---\s*\r?\n.*?\r?\n---', ''
    
    # Parse frontmatter into a hashtable
    $frontmatterHash = @{}
    $frontmatter -split '\r?\n' | ForEach-Object {
        if ($_ -match '^(\w+):\s*(.*)$') {
            $frontmatterHash[$Matches[1]] = $Matches[2]
        }
    }
    
    # Update type and alwaysApply based on Rule Type
    if ($RuleType -eq "Always") {
        $frontmatterHash["type"] = "auto"
        $frontmatterHash["alwaysApply"] = "True"
    } else {
        $frontmatterHash["type"] = "manual"
        $frontmatterHash["alwaysApply"] = "False"
    }
    
    # Convert frontmatter back to YAML
    $newFrontmatter = ($frontmatterHash.GetEnumerator() | ForEach-Object {
        "$($_.Key): $($_.Value)"
    }) -join "`n"
    
    # Create updated content
    $newContent = @"
---
$newFrontmatter
---
$remainingContent
"@
    
    # Confirm changes if not forced
    if (-not $Force) {
        Write-Host "About to update Rule Type to '$RuleType' in file: $FilePath"
        Write-Host "This will set:"
        Write-Host "  type: $($frontmatterHash["type"])"
        Write-Host "  alwaysApply: $($frontmatterHash["alwaysApply"])"
        $confirmation = Read-Host "Do you want to continue? (Y/N)"
        if ($confirmation -ne "Y" -and $confirmation -ne "y") {
            Write-Host "Operation cancelled."
            exit
        }
    }
    
    # Apply the change
    Set-Content -Path $FilePath -Value $newContent -NoNewline
    Write-Host "Successfully updated Rule Type to '$RuleType' in: $FilePath" -ForegroundColor Green
} else {
    Write-Error "Could not find frontmatter in file: $FilePath"
    exit 1
} 