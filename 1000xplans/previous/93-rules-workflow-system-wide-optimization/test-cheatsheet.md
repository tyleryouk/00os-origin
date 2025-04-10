# Test Cheatsheet: Core Subsystem Optimization

This document provides a comprehensive testing framework for verifying the successful implementation of the core subsystem optimization.

## Message-Command Verification Tests

This section contains specialized tests for the message-command verification process to be used during dev-mode implementation. For the documentation of our current plan-mode testing methodology, see `message-command-processing-tests.md`.

### Basic Verification Tests

1. **Valid Message-Command Test**
   ```
   dev-mode rules-workflow performance @parameters/rules/dev-mode/performance.mdc none
   ```
   Expected: Verification succeeds, parameter is processed
   
2. **Mode Mismatch Test**
   ```
   plan-mode rules-workflow performance @parameters/rules/dev-mode/performance.mdc none
   ```
   Expected: "Error: Mode mismatch. Message-command specifies 'plan-mode' but parameter requires 'dev-mode'"
   
3. **Workflow-Type Mismatch Test**
   ```
   dev-mode front-end-workflow performance @parameters/rules/dev-mode/performance.mdc none
   ```
   Expected: "Error: Workflow-type mismatch. Message-command specifies 'front-end-workflow' but parameter requires 'rules-workflow'"
   
4. **Pathway-Name Mismatch Test**
   ```
   dev-mode rules-workflow documentation @parameters/rules/dev-mode/performance.mdc none
   ```
   Expected: "Error: Pathway-name mismatch. Message-command specifies 'documentation' but parameter requires 'performance'"
   
5. **Project-Rule-Parameter Mismatch Test**
   ```
   dev-mode rules-workflow performance @parameters/rules/dev-mode/documentation.mdc none
   ```
   Expected: "Error: Project-rule-parameter mismatch. Message-command specifies '@parameters/rules/dev-mode/documentation.mdc' but parameter requires '@parameters/rules/dev-mode/performance.mdc'"
   
6. **Optional-Standard-Parameter(s) Mismatch Test**
   ```
   dev-mode rules-workflow performance @parameters/rules/dev-mode/performance.mdc param1
   ```
   Expected: "Error: Optional-standard-parameter(s) mismatch. Message-command specifies 'param1' but parameter requires 'none'"

### Pathway-Name Specific Tests

1. **"none" vs. Specific Pathway Test**
   ```
   plan-mode rules-workflow none @parameters/rules/plan-mode/system-wide-optimization.mdc none
   ```
   Expected: "Error: Pathway-name mismatch. Message-command specifies 'none' but parameter requires 'system-wide-optimization'"

2. **Empty Pathway vs. Required Pathway Test**
   ```
   plan-mode rules-workflow @parameters/rules/plan-mode/system-wide-optimization.mdc none
   ```
   Expected: Error message about missing pathway-name component (malformed message-command)

3. **Special Character in Pathway Test**
   ```
   plan-mode rules-workflow system/wide-optimization @parameters/rules/plan-mode/system-wide-optimization.mdc none
   ```
   Expected: "Error: Pathway-name mismatch. Message-command specifies 'system/wide-optimization' but parameter requires 'system-wide-optimization'"

4. **Case Sensitivity in Pathway Test**
   ```
   plan-mode rules-workflow System-Wide-Optimization @parameters/rules/plan-mode/system-wide-optimization.mdc none
   ```
   Expected: "Error: Pathway-name mismatch. Message-command specifies 'System-Wide-Optimization' but parameter requires 'system-wide-optimization'"

### File Access Tests

1. **Parameter File Not Found Test**
   ```
   dev-mode rules-workflow performance @parameters/rules/dev-mode/nonexistent.mdc none
   ```
   Expected: "Error: Project-rule-parameter '@parameters/rules/dev-mode/nonexistent.mdc' not found"
   
2. **Malformed Header Test**
   ```
   dev-mode rules-workflow performance @parameters/rules/malformed-header.mdc none
   ```
   Expected: "Error: Malformed header in project-rule-parameter '@parameters/rules/malformed-header.mdc'"

