# Context Analysis: Front-End Patterns

## Existing Front-End Workflow Patterns

This document analyzes the existing front-end workflow patterns and identifies patterns that need to be standardized or enhanced to match the structure and comprehensiveness of the rules-workflow patterns.

## Component Pattern Documentation

The front-end-workflow already has strong component pattern documentation in `1000xbrain/workflows/front-end-workflow/component-patterns.md`, which covers:

1. **Basic Component Structure**
2. **Functional vs. Class Components**
3. **Component Composition**
4. **State Management Patterns**
5. **Prop Management Patterns**
6. **Event Handling Patterns**
7. **Performance Optimization Patterns**
8. **Rendering Optimization Patterns**
9. **Styling Patterns**
10. **Accessibility Patterns**

However, these patterns are not well integrated into a standardized workflow process and parameter structure.

## Tool Usage Patterns That Need Standardization

### Search Patterns

The front-end-workflow needs standardized search patterns for:

1. **Component Discovery**:
```typescript
// Find components by feature or functionality
codebase_search("authentication component", ["front-end/src/components"])

// Find specific component implementations
grep_search("export.*function.*Button", false, "front-end/src/components/**/*.tsx")

// Find component usage patterns
grep_search("import.*Button.*from", false, "front-end/src/**/*.tsx")
```

2. **Hook Pattern Discovery**:
```typescript
// Find custom hooks
grep_search("export.*function.*use", false, "front-end/src/hooks/**/*.ts")

// Find hook usage patterns
grep_search("use(State|Effect|Context|Reducer|Callback|Memo)", false, "front-end/src/components/**/*.tsx")

// Find specific hook implementations
codebase_search("authentication hook implementation", ["front-end/src/hooks"])
```

3. **State Management Discovery**:
```typescript
// Find context providers
grep_search("export.*Context.*Provider", false, "front-end/src/contexts/**/*.tsx")

// Find state management patterns
grep_search("useReducer|useContext", false, "front-end/src/**/*.tsx")

// Find global state implementations
codebase_search("global state management pattern", ["front-end/src/contexts", "front-end/src/store"])
```

### File Reading Patterns

The front-end-workflow needs standardized file reading patterns for:

1. **Component Analysis**:
```typescript
// Read entire component for analysis
read_file("front-end/src/components/[ComponentName].tsx", should_read_entire_file=true)

// Read specific sections of larger components
read_file("front-end/src/components/[LargeComponent].tsx", offset=50, limit=100)

// Read component test file for understanding behavior
read_file("front-end/src/components/[ComponentName].test.tsx", should_read_entire_file=true)
```

2. **Hook Analysis**:
```typescript
// Read custom hook implementation
read_file("front-end/src/hooks/[HookName].ts", should_read_entire_file=true)

// Read hook tests
read_file("front-end/src/hooks/[HookName].test.ts", should_read_entire_file=true)

// Read related utilities for hooks
read_file("front-end/src/utils/[UtilName].ts", should_read_entire_file=true)
```

3. **Context and State Analysis**:
```typescript
// Read context implementation
read_file("front-end/src/contexts/[ContextName].tsx", should_read_entire_file=true)

// Read reducer implementation
read_file("front-end/src/reducers/[ReducerName].ts", should_read_entire_file=true)

// Read store configuration
read_file("front-end/src/store/[StoreName].ts", should_read_entire_file=true)
```

### Code Editing Patterns

The front-end-workflow needs standardized code editing patterns for:

1. **Component Creation**:
```typescript
// Create new component
edit_file("front-end/src/components/[NewComponent].tsx",
          "Create new component implementing [feature]",
          "import React from 'react';\n\nexport interface [ComponentName]Props {\n  // props definition\n}\n\nexport const [ComponentName]: React.FC<[ComponentName]Props> = (props) => {\n  // implementation\n  return (\n    <div>\n      {/* component JSX */}\n    </div>\n  );\n};\n")

// Create component test
edit_file("front-end/src/components/[NewComponent].test.tsx",
          "Create tests for new component",
          "import { render, screen } from '@testing-library/react';\nimport { [ComponentName] } from './[ComponentName]';\n\ndescribe('[ComponentName]', () => {\n  test('renders correctly', () => {\n    // test implementation\n  });\n});\n")
```

2. **Hook Creation**:
```typescript
// Create new hook
edit_file("front-end/src/hooks/[NewHook].ts",
          "Create new hook implementing [feature]",
          "import { useState, useEffect } from 'react';\n\nexport const [HookName] = () => {\n  // hook implementation\n  return {\n    // return values\n  };\n};\n")

// Create hook test
edit_file("front-end/src/hooks/[NewHook].test.ts",
          "Create tests for new hook",
          "import { renderHook, act } from '@testing-library/react-hooks';\nimport { [HookName] } from './[HookName]';\n\ndescribe('[HookName]', () => {\n  test('works correctly', () => {\n    // test implementation\n  });\n});\n")
```

3. **Component Modification**:
```typescript
// Add feature to existing component
edit_file("front-end/src/components/[ExistingComponent].tsx",
          "Add [feature] to component",
          "// ... existing code ...\n\n// Add new state\nconst [newState, setNewState] = useState(initialValue);\n\n// Add new effect\nuseEffect(() => {\n  // effect implementation\n}, [dependencies]);\n\n// ... existing code ...\n\n// Update JSX\n<div>\n  {/* New feature JSX */}\n  {newState ? <NewFeature /> : null}\n</div>\n// ... existing code ...\n")
```

