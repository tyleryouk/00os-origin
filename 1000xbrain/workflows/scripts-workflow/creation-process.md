---
description: Process for creating new scripts within the scripts-workflow
globs: 1000xscripts/**
alwaysApply: false
type: auto
---

# Script Creation Process

## File Purpose and Relationship

This file defines the structured process for creating new scripts within the 1000xscripts directory. It provides detailed guidelines, standards, and best practices for script development. This file should be consulted when:

- Creating new automation scripts
- Understanding script structure requirements
- Following proper documentation standards
- Implementing error handling and logging
- Testing new script functionality

This file complements:
- **workflows/scripts-workflow/scripts-workflow.md**: Core workflow definition
- **workflows/scripts-workflow/enhancement-process.md**: Guidelines for enhancing existing scripts
- **workflows/scripts-workflow/synchronization-guide.md**: Synchronization verification standards

## 1. Script Creation Preparation

Before creating a new script, the following preparation steps should be taken:

### 1.1 Need Assessment

1. **Problem Identification**:
   - Clearly define the problem the script will solve
   - Identify the specific tasks it will automate
   - Determine if an existing script could be enhanced instead

2. **Scope Definition**:
   - Define the exact scope of functionality
   - Determine what the script will and won't do
   - Establish clear boundaries for the script's responsibilities

3. **Integration Planning**:
   - Identify how the script will integrate with existing scripts
   - Determine dependencies and relationships
   - Plan for any shared functionality

### 1.2 Requirements Gathering

1. **Functional Requirements**:
   - Define required inputs and expected outputs
   - Identify required parameters and their types
   - Determine error handling requirements
   - Specify logging needs

2. **Performance Requirements**:
   - Establish performance expectations
   - Identify any time-critical operations
   - Consider resource usage constraints

3. **Compatibility Requirements**:
   - Ensure compatibility with PowerShell versions
   - Check compatibility with existing scripts
   - Verify system requirements

## 2. Script Structure Standards

All new scripts must adhere to these structural standards:

### 2.1 Header Section

Every script must begin with a standardized header section:

```powershell
<#
.SYNOPSIS
    Brief description of the script's purpose.

.DESCRIPTION
    Detailed description of what the script does, its functionality,
    and how it contributes to the cognitive architecture.

.PARAMETER ParameterName
    Description of each parameter, including its purpose, type, and any default values.

.EXAMPLE
    .\Script-Name.ps1 -Parameter Value
    Description of what this example does.

.NOTES
    File Name      : Script-Name.ps1
    Author         : 1000xdev
    Prerequisite   : PowerShell 5.1 or later
    Created Date   : YYYY-MM-DD
#>
```

### 2.2 Parameters Section

Parameters should be defined using the `param()` block:

```powershell
param(
    [Parameter(Mandatory=$true, HelpMessage="Description of the parameter")]
    [ValidateNotNullOrEmpty()]
    [string]$RequiredParameter,
    
    [Parameter(Mandatory=$false)]
    [switch]$DryRun = $false,
    
    [Parameter(Mandatory=$false)]
    [switch]$Force = $false
)
```

### 2.3 Script Structure

The script body should follow this structure:

1. **Function Definitions**: Define all functions at the top of the script
2. **Configuration Variables**: Define configuration variables
3. **Main Script Logic**: Implement the main script logic
4. **Error Handling**: Include appropriate error handling
5. **Cleanup**: Perform any necessary cleanup operations

## 3. Script Implementation Guidelines

### 3.1 Coding Standards

1. **Naming Conventions**:
   - Use Pascal Case for function and script names (e.g., `Get-FileContent`)
   - Use camel case for variable names (e.g., `$fileContent`)
   - Use descriptive names that clearly indicate purpose

2. **Formatting**:
   - Use consistent indentation (4 spaces recommended)
   - Include blank lines between logical sections
   - Limit line length to 100 characters where possible

3. **Comments**:
   - Include comments for complex logic
   - Document any non-obvious code
   - Explain the purpose of major code blocks

### 3.2 Error Handling

All scripts must implement robust error handling:

1. **Try-Catch Blocks**:
   ```powershell
   try {
       # Code that might generate an error
   }
   catch {
       Write-Error "An error occurred: $_"
       # Handle the error appropriately
   }
   finally {
       # Cleanup operations
   }
   ```

2. **DryRun Parameter**:
   - All scripts that modify files must include a `-DryRun` parameter
   - When `-DryRun` is specified, the script should show what would happen without making changes

3. **Force Parameter**:
   - Include a `-Force` parameter for operations that should normally prompt for confirmation
   - Use `-Force` to skip confirmation prompts when scripting automation

### 3.3 Logging

Implement appropriate logging in all scripts:

1. **Console Output**:
   - Use `Write-Host` for informational messages with appropriate colors
   - Use `Write-Warning` for warning messages
   - Use `Write-Error` for error messages

2. **File Logging**:
   - Implement file logging for important operations
   - Include timestamps in log entries
   - Log both errors and successful operations

3. **Verbosity Levels**:
   - Support different verbosity levels when appropriate
   - Allow control of output detail through parameters

## 4. Documentation Requirements

### 4.1 In-Script Documentation

1. **Comment-Based Help**:
   - Include comprehensive comment-based help at the top of the script
   - Document all parameters thoroughly
   - Provide usage examples

2. **Function Documentation**:
   - Document each function with comment-based help
   - Explain parameters, return values, and purpose

3. **Code Comments**:
   - Include comments for complex logic
   - Document any non-obvious implementations
   - Explain the purpose of major code blocks

### 4.2 External Documentation

1. **README Updates**:
   - Update the 1000xscripts README.md to include the new script
   - Document the purpose and basic usage

2. **SCRIPTS-SUMMARY.md Updates**:
   - Add the script to the appropriate section in SCRIPTS-SUMMARY.md
   - Include a brief description and common usage patterns

## 5. Testing Procedures

### 5.1 Basic Testing

1. **Syntax Validation**:
   - Verify script runs without syntax errors
   - Check for PowerShell best practices with PSScriptAnalyzer

2. **Functionality Testing**:
   - Test with various parameter combinations
   - Verify outputs match expectations
   - Test with invalid inputs to verify error handling

3. **DryRun Testing**:
   - Test with `-DryRun` parameter
   - Verify output correctly shows what would happen
   - Confirm no changes are made in DryRun mode

### 5.2 Integration Testing

1. **Dependency Testing**:
   - Test with any dependent scripts
   - Verify proper integration with existing scripts
   - Check for any conflicts or issues

2. **Environment Testing**:
   - Test in different environments if relevant
   - Verify compatibility with target PowerShell versions
   - Check for any environment-specific issues

### 5.3 Edge Case Testing

1. **Error Condition Testing**:
   - Test with invalid inputs
   - Simulate error conditions
   - Verify error handling works as expected

2. **Performance Testing**:
   - Test with large data sets if applicable
   - Verify performance meets expectations
   - Identify any performance bottlenecks

## 6. Script Creation Process Steps

The complete script creation process follows these steps:

### 6.1 Planning Phase

1. Complete need assessment and requirements gathering
2. Design the script structure and functionality
3. Create a planning folder with detailed requirements
4. Design a testing plan for verification

### 6.2 Implementation Phase

1. Create the script following the structure standards
2. Implement required functionality and error handling
3. Add comprehensive documentation
4. Implement logging as needed

### 6.3 Testing Phase

1. Perform basic testing to verify functionality
2. Test error handling with various inputs
3. Verify integration with existing scripts
4. Document test results

### 6.4 Integration Phase

1. Add the script to the appropriate directory
2. Update documentation to reference the new script
3. Verify compatibility with existing scripts
4. Document any integration considerations

## 7. Directory Placement Guidelines

New scripts should be placed in the appropriate directory based on their purpose:

1. **frontmatter-scripts/**: Scripts related to frontmatter management
2. **rules-scripts/**: Scripts for Cursor Rules management
3. **maintenance-scripts/**: Scripts for system maintenance
4. **report-scripts/**: Scripts that generate reports
5. **utility-scripts/**: General utility scripts

Scripts that orchestrate multiple operations across categories may be placed in the root directory.

## 8. Example Script Template

```powershell
<#
.SYNOPSIS
    Brief description of the script's purpose.

.DESCRIPTION
    Detailed description of what the script does, its functionality,
    and how it contributes to the cognitive architecture.

.PARAMETER Path
    The path to process.

.PARAMETER DryRun
    If specified, shows what would happen without making changes.

.PARAMETER Force
    If specified, performs operations without confirmation prompts.

.EXAMPLE
    .\Script-Name.ps1 -Path "C:\Path" -DryRun
    Shows what changes would be made without actually making them.

.NOTES
    File Name      : Script-Name.ps1
    Author         : 1000xdev
    Prerequisite   : PowerShell 5.1 or later
    Created Date   : YYYY-MM-DD
#>

param(
    [Parameter(Mandatory=$true, HelpMessage="The path to process")]
    [ValidateNotNullOrEmpty()]
    [string]$Path,
    
    [Parameter(Mandatory=$false)]
    [switch]$DryRun = $false,
    
    [Parameter(Mandatory=$false)]
    [switch]$Force = $false
)

# Function definitions
function Get-Something {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    
    try {
        # Function logic
    }
    catch {
        Write-Error "An error occurred in Get-Something: $_"
        throw
    }
}

# Configuration variables
$logFile = "$(Get-Date -Format 'yyyy-MM-dd-HHmmss').log"
$isModified = $false

# Begin main script execution
Write-Host "Starting script execution..." -ForegroundColor Cyan

try {
    # Check if path exists
    if (-not (Test-Path -Path $Path)) {
        throw "The specified path does not exist: $Path"
    }
    
    # Main script logic
    Write-Host "Processing $Path..." -ForegroundColor Green
    
    if ($DryRun) {
        Write-Host "DryRun mode: Would process files in $Path" -ForegroundColor Yellow
        # Show what would happen without making changes
    }
    else {
        # Confirm action unless Force is specified
        if (-not $Force) {
            $confirmation = Read-Host "Are you sure you want to proceed? (Y/N)"
            if ($confirmation -ne "Y") {
                Write-Host "Operation cancelled by user." -ForegroundColor Yellow
                exit
            }
        }
        
        # Perform actual operations
        Write-Host "Performing operations..." -ForegroundColor Green
        $isModified = $true
    }
}
catch {
    Write-Error "An error occurred during script execution: $_"
    exit 1
}
finally {
    # Cleanup operations
    if ($isModified) {
        Write-Host "Operations completed successfully." -ForegroundColor Green
    }
    else {
        if ($DryRun) {
            Write-Host "DryRun completed. No changes were made." -ForegroundColor Yellow
        }
        else {
            Write-Host "No changes were made." -ForegroundColor Yellow
        }
    }
}
```

## Success Criteria

A new script is considered successfully created when:

1. It follows all structural and coding standards
2. It includes comprehensive documentation
3. It implements proper error handling and logging
4. It has been thoroughly tested
5. It has been integrated with the appropriate directory
6. Documentation has been updated to reference it 