3. **Missing Header Component Test**
   ```
   dev-mode rules-workflow performance @parameters/rules/incomplete-header.mdc none
   ```
   Expected: "Error: Incomplete header in project-rule-parameter '@parameters/rules/incomplete-header.mdc'. Missing required component: pathway"

4. **Unexpected Header Format Test**
   ```
   dev-mode rules-workflow performance @parameters/rules/unexpected-format-header.mdc none
   ```
   Expected: "Error: Malformed header in project-rule-parameter '@parameters/rules/unexpected-format-header.mdc'. Expected format: '# mode: [mode] | workflow: [workflow-type] | pathway: [pathway-name] | filepath: @[filepath].mdc | optional-standard-parameter(s): [params]'"

### Tool Access Comparison Tests

1. **read_file vs. fetch_rules Test**
   ```
   dev-mode rules-workflow performance @parameters/rules/dev-mode/performance.mdc none
   ```
   Expected: Both read_file and fetch_rules are attempted, with read_file demonstrating superior reliability

2. **Large Parameter Access Test**
   ```
   dev-mode rules-workflow system-wide-optimization @parameters/rules/dev-mode/system-wide-optimization.mdc none
   ```
   Expected: read_file successfully handles large parameter files while fetch_rules may have context limitations

3. **Complex Header Extraction Test**
   ```
   dev-mode rules-workflow complex-header @parameters/rules/dev-mode/complex-header.mdc none
   ```
   Expected: read_file permits more efficient header extraction than fetch_rules

4. **Nonexistent Parameter Error Handling Test**
   ```
   dev-mode rules-workflow performance @parameters/rules/dev-mode/nonexistent.mdc none
   ```
   Expected: read_file provides clearer error messages than fetch_rules for nonexistent parameters

5. **Tool Usage Optimization Implementation**
   ```typescript
   // OPTIMAL IMPLEMENTATION: Using read_file for project-rule-parameter access
   try {
     const parameter_path = project_rule_parameter.substring(1);
     const parameter_content = read_file(`.cursor/rules/${parameter_path}`, should_read_entire_file=true);
     
     // Extract header and continue verification...
   } catch (error) {
     return `${mode_indicator}\n\nError: Project-rule-parameter '${project_rule_parameter}' not found`;
   }
   
   // NON-OPTIMAL IMPLEMENTATION: Using fetch_rules for project-rule-parameter access
   try {
     const parameter_path = project_rule_parameter.substring(1);
     const parameter_content = fetch_rules([parameter_path]);
     
     // Less reliable extraction with potential context limitations...
   } catch (error) {
     return `${mode_indicator}\n\nError: Project-rule-parameter '${project_rule_parameter}' not found or inaccessible via fetch_rules`;
   }
   ```

6. **Tool Purpose Optimization Implementation**
   ```typescript
   // RECOMMENDED: Use read_file for project-rule-parameters
   const parameter_content = read_file(`.cursor/rules/${parameter_path}`, should_read_entire_file=true);
   
   // RECOMMENDED: Use fetch_rules for knowledge components
   const knowledge_content = fetch_rules(["knowledge/rules/patterns/tool/fetch-rules-patterns"], 
                                        "Understanding fetch_rules usage patterns");
   ```

### Verification Process Tests

1. **Tool Call Verification Test**
   ```
   dev-mode rules-workflow performance @parameters/rules/dev-mode/performance.mdc none
   ```
   Expected: Tool call to read_file is executed to access parameter content

2. **Failed Tool Call Recovery Test**
   ```
   dev-mode rules-workflow performance @parameters/rules/dev-mode/inaccessible.mdc none
   ```
   Expected: "Error: Unable to access project-rule-parameter '@parameters/rules/dev-mode/inaccessible.mdc'. File may be inaccessible or permissions may be insufficient."

