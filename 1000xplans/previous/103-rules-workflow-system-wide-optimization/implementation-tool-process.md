# Implementation Plan: Tool Call Process

## Overview

This document outlines the plan for implementing a strict tool call process that enforces the single source of truth approach. This process ensures that documentation in knowledge/system-structure/ is always updated first before making any changes to the system, creating a documentation-first workflow that maintains consistency and accuracy.

## Current State Analysis

### Existing Tool Call Patterns
- No standardized tool call sequence for updating documentation
- System structure changes often happen without documentation updates
- Inconsistent approaches to accessing knowledge before implementation
- No clear pattern for ensuring documentation-first implementation
- fetch_rules usage is ad-hoc rather than systematically integrated
- No clear enforcement of domain access restrictions

### Problems with Current Approach
1. **Documentation Lag**: Implementation often proceeds without documentation updates
2. **Inconsistent Patterns**: Different tool call patterns across parameters and modes
3. **Missing Knowledge Context**: Implementation sometimes proceeds without proper knowledge
4. **No Verification**: Few mechanisms to verify documentation was updated first
5. **Inconsistent References**: Knowledge references vary widely across implementations
6. **Domain Access Violations**: No clear enforcement of domain access restrictions

## Target Tool Call Process

The implementation will establish standardized tool call processes for each pathway, with these common elements:

### Core Tool Call Sequence

Every implementation must follow this sequence:

1. **Knowledge Access**: Use fetch_rules to access relevant knowledge/system-structure/ files
2. **Documentation Update**: Edit knowledge/system-structure/ files FIRST
3. **System Implementation**: Only after documentation is updated, implement system changes

### Domain Access Enforcement

Each tool call sequence must respect the domain access restrictions for the pathway:

- **system-wide and system-wide-optimization**: Can access all of 1000xbrain/**
- **subsystem-core**: Limited to knowledge/system-structure/ and core/ in dev-mode
- **subsystem-knowledge**: Limited to knowledge/system-structure/ and knowledge/ in dev-mode
- **subsystem-parameters**: Limited to knowledge/system-structure/ and parameters/ in dev-mode
- **subsystem-workflows**: Limited to knowledge/system-structure/ and workflows/ in dev-mode
- **workflows**: Access depends on workflow-type, following subsystem patterns

### Pathway-Specific Extensions

Each pathway will have specific extensions to this core sequence:

- **system-wide pathway**: Emphasizes comprehensive documentation updates
- **subsystem-specific pathways**: Focus on subsystem-specific documentation
- **workflow pathway**: Emphasizes cross-subsystem documentation consistency

## Implementation Approach

The implementation will follow these sequential steps:

### 1. Process Definition
- Define the core tool call sequence in detail
- Create pathway-specific variations
- Document required parameters for each tool call
- Establish order dependencies between tool calls
- Define domain access restrictions for each pathway

### 2. Template Creation
- Create standardized tool call templates for each pathway
- Include complete examples with realistic content
- Document the reasoning behind each step
- Create error handling guidelines
- Include domain access enforcement guidelines

### 3. Knowledge Integration
- Define specific fetch_rules patterns for each pathway
- Create clear examples of knowledge/system-structure/ file access
- Document which files should be accessed for different scenarios
- Create guidance for handling missing or incomplete knowledge

### 4. Documentation-First Enforcement
- Create verification steps to ensure documentation is updated first
- Define rollback procedures for incomplete documentation updates
- Establish checks for documentation completeness
- Create links between documentation updates and implementation steps

### 5. Domain Access Enforcement
- Create verification steps to ensure domain access restrictions are respected
- Document clear boundaries for each pathway
- Establish checks for domain access compliance
- Include domain verification in the tool call process

### 6. Parameter Integration
- Update all parameter templates to include the standardized tool call process
- Ensure consistent implementation across plan-mode and dev-mode
- Verify that all parameters enforce the documentation-first approach
- Create examples of proper tool call usage for each parameter
- Include domain access specifications in each parameter

## Tool Call Process Details

### Core Tool Call Sequence

#### 1. Knowledge Access
```typescript
// ALWAYS START by accessing relevant knowledge
fetch_rules(["knowledge/system-structure/[relevant-file]"], 
          "Understanding [specific aspect] before making changes")

// For multiple knowledge files
fetch_rules([
  "knowledge/system-structure/[relevant-file-1]",
  "knowledge/system-structure/[relevant-file-2]"
], "Building comprehensive understanding of [aspect] before implementation")
```

#### 2. Documentation Update
```typescript
// AFTER accessing knowledge, ALWAYS update documentation FIRST
edit_file("1000xbrain/knowledge/system-structure/[relevant-file].md",
          "Update [aspect] documentation to reflect changes",
          "Updated content...")

// For multiple documentation updates
edit_file("1000xbrain/knowledge/system-structure/[relevant-file-1].md",
          "Update primary documentation for [aspect]",
          "Updated content...")
          
edit_file("1000xbrain/knowledge/system-structure/[relevant-file-2].md",
          "Update related documentation for [aspect]",
          "Updated content...")
```

#### 3. System Implementation
```typescript
// ONLY AFTER documentation is updated, implement system changes
// IMPORTANT: Respect domain access restrictions for the pathway
edit_file("1000xbrain/[relevant-subsystem]/[file].md",
          "Implement [aspect] changes based on updated documentation",
          "Implementation content...")

// For multiple implementation files
edit_file("1000xbrain/[relevant-subsystem]/[file-1].md",
          "Implement primary changes for [aspect]",
          "Implementation content...")
          
edit_file("1000xbrain/[relevant-subsystem]/[file-2].md",
          "Implement related changes for [aspect]",
          "Implementation content...")
```

### Domain Access Verification
```typescript
// Verify that file edits respect domain access restrictions
// Example for subsystem-core pathway in dev-mode
// ALLOWED: Edit files in knowledge/system-structure/ and core/
edit_file("1000xbrain/knowledge/system-structure/subsystem-core.md", ...)
edit_file("1000xbrain/core/[file].md", ...)

// NOT ALLOWED: Edit files in other subsystems
// edit_file("1000xbrain/knowledge/[file].md", ...) // DOMAIN ACCESS VIOLATION!
// edit_file("1000xbrain/parameters/[file].md", ...) // DOMAIN ACCESS VIOLATION!
// edit_file("1000xbrain/workflows/[file].md", ...) // DOMAIN ACCESS VIOLATION!
```

### Pathway-Specific Tool Call Processes

#### system-wide Pathway
```typescript
// Domain Access: Full read and edit access to all of 1000xbrain/**

// 1. ACCESS SYSTEM ARCHITECTURE KNOWLEDGE
fetch_rules([
  "knowledge/system-structure/system-architecture",
  "knowledge/system-structure/workflow-subsystem-relationships"
], "Understanding the system architecture before making system-wide changes")

// 2. UPDATE SYSTEM DOCUMENTATION FIRST
edit_file("1000xbrain/knowledge/system-structure/system-architecture.md",
          "Update system architecture documentation to reflect changes",
          "Updated content...")
          
edit_file("1000xbrain/knowledge/system-structure/workflow-subsystem-relationships.md",
          "Update workflow-subsystem relationships documentation",
          "Updated content...")

// 3. IMPLEMENT SYSTEM-WIDE CHANGES
// First in core subsystem
edit_file("1000xbrain/core/system-organization.md",
          "Implement system architecture changes in core subsystem",
          "Implementation content...")

// Then in other subsystems as needed
edit_file("1000xbrain/[other-subsystem]/[file].md",
          "Implement corresponding changes in [other-subsystem]",
          "Implementation content...")
```

#### subsystem-core Pathway
```typescript
// Domain Access: 
// - Plan-Mode: Read access to all of 1000xbrain
// - Dev-Mode: Edit access to 1000xbrain/knowledge/system-structure/ and 1000xbrain/core/

// 1. ACCESS CORE SUBSYSTEM KNOWLEDGE
fetch_rules([
  "knowledge/system-structure/subsystem-core",
  "knowledge/system-structure/system-architecture"
], "Understanding the core subsystem before making changes")

// 2. UPDATE CORE DOCUMENTATION FIRST
edit_file("1000xbrain/knowledge/system-structure/subsystem-core.md",
          "Update core subsystem documentation to reflect changes",
          "Updated content...")

// Only if needed, update system architecture
edit_file("1000xbrain/knowledge/system-structure/system-architecture.md",
          "Update system architecture documentation to reflect core changes",
          "Updated content...")

// 3. IMPLEMENT CORE SUBSYSTEM CHANGES
// ONLY modify files within the core subsystem (dev-mode domain restriction)
edit_file("1000xbrain/core/[file].md",
          "Implement core subsystem changes based on updated documentation",
          "Implementation content...")

// DO NOT modify files in other subsystems (domain access restriction)
// edit_file("1000xbrain/knowledge/[file].md", ...) // DOMAIN ACCESS VIOLATION!
// edit_file("1000xbrain/parameters/[file].md", ...) // DOMAIN ACCESS VIOLATION!
// edit_file("1000xbrain/workflows/[file].md", ...) // DOMAIN ACCESS VIOLATION!
```

[Similar details for each pathway...]

#### workflows Pathway
```typescript
// Domain Access: Follows the relevant subsystem access patterns based on the workflow-type

// 1. ACCESS WORKFLOW AND SUBSYSTEM RELATIONSHIP KNOWLEDGE
fetch_rules([
  "knowledge/system-structure/workflow-subsystem-relationships",
  "knowledge/system-structure/system-architecture"
], "Understanding workflow relationships before making changes to [workflow-type]")

// 2. UPDATE WORKFLOW DOCUMENTATION FIRST
edit_file("1000xbrain/knowledge/system-structure/workflow-subsystem-relationships.md",
          "Update workflow relationships documentation to reflect changes",
          "Updated content...")

// 3. IMPLEMENT WORKFLOW CHANGES ACROSS SUBSYSTEMS
// Implementation must follow domain access patterns for the workflow type
// The order of changes should respect subsystem relationships

// First in knowledge subsystem
edit_file("1000xbrain/knowledge/[workflow-type]/[file].md",
          "Implement [workflow-type] changes in knowledge subsystem",
          "Implementation content...")

// Then in parameters subsystem
edit_file("1000xbrain/parameters/[workflow-type]/[file].md",
          "Implement corresponding changes in parameters subsystem",
          "Implementation content...")

// Then in workflows subsystem
edit_file("1000xbrain/workflows/[workflow-type]/[file].md",
          "Implement corresponding changes in workflows subsystem",
          "Implementation content...")
```

## Documentation Verification Process

To verify that documentation was updated properly before implementation, each tool call process will include:

### 1. Pre-Implementation Verification
```typescript
// After updating documentation, verify before implementation
read_file("1000xbrain/knowledge/system-structure/[relevant-file].md", [line_range], [line_count])
```

### 2. Domain Access Verification
```typescript
// Verify that implementation respects domain access restrictions
// For example, in subsystem-core pathway, check that changes are limited to:
// - 1000xbrain/knowledge/system-structure/**
// - 1000xbrain/core/**
grep_search("edit_file\\(\"1000xbrain/((?!knowledge/system-structure|core).)*\"", true, "tool_call_history.txt")
// Should return no results, indicating no edits outside allowed domains
```

### 3. Post-Implementation Consistency Check
```typescript
// After implementation, verify documentation consistency
grep_search("[relevant_term]", false, "1000xbrain/knowledge/system-structure/**/*.md")
grep_search("[relevant_term]", false, "1000xbrain/[relevant_subsystem]/**/*.md")
```

### 4. Explicit Phase Signaling
```typescript
// Signal clear phase transitions in the implementation
// After documentation updates
// [MESSAGE]: "Documentation updates complete. Proceeding to implementation."

// After domain access verification
// [MESSAGE]: "Domain access verification complete. Implementation respects domain restrictions."

// After implementation complete
// [MESSAGE]: "Implementation complete. Verifying consistency."
```

## Tool Call Templates

### Default Tool Call Template

```typescript
// TEMPLATE: Standard tool call process with verification

// 1. ACCESS KNOWLEDGE
fetch_rules([
  "knowledge/system-structure/[relevant-file-1]",
  "knowledge/system-structure/[relevant-file-2]"
], "Understanding [aspect] before making changes")

// 2. UPDATE DOCUMENTATION FIRST
edit_file("1000xbrain/knowledge/system-structure/[relevant-file-1].md",
          "Update [aspect] documentation to reflect changes",
          "Updated content...")

// 3. VERIFY DOCUMENTATION UPDATES
read_file("1000xbrain/knowledge/system-structure/[relevant-file-1].md", [line_range], [line_count])

// 4. INDICATE TRANSITION
// [MESSAGE]: "Documentation updates complete. Proceeding to implementation."

// 5. IMPLEMENT CHANGES (RESPECTING DOMAIN ACCESS RESTRICTIONS)
// Only modify files within the allowed domains for this pathway
edit_file("1000xbrain/[allowed-subsystem]/[file-1].md",
          "Implement [aspect] changes based on updated documentation",
          "Implementation content...")

// 6. VERIFY IMPLEMENTATION
read_file("1000xbrain/[allowed-subsystem]/[file-1].md", [line_range], [line_count])

// 7. CHECK CONSISTENCY
grep_search("[relevant_term]", false, "1000xbrain/knowledge/system-structure/**/*.md")
grep_search("[relevant_term]", false, "1000xbrain/[allowed-subsystem]/**/*.md")

// 8. INDICATE COMPLETION
// [MESSAGE]: "Implementation complete. Documentation and implementation are consistent."
```

## Parameter Integration

All project-rule-parameters will be updated to include the standardized tool call process. Parameters will:

1. Explicitly describe the required tool call sequence
2. Include complete examples with realistic content
3. Explain the reasoning behind the documentation-first approach
4. Provide clear guidelines for handling edge cases
5. Clearly document domain access restrictions
6. Include verification steps for domain access compliance

## Domain Access Enforcement

The tool call process must enforce these domain access restrictions:

### system-wide and system-wide-optimization
- **Domain Access**: Full read and edit access to all of 1000xbrain/**
- All tool calls for editing files within 1000xbrain are allowed

### subsystem-core
- **Plan-Mode**: Read access to all of 1000xbrain
- **Dev-Mode**: Edit access limited to:
  - 1000xbrain/knowledge/system-structure/**
  - 1000xbrain/core/**
- Tool calls must be verified to respect these restrictions

### subsystem-knowledge
- **Plan-Mode**: Read access to all of 1000xbrain
- **Dev-Mode**: Edit access limited to:
  - 1000xbrain/knowledge/system-structure/**
  - 1000xbrain/knowledge/**
- Tool calls must be verified to respect these restrictions

### subsystem-parameters
- **Plan-Mode**: Read access to all of 1000xbrain
- **Dev-Mode**: Edit access limited to:
  - 1000xbrain/knowledge/system-structure/**
  - 1000xbrain/parameters/**
- Tool calls must be verified to respect these restrictions

### subsystem-workflows
- **Plan-Mode**: Read access to all of 1000xbrain
- **Dev-Mode**: Edit access limited to:
  - 1000xbrain/knowledge/system-structure/**
  - 1000xbrain/workflows/**
- Tool calls must be verified to respect these restrictions

### workflows
- **Domain Access**: Follows the relevant subsystem domain access patterns
- Tool calls must coordinate changes across subsystems in the correct order

## Success Criteria

The tool call process implementation will be successful when:

1. All parameters enforce the documentation-first approach
2. Tool call sequences are consistent across all parameters
3. Knowledge access is standardized and comprehensive
4. Documentation verification is integrated into all processes
5. Implementation always follows documentation updates
6. Cross-references between documentation and implementation are maintained
7. Domain access restrictions are clearly defined and enforced for each pathway
8. Tool call processes include domain access verification steps

This implementation will create a robust, consistent tool call process that enforces the single source of truth approach and domain access restrictions, improving documentation accuracy and system consistency. 