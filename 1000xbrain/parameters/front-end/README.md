# Front-End-Workflow Project-Rule-Parameters

This directory contains project-rule-parameters for the front-end-workflow system, organized into clear categories for improved usability and understanding.

## Directory Organization

The parameters/front-end/ directory is organized into the following structure:

```
1000xbrain/parameters/front-end/
├── plan-mode/               # Core plan-mode parameters
├── dev-mode/                # Core dev-mode parameters
├── direct-mode/             # Direct mode parameters
├── helpers/                 # Helper commands by category
│   ├── verification/        # Commands for verifying correctness
│   ├── analysis/            # Commands for analyzing components/hooks
│   ├── implementation/      # Commands for implementation guidance
│   ├── recovery/            # Commands for handling interruptions
│   ├── validation/          # Commands for validating structure
│   └── finalization/        # Commands for completing implementation
└── (root)                   # Legacy flat structure (being phased out)
```

This organization improves clarity about each command's purpose and promotes proper usage in appropriate contexts.

## Message-Command Categories

### Core Message-Commands

| Category | Message-Command | Purpose | Project-Rule-Parameter |
|----------|----------------|---------|------------------------|
| **Activation** | `plan-mode: front-end-workflow` | Start/switch to Planning Mode with 📋 indicator | `@parameters/front-end/plan-mode/*.mdc` |
| **Activation** | `dev-mode: front-end-workflow` | Start/switch to Developer Mode with 💻 indicator | `@parameters/front-end/dev-mode/*.mdc` |
| **Activation** | `direct-mode: front-end-workflow` | Skip planning, start direct implementation with ⚡ indicator | `@parameters/front-end/dev-mode/*.mdc` |
| **Continuation** | `continue-planning` | Continue planning with guidance | `@parameters/front-end/continuation/continue-planning.mdc` |
| **Continuation** | `continue-implementation` | Continue implementation | `@parameters/front-end/continuation/continue-implementation*.mdc` |

### Helper Message-Commands

Helper commands are specialized tools for specific front-end development purposes and are organized by function:

#### 1. Verification Helpers
- **Purpose**: Verify correctness and completeness of front-end components
- **Usage Timing**: After component creation, after implementation, or during quality checks
- **Commands**:
  - `verify-component`: Verify component implementation correctness
  - `verify-hook`: Verify custom hook implementation
  - `verify-context`: Verify React context implementation
  - `verify-types`: Verify TypeScript type definitions

#### 2. Analysis Helpers
- **Purpose**: Analyze existing components, hooks, and patterns
- **Usage Timing**: During analysis phase, reviewing existing code, or maintenance
- **Commands**:
  - `analyze-component`: Analyze React component structure and patterns
  - `explore-hooks`: Examine custom hook implementations
  - `map-state-flow`: Map application state flow
  - `analyze-logs`: Analyze front-end application logs

#### 3. Implementation Helpers
- **Purpose**: Guide specific implementation approaches for front-end features
- **Usage Timing**: During implementation phase, when implementing new features
- **Commands**:
  - `implement-component`: Create new React component
  - `implement-hook`: Create new custom hook
  - `implement-context`: Create new React context
  - `implement-api-integration`: Implement API integration

#### 4. Recovery Helpers
- **Purpose**: Resume interrupted or problematic implementations
- **Usage Timing**: When implementation was interrupted or needs continuation
- **Commands**:
  - `recover-implementation`: Resume interrupted implementation
  - `fix-component-issues`: Address component implementation issues
  - `recover-from-errors`: Recover from implementation errors

#### 5. Validation Helpers
- **Purpose**: Validate front-end code correctness and compliance
- **Usage Timing**: After making changes, during quality checks
- **Commands**:
  - `validate-component`: Validate component implementation
  - `validate-accessibility`: Check accessibility compliance
  - `validate-responsive-design`: Verify responsive design implementation
  - `validate-performance`: Check performance optimization

#### 6. Finalization Helpers
- **Purpose**: Complete and verify front-end implementation processes
- **Usage Timing**: At the end of implementation process
- **Commands**:
  - `finalize-component`: Complete component implementation with optimizations
  - `finalize-documentation`: Complete component documentation
  - `finalize-implementation`: Complete and verify implementation

## Usage Guidelines

### Helper Command Usage

Helper commands are standalone, specialized tools that:
1. Do not require workflow-type parameters
2. Perform targeted, specific functions
3. Should be used at specific points based on their category
4. Are designed as one-off, targeted commands rather than workflow steps

### When to Use Helper Commands

- **Verification Helpers**: After creating components or implementing features
- **Analysis Helpers**: When reviewing existing components or during maintenance
- **Implementation Helpers**: When beginning implementation with specific approaches
- **Recovery Helpers**: When implementation was interrupted and needs continuation
- **Validation Helpers**: After making changes that need verification
- **Finalization Helpers**: At the completion of implementation

### Command Sequence Examples

#### Component Implementation Sequence
```
analyze-component               # Analyze similar components
implement-component             # Implement new component
validate-accessibility          # Verify accessibility compliance
finalize-component              # Apply optimizations and finalize
```

#### API Integration Sequence
```
analyze-logs                    # Analyze current API usage patterns
implement-api-integration       # Implement new API integration
validate-performance            # Verify performance characteristics
finalize-implementation         # Complete and verify implementation
```

#### UI Enhancement Sequence
```
map-state-flow                  # Map application state flow
implement-hook                  # Implement custom hook for state management
implement-component             # Create component using the hook
finalize-documentation          # Complete documentation
```

## Log-Based Workflow

The front-end-workflow system specializes in log-based development, where application logs guide implementation:

- **Log Analysis**: `analyze-logs` command helps identify issues from application logs
- **Log Monitoring**: `watch-logs` command provides real-time log monitoring
- **Log Enhancement**: `add-logs` command improves logging for better debugging
- **Log-Driven Testing**: `recreate-ux-situation` creates test scenarios based on log analysis

This log-based approach:
1. Leverages application logs as the primary development guide
2. Focuses on user behavior and error patterns
3. Enables data-driven implementation decisions
4. Provides clear verification of fixes and improvements

## Direct Mode

Direct mode provides an immediate implementation pathway without creating a planning folder first:

```
direct-mode: front-end-workflow @optional-project-rule-parameter.mdc
prompt: [implementation details]
```

This mode:
1. Skips the planning phase entirely
2. Uses the ⚡ indicator for all responses
3. Requires a prompt with implementation details
4. Performs extensive research (minimum 20 tool calls) before implementation
5. Follows a research → implement → research → implement pattern
6. Maintains a clear implementation record despite not having a planning folder

## Cross-Workflow Integration

The front-end-workflow system includes integration with other workflows:

- **Back-End Integration**: Parameters for connecting with back-end API implementations
- **Documentation Integration**: Parameters for enhancing official documentation
- **Rules Integration**: Parameters for contributing to cognitive architecture

These cross-workflow integration parameters facilitate:
1. Seamless data flow between front-end and back-end
2. Consistent documentation across the system
3. Pattern sharing between workflows
4. Enhanced development productivity 