3. **Mode Indicator Persistence Test**
   ```
   invalid-mode rules-workflow performance @parameters/rules/dev-mode/performance.mdc none
   ```
   Expected: Response still includes a mode indicator (fallback to default) despite invalid mode

4. **Component Extraction Validation Test**
   ```
   dev-mode rules-workflow performance @parameters/rules/dev-mode/corrupted-header.mdc none
   ```
   Expected: "Error: Unable to extract components from project-rule-parameter header in '@parameters/rules/dev-mode/corrupted-header.mdc'"

### Project-Rule-Parameter Processing Tests

1. **Tool Call Execution Test**
   ```
   dev-mode rules-workflow performance @parameters/rules/dev-mode/performance.mdc none
   ```
   Expected: After verification, tool calls specified in the parameter are executed
   
2. **Knowledge Access Test**
   ```
   dev-mode rules-workflow performance @parameters/rules/dev-mode/performance.mdc none
   ```
   Expected: After verification, knowledge components specified in the parameter are accessed

3. **Parameter Content Processing Test**
   ```
   dev-mode rules-workflow analysis @parameters/rules/dev-mode/analysis.mdc none
   ```
   Expected: After verification, parameter content is properly analyzed and processed before executing tool calls

4. **Complex Parameter Processing Test**
   ```
   dev-mode rules-workflow complex-scenario @parameters/rules/dev-mode/complex-scenario.mdc multi-param
   ```
   Expected: Complex parameters with multiple tools and knowledge components are properly processed

### Verification Process Test Sequence

The following test sequence verifies the complete verification process during implementation:

```typescript
// 1. Test valid message-command
testVerification("dev-mode rules-workflow performance @parameters/rules/dev-mode/performance.mdc none");
// Expected: Verification successful

// 2. Test mode mismatch
testVerification("plan-mode rules-workflow performance @parameters/rules/dev-mode/performance.mdc none");
// Expected: Mode mismatch error

// 3. Test workflow-type mismatch
testVerification("dev-mode front-end-workflow performance @parameters/rules/dev-mode/performance.mdc none");
// Expected: Workflow-type mismatch error

// 4. Test pathway-name mismatch
testVerification("dev-mode rules-workflow documentation @parameters/rules/dev-mode/performance.mdc none");
// Expected: Pathway-name mismatch error

// 5. Test project-rule-parameter mismatch
testVerification("dev-mode rules-workflow performance @parameters/rules/dev-mode/documentation.mdc none");
// Expected: Project-rule-parameter mismatch error

// 6. Test optional parameters mismatch
testVerification("dev-mode rules-workflow performance @parameters/rules/dev-mode/performance.mdc param1");
// Expected: Optional-standard-parameter(s) mismatch error

// 7. Test parameter file not found
testVerification("dev-mode rules-workflow performance @parameters/rules/dev-mode/nonexistent.mdc none");
// Expected: File not found error

// 8. Test malformed header
testVerification("dev-mode rules-workflow performance @parameters/rules/malformed-header.mdc none");
// Expected: Malformed header error

// 9. Test "none" vs specific pathway
testVerification("plan-mode rules-workflow none @parameters/rules/plan-mode/system-wide-optimization.mdc none");
// Expected: Pathway-name mismatch error

// 10. Test tool call execution verification
testVerification("dev-mode rules-workflow tool-call-verification @parameters/rules/dev-mode/tool-call-verification.mdc none", 
                {verifyToolCalls: true});
// Expected: Tool call executed to read parameter file

// 11. Test mode indicator persistence with error
testVerification("invalid-mode rules-workflow test @parameters/rules/invalid-test.mdc none");
// Expected: Response includes mode indicator despite invalid mode
```

### Implementation of Verification Function

