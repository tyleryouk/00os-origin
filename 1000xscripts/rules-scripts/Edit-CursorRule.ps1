<#
.SYNOPSIS
    Edits Cursor Project Rule files (.mdc) using Visual Studio Code.

.DESCRIPTION
    This script allows you to edit Cursor Project Rule files (.mdc) using Visual Studio Code.
    It works similarly to Ben Gribaudo's Edit-DataMashup function for Power Query files.
    
    The script:
    1. Creates a backup of the .mdc file
    2. Opens a temporary copy in VS Code
    3. When you save and close the file in VS Code, updates the original .mdc file
    
    This provides a way to edit .mdc files with full VS Code capabilities while
    preserving their functionality as Cursor Project Rules.

.PARAMETER FilePath
    The path to the .mdc file to edit.

.PARAMETER SkipBackup
    If specified, the script will not create a backup of the file before modifying it.

.EXAMPLE
    .\Edit-CursorRule.ps1 -FilePath ".cursor/rules/core/identity/global-rules.mdc"

.NOTES
    Author: 1000xdev
    Version: 1.0
    Requirements: Visual Studio Code must be installed and accessible in the system PATH.
    Based on the Edit-DataMashup function by Ben Gribaudo.
#>

param(
    [Parameter(Mandatory=$True, Position=0)]
    [string]$FilePath,
    
    [switch]$SkipBackup
)

# Function to create a backup of a file
function Backup-File {
    param([string]$filePath)
    
    try {
        $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
        $backupPath = "$filePath.backup-$timestamp"
        Copy-Item -Path $filePath -Destination $backupPath -Force
        return $backupPath
    }
    catch {
        Write-Error "Failed to backup $filePath. Error: $_"
        return $null
    }
}

# Function to extract frontmatter from a file
function Get-Frontmatter {
    param([string]$filePath)
    
    $content = Get-Content -Path $filePath -Raw
    
    if ($content -match "(?s)^---\s*\r?\n(.*?)\r?\n---\s*\r?\n") {
        return $Matches[1]
    }
    
    return ""
}

# Function to extract content without frontmatter
function Get-ContentWithoutFrontmatter {
    param([string]$filePath)
    
    $content = Get-Content -Path $filePath -Raw
    
    # Remove frontmatter if it exists
    if ($content -match "(?s)^---\s*\r?\n(.*?)\r?\n---\s*\r?\n") {
        $content = $content -replace "(?s)^---\s*\r?\n.*?\r?\n---\s*\r?\n", ""
    }
    
    return $content.Trim()
}

# Ensure the file exists
if (-not (Test-Path $FilePath)) {
    Write-Error "File not found: $FilePath"
    exit 1
}

# Create a backup unless skipped
$backupPath = $null
if (-not $SkipBackup) {
    $backupPath = Backup-File -filePath $FilePath
    if (-not $backupPath) {
        Write-Error "Failed to create backup of $FilePath"
        exit 1
    }
    
    Write-Host "Backed up to: $backupPath" -ForegroundColor Cyan
}

# Create a temporary file
$tempFile = New-TemporaryFile

$successful = $false

try {
    # Rename temp file to .md extension for proper syntax highlighting in VS Code
    $tempFile = Rename-Item $tempFile ($tempFile.Name + ".md") -PassThru -ErrorAction Stop
    
    # Get the original content
    $originalContent = Get-Content $FilePath -Raw -ErrorAction Stop
    
    # Copy content to temp file
    $originalContent | Out-File $tempFile -NoNewline -ErrorAction Stop
    
    # Try different ways to open VS Code
    $vsCodeOpened = $false
    
    # Try with 'code' command
    try {
        Start-Process "code" "-w `"$($tempFile.FullName)`"" -Wait -ErrorAction Stop
        $vsCodeOpened = $true
    } catch {
        Write-Host "Trying alternative VS Code command..." -ForegroundColor Yellow
    }
    
    # Try with 'code.exe' if the first attempt failed
    if (-not $vsCodeOpened) {
        try {
            Start-Process "code.exe" "-w `"$($tempFile.FullName)`"" -Wait -ErrorAction Stop
            $vsCodeOpened = $true
        } catch {
            Write-Host "Trying another alternative VS Code command..." -ForegroundColor Yellow
        }
    }
    
    # Try with 'code.cmd' if both previous attempts failed
    if (-not $vsCodeOpened) {
        try {
            Start-Process "code.cmd" "-w `"$($tempFile.FullName)`"" -Wait -ErrorAction Stop
            $vsCodeOpened = $true
        } catch {
            Write-Error "Failed to open VS Code. Ensure it's installed and in your PATH."
            exit 1
        }
    }
    
    # Read edited content
    $editedContent = Get-Content $tempFile -Raw -ErrorAction Stop
    
    # Check if content was actually changed
    if ($originalContent -eq $editedContent) { 
        Write-Host "No changes were made to the file." -ForegroundColor Yellow
        $successful = $true
        exit 0
    }
    
    # Save edited content back to original file
    Set-Content -Path $FilePath -Value $editedContent -Force
    Write-Host "Successfully updated: $FilePath" -ForegroundColor Green
    $successful = $true
}
catch {
    Write-Error "Failed to edit $FilePath. Error: $_"
    
    # If we have a backup and the operation failed, offer to restore
    if ($backupPath -and (Test-Path $backupPath)) {
        $restore = Read-Host "Do you want to restore from backup? (Y/N)"
        if ($restore -eq "Y" -or $restore -eq "y") {
            try {
                Copy-Item -Path $backupPath -Destination $FilePath -Force
                Write-Host "Successfully restored from backup." -ForegroundColor Green
            }
            catch {
                Write-Error "Failed to restore from backup. Error: $_"
            }
        }
    }
}
finally {
    # Clean up temp file
    if (Test-Path $tempFile) {
        Remove-Item $tempFile -Force
    }
    
    # If not successful and no explicit error was shown, show the edited content
    if (-not $successful) {
        Write-Error "Failed to update $FilePath with edited content. Original file remains unchanged."
        if ($editedContent) {
            Write-Host "Your edited content:`n$editedContent" -ForegroundColor Yellow
        }
    }
}

# Create a wrapper function for module usage
function Edit-CursorRule {
    <#
    .SYNOPSIS
        Edits a single Cursor Project Rule file with VS Code.
    
    .DESCRIPTION
        This function allows you to edit a Cursor Project Rule file (.mdc) using VS Code.
        When you save and close the file in VS Code, the changes will be applied to the .mdc file.
    
    .PARAMETER FilePath
        The path to the .mdc file to edit.
    
    .PARAMETER SkipBackup
        If specified, the function will not create a backup of the file before modifying it.
    
    .EXAMPLE
        Edit-CursorRule -FilePath ".cursor/rules/core/identity/global-rules.mdc"
    
    .NOTES
        Requires VS Code to be installed and in the system PATH.
    #>
    
    param (
        [Parameter(Mandatory=$True, Position=0)]
        [string]$FilePath,
        
        [switch]$SkipBackup
    )
    
    & $PSCommandPath -FilePath $FilePath -SkipBackup:$SkipBackup
}

Export-ModuleMember -Function Edit-CursorRule 