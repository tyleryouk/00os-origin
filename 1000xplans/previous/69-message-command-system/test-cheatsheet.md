# Test Cheatsheet: Message Command System

## Parameter Definition Tests

### 1. Format Validation Tests
```powershell
# Test parameter definition format
Describe "Parameter Definition Format" {
    It "Validates USE WHEN header format" {
        $content = Get-Content "parameters/standard/workflow-type.md"
        $result = Test-UseWhenHeader -Content $content
        $result | Should -Be $true
    }

    It "Validates USE WHEN header content" {
        $content = Get-Content "parameters/standard/workflow-type.md"
        $header = Get-UseWhenHeader -Content $content
        $header | Should -Match "^# USE WHEN .+ -ing .+, .+ -ing .+, or .+ -ing .+"
    }

    It "Validates standard parameter definition format" {
        $content = Get-Content "parameters/standard/workflow-type.md"
        $sections = Parse-MarkdownSections $content
        $result = Test-ParameterDefinitionFormat -Sections $sections
        $result | Should -Be $true
    }
}
```

### 2. Relationship Validation Tests
```powershell
# Test parameter relationships
Describe "Parameter Relationships" {
    It "Validates compatible parameters" {
        $result = Test-ParameterCompatibility -Command "plan-mode" -Parameters @{
            Standard = "rules-workflow"
            ProjectRule = "@parameters/rules/plan-mode.mdc"
        }
        $result | Should -Be $true
    }

    It "Validates USE WHEN relationships" {
        $result = Test-UseWhenRelationships -Parameter "workflow-type"
        $result | Should -Be $true
    }
}
```

### 3. Command Compatibility Tests
```powershell
# Test command compatibility
Describe "Command Compatibility" {
    It "Validates command parameter requirements" {
        $result = Test-CommandRequirements -Command "create-template" -Parameters @{
            Standard = @("rules-workflow", "@folder-path", "@planning-path")
            ProjectRule = "project-rule-parameter"
        }
        $result | Should -Be $true
    }

    It "Validates USE WHEN compatibility" {
        $result = Test-UseWhenCompatibility -Command "create-template" -UseWhenHeader "USE WHEN creating templates"
        $result | Should -Be $true
    }
}
```

### 4. Knowledge Integration Tests
```powershell
# Test knowledge integration
Describe "Knowledge Integration" {
    It "Validates fetch_rules integration" {
        $result = Test-FetchRulesIntegration -Command "plan-mode: rules-workflow @template.mdc"
        $result | Should -Be $true
    }

    It "Validates USE WHEN header presence" {
        $content = Get-Content "parameters/standard/workflow-type.md"
        $result = Test-UseWhenHeaderPresence -Content $content
        $result | Should -Be $true
    }
}
```

## Script Processing Tests

### 1. Parameter Detection Tests
```powershell
# Test parameter detection
Describe "Parameter Detection" {
    It "Detects standard parameters correctly" {
        $command = "plan-mode: rules-workflow @template.mdc"
        $result = Get-CommandParameters -Command $command
        $result.StandardParameters | Should -Contain "rules-workflow"
    }

    It "Validates USE WHEN header presence" {
        $content = Get-Content "parameters/standard/workflow-type.md"
        $result = Test-UseWhenHeaderPresence -Content $content
        $result | Should -Be $true
    }
}

### 2. Knowledge Access Tests
```powershell
# Test knowledge access
Describe "Knowledge Access" {
    It "Validates fetch_rules functionality" {
        $result = Test-FetchRulesFunctionality -Command "plan-mode: rules-workflow @template.mdc"
        $result | Should -Be $true
    }

    It "Validates USE WHEN header presence" {
        $content = Get-Content "parameters/standard/workflow-type.md"
        $result = Test-UseWhenHeaderPresence -Content $content
        $result | Should -Be $true
    }
}
```

### 3. Documentation Generation Tests
```powershell
# Test documentation generation
Describe "Documentation Generation" {
    It "Generates valid cheatsheet" {
        $result = New-WorkflowCheatsheet -WorkflowType "rules"
        $result | Should -Not -BeNullOrEmpty
    }

    It "Includes USE WHEN descriptions" {
        $result = Test-UseWhenInCheatsheet -CheatsheetPath "cheatsheets/rules-workflow.md"
        $result | Should -Be $true
    }
}
```

## Integration Tests

### 1. End-to-End Command Tests
```powershell
# Test complete command processing
Describe "Command Processing" {
    It "Processes plan-mode command correctly" {
        $command = "plan-mode: rules-workflow @plan-mode-system.mdc"
        $result = Process-Command -Command $command
        $result.Success | Should -Be $true
    }

    It "Validates USE WHEN integration" {
        $result = Test-UseWhenIntegration -Command "plan-mode: rules-workflow @template.mdc"
        $result | Should -Be $true
    }
}

### 2. Cross-Reference Tests
```powershell
# Test documentation cross-references
Describe "Documentation Cross-References" {
    It "Validates cross-references" {
        $result = Test-DocumentationReferences -CheatsheetPath "cheatsheets/rules-workflow.md"
        $result | Should -Be $true
    }

    It "Validates USE WHEN cross-references" {
        $result = Test-UseWhenCrossReferences -Path "parameters/rules"
        $result | Should -Be $true
    }
}
```

### 3. System State Tests
```powershell
# Test system state consistency
Describe "System State" {
    It "Maintains consistent state" {
        $result = Test-SystemState -After {
            Process-Command "plan-mode: rules-workflow @template.mdc"
            Process-Command "continue-planning: @next-phase.mdc"
        }
        $result | Should -Be $true
    }

    It "Maintains USE WHEN consistency" {
        $result = Test-UseWhenStateConsistency -Path "parameters"
        $result | Should -Be $true
    }
}
```

## Manual Test Cases

### 1. Parameter Definition Verification
- [ ] Verify all standard parameters have valid markdown definitions
- [ ] Check project-rule parameter markdown definitions
- [ ] Validate relationship documentation
- [ ] Verify USE WHEN header format and content
- [ ] Check USE WHEN description effectiveness

### 2. Command Processing Verification
- [ ] Test all command types with various parameters
- [ ] Verify error handling for invalid commands
- [ ] Check parameter validation feedback
- [ ] Validate USE WHEN header processing
- [ ] Test USE WHEN categorization

### 3. Documentation Accuracy
- [ ] Review generated cheatsheets for accuracy
- [ ] Verify cross-reference links work
- [ ] Check formatting consistency
- [ ] Validate USE WHEN header inclusion
- [ ] Verify USE WHEN description clarity

## Test Execution Checklist

### Phase 1: Parameter System
- [ ] Run format validation tests
- [ ] Execute relationship validation tests
- [ ] Perform command compatibility tests
- [ ] Validate USE WHEN header format
- [ ] Test USE WHEN description effectiveness

### Phase 2: Script Processing
- [ ] Run parameter detection tests
- [ ] Execute knowledge access tests
- [ ] Perform documentation generation tests
- [ ] Test USE WHEN header processing
- [ ] Validate USE WHEN integration

### Phase 3: Integration
- [ ] Run end-to-end command tests
- [ ] Execute cross-reference tests
- [ ] Perform system state tests
- [ ] Check USE WHEN consistency
- [ ] Validate USE WHEN relationships

### Phase 4: Manual Verification
- [ ] Complete parameter definition verification
- [ ] Perform command processing verification
- [ ] Review documentation accuracy
- [ ] Verify USE WHEN implementation
- [ ] Test USE WHEN effectiveness

## Test Environment Setup

### 1. Test Data Setup
```powershell
# Create test parameter definitions
New-TestParameterDefinition -Type "Standard" -Name "test-workflow" -Format "Markdown" -UseWhen "USE WHEN testing workflow parameters"
New-TestParameterDefinition -Type "ProjectRule" -Name "test-template" -Format "Markdown" -UseWhen "USE WHEN testing template parameters"
```

### 2. Test Environment Configuration
```powershell
# Configure test environment
Set-TestEnvironment -Path "test/message-command-system"
Initialize-TestData
Initialize-UseWhenHeaders
```

### 3. Cleanup Procedures
```powershell
# Cleanup test data
Remove-TestData
Reset-TestEnvironment
Reset-UseWhenHeaders
```

## Regression Test Suite

### 1. Basic Functionality Tests
```powershell
# Test basic command processing
Describe "Basic Functionality" {
    It "Processes basic commands" {
        $commands = @(
            "plan-mode: rules-workflow",
            "dev-mode: front-end-workflow",
            "continue-planning: @template.mdc"
        )
        foreach ($cmd in $commands) {
            $result = Process-Command $cmd
            $result.Success | Should -Be $true
        }
    }

    It "Validates USE WHEN functionality" {
        $result = Test-UseWhenBasicFunctionality
        $result | Should -Be $true
    }
}
```

### 2. Error Handling Tests
```powershell
# Test error handling
Describe "Error Handling" {
    It "Handles invalid commands gracefully" {
        $result = Process-Command "invalid-command: parameter"
        $result.Success | Should -Be $false
        $result.Error | Should -Not -BeNullOrEmpty
    }

    It "Handles invalid USE WHEN headers" {
        $result = Test-InvalidUseWhenHeaders
        $result.Success | Should -Be $false
        $result.Error | Should -Not -BeNullOrEmpty
    }
}
```

### 3. Performance Tests
```powershell
# Test performance metrics
Describe "Performance" {
    It "Processes commands within time limit" {
        $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
        Process-Command "plan-mode: rules-workflow @template.mdc"
        $stopwatch.Stop()
        $stopwatch.ElapsedMilliseconds | Should -BeLessThan 1000
    }

    It "Processes USE WHEN headers efficiently" {
        $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
        Test-UseWhenProcessingEfficiency
        $stopwatch.Stop()
        $stopwatch.ElapsedMilliseconds | Should -BeLessThan 500
    }
}
```

### 4. Knowledge Integration Tests
```powershell
# Test knowledge integration
Describe "Knowledge Integration" {
    It "Validates fetch_rules integration" {
        $result = Test-FetchRulesIntegration -Command "plan-mode: rules-workflow @template.mdc"
        $result | Should -Be $true
    }

    It "Validates USE WHEN header presence" {
        $content = Get-Content "parameters/standard/workflow-type.md"
        $result = Test-UseWhenHeaderPresence -Content $content
        $result | Should -Be $true
    }
}
```

## Validation Tests

### 1. Knowledge Reference Validation
```powershell
# Test knowledge reference validity
Describe "Knowledge Reference Validation" {
    It "Validates valid knowledge reference" {
        $result = Test-KnowledgeReferenceValidity -Command "plan-mode: rules-workflow @template.mdc"
        $result | Should -Be $true
    }

    It "Validates invalid knowledge reference" {
        $result = Test-InvalidKnowledgeReference -Command "plan-mode: rules-workflow @invalid-template.mdc"
        $result | Should -Be $false
    }
}

### 2. Parameter Relationship Validation
```powershell
# Test parameter relationships
Describe "Parameter Relationships" {
    It "Validates compatible parameters" {
        $result = Test-ParameterCompatibility -Command "plan-mode" -Parameters @{
            Standard = "rules-workflow"
            ProjectRule = "@parameters/rules/plan-mode.mdc"
        }
        $result | Should -Be $true
    }

    It "Validates USE WHEN relationships" {
        $result = Test-UseWhenRelationships -Parameter "workflow-type"
        $result | Should -Be $true
    }
}

### 3. Documentation Format Validation
```powershell
# Test documentation format
Describe "Documentation Format" {
    It "Validates USE WHEN header presence" {
        $content = Get-Content "parameters/standard/workflow-type.md"
        $result = Test-UseWhenHeaderPresence -Content $content
        $result | Should -Be $true
    }

    It "Validates USE WHEN header format" {
        $content = Get-Content "parameters/standard/workflow-type.md"
        $header = Get-UseWhenHeader -Content $content
        $header | Should -Match "^# USE WHEN .+ -ing .+, .+ -ing .+, or .+ -ing .+"
    }

    It "Validates standard parameter definition format" {
        $content = Get-Content "parameters/standard/workflow-type.md"
        $sections = Parse-MarkdownSections $content
        $result = Test-ParameterDefinitionFormat -Sections $sections
        $result | Should -Be $true
    }
}
```

## System-Wide Tests

### 1. Cross-System Integration
```powershell
# Test system-wide integration
Describe "Cross-System Integration" {
    It "Validates command system" {
        $result = Test-CommandSystemIntegration -Command "plan-mode: rules-workflow @template.mdc"
        $result | Should -Be $true
    }

    It "Validates knowledge system" {
        $result = Test-KnowledgeSystemIntegration -Command "plan-mode: rules-workflow @template.mdc"
        $result | Should -Be $true
    }
}

### 2. Pattern Recognition Tests
```powershell
# Test pattern recognition
Describe "Pattern Recognition" {
    It "Validates pattern detection" {
        $result = Test-PatternDetection -Command "plan-mode: rules-workflow @template.mdc"
        $result | Should -Be $true
    }

    It "Validates pattern application" {
        $result = Test-PatternApplication -Command "plan-mode: rules-workflow @pattern-template.mdc"
        $result | Should -Be $true
    }
}

### 3. Error Recovery Tests
```powershell
# Test error recovery
Describe "Error Recovery" {
    It "Validates invalid knowledge access" {
        $result = Test-InvalidKnowledgeAccess -Command "plan-mode: rules-workflow @invalid-template.mdc"
        $result | Should -Be $false
    }

    It "Validates invalid parameter combination" {
        $result = Test-InvalidParameterCombination -Command "plan-mode: rules-workflow @invalid1.mdc @invalid2.mdc"
        $result | Should -Be $false
    }

    It "Validates invalid documentation" {
        $result = Test-InvalidDocumentation -Command "plan-mode: rules-workflow @invalid-template.mdc"
        $result | Should -Be $false
    }
}
```

## Success Criteria

### 1. Knowledge Integration Success
- ✓ All knowledge references are valid
- ✓ fetch_rules tool works correctly
- ✓ Knowledge relationships are maintained
- ✓ Documentation reflects knowledge integration

### 2. Parameter System Success
- ✓ USE WHEN headers are correct
- ✓ Parameter definitions are complete
- ✓ Knowledge integration is documented
- ✓ Relationships are validated

### 3. Documentation Success
- ✓ Format is consistent
- ✓ Knowledge references are valid
- ✓ Cross-references are complete
- ✓ Integration is documented

### 4. System-Wide Success
- ✓ All components work together
- ✓ Knowledge is properly integrated
- ✓ Documentation is complete
- ✓ Error handling is effective

## Knowledge Integration Tests

### 1. fetch_rules Tool Tests
```powershell
# Test fetch_rules functionality
Describe "fetch_rules Tool" {
    It "Validates fetch_rules command format" {
        $command = 'fetch_rules(["knowledge/patterns/impl/pattern-name"])'
        $result = Test-FetchRulesFormat -Command $command
        $result | Should -Be $true
    }

    It "Validates knowledge path existence" {
        $path = "knowledge/patterns/impl/pattern-name"
        $result = Test-KnowledgePathExists -Path $path
        $result | Should -Be $true
    }

    It "Validates knowledge content format" {
        $content = Get-KnowledgeContent -Path "knowledge/patterns/impl/pattern-name"
        $result = Test-KnowledgeFormat -Content $content
        $result | Should -Be $true
    }
}
```

### 2. Knowledge Reference Tests
```powershell
# Test knowledge references
Describe "Knowledge References" {
    It "Validates USE WHEN knowledge references" {
        $header = Get-UseWhenHeader -File "parameters/standard/workflow-type.md"
        $result = Test-KnowledgeReferences -Header $header
        $result | Should -Be $true
    }

    It "Validates knowledge path format" {
        $references = Get-KnowledgeReferences -File "parameters/standard/workflow-type.md"
        $result = Test-KnowledgePathFormat -References $references
        $result | Should -Be $true
    }

    It "Validates knowledge integration points" {
        $content = Get-Content "parameters/standard/workflow-type.md"
        $result = Test-KnowledgeIntegration -Content $content
        $result | Should -Be $true
    }
}
```

### 3. Pattern Integration Tests
```powershell
# Test pattern integration
Describe "Pattern Integration" {
    It "Validates pattern references" {
        $content = Get-Content "parameters/standard/workflow-type.md"
        $result = Test-PatternReferences -Content $content
        $result | Should -Be $true
    }

    It "Validates pattern implementation" {
        $pattern = Get-Pattern -Path "knowledge/patterns/impl/pattern-name"
        $result = Test-PatternImplementation -Pattern $pattern
        $result | Should -Be $true
    }

    It "Validates pattern documentation" {
        $docs = Get-PatternDocumentation -Pattern "pattern-name"
        $result = Test-PatternDocumentation -Documentation $docs
        $result | Should -Be $true
    }
}
```

### 4. Cross-System Knowledge Tests
```powershell
# Test cross-system knowledge integration
Describe "Cross-System Knowledge" {
    It "Validates command-knowledge relationships" {
        $command = "plan-mode: rules-workflow @template.mdc"
        $result = Test-CommandKnowledgeRelationship -Command $command
        $result | Should -Be $true
    }

    It "Validates parameter-knowledge relationships" {
        $parameter = "workflow-type"
        $result = Test-ParameterKnowledgeRelationship -Parameter $parameter
        $result | Should -Be $true
    }

    It "Validates documentation-knowledge relationships" {
        $doc = "parameters/standard/workflow-type.md"
        $result = Test-DocumentationKnowledgeRelationship -Document $doc
        $result | Should -Be $true
    }
}
```

## Enhanced Test Execution Checklist

### Phase 1: Knowledge System Tests
- [ ] Run fetch_rules tool tests
- [ ] Execute knowledge reference tests
- [ ] Perform pattern integration tests
- [ ] Validate cross-system knowledge tests
- [ ] Test knowledge access patterns

### Phase 2: Integration Tests
- [ ] Run command-knowledge integration tests
- [ ] Execute parameter-knowledge integration tests
- [ ] Perform documentation-knowledge integration tests
- [ ] Test pattern implementation
- [ ] Validate knowledge relationships

### Phase 3: Validation Tests
- [ ] Run knowledge format validation
- [ ] Execute pattern format validation
- [ ] Perform reference validation
- [ ] Test integration point validation
- [ ] Validate relationship consistency

### Phase 4: Documentation Tests
- [ ] Run knowledge documentation tests
- [ ] Execute pattern documentation tests
- [ ] Perform integration documentation tests
- [ ] Test relationship documentation
- [ ] Validate format consistency

## Test Environment Setup

### 1. Knowledge Test Data Setup
```powershell
# Create test knowledge components
New-TestKnowledgeComponent -Type "Pattern" -Path "knowledge/patterns/test" -Format "Markdown"
New-TestKnowledgeComponent -Type "Reference" -Path "knowledge/reference/test" -Format "Markdown"
New-TestKnowledgeComponent -Type "Guide" -Path "knowledge/guides/test" -Format "Markdown"
```

### 2. Pattern Test Data Setup
```powershell
# Create test patterns
New-TestPattern -Type "Implementation" -Name "test-pattern" -Format "Markdown"
New-TestPattern -Type "Documentation" -Name "test-doc-pattern" -Format "Markdown"
New-TestPattern -Type "Integration" -Name "test-integration" -Format "Markdown"
```

### 3. Integration Test Data Setup
```powershell
# Create test integration points
New-TestIntegrationPoint -Type "Command" -Name "test-command" -Knowledge "test-knowledge"
New-TestIntegrationPoint -Type "Parameter" -Name "test-param" -Knowledge "test-knowledge"
New-TestIntegrationPoint -Type "Documentation" -Name "test-doc" -Knowledge "test-knowledge"
``` 