```typescript
/**
 * Verify a message-command against its project-rule-parameter
 * 
 * @param {string} message_command - The message-command to verify
 * @param {object} options - Optional verification options
 * @returns {string} - Verification result with appropriate mode indicator
 */
function verifyMessageCommand(message_command, options = {}) {
  // 1. Parse message-command components
  const components = message_command.split(' ');
  if (components.length < 5) {
    return getDefaultModeIndicator(components) + 
      "\n\nError: Malformed message-command. Expected format: 'mode workflow-type pathway-name @project-rule-parameter.mdc optional-parameters'";
  }
  
  const mode = components[0];
  const workflow_type = components[1];
  const pathway_name = components[2];
  const project_rule_parameter = components[3];
  const optional_parameters = components[4];
  
  // 2. Set appropriate mode indicator
  const mode_indicator = getModeIndicator(mode, workflow_type);
  
  // 3. Verify project-rule-parameter format
  if (!project_rule_parameter.startsWith('@') || !project_rule_parameter.endsWith('.mdc')) {
    return `${mode_indicator}\n\nError: Malformed project-rule-parameter '${project_rule_parameter}'. Expected format: '@path/to/parameter.mdc'`;
  }
  
  // 4. Read the project-rule-parameter file
  try {
    const parameter_path = project_rule_parameter.substring(1); // Remove @ from start
    const parameter_content = read_file(`.cursor/rules/${parameter_path}`, should_read_entire_file=true);
    
    // 5. Extract and parse header
    const header = extractParameterHeader(parameter_content);
    if (!header) {
      return `${mode_indicator}\n\nError: Malformed header in project-rule-parameter '${project_rule_parameter}'`;
    }
    
    // 6. Extract components from header
    const headerComponents = parseHeaderComponents(header);
    if (!headerComponents) {
      return `${mode_indicator}\n\nError: Unable to extract components from project-rule-parameter header in '${project_rule_parameter}'`;
    }
    
    // 7. Component-by-component verification
    // Mode verification
    if (mode !== headerComponents.mode) {
      return `${mode_indicator}\n\nError: Mode mismatch. Message-command specifies '${mode}' but parameter requires '${headerComponents.mode}'`;
    }
    
    // Workflow-type verification
    if (workflow_type !== headerComponents.workflow) {
      return `${mode_indicator}\n\nError: Workflow-type mismatch. Message-command specifies '${workflow_type}' but parameter requires '${headerComponents.workflow}'`;
    }
    
    // Pathway-name verification
    if (pathway_name !== headerComponents.pathway) {
      return `${mode_indicator}\n\nError: Pathway-name mismatch. Message-command specifies '${pathway_name}' but parameter requires '${headerComponents.pathway}'`;
    }
    
    // Project-rule-parameter verification
    if (project_rule_parameter !== headerComponents.filepath) {
      return `${mode_indicator}\n\nError: Project-rule-parameter mismatch. Message-command specifies '${project_rule_parameter}' but parameter requires '${headerComponents.filepath}'`;
    }
    
    // Optional-standard-parameter(s) verification
    if (optional_parameters !== headerComponents.optional) {
      return `${mode_indicator}\n\nError: Optional-standard-parameter(s) mismatch. Message-command specifies '${optional_parameters}' but parameter requires '${headerComponents.optional}'`;
    }
    
    // 8. All components match, verification successful
    return `${mode_indicator}\n\nVerification successful. Processing parameter...`;
    
  } catch (error) {
    // Handle file access errors
    return `${mode_indicator}\n\nError: Project-rule-parameter '${project_rule_parameter}' not found`;
  }
}
```

## Line Count Verification

Use these commands to verify line count targets are met:

```powershell
# Verify total core line count (target: <2000 lines)
$coreLines = (Get-ChildItem -Path "1000xbrain/core/" -Recurse -Filter "*.md" | Where-Object { $_.Name -ne "README.md" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum
"Total core lines: $coreLines (Target: <2000)"

# Verify line counts by directory
$identityLines = (Get-ChildItem -Path "1000xbrain/core/identity/" -Recurse -Filter "*.md" | Where-Object { $_.Name -ne "README.md" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum
"Identity files: $identityLines lines (Target: <600)"

$modesLines = (Get-ChildItem -Path "1000xbrain/core/modes/" -Recurse -Filter "*.md" | Where-Object { $_.Name -ne "README.md" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum
"Modes files: $modesLines lines (Target: <800)"

$communicationLines = (Get-ChildItem -Path "1000xbrain/core/communication/" -Recurse -Filter "*.md" | Where-Object { $_.Name -ne "README.md" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum
"Communication files: $communicationLines lines (Target: <400)"

# Verify core-essentials.md line count
$essentialsLines = (Get-Content "1000xbrain/core/core-essentials.md" | Measure-Object -Line).Lines
"core-essentials.md: $essentialsLines lines (Target: <200)"
```

