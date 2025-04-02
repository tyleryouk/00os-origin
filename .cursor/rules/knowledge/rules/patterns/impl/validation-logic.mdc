# USE WHEN implementing validation logic, designing validation criteria, or enhancing reference checking

# Validation Logic Patterns

## Overview
This document provides implementation patterns for the validation logic used to verify project-rule-parameter references and structural requirements in the 1000xbrain cognitive architecture.

## Key Concepts
- **Validation Rules**: Specific criteria that define correct reference formats
- **Detection Logic**: Regex patterns and checks used to identify issues
- **Reporting Logic**: Methods to communicate validation results
- **Validation Scopes**: Different aspects of the system that require validation

## Validation Categories

### 1. Reference Validation

Reference validation focuses on project-rule-parameter references:

1. **Extension Correctness**: 
   - All project-rule-parameter references must use `.mdc` extension
   - Regex pattern: `@([a-zA-Z0-9_\-/]+)\.mdc`
   - Error for: `@([a-zA-Z0-9_\-/]+)\.md\b`

2. **File Existence**: 
   - Referenced files must actually exist in the .cursor/rules directory
   - Check: `Test-Path $fullPath`

3. **Path Validity**: 
   - References must use correct path format
   - Standard format: `@parameters/rules/filename.mdc`

### 2. Documentation Structure Validation

Documentation structure validation focuses on required elements:

1. **README.md Existence**:
   - Every directory should have a README.md file
   - Check: `Test-Path $readmePath`

2. **USE WHEN Headers**:
   - All knowledge files must begin with a USE WHEN header
   - Check first line: `$firstLine -like "# USE WHEN*"`

3. **README.md Access Before Modification**:
   - Files should only be modified after checking README.md
   - Compare timestamps: `$readmeLastAccessed -lt $file.LastWriteTime.AddHours(-1)`

### 3. Header Format Validation

Header format validation ensures consistent documentation:

1. **Planning Header Format**:
   - Format: `# workflow-type | pathway-type`
   - Regex pattern: `^# ([a-z-]+) \| ([a-z-]+)$`

2. **Workflow Type Match**:
   - Workflow type must match the implementing workflow
   - Common confusion: Using pathway target as workflow type

## Implementation Patterns

### Pattern 1: Structured Validation Checks

Organize validation logic into structured, purpose-specific functions:

```powershell
# Validation logic for specific check type
function Validate-SpecificRequirement {
    param (
        [string]$target,
        [hashtable]$options
    )
    
    # 1. Define validation criteria
    $criteria = @{
        Pattern = $options.Pattern
        ErrorMessage = $options.ErrorMessage
        SeverityLevel = $options.SeverityLevel
    }
    
    # 2. Perform validation check
    $isValid = Test-ValidationCriteria $target $criteria
    
    # 3. Report validation results
    if (-not $isValid) {
        Report-ValidationFailure $target $criteria
        return $false
    }
    
    return $true
}
```

### Pattern 2: Layered Validation Approach

Implement validation in layers, from basic to advanced checks:

1. **Basic Validation Layer**:
   - Simple existence and format checks
   - Fast execution for frequent validation

2. **Structure Validation Layer**:
   - Directory structure and file organization checks
   - Medium frequency validation

3. **Content Validation Layer**:
   - Detailed content analysis and cross-referencing
   - Less frequent, more resource-intensive validation

### Pattern 3: Reporting Hierarchy

Use a hierarchical reporting approach for validation issues:

1. **Error**: Critical issues that must be fixed
   - Format: `Write-Error "ERROR in [file]: [specific issue details]"`
   - Example: `ERROR in file.md: Incorrect extension in @parameter.md (should be .mdc)`

2. **Warning**: Important issues that should be addressed
   - Format: `Write-Warning "WARNING: [issue description] in [file]"`
   - Example: `WARNING: Missing README.md in directory: /path/to/dir`

3. **Information**: Helpful notes about potential improvements
   - Format: `Write-Host "INFO: [suggestion] in [file]"`
   - Example: `INFO: Consider adding examples section in file.md`

## Implementation Examples

### Reference Validation Implementation

