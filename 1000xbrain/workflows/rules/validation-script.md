# Validation Script for Project Rule Parameters

This document provides the implementation details for the validation script used to check for correct project-rule-parameter references throughout the 1000xbrain cognitive architecture.

For detailed message-command validation requirements, see core/communication/message-commands.md and the self-documenting header system in each project-rule-parameter.

## Purpose

The validation script provides automated checking for:

1. **Extension Correctness**: Ensuring all project-rule-parameter references use `.mdc` extension
2. **File Existence**: Verifying referenced files actually exist
3. **Naming Consistency**: Checking for consistency in naming patterns
4. **Path Validity**: Validating file paths are correctly formatted

For detailed validation script patterns, use:
```typescript
fetch_rules(["knowledge/rules/patterns/impl/validation-script-patterns"], 
           "Understanding validation script implementation patterns")
```

## Validation Logic

For comprehensive validation logic patterns, use:
```typescript
fetch_rules(["knowledge/rules/patterns/impl/validation-logic"], 
           "Understanding validation logic and criteria")
```

## Implementation Guidance

For detailed implementation guidance, use:
```typescript
fetch_rules(["knowledge/rules/guides/validation-implementation"], 
           "Understanding validation system implementation approaches")
```

## Error Handling

For error handling patterns, use:
```typescript
fetch_rules(["knowledge/rules/patterns/impl/validation-error-handling"], 
           "Understanding validation error handling and resolution approaches")
```

## Script Implementation

The validation script is implemented as a PowerShell script in the 1000xscripts directory:

```powershell
# Validate-ProjectRuleParameters.ps1

# Define root directories
$brainDir = "../1000xbrain"
$rulesDir = "../.cursor/rules"

# Function to check for parameter reference correctness
function Check-ParameterReferences {
    param (
        [string]$filePath
    )
    
    $content = Get-Content $filePath -Raw
    $matches = [regex]::Matches($content, '@([a-zA-Z0-9_\-/]+)\.mdc')
    
    foreach ($match in $matches) {
        $paramRef = $match.Groups[1].Value
        $fullPath = Join-Path $rulesDir "$paramRef.mdc"
        
        # Check if file exists
        if (-not (Test-Path $fullPath)) {
            Write-Warning "Invalid reference in $filePath: $paramRef.mdc does not exist"
        }
    }
    
    # Check for incorrect .md extension in references
    $incorrectMatches = [regex]::Matches($content, '@([a-zA-Z0-9_\-/]+)\.md\b')
    foreach ($match in $incorrectMatches) {
        $paramRef = $match.Groups[1].Value
        Write-Error "ERROR in $filePath: Incorrect extension in @$paramRef.md (should be .mdc)"
    }
}

# Process all markdown files in brain directory
Get-ChildItem $brainDir -Filter *.md -Recurse | ForEach-Object {
    Check-ParameterReferences $_.FullName
}

Write-Host "Validation complete"
```

## Integration Points

The validation script integrates with other components through:

1. **File System Access**: Reading 1000xbrain markdown files
2. **Pattern Matching**: Using regex to identify parameter references
3. **Error Reporting**: Providing structured warnings and errors

## Usage Instructions

The validation script should be used:

1. **Regularly During Development**: Run the script periodically to check for reference integrity
2. **After Comprehensive Updates**: Particularly after updating multiple files or adding new project-rule-parameters
3. **Before Implementation Completion**: As a final verification step

### Command Line Usage

```powershell
# Navigate to scripts directory
cd 1000xscripts

# Run the validation script
.\Validate-ProjectRuleParameters.ps1
```

## Output Types

The script produces two types of messages:

1. **Warnings**: Indicate that a referenced file does not exist
   - Format: `WARNING: Invalid reference in [file]: [parameter].mdc does not exist`
   - Action: Investigate missing file or fix typo in reference

2. **Errors**: Indicate critical issues that must be fixed
   - Format: `ERROR in [file]: Incorrect extension in @[parameter].md (should be .mdc)`
   - Action: Immediately correct the extension to .mdc

## Enhancement Options

The script can be enhanced with additional features:

1. **Summary Reports**: Add summary statistics at the end of validation
2. **Export Options**: Add ability to export results to CSV or JSON
3. **Filter Capabilities**: Add filters for specific directories or file types
4. **Integration Tests**: Add integration with CI/CD systems

## Maintenance Process

The validation script should be maintained when:

1. **Directory Structures Change**: Update path variables
2. **New Reference Patterns Emerge**: Add new regex patterns
3. **Additional Checks Are Needed**: Implement new validation functions

## Related Tools

For related scanning and validation tools, see:
- [scanning-process.md](scanning-process.md) - For symbol usage scanning
- [scanning-automation.md](scanning-automation.md) - For automated scanning processes

For validation requirements that this script checks against, see:
- core/communication/message-commands.md - For structure guidance 
- core/communication/syntax-standards.md - For detailed syntax standards

## Conclusion

The validation script plays a critical role in maintaining the integrity of the 1000xbrain cognitive architecture by ensuring consistent project-rule-parameter references. By systematically checking references, extensions, and documentation structure, the validation system helps prevent AI hallucinations, incorrect tool calls, and ensures reliable operation of the message-command system.