## Functionality Verification Tests

### Message-Command Format Tests

Test the new message-command format with these test cases:

1. **Basic Format Test**
   ```
   plan-mode rules-workflow documentation-pathway @template-basic.mdc none
   ```
   Expected: Successfully processes the command with pathway component

2. **Backward Compatibility Test**
   ```
   plan-mode rules-workflow none @template-basic.mdc none
   ```
   Expected: Successfully processes the command with "none" pathway component

3. **Invalid Format Test**
   ```
   plan-mode rules-workflow: documentation-pathway @template-basic.mdc none
   ```
   Expected: Error message about invalid format (unexpected colon)

4. **Multiple Parameters Test**
   ```
   plan-mode rules-workflow documentation-pathway @template-basic.mdc param1
   ```
   Expected: Successfully processes with standard parameters

5. **Multiple Spaces Test**
   ```
   plan-mode    rules-workflow    documentation-pathway    @template-basic.mdc    param1
   ```
   Expected: Successfully processes despite multiple spaces between components

6. **Direct Mode Standard Format Test**
   ```
   direct-mode rules-workflow documentation-pathway @template-basic.mdc param1
   prompt:
   ```
   Expected: Successfully processes the direct-mode command with standard format

7. **Direct Mode Simplified Format Test**
   ```
   direct-mode rules-workflow
   prompt:
   ```
   Expected: Successfully processes the direct-mode command with simplified format

### Mode System Verification Tests

Verify core identity and behavior preservation with these tests:

1. **Plan Mode Test**
   ```
   plan-mode rules-workflow none @template-basic.mdc none
   ```
   Expected: AI enters Planning Mode with correct indicator (📋 1000xdev [rules-workflow])

2. **Dev Mode Test**
   ```
   dev-mode front-end-workflow none @direct-implementation.mdc none
   ```
   Expected: AI enters Developer Mode with correct indicator (💻 1000xdev [front-end-workflow])

3. **Direct Mode Test**
   ```
   direct-mode back-end-workflow none @direct-implementation.mdc none
   prompt:
   ```
   Expected: AI enters Direct Mode with correct indicator (⚡ 1000xdev [back-end-workflow])

4. **Mode Transition Test**
   - Start in plan-mode
   - Complete planning process
   - Signal planning-document-complete
   - Transition to dev-mode
   Expected: Proper mode transition with clear indicator change

### Knowledge Access Tests

Verify knowledge migration with these tests:

1. **Basic Knowledge Access**
   ```typescript
   fetch_rules(["knowledge/rules/guides/architecture"], 
              "Understanding system architecture")
   ```
   Expected: Successfully accesses moved architectural knowledge

2. **Mode Knowledge Access**
   ```typescript
   fetch_rules(["knowledge/rules/reference/architecture/modes"], 
              "Understanding detailed mode implementation")
   ```
   Expected: Successfully accesses detailed mode information moved from core files

3. **Message-Command Knowledge Access**
   ```typescript
   fetch_rules(["knowledge/rules/reference/architecture/message-commands"], 
              "Understanding message-command format")
   ```
   Expected: Successfully accesses updated message-command format documentation

### Common-Words Verification

Verify terminology standardization with these checks:

1. **Registry Completeness**: Review common-words registry for completeness
2. **Terminology Consistency**: Verify consistent terminology usage across core files
3. **Relationship Documentation**: Check that term relationships are properly documented
4. **Format Standardization**: Verify kebab-case format for all terminology

