# Test Cheatsheet: Performance Benchmarking

## Directory Structure Tests

### Test 1: Template Directory Migration
1. **Setup**: Verify that templates have been moved to appropriate standard directories
2. **Commands**:
   ```powershell
   # Check target directories exist
   Test-Path -Path "1000xbrain/knowledge/patterns/doc/templates"
   Test-Path -Path "1000xbrain/workflows/templates"
   Test-Path -Path "1000xbrain/parameters/templates"
   
   # Verify templates were moved
   Get-ChildItem -Path "1000xbrain/knowledge/patterns/doc/templates" -Recurse
   Get-ChildItem -Path "1000xbrain/workflows/templates" -Recurse
   Get-ChildItem -Path "1000xbrain/parameters/templates" -Recurse
   
   # Verify original templates directory is removed
   Test-Path -Path "1000xbrain/templates"
   ```
3. **Success Criteria**: 
   - Target directories exist
   - Template files present in appropriate directories
   - Original templates directory no longer exists

### Test 2: Cross-References Elimination
1. **Setup**: Verify cross-references.md has been eliminated and content integrated
2. **Commands**:
   ```powershell
   # Check cross-references.md no longer exists
   Test-Path -Path "1000xbrain/cross-references.md"
   
   # Search for integrated reference patterns in target files
   Select-String -Path "1000xbrain/parameters/*.md" -Pattern "Related Files|See Also|References"
   Select-String -Path "1000xbrain/workflows/*.md" -Pattern "Related Files|See Also|References"
   Select-String -Path "1000xbrain/knowledge/patterns/doc/*.md" -Pattern "Related Files|See Also|References"
   ```
3. **Success Criteria**: 
   - cross-references.md file no longer exists
   - Essential references integrated into appropriate files
   - Standardized reference patterns present in files

### Test 3: Directory Structure Alignment
1. **Setup**: Verify all components are properly housed in standard directories
2. **Commands**:
   ```powershell
   # List top-level directories
   Get-ChildItem -Path "1000xbrain" -Directory
   
   # Check for README.md files with responsibility boundaries
   Get-ChildItem -Path "1000xbrain" -Filter "README.md" -Recurse
   ```
3. **Success Criteria**: 
   - Only standard directories at top level (core, workflows, parameters, knowledge)
   - README.md files present with clear responsibility boundaries
   - Consistent naming patterns across directories

## Content Organization Tests

### Test 4: Content Consolidation
1. **Setup**: Verify redundant content has been eliminated
2. **Commands**:
   ```powershell
   # Check for duplicate content patterns
   $duplicatePattern = "mode system|message-command|project-rule-parameter|fetch_rules"
   $files = Get-ChildItem -Path "1000xbrain" -Filter "*.md" -Recurse
   
   foreach ($file in $files) {
       $content = Get-Content $file.FullName
       $matches = $content | Select-String -Pattern $duplicatePattern
       Write-Output "$($file.FullName): $($matches.Count) matches"
   }
   ```
3. **Success Criteria**: 
   - No excessive duplication of content across files
   - Clear sources of truth for key concepts
   - Proper cross-referencing between related files

### Test 5: File Organization
1. **Setup**: Verify files follow standardized organization patterns
2. **Commands**:
   ```powershell
   # Check for file structure patterns
   $structurePattern = "## File Purpose|## Overview|## Usage|## Related"
   $files = Get-ChildItem -Path "1000xbrain" -Filter "*.md" -Recurse
   
   foreach ($file in $files) {
       $content = Get-Content $file.FullName
       $matches = $content | Select-String -Pattern $structurePattern
       Write-Output "$($file.FullName): $($matches.Count) matches"
   }
   ```
3. **Success Criteria**: 
   - Files follow standardized structure templates
   - Consistent section organization across files
   - Clear hierarchical relationships between sections

### Test 6: Information Chunking
1. **Setup**: Verify information is organized into logical chunks
2. **Commands**:
   ```powershell
   # Check for chunking patterns
   $chunkPattern = "### |#### |> "
   $files = Get-ChildItem -Path "1000xbrain/workflows" -Filter "*.md" -Recurse
   
   foreach ($file in $files) {
       $content = Get-Content $file.FullName
       $chunks = $content | Select-String -Pattern $chunkPattern
       Write-Output "$($file.FullName): $($chunks.Count) chunks"
   }
   ```
3. **Success Criteria**: 
   - Information organized into logical, self-contained chunks
   - Consistent chunking patterns across files
   - Clear hierarchical relationships between chunks

## Reference Architecture Tests

### Test 7: Reference Pattern Optimization
1. **Setup**: Verify reference patterns are standardized
2. **Commands**:
   ```powershell
   # Check for reference patterns
   $referencePattern = "For .+, (use|see):|\[.+\]\(.+\)|`@.+\.md(c)?`"
   $files = Get-ChildItem -Path "1000xbrain" -Filter "*.md" -Recurse
   
   foreach ($file in $files) {
       $content = Get-Content $file.FullName
       $references = $content | Select-String -Pattern $referencePattern
       Write-Output "$($file.FullName): $($references.Count) references"
   }
   ```
3. **Success Criteria**: 
   - Standardized reference formats across files
   - Direct reference patterns where possible
   - Reduced complexity in reference chains

### Test 8: fetch_rules Optimization
1. **Setup**: Verify fetch_rules usage is optimized
2. **Commands**:
   ```powershell
   # Check for fetch_rules patterns
   $fetchPattern = "fetch_rules\(\["
   $files = Get-ChildItem -Path "1000xbrain/workflows" -Filter "*.md" -Recurse
   
   foreach ($file in $files) {
       $content = Get-Content $file.FullName
       $fetches = $content | Select-String -Pattern $fetchPattern
       Write-Output "$($file.FullName): $($fetches.Count) fetch_rules calls"
   }
   ```
3. **Success Criteria**: 
   - Optimized fetch_rules usage patterns
   - Grouped related knowledge access calls
   - Reduced unnecessary knowledge access operations

### Test 9: Reference Validation
1. **Setup**: Verify references are valid and resolvable
2. **Commands**:
   ```powershell
   # Extract file references
   $filePattern = "(see|use):\s+`([^`]+\.md(c)?)`"
   $files = Get-ChildItem -Path "1000xbrain" -Filter "*.md" -Recurse
   
   foreach ($file in $files) {
       $content = Get-Content $file.FullName
       $matches = $content | Select-String -Pattern $filePattern -AllMatches
       
       foreach ($match in $matches) {
           $reference = $match.Matches.Groups[2].Value
           $targetPath = Join-Path -Path "1000xbrain" -ChildPath $reference
           $exists = Test-Path -Path $targetPath
           Write-Output "Reference in $($file.Name) to $reference: $(if ($exists) { 'Exists' } else { 'Missing' })"
       }
   }
   ```
3. **Success Criteria**: 
   - All references resolve to existing files
   - No broken reference chains
   - Proper reference categorization and formatting

## Hallucination Prevention Tests

### Test 10: Structure Adherence
1. **Setup**: Verify strict adherence to documented structure
2. **Commands**:
   ```powershell
   # Verify directory structure
   $standardDirs = @("core", "workflows", "parameters", "knowledge")
   $dirs = Get-ChildItem -Path "1000xbrain" -Directory | Select-Object -ExpandProperty Name
   
   foreach ($dir in $dirs) {
       if ($standardDirs -contains $dir) {
           Write-Output "$dir: Standard directory"
       } else {
           Write-Output "$dir: Non-standard directory"
       }
   }
   ```
3. **Success Criteria**: 
   - Only standard directories at top level
   - All components housed in appropriate directories
   - No unauthorized structural elements

### Test 11: Boundary Enforcement
1. **Setup**: Verify explicit boundaries for system operations
2. **Commands**:
   ```powershell
   # Check for boundary definition patterns
   $boundaryPattern = "## (Prohibited|Authorized) Actions|⚠️|🚫|✅"
   $files = Get-ChildItem -Path "1000xbrain/core" -Filter "*.md" -Recurse
   
   foreach ($file in $files) {
       $content = Get-Content $file.FullName
       $boundaries = $content | Select-String -Pattern $boundaryPattern
       Write-Output "$($file.FullName): $($boundaries.Count) boundary definitions"
   }
   ```
3. **Success Criteria**: 
   - Clear boundary definitions in core files
   - Explicit authorization models for operations
   - Comprehensive error handling for boundary violations

### Test 12: Cognitive Load Management
1. **Setup**: Verify implementation of cognitive load management techniques
2. **Commands**:
   ```powershell
   # Check for cognitive load management patterns
   $cognitivePattern = "chunk|cognitive load|context window|progressive"
   $files = Get-ChildItem -Path "1000xbrain/core" -Filter "*.md" -Recurse
   
   foreach ($file in $files) {
       $content = Get-Content $file.FullName
       $cognitive = $content | Select-String -Pattern $cognitivePattern
       Write-Output "$($file.FullName): $($cognitive.Count) cognitive management references"
   }
   ```
3. **Success Criteria**: 
   - Optimized information chunk size
   - Efficient context window utilization strategies
   - Minimal context switches for common operations

## Performance Benchmark Tests

### Test 13: Information Access Efficiency
1. **Setup**: Measure information access efficiency
2. **Baseline**: Count steps to access key information before optimization
3. **Test Steps**:
   - Map access path for key concepts through file structure
   - Count steps to fully resolve key concepts
   - Measure fetch_rules calls needed for common tasks
4. **Success Criteria**: 
   - Reduced steps to access common information
   - More direct paths to key concepts
   - Fewer fetch_rules calls for related information

### Test 14: Context Switching Efficiency
1. **Setup**: Measure context switch reduction for common operations
2. **Baseline**: Count context switches before optimization
3. **Test Steps**:
   - Track transitions between files for common tasks
   - Count fetch_rules calls needed for implementation tasks
   - Measure information lookup requirements
4. **Success Criteria**: 
   - Reduced context switches for common operations
   - Lower cognitive load during task processing
   - More cohesive information organization

### Test 15: Resource Utilization
1. **Setup**: Measure context window utilization efficiency
2. **Baseline**: Analyze context utilization before optimization
3. **Test Steps**:
   - Estimate token usage for key file access
   - Count information chunks needed for common tasks
   - Measure redundant information loading
4. **Success Criteria**: 
   - Improved context window utilization
   - Reduced administrative overhead
   - More efficient information packaging

## Post-Implementation Verification

### Test 16: Comprehensive Structure Validation
1. **Setup**: Perform end-to-end structure validation
2. **Commands**:
   ```powershell
   # Validate overall structure
   Get-ChildItem -Path "1000xbrain" -Directory | ForEach-Object {
       $dirName = $_.Name
       $files = Get-ChildItem -Path $_.FullName -Recurse -File | Measure-Object | Select-Object -ExpandProperty Count
       $readme = Test-Path -Path "$($_.FullName)/README.md"
       Write-Output "$dirName`: $files files, README.md: $readme"
   }
   ```
3. **Success Criteria**: 
   - All components in appropriate standard directories
   - README.md files present with clear responsibilities
   - Consistent organization throughout the codebase

### Test 17: Hallucination Prevention Verification
1. **Setup**: Verify hallucination prevention effectiveness
2. **Test Steps**:
   - Attempt to create non-existent files through references
   - Test reference resolution with invalid paths
   - Verify boundary enforcement for file operations
3. **Success Criteria**: 
   - No hallucination of non-existent files
   - Proper error handling for invalid references
   - Clear boundaries enforced for file operations

### Test 18: Documentation Quality Verification
1. **Setup**: Verify documentation completeness and quality
2. **Commands**:
   ```powershell
   # Check for documentation quality patterns
   $qualityPattern = "## File Purpose|## Overview|## Related|# .+ Summary"
   $files = Get-ChildItem -Path "1000xbrain" -Filter "*.md" -Recurse
   
   foreach ($file in $files) {
       $content = Get-Content $file.FullName
       $quality = $content | Select-String -Pattern $qualityPattern
       Write-Output "$($file.FullName): $($quality.Count) quality indicators"
   }
   ```
3. **Success Criteria**: 
   - Comprehensive documentation across components
   - Clear responsibility boundaries
   - Consistent quality indicators throughout documentation 