```powershell
function Validate-ProjectRuleParameters {
    param (
        [string]$ContentRootPath,
        [string]$RulesRootPath,
        [switch]$IncludeWarnings
    )
    
    $files = Get-ChildItem $ContentRootPath -Filter "*.md" -Recurse
    $issues = @{
        Errors = @()
        Warnings = @()
        Info = @()
    }
    
    foreach ($file in $files) {
        $content = Get-Content $file.FullName -Raw
        
        # Check for correct extension (.mdc)
        $incorrectExtensions = [regex]::Matches($content, '@([a-zA-Z0-9_\-/]+)\.md\b')
        foreach ($match in $incorrectExtensions) {
            $paramRef = $match.Groups[1].Value
            $issues.Errors += @{
                File = $file.FullName
                Issue = "Incorrect extension in @$paramRef.md (should be .mdc)"
                Line = Get-LineNumber $content $match.Index
                Fix = "Change .md to .mdc and ensure wrapped in backticks"
            }
        }
        
        # Check for file existence
        $correctRefs = [regex]::Matches($content, '@([a-zA-Z0-9_\-/]+)\.mdc')
        foreach ($match in $correctRefs) {
            $paramRef = $match.Groups[1].Value
            $fullPath = Join-Path $RulesRootPath "$paramRef.mdc"
            
            if (-not (Test-Path $fullPath)) {
                $issues.Warnings += @{
                    File = $file.FullName
                    Issue = "Referenced file @$paramRef.mdc does not exist"
                    Line = Get-LineNumber $content $match.Index
                    Fix = "Create the file or update the reference"
                }
            }
        }
    }
    
    # Report issues
    foreach ($error in $issues.Errors) {
        Write-Error "ERROR in $($error.File) (line $($error.Line)): $($error.Issue)"
    }
    
    if ($IncludeWarnings) {
        foreach ($warning in $issues.Warnings) {
            Write-Warning "WARNING in $($warning.File) (line $($warning.Line)): $($warning.Issue)"
        }
    }
    
    return $issues
}
```

### Structure Validation Implementation

```powershell
function Validate-DocumentationStructure {
    param (
        [string]$RootPath,
        [switch]$RecursiveChecking
    )
    
    $structureIssues = @{
        MissingReadme = @()
        MissingHeaders = @()
        AccessPatterns = @()
    }
    
    # Check README.md files
    $directories = Get-ChildItem $RootPath -Directory -Recurse:$RecursiveChecking
    foreach ($dir in $directories) {
        $readmePath = Join-Path $dir.FullName "README.md"
        if (-not (Test-Path $readmePath)) {
            $structureIssues.MissingReadme += $dir.FullName
        }
    }
    
    # Check USE WHEN headers in knowledge files
    $knowledgeDir = Join-Path $RootPath "knowledge"
    if (Test-Path $knowledgeDir) {
        $knowledgeFiles = Get-ChildItem $knowledgeDir -Filter "*.md" -Recurse | 
                          Where-Object { $_.Name -ne "README.md" }
        
        foreach ($file in $knowledgeFiles) {
            $firstLine = Get-Content $file.FullName -TotalCount 1
            if (-not ($firstLine -like "# USE WHEN*")) {
                $structureIssues.MissingHeaders += $file.FullName
            }
        }
    }
    
    # Report structure issues
    foreach ($dir in $structureIssues.MissingReadme) {
        Write-Warning "Missing README.md in directory: $dir"
    }
    
    foreach ($file in $structureIssues.MissingHeaders) {
        Write-Error "Missing required USE WHEN header in file: $file"
    }
    
    return $structureIssues
}
```

## Integration and Usage

### Integration with Workflows

Validation logic should be integrated with key workflows:

1. **Pre-Commit Validation**: Run before committing changes
2. **Pull Request Validation**: Run when creating pull requests
3. **Scheduled Validation**: Run on a regular schedule
4. **Manual Validation**: Run on demand during development

### Validation Parameters

Common validation parameters to consider:

1. **Scope**: What parts of the system to validate (specific directories, file types)
2. **Severity**: What level of issues to report (errors only, include warnings, include info)
3. **Fix Mode**: Whether to automatically fix issues or just report them
4. **Report Format**: How to format and output validation results

## Related Patterns
- Validation Script Patterns: `knowledge/rules/patterns/impl/validation-script-patterns`
- Error Handling Patterns: `knowledge/rules/patterns/impl/validation-error-handling`
- Implementation Guidance: `knowledge/rules/guides/validation-implementation`

## Conclusion
Effective validation logic is essential for maintaining the integrity of the 1000xbrain cognitive architecture. By implementing these validation patterns, you can ensure consistent reference formats, proper file structure, and adherence to documentation standards across the system. 