## Content Verification Checklist

### Core Essentials Verification
- [ ] Contains all essential identity components
- [ ] Includes clear mode system overview
- [ ] Documents simplified message-commands
- [ ] Provides knowledge access guidance
- [ ] Highlights file safety requirements
- [ ] Maintains under 200 line count

### Mode System Verification
- [ ] All modes clearly documented
- [ ] Mode indicators properly formatted
- [ ] Mode transitions documented
- [ ] Implementation details moved to knowledge
- [ ] Maintains under 800 line count total

### Identity Verification
- [ ] Core identity preserved
- [ ] Role separation maintained
- [ ] Authorization matrix included
- [ ] Implementation details moved to knowledge
- [ ] Maintains under 600 line count total

### Communication Verification
- [ ] Updated message-command format documented
- [ ] Symbol usage guidelines clear
- [ ] Communication standards consistent
- [ ] Implementation examples moved to knowledge
- [ ] Maintains under 400 line count total

## Documentation Quality Tests

### Clarity Checks
- [ ] Clear, concise explanations
- [ ] Well-structured headings
- [ ] Logical organization
- [ ] Minimal redundancy
- [ ] Focused content

### Consistency Checks
- [ ] Consistent terminology
- [ ] Standardized formatting
- [ ] Uniform documentation style
- [ ] Consistent references
- [ ] Aligned headers

### Completeness Checks
- [ ] All essential concepts covered
- [ ] No critical information gaps
- [ ] Proper cross-referencing
- [ ] Knowledge access patterns documented
- [ ] Implementation guidance clear

## Verification Process Quality Checks

- [ ] Tool call inclusion verified
- [ ] Parameter file access confirmed
- [ ] Component extraction validated
- [ ] Mode indicator persistence confirmed
- [ ] Error message format standardized
- [ ] Component-by-component verification executed
- [ ] Response formatting consistency maintained

## Regression Tests

Perform these regression tests to ensure optimization hasn't broken functionality:

1. **Mode Transition Test**
   - Request planning documentation creation
   - Complete planning process
   - Transition to implementation
   - Expected: Full workflow functions without errors

2. **Knowledge Access Test**
   - Request domain-specific knowledge
   - Apply knowledge to implementation
   - Expected: Knowledge accessible and applicable

3. **Message-Command Test**
   - Use all core message-commands
   - Test with both old and new formats
   - Expected: All commands function correctly

4. **Identity Preservation Test**
   - Verify 1000xdev maintains proper identity
   - Check role separation is preserved
   - Expected: Identity and role clarity maintained

## Optimization Success Metrics

Track these metrics to verify optimization success:

1. **Line Count Reduction**
   - Starting total:
   - Final total:
   - Reduction percentage:
   - Target met: Yes/No

2. **Knowledge Migration**
   - Number of knowledge files created:
   - Implementation details moved:
   - Access patterns documented:
   - Migration complete: Yes/No

3. **Terminology Standardization**
   - Terms standardized:
   - Common-words registry completed:
   - Inconsistencies resolved:
   - Standardization complete: Yes/No

4. **Message-Command Format**
   - Documentation updated:
   - New format implemented:
   - Backward compatibility verified:
   - Format enhancement complete: Yes/No

5. **Verification Process Quality**
   - Tool call verification implemented: Yes/No
   - Component-by-component verification: Yes/No
   - Error message standardization: Yes/No
   - Mode indicator persistence: Yes/No

## Final Verification

Run this final verification checklist:

- [ ] All line count targets met
- [ ] All functionality tests passed
- [ ] Documentation quality verified
- [ ] Regression tests passed
- [ ] Knowledge access confirmed
- [ ] Common-words standardized
- [ ] Message-command format enhanced
- [ ] Verification process robust and reliable 

### Multiple Standard Parameters Tests

1. **Single Variable Parameter Test**
   ```
   direct-mode rules-workflow none @parameters/rules/direct-mode/add-project-rule-parameter.mdc new-file.md
   ```
   Expected: Verification succeeds, parameter is processed

2. **Multiple Parameters When One Expected Test**
   ```
   direct-mode rules-workflow none @parameters/rules/direct-mode/add-project-rule-parameter.mdc file1.md file2.md
   ```
   Expected: "Error: Optional-standard-parameter(s) mismatch. Message-command specifies multiple values 'file1.md file2.md' but parameter expects a single brain-file-name value"

3. **Multiple Variable Parameters Test**
   ```
   direct-mode rules-workflow none @parameters/rules/direct-mode/add-project-rule-parameter.mdc file1.md file2.md file3.md
   ```
   Expected: "Error: Optional-standard-parameter(s) mismatch. Message-command specifies multiple values 'file1.md file2.md file3.md' but parameter expects a single brain-file-name value"

### Parameter Typo Detection Tests

1. **Basic Typo Detection Test**
   ```
   direct-mode rules-workflow none @parameters/rules/direct-mode/add-project-rule-parameter.mdc tool-call-verfication.md
   ```
   Expected: "Error: Optional-standard-parameter(s) contains a typo. 'tool-call-verfication.md' should likely be 'tool-call-verification.md'"
   - This provides a helpful suggestion for the standard-parameter

2. **Multiple Word Typo Test**
   ```
   direct-mode rules-workflow none @parameters/rules/direct-mode/add-project-rule-parameter.mdc implemetation-anaylsis.md
   ```
   Expected: "Error: Optional-standard-parameter(s) contains a typo. 'implemetation-anaylsis.md' should likely be 'implementation-analysis.md'"
   - Multiple typos in standard-parameter are detected and suggested

3. **Compound Typo Detection Test**
   ```
   direct-mode rules-workflow none @parameters/rules/direct-mode/add-project-rule-parameter.mdc system-optimisation-documentaton.md
   ```
   Expected: "Error: Optional-standard-parameter(s) contains a typo. 'system-optimisation-documentaton.md' should likely be 'system-optimization-documentation.md'"
   - Multiple typos across different parts of the standard-parameter are detected

4. **No Typo Test with Similar Word**
   ```
   direct-mode rules-workflow none @parameters/rules/direct-mode/add-project-rule-parameter.mdc verification-process.md
   ```
   Expected: Verification succeeds, no typo detected
   - Similar but correctly spelled words pass verification

5. **Near-Miss Typo Test**
   ```
   direct-mode rules-workflow none @parameters/rules/direct-mode/add-project-rule-parameter.mdc veriffication.md
   ```
   Expected: Normal verification (current typo detection only finds exact matches in the typo dictionary)
   - Typos not in the dictionary are not detected

### Core Component Exact Matching Tests

1. **Mode Component Typo Test**
   ```
   directmode rules-workflow none @parameters/rules/direct-mode/add-project-rule-parameter.mdc verification.md
   ```
   Expected: "Error: Mode mismatch. Message-command specifies 'directmode' but parameter requires 'direct-mode'"
   - No typo detection applied to mode component - exact match required

2. **Workflow-Type Component Typo Test**
   ```
   direct-mode rulesworkflow none @parameters/rules/direct-mode/add-project-rule-parameter.mdc verification.md
   ```
   Expected: "Error: Workflow-type mismatch. Message-command specifies 'rulesworkflow' but parameter requires 'rules-workflow'"
   - No typo detection applied to workflow-type component - exact match required

3. **Pathway-Name Component Typo Test**
   ```
   direct-mode rules-workflow non @parameters/rules/direct-mode/add-project-rule-parameter.mdc verification.md
   ```
   Expected: "Error: Pathway-name mismatch. Message-command specifies 'non' but parameter requires 'none'"
   - No typo detection applied to pathway-name component - exact match required

4. **Project-Rule-Parameter Component Typo Test**
   ```
   direct-mode rules-workflow none @parameters/rules/directmode/add-project-rule-parameter.mdc verification.md
   ```
   Expected: "Error: Project-rule-parameter mismatch. Message-command specifies '@parameters/rules/directmode/add-project-rule-parameter.mdc' but parameter requires '@parameters/rules/direct-mode/add-project-rule-parameter.mdc'"
   - No typo detection applied to project-rule-parameter component - exact match required

5. **Multiple Component Typo Test**
   ```
   directmode rules-workflow non @parameters/rules/direct-mode/add-project-rule-parameter.mdc verification.md
   ```
   Expected: "Error: Mode mismatch. Message-command specifies 'directmode' but parameter requires 'direct-mode'"
   - First component mismatch is reported, subsequent components not checked

### Combined Parameter Tests

1. **Standard-Parameter Typo with Valid Components**
   ```
   direct-mode rules-workflow none @parameters/rules/direct-mode/add-project-rule-parameter.mdc implemetation-verfication.md
   ```
   Expected: "Error: Optional-standard-parameter(s) contains a typo. 'implemetation-verfication.md' should likely be 'implementation-verification.md'"
   - Typo detection helps with standard-parameter while core components match exactly

2. **Combined Error: Multiple Parameters with Typo**
   ```
   direct-mode rules-workflow none @parameters/rules/direct-mode/add-project-rule-parameter.mdc verfication.md file2.md
   ```
   Expected: "Error: Optional-standard-parameter(s) mismatch. Message-command specifies multiple values 'verfication.md file2.md' but parameter expects a single brain-file-name value"
   - Multiple parameter error takes precedence over typo detection

3. **Component Typo with Parameter Typo**
   ```
   direct-mod rules-workflow none @parameters/rules/direct-mode/add-project-rule-parameter.mdc verfication.md
   ```
   Expected: "Error: Mode mismatch. Message-command specifies 'direct-mod' but parameter requires 'direct-mode'"
   - Component mismatch takes precedence over standard-parameter typo

### Key Rule Implementation

```typescript
// Verification implementation with selective typo detection
function verifyMessageCommand(message_command) {
  // ... existing parsing and initialization ...
  
  // Exact component matching for core components
  if (mode !== header_mode) {
    return `${mode_indicator}\n\nError: Mode mismatch. Message-command specifies '${mode}' but parameter requires '${header_mode}'`;
  }
  
  if (workflow_type !== header_workflow) {
    return `${mode_indicator}\n\nError: Workflow-type mismatch. Message-command specifies '${workflow_type}' but parameter requires '${header_workflow}'`;
  }
  
  if (pathway_name !== header_pathway) {
    return `${mode_indicator}\n\nError: Pathway-name mismatch. Message-command specifies '${pathway_name}' but parameter requires '${header_pathway}'`;
  }
  
  if (project_rule_parameter !== header_filepath) {
    return `${mode_indicator}\n\nError: Project-rule-parameter mismatch. Message-command specifies '${project_rule_parameter}' but parameter requires '${header_filepath}'`;
  }
  
  // Multiple parameter check
  if (optional_parameters.includes(' ') && 
      header_optional.startsWith('[') && 
      header_optional.endsWith(']')) {
    const variable_name = header_optional.substring(1, header_optional.length - 1);
    return `${mode_indicator}\n\nError: Optional-standard-parameter(s) mismatch. Message-command specifies multiple values '${optional_parameters}' but parameter expects a single ${variable_name} value`;
  }
  
  // Apply typo detection ONLY to standard parameters
  if (header_optional.startsWith('[') && header_optional.endsWith(']')) {
    // Check for typos in variable parameters
    const typoError = detectTypos(optional_parameters, header_optional);
    if (typoError) {
      return typoError;
    }
    
    // Continue with pattern validation for variable parameter
    // ...
  } else if (optional_parameters !== header_optional) {
    // For non-variable parameters, require exact match
    return `${mode_indicator}\n\nError: Optional-standard-parameter(s) mismatch. Message-command specifies '${optional_parameters}' but parameter requires '${header_optional}'`;
  }
  
  // All components match - verification successful
  return `${mode_indicator}\n\nVerification successful.`;
}
``` 