### Terminal Command Patterns

The front-end-workflow needs standardized terminal command patterns for:

1. **Type Checking**:
```typescript
// Check for TypeScript errors
run_terminal_cmd("cd front-end && npm run type-check", false, false)

// Run linting
run_terminal_cmd("cd front-end && npm run lint", false, false)
```

2. **Testing**:
```typescript
// Run tests for specific component
run_terminal_cmd("cd front-end && npm test -- [ComponentName]", false, false)

// Run all tests
run_terminal_cmd("cd front-end && npm test -- --watchAll=false", false, false)
```

3. **Log Analysis**:
```typescript
// View recent logs
run_terminal_cmd("Get-Content -Path \"logs-main/front-end/$(Get-Date -Format 'yyyy-MM-dd').log\" -Tail 50", false, false)

// Search for errors in logs
run_terminal_cmd("Get-ChildItem -Path \"logs-main/front-end\" -Filter \"*.log\" | Select-String -Pattern \"ERROR\" | Select-Object -Last 20", false, false)
```

### fetch_rules Knowledge Integration

The front-end-workflow needs standardized knowledge access patterns for:

1. **React Patterns**:
```typescript
// Access React component patterns
fetch_rules(["knowledge/patterns/front-end/react-component-patterns"], 
           "Accessing React component patterns for implementation")

// Access React hook patterns
fetch_rules(["knowledge/patterns/front-end/react-hook-patterns"], 
           "Accessing React hook patterns for implementation")
```

2. **State Management Patterns**:
```typescript
// Access state management patterns
fetch_rules(["knowledge/patterns/front-end/state-management-patterns"], 
           "Accessing state management patterns for implementation")

// Access context patterns
fetch_rules(["knowledge/patterns/front-end/context-patterns"], 
           "Accessing context patterns for implementation")
```

3. **Performance Optimization Patterns**:
```typescript
// Access performance optimization patterns
fetch_rules(["knowledge/patterns/front-end/performance-optimization-patterns"], 
           "Accessing performance optimization patterns for implementation")

// Access rendering optimization patterns
fetch_rules(["knowledge/patterns/front-end/rendering-optimization-patterns"], 
           "Accessing rendering optimization patterns for implementation")
```

## Mode-Specific Pattern Requirements

### Plan-Mode Front-End Workflow Patterns

The front-end-workflow needs standardized plan-mode patterns for:

1. **Component Planning**:
   - Structure and organization planning
   - Props and state planning
   - Component hierarchy planning
   - Lifecycle and effects planning

2. **State Management Planning**:
   - State structure planning
   - State flow planning
   - Context design planning
   - Reducer action planning

3. **API Integration Planning**:
   - API interface planning
   - Data fetching strategy planning
   - Error handling planning
   - Loading state planning

### Dev-Mode Front-End Workflow Patterns

The front-end-workflow needs standardized dev-mode patterns for:

1. **Component Implementation**:
   - Implementation sequencing
   - Progressive feature implementation
   - Test-driven implementation
   - Refactoring strategies

2. **Hook Implementation**:
   - Custom hook creation steps
   - Hook testing approaches
   - Hook dependency management
   - Hook optimization

3. **Context Implementation**:
   - Context setup sequence
   - Provider implementation
   - Consumer integration
   - Context testing strategies

### Direct-Mode Front-End Workflow Patterns

The front-end-workflow needs standardized direct-mode patterns for:

1. **Quick Component Creation**:
   - Research > Implementation > Verification
   - Standard scaffolding
   - Integrated testing
   - Automatic documentation

2. **Bug Fixing**:
   - Research > Analysis > Fix > Verification
   - Error trace analysis
   - Root cause identification
   - Targeted fixing

3. **Feature Enhancement**:
   - Research > Planning > Implementation > Testing
   - Progressive enhancement
   - Backward compatibility
   - Integrated test updating

## Pattern Integration Requirements

To fully enhance the front-end-workflow patterns, the implementation must:

1. **Create Standard Pattern Files**:
   - Develop structured pattern files for each category
   - Ensure consistent formatting and organization
   - Include comprehensive examples
   - Add clear usage guidance

2. **Integrate Patterns into Parameter Structure**:
   - Embed relevant patterns in parameter files
   - Create clear cross-references
   - Ensure consistent usage across parameter types
   - Maintain pattern evolution over time

3. **Document Pattern Usage**:
   - Create pattern-specific documentation
   - Include real-world examples
   - Provide clear tool call sequences
   - Add troubleshooting guidance

4. **Establish Pattern Evolution Process**:
   - Define pattern versioning approach
   - Create pattern update workflow
   - Document pattern deprecation process
   - Establish pattern migration guidance

## Next Steps

Based on this pattern analysis, the implementation will focus on:

1. Creating standardized tool call pattern files
2. Developing mode-specific pattern documentation
3. Integrating patterns into parameter structure
4. Establishing pattern evolution and management processes
5. Documenting pattern usage with comprehensive examples 