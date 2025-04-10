# Context Analysis: Helper Commands

## Current Helper Command Structure

The front-end-workflow currently has several helper command parameter files, but they are organized in a flat structure rather than grouped into logical subdirectories. This document analyzes the current state of helper commands and outlines the target organization structure that mirrors the rules-workflow.

## Existing Helper Command Files

Current helper command files in the front-end parameters directory include:

1. **Component Analysis Commands**:
   - `analyze-component.md`: Provides component analysis functionality
   - `explore-hooks.md`: Offers hook exploration capabilities
   - `map-state-flow.md`: Maps state flow through components

2. **API Integration Commands**:
   - `document-api-integration.md`: Helps document API integration

3. **Log Analysis Commands**:
   - `add-logs.md`: Adds logging functionality
   - `analyze-logs.md`: Analyzes log files
   - `watch-logs.md`: Monitors logs in real-time

4. **UX Testing Commands**:
   - `recreate-ux-situation.md`: Recreates user experience testing scenarios
   - `ux-situation.md`: Defines user experience testing scenarios

These files are currently stored directly in the `1000xbrain/parameters/front-end/` directory without any subdirectory organization.

## Target Helper Command Organization

The rules-workflow organizes helper commands into logical subdirectories based on their function. The front-end-workflow should adopt a similar structure:

```
1000xbrain/parameters/front-end/helpers/
├── recovery/        # Error recovery commands
├── finalization/    # Completion and finalization commands
├── validation/      # Validation and verification commands
├── implementation/  # Implementation-specific commands
├── analysis/        # Analysis and exploration commands
├── verification/    # Testing and verification commands
└── README.md        # Overview and guidance
```

## Migration Plan for Existing Helper Commands

The existing helper command files should be migrated to the appropriate subdirectories based on their function:

1. **analysis/**:
   - `analyze-component.md` → `analysis/analyze-component.md`
   - `explore-hooks.md` → `analysis/explore-hooks.md`
   - `map-state-flow.md` → `analysis/map-state-flow.md`
   - `analyze-logs.md` → `analysis/analyze-logs.md`

2. **implementation/**:
   - `add-logs.md` → `implementation/add-logs.md`
   - `document-api-integration.md` → `implementation/document-api-integration.md`

3. **verification/**:
   - `recreate-ux-situation.md` → `verification/recreate-ux-situation.md`
   - `ux-situation.md` → `verification/ux-situation.md`
   - `watch-logs.md` → `verification/watch-logs.md`

## Missing Helper Command Categories

Comparing with the rules-workflow helper command structure, several categories of helper commands are missing from the front-end-workflow:

1. **recovery/**: Error recovery helpers are missing
   - Need to create `recovery/error-recovery.md`
   - Need to create `recovery/state-recovery.md`
   - Need to create `recovery/component-recovery.md`

2. **finalization/**: Completion and finalization helpers are missing
   - Need to create `finalization/component-finalization.md`
   - Need to create `finalization/documentation-finalization.md`
   - Need to create `finalization/implementation-finalization.md`

3. **validation/**: Validation helpers are missing
   - Need to create `validation/component-validation.md`
   - Need to create `validation/hook-validation.md`
   - Need to create `validation/state-validation.md`

## Helper Command Format Standardization

In addition to reorganizing the directory structure, the helper command files need to be standardized in format to match the rules-workflow helper commands:

1. **File Structure**:
   - Clear file purpose and usage section
   - Command syntax and parameters section
   - Example usage with real-world examples
   - Integration with other commands section
   - Troubleshooting guidance

2. **Tool Call Sequences**:
   - Standardized tool call sequences for common operations
   - Chained tool call patterns for complex operations
   - Error handling patterns
   - Verification sequences

3. **Code Examples**:
   - Consistent formatting for code examples
   - Clear comments for complex operations
   - Example output interpretation guidance
   - Implementation variations

## Helper Command Integration Requirements

The helper commands need to be properly integrated with the mode-specific parameters:

1. **Plan-Mode Integration**:
   - Plan-mode parameters should reference appropriate analysis helpers
   - Documentation creation should use appropriate helpers

2. **Dev-Mode Integration**:
   - Dev-mode parameters should reference appropriate implementation helpers
   - Error recovery should use appropriate recovery helpers
   - Testing should use appropriate verification helpers

3. **Direct-Mode Integration**:
   - Direct-mode parameters should reference appropriate implementation helpers
   - Research-first approach should use appropriate analysis helpers
   - Verification should use appropriate validation helpers

## README File Requirements

Each helpers subdirectory should have a README.md file that provides:

1. **Directory Purpose**: Clear explanation of the subdirectory's purpose
2. **File Listing**: List of files with brief descriptions
3. **Usage Guidance**: How to use helpers in this category
4. **Integration Points**: How these helpers integrate with mode-specific parameters
5. **Cross-References**: References to related helper categories

## Implementation Approach

The implementation of the helper command reorganization will follow this approach:

1. **Create Directory Structure**:
   - Create all required subdirectories
   - Create README.md files for each subdirectory

2. **Migrate Existing Files**:
   - Copy existing files to new locations
   - Update file references and cross-links
   - Ensure backward compatibility

3. **Standardize File Format**:
   - Update existing files to match standard format
   - Ensure consistent structure across all files
   - Add comprehensive examples and guidance

4. **Create Missing Files**:
   - Develop missing helper command files
   - Ensure comprehensive coverage of all required functionality
   - Follow established format and structure

5. **Update Integration Points**:
   - Update mode-specific parameters to reference new locations
   - Ensure proper integration with all workflow components
   - Establish clear cross-referencing system

## Tool Call Pattern Examples

Each helper command should include standardized tool call pattern examples:

### Component Analysis Pattern

```typescript
// Component Analysis Pattern
// 1. Find component
grep_search("export.*function.*ComponentName", false, "front-end/src/components/**/*.tsx")

// 2. Read component implementation
read_file("front-end/src/components/ComponentName.tsx", should_read_entire_file=true)

// 3. Find component usage
grep_search("import.*ComponentName.*from", false, "front-end/src/**/*.tsx")

// 4. Analyze component dependencies
grep_search("import.*from", false, "front-end/src/components/ComponentName.tsx")

// 5. Read dependency implementations as needed
read_file("front-end/src/hooks/useHookName.ts", should_read_entire_file=true)
```

### Log Analysis Pattern

```typescript
// Log Analysis Pattern
// 1. Check recent logs
run_terminal_cmd("Get-Content -Path \"logs-main/front-end/$(Get-Date -Format 'yyyy-MM-dd').log\" -Tail 50", false, false)

// 2. Search for errors
run_terminal_cmd("Get-ChildItem -Path \"logs-main/front-end\" -Filter \"*.log\" | Select-String -Pattern \"ERROR\" | Select-Object -Last 20", false, false)

// 3. Examine related component
read_file("front-end/src/components/ComponentName.tsx", should_read_entire_file=true)

// 4. Check related hook
read_file("front-end/src/hooks/useHookName.ts", should_read_entire_file=true)
```

### Implementation Pattern

```typescript
// Implementation Pattern
// 1. Read existing implementation
read_file("front-end/src/components/ComponentName.tsx", should_read_entire_file=true)

// 2. Make changes
edit_file("front-end/src/components/ComponentName.tsx",
          "Implement feature",
          "// ... existing code ...\n\n// Add new state\nconst [newState, setNewState] = useState(initialValue);\n\n// ... existing code ...\n\n// Update JSX\n<div>\n  {/* New feature */}\n  {newState && <NewFeature />}\n</div>\n// ... existing code ...\n")

// 3. Update tests
edit_file("front-end/src/components/ComponentName.test.tsx",
          "Update tests for new feature",
          "// ... existing code ...\n\ntest('renders new feature when state is true', () => {\n  // Test implementation\n});\n\n// ... existing code ...\n")

// 4. Verify changes
run_terminal_cmd("cd front-end && npm run type-check", false, false)
```

## Next Steps

Based on this context analysis, the implementation will focus on:

1. Creating the helpers directory structure with all required subdirectories
2. Developing README.md files for each subdirectory
3. Migrating existing helper command files to their new locations
4. Creating missing helper command files
5. Standardizing file format and structure
6. Ensuring proper integration with mode-specific parameters 