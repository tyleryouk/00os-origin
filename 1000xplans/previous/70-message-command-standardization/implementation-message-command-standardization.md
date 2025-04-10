# Message Command Standardization Implementation Plan

## Overview

This document outlines the detailed implementation plan for standardizing message commands in the PolygonExpress project.

## Implementation Scope

### Focus Workflows
This standardization effort will initially focus exclusively on:
- **rules-workflow**
- **front-end-workflow**

### Rationale for Limited Scope
- These are currently the only complete workflows in the system
- Other workflows (back-end, documentation, scripts) still need major enhancements
- Implementing standards on incomplete workflows would create additional work later
- Starting with complete workflows allows us to establish patterns that can be applied to other workflows

### Future Expansion
- The standards established here will serve as the foundation for other workflows
- Other workflows will be standardized as they are enhanced and completed
- The parameter loyalty system and validation approach will be designed to be extensible

## Current System Analysis

### Parameter Definition Structure
The current system defines parameters in a simplified structure that doesn't support multiple parameter combinations:

```powershell
# Current structure in ParameterDefinitions.psm1
$parameterDefinitions = @{
    "create-template" = @{
        "standard-parameters" = @("workflow-type")
        "project-rule-parameters" = @("template-type")
    }
}
```

### Cheatsheet Generation System
The current cheatsheet generation system (in Update-WorkflowCheatsheets.ps1) has these limitations:
1. Only displays one standard-parameter per message-command
2. No validation for parameter loyalty
3. No documentation of parameter relationships
4. No distinction between required and optional parameters

### Project Rule Parameter Usage
Currently, some project-rule-parameters are used with multiple message-commands:
- `@dev-mode-system-wide.mdc` used with both `dev-mode` and `continue-implementation`
- No explicit loyalty tracking in parameter definitions
- No validation system to enforce parameter loyalty

## Enhanced Data Structure Design

### Parameter Definition Enhancement
We will update the parameter definition structure to support:
1. Multiple standard-parameter combinations
2. Parameter loyalty tracking
3. Parameter order requirements
4. Required vs. optional distinction

```powershell
# Enhanced structure in ParameterDefinitions.psm1
$parameterDefinitions = @{
    "create-template" = @{
        "standard-parameter-combinations" = @(
            # Pattern 1: Simple template creation
            @{
                "parameters" = @(
                    @{
                        "name" = "workflow-type"
                        "required" = $true
                        "order" = 1
                    }
                )
            },
            # Pattern 2: Advanced template creation
            @{
                "parameters" = @(
                    @{
                        "name" = "workflow-type"
                        "required" = $true
                        "order" = 1
                    },
                    @{
                        "name" = "folder-type"
                        "required" = $true
                        "order" = 2
                    },
                    @{
                        "name" = "project-rule-parameter"
                        "required" = $true
                        "order" = 3
                    }
                )
            }
        ),
        "project-rule-parameters" = @{
            # Parameter loyalty and relationship tracking
            "@template-basic.mdc" = @{
                "loyal_to" = "create-template"
                "description" = "Basic template creation"
                "requires" = @()
                "conflicts_with" = @()
                "deprecated" = $false
            },
            "@template-advanced.mdc" = @{
                "loyal_to" = "create-template"
                "description" = "Advanced template creation"
                "requires" = @()
                "conflicts_with" = @()
                "deprecated" = $false
            }
        }
    },
    "dev-mode" = @{
        "standard-parameter-combinations" = @(
            # Standard dev-mode pattern
            @{
                "parameters" = @(
                    @{
                        "name" = "workflow-type"
                        "required" = $true
                        "order" = 1
                    }
                )
            }
        ),
        "project-rule-parameters" = @{
            # Parameter loyalty and relationship tracking
            "@dev-mode-system-wide.mdc" = @{
                "loyal_to" = "dev-mode"
                "description" = "System-wide implementation"
                "requires" = @()
                "conflicts_with" = @()
                "deprecated" = $false
            }
        }
    },
    "continue-implementation" = @{
        "standard-parameter-combinations" = @(
            # Basic pattern with no standard params
            @{
                "parameters" = @()
            },
            # Recovery point pattern
            @{
                "parameters" = @(
                    @{
                        "name" = "recovery-point"
                        "required" = $true
                        "order" = 1
                    }
                )
            }
        ),
        "project-rule-parameters" = @{
            # Parameter loyalty and relationship tracking
            "@continue-implementation-system-wide.mdc" = @{
                "loyal_to" = "continue-implementation"
                "description" = "Continue system-wide implementation"
                "requires" = @()
                "conflicts_with" = @()
                "deprecated" = $false
            }
        }
    }
}
```

### Parameter Loyalty Definition File

Each project-rule-parameter will have a loyalty definition section:

```markdown
## Project Rule Parameter

Loyal to: continue-implementation: @parameters/rules/continue-implementation-system-wide.mdc
```

## Enhanced Call Pattern Enforcement

### Project-Rule-Parameter Call Pattern Definition

To enforce a strict one-to-one relationship between project-rule-parameters and their usage patterns, we will add call pattern definitions to each project-rule-parameter:

```powershell
# Enhanced structure with explicit call patterns
$parameterDefinitions = @{
    "create-template" = @{
        "standard-parameter-combinations" = @(
            # As previously defined
        ),
        "project-rule-parameters" = @{
            "@template-basic.mdc" = @{
                "loyal_to" = "create-template",
                "description" = "Basic template creation",
                "call_pattern" = @{
                    "message_command" = "create-template",
                    "standard_parameters" = @("workflow-type"),
                    "example" = "create-template: rules-workflow @template-basic.mdc"
                },
                "requires" = @(),
                "conflicts_with" = @(),
                "deprecated" = $false
            },
            "@template-advanced.mdc" = @{
                "loyal_to" = "create-template",
                "description" = "Advanced template creation",
                "call_pattern" = @{
                    "message_command" = "create-template",
                    "standard_parameters" = @("workflow-type"),
                    "example" = "create-template: front-end-workflow @template-advanced.mdc"
                },
                "requires" = @(),
                "conflicts_with" = @(),
                "deprecated" = $false
            },
            "@template-past-chat-hallucination.mdc" = @{
                "loyal_to" = "create-template",
                "description" = "Past chat hallucination template",
                "call_pattern" = @{
                    "message_command" = "create-template",
                    "standard_parameters" = @("workflow-type", "folder-type", "project-rule-parameter"),
                    "example" = "create-template: rules-workflow @past-chat-folder @planning-folder @template-past-chat-hallucination.mdc"
                },
                "requires" = @(),
                "conflicts_with" = @(),
                "deprecated" = $false
            }
        }
    },
    "continue-implementation" = @{
        "standard-parameter-combinations" = @(
            # As previously defined
        ),
        "project-rule-parameters" = @{
            "@continue-implementation-system-wide.mdc" = @{
                "loyal_to" = "continue-implementation",
                "description" = "Continue system-wide implementation",
                "call_pattern" = @{
                    "message_command" = "continue-implementation",
                    "standard_parameters" = @(),
                    "example" = "continue-implementation: @continue-implementation-system-wide.mdc"
                },
                "requires" = @(),
                "conflicts_with" = @(),
                "deprecated" = $false
            },
            "@continue-implementation-error-recovery.mdc" = @{
                "loyal_to" = "continue-implementation",
                "description" = "Continue error recovery implementation",
                "call_pattern" = @{
                    "message_command" = "continue-implementation",
                    "standard_parameters" = @("recovery-point"),
                    "example" = "continue-implementation: recovery-point @continue-implementation-error-recovery.mdc"
                },
                "requires" = @(),
                "conflicts_with" = @(),
                "deprecated" = $false
            }
        }
    }
}
```

### Enhanced Parameter File Format

Each project-rule-parameter file will now include a clearly defined call pattern section:

```markdown
## Project Rule Parameter

Loyal to: continue-implementation: @parameters/rules/continue-implementation-system-wide.mdc

## Call Pattern

Message-Command: continue-implementation
Standard-Parameters: none
Example: `continue-implementation: @continue-implementation-system-wide.mdc`
```

### Call Pattern Validation

The validation system will be enhanced to enforce the exact call pattern for each project-rule-parameter:

```powershell
function Test-CallPattern {
    param (
        [string]$Command,
        [string]$ProjectRuleParameter
    )
    
    # Parse command and parameters
    $parts = $Command -split ":"
    if ($parts.Count -lt 1) {
        return @{
            Valid = $false
            Errors = @("Invalid command format: missing message-command")
        }
    }
    
    $messageCommand = $parts[0].Trim()
    $paramString = if ($parts.Count -gt 1) { $parts[1].Trim() } else { "" }
    
    # Parse parameters
    $parameters = $paramString -split " " | Where-Object { $_ -ne "" }
    
    # Find the project-rule parameter
    $prpIndex = -1
    for ($i = 0; $i -lt $parameters.Count; $i++) {
        if ($parameters[$i] -eq $ProjectRuleParameter) {
            $prpIndex = $i
            break
        }
    }
    
    if ($prpIndex -eq -1) {
        return @{
            Valid = $false
            Errors = @("Project-rule-parameter not found in command")
        }
    }
    
    # Get parameter definitions
    $definitions = Get-ParameterDefinitions
    
    # Extract parameter name without @ and .mdc
    $paramName = $ProjectRuleParameter -replace '^@', '' -replace '\.mdc$', ''
    
    # Find the parameter in definitions
    $foundParam = $false
    $callPattern = $null
    
    foreach ($cmd in $definitions.Keys) {
        if ($definitions[$cmd].project-rule-parameters.ContainsKey($ProjectRuleParameter)) {
            $callPattern = $definitions[$cmd].project-rule-parameters[$ProjectRuleParameter].call_pattern
            $foundParam = $true
            break
        }
    }
    
    if (-not $foundParam) {
        return @{
            Valid = $false
            Errors = @("Project-rule-parameter not found in definitions")
        }
    }
    
    # Verify message command
    if ($messageCommand -ne $callPattern.message_command) {
        return @{
            Valid = $false
            Errors = @("Message-command mismatch: Expected '$($callPattern.message_command)', found '$messageCommand'")
        }
    }
    
    # Extract standard parameters (all parameters before the project-rule-parameter)
    $standardParams = @()
    for ($i = 0; $i -lt $prpIndex; $i++) {
        $standardParams += $parameters[$i]
    }
    
    # Verify standard parameters
    if ($standardParams.Count -ne $callPattern.standard_parameters.Count) {
        return @{
            Valid = $false
            Errors = @("Standard parameter count mismatch: Expected $($callPattern.standard_parameters.Count), found $($standardParams.Count)")
        }
    }
    
    for ($i = 0; $i -lt $standardParams.Count; $i++) {
        if ($standardParams[$i] -ne $callPattern.standard_parameters[$i]) {
            return @{
                Valid = $false
                Errors = @("Standard parameter mismatch at position $i: Expected '$($callPattern.standard_parameters[$i])', found '$($standardParams[$i])'")
            }
        }
    }
    
    # All checks passed
    return @{
        Valid = $true
        Errors = @()
    }
}

# Enhanced Test-MessageCommand to include call pattern validation
function Test-MessageCommand {
    param (
        [string]$Command
    )
    
    # Previous validation code...
    
    # Add call pattern validation for project rule parameters
    foreach ($param in $projectRuleParams) {
        $callPatternResult = Test-CallPattern -Command $Command -ProjectRuleParameter $param
        if (-not $callPatternResult.Valid) {
            $result.Errors += $callPatternResult.Errors
            $result.Valid = $false
        }
    }
    
    return $result
}
```

### Enhanced Cheatsheet Format

The cheatsheet format will be updated to clearly show the one-to-one relationship between project-rule-parameters and their call patterns:

```markdown
#### Project-Rule-Parameter Call Patterns

| Parameter | Call Pattern | 
|-----------|--------------|
| `@template-basic.mdc` | `create-template: workflow-type @template-basic.mdc` |
| `@template-advanced.mdc` | `create-template: workflow-type @template-advanced.mdc` |
| `@template-past-chat-hallucination.mdc` | `create-template: workflow-type folder-type project-rule-parameter @template-past-chat-hallucination.mdc` |
```

### Call Pattern Documentation

Each project-rule-parameter will have documented exactly one way to call it:

```powershell
function Get-CallPatternDocumentation {
    param (
        [string]$ProjectRuleParameter
    )
    
    # Get parameter definitions
    $definitions = Get-ParameterDefinitions
    
    # Find the parameter in definitions
    foreach ($cmd in $definitions.Keys) {
        if ($definitions[$cmd].project-rule-parameters.ContainsKey($ProjectRuleParameter)) {
            return $definitions[$cmd].project-rule-parameters[$ProjectRuleParameter].call_pattern.example
        }
    }
    
    return "Call pattern not found"
}
```

## Creating a New Project-Rule-Parameter

To streamline the creation of new project-rule-parameters with strict call patterns, we will create a helper function:

```powershell
function New-ProjectRuleParameter {
    param (
        [string]$Name,
        [string]$MessageCommand,
        [string[]]$StandardParameters,
        [string]$Description,
        [string]$OutputPath
    )
    
    # Generate the call pattern example
    $example = "$MessageCommand: "
    foreach ($param in $StandardParameters) {
        $example += "$param "
    }
    $example += "@$Name.mdc"
    
    # Create content with call pattern
    $content = @"
# $Description

## File Purpose and Relationship

This file defines the specific operation of the `$example` message-command. It should be consulted to understand:

- Purpose specific to this parameter
- Usage scenarios
- Implementation details

## Project Rule Parameter

Loyal to: $MessageCommand: @parameters/$(($OutputPath -split '/')[-2])/$Name.mdc

## Call Pattern

Message-Command: $MessageCommand
Standard-Parameters: $(if ($StandardParameters.Count -gt 0) { $StandardParameters -join ", " } else { "none" })
Example: `$example`

## Implementation Details

// Implementation details specific to this parameter
"@
    
    # Write to file
    $filePath = Join-Path -Path $OutputPath -ChildPath "$Name.md"
    Set-Content -Path $filePath -Value $content
    
    Write-Host "Created new project-rule-parameter at: $filePath"
    Write-Host "Call pattern: $example"
    
    # Add to parameter definitions
    # Implementation would update the definitions file
}
```

### Migration Workflow for Existing Parameters

To enforce call patterns on existing parameters, we'll add a migration step:

```powershell
function Add-CallPatternToExistingParameters {
    param (
        [string]$ParametersDirectory
    )
    
    # Get all parameter files
    $files = Get-ChildItem -Path $ParametersDirectory -Recurse -Filter "*.md"
    
    $results = @{
        Updated = 0
        Failed = 0
        FailedFiles = @()
    }
    
    foreach ($file in $files) {
        $content = Get-Content -Path $file.FullName -Raw
        
        # Extract parameter name
        $paramName = "@" + $file.BaseName + ".mdc"
        
        # Get parameter definitions
        $definitions = Get-ParameterDefinitions
        
        # Find loyal command and call pattern
        $loyalCommand = $null
        $callPattern = $null
        
        foreach ($cmd in $definitions.Keys) {
            if ($definitions[$cmd].project-rule-parameters.ContainsKey($paramName)) {
                $loyalCommand = $cmd
                $callPattern = $definitions[$cmd].project-rule-parameters[$paramName].call_pattern
                break
            }
        }
        
        if ($loyalCommand -and $callPattern) {
            # Check if call pattern section exists
            $callPatternSection = "## Call Pattern"
            
            if ($content -match $callPatternSection) {
                # Update existing call pattern
                $updatedContent = $content -replace "$callPatternSection(\r\n|\r|\n)+.+?(\r\n|\r|\n)+.+?(\r\n|\r|\n)+.+?(\r\n|\r|\n)+", 
                @"
$callPatternSection

Message-Command: $($callPattern.message_command)
Standard-Parameters: $(if ($callPattern.standard_parameters.Count -gt 0) { $callPattern.standard_parameters -join ", " } else { "none" })
Example: `$($callPattern.example)`

"@
            } else {
                # Add call pattern after loyalty section
                $loyaltyPattern = "## Project Rule Parameter(\r\n|\r|\n)+Loyal to:"
                if ($content -match $loyaltyPattern) {
                    $updatedContent = $content -replace "($loyaltyPattern.+?)(\r\n|\r|\n)+", 
                    @"
$1

$callPatternSection

Message-Command: $($callPattern.message_command)
Standard-Parameters: $(if ($callPattern.standard_parameters.Count -gt 0) { $callPattern.standard_parameters -join ", " } else { "none" })
Example: `$($callPattern.example)`

"@
                } else {
                    # Add both loyalty and call pattern
                    $updatedContent = $content + @"

## Project Rule Parameter

Loyal to: $loyalCommand: $paramName

$callPatternSection

Message-Command: $($callPattern.message_command)
Standard-Parameters: $(if ($callPattern.standard_parameters.Count -gt 0) { $callPattern.standard_parameters -join ", " } else { "none" })
Example: `$($callPattern.example)`

"@
                }
            }
            
            # Write updated content
            Set-Content -Path $file.FullName -Value $updatedContent
            $results.Updated++
        } else {
            $results.Failed++
            $results.FailedFiles += $file.FullName
        }
    }
    
    return $results
}
```

This system ensures each project-rule-parameter has:
1. Exactly one defined message-command it can be used with
2. A specific set of standard-parameters that must be used with it
3. Clear documentation of its call pattern
4. Validation to enforce the one-to-one relationship

## Implementation Order

1. **Develop Enhanced Parameter Definition Module**: This is the foundation
2. **Create Parameter Validation System**: Builds on the enhanced definitions
3. **Develop Enhanced Cheatsheet Generation**: Uses the first two components
4. **Create and Test Migration Tool**: Updates existing parameters with loyalty
5. **Run Migration and Generate New Cheatsheets**: Apply the changes
6. **Update Documentation**: Create comprehensive documentation

## Testing Strategy

### Unit Testing

```powershell
# Test parameter definitions
$definitions = Get-ParameterDefinitions
Write-Host "Command count: $($definitions.Keys.Count)"

# Test parameter loyalty
$loyal = Test-ParameterLoyalty -ProjectRuleParameter "@dev-mode-system-wide.mdc" -MessageCommand "dev-mode"
Write-Host "dev-mode loyal to @dev-mode-system-wide.mdc: $loyal"

$loyal = Test-ParameterLoyalty -ProjectRuleParameter "@continue-implementation-system-wide.mdc" -MessageCommand "continue-implementation"
Write-Host "continue-implementation loyal to @continue-implementation-system-wide.mdc: $loyal"

# Test standard parameter combinations
$valid = Test-StandardParameterCombination -MessageCommand "dev-mode" -StandardParameters @("rules-workflow")
Write-Host "dev-mode: rules-workflow valid: $valid"

$valid = Test-StandardParameterCombination -MessageCommand "create-template" -StandardParameters @("rules-workflow", "folder-type", "project-rule-parameter")
Write-Host "create-template with 3 params valid: $valid"

# Test message command validation
$result = Test-MessageCommand -Command "dev-mode: rules-workflow @dev-mode-system-wide.mdc"
Write-Host "dev-mode command valid: $($result.Valid)"

$result = Test-MessageCommand -Command "continue-implementation: @dev-mode-system-wide.mdc"
Write-Host "continue-implementation with wrong param valid: $($result.Valid)"
if (-not $result.Valid) {
    Write-Host "Errors: $($result.Errors -join '; ')"
}
```

### Integration Testing

```powershell
# Test parameter file validation
$result = Test-ParameterFile -FilePath "1000xbrain/parameters/rules/dev-mode-system-wide.md"
Write-Host "dev-mode-system-wide.md valid: $($result.Valid)"

# Test cheatsheet generation
Generate-EnhancedCheatsheet -WorkflowType "rules" -OutputPath "test-rules-cheatsheet.md"
Write-Host "Cheatsheet generated: test-rules-cheatsheet.md"

# Test migration
$results = Update-LoyaltyInformation -ParametersDirectory "test-parameters"
Write-Host "Migration test - Updated: $($results.Updated), Failed: $($results.Failed)"
```

## Success Criteria

1. Parameter Definition System
- [ ] Loyalty tracking implemented for rules-workflow and front-end-workflow
- [ ] Validation system working for target workflows
- [ ] Documentation system complete with workflow scope clarity

2. Cheatsheet Enhancement
- [ ] Format updated with loyalty info for rules-workflow and front-end-workflow
- [ ] Generation system enhanced to support focused workflows
- [ ] Relationship display working for in-scope parameters

3. Implementation
- [ ] Parameter definitions updated for rules-workflow and front-end-workflow
- [ ] Validation system implemented with scope awareness
- [ ] Documentation generated with clear workflow boundaries

4. Testing
- [ ] All loyalty tests passing for in-scope workflows
- [ ] Validation tests successful within defined scope
- [ ] Relationships verified for rules-workflow and front-end-workflow

5. Documentation
- [ ] Guides updated with explicit workflow scope
- [ ] Examples created focusing on supported workflows
- [ ] System documented with expansion potential for future workflows

## Next Steps

1. Complete remaining Phase 1 tasks for rules-workflow and front-end-workflow
   - Implement enhanced parameter definition module
   - Create test cases for the module

2. Begin Phase 2 implementation within defined scope
   - Develop enhanced cheatsheet generation
   - Test new formats with example data

3. Prepare for Phase 3 execution with focus on target workflows
   - Create parameter validation system
   - Test with real-world examples

4. Document patterns for future expansion to other workflows
   - Create documentation on extending the system
   - Develop guidelines for new workflow integration
``` 
``` 