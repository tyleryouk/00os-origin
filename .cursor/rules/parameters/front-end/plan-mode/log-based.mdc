# Plan Mode: Front-End Log-Based Approach

## File Purpose and Relationship

This file provides a planning template specifically designed for the log-based development approach in the GigaSwap project. It structures planning documentation to prepare for implementation that will leverage strategic logging for verification, debugging, and testing.

This file complements:
- **front-end-workflow-reference.md**: Core front-end development workflow
- **log-based-process.md**: Detailed log-based development process
- **dev-mode-log-based.md**: Implementation companion to this planning template

## Usage as Project-Rule-Parameter

This file is a Manual rule type and should be referenced as a project-rule-parameter in the plan-mode message-command:

```
plan-mode: front-end-workflow @parameters/front-end/plan-mode/plan-mode-log-based.mdc
```

## Log-Based Planning Structure

When this template is applied, the planning folder will be structured as follows:

```
planning/
  ├── requirements.md (Feature requirements with log-specific success criteria)
  ├── context-logging-strategy.md (Comprehensive logging strategy)
  ├── implementation-component.md (Component implementation with logging points)
  ├── implementation-log-analysis.md (Log analysis approach)
  ├── test-cheatsheet.md (Testing scenarios with expected log outputs)
  └── README.md (Overview)
```

## Log-Based Planning Process

### 1. Requirements with Log-Based Success Criteria

The requirements.md file should document standard requirements along with log-based success criteria:

```markdown
# Requirements: [Feature Name]

## Objective
[Clear statement of feature purpose and business value]

## Core Requirements
1. [Functional requirement 1]
2. [Functional requirement 2]
3. [Functional requirement 3]

## Log-Based Success Criteria
- Logs show successful component initialization with proper props
- Logs demonstrate correct state transitions during [key interaction]
- Error scenarios produce appropriate error logs with diagnostic information
- API interactions are properly logged with request/response details
- Performance-critical operations show acceptable timing in logs
```

### 2. Logging Strategy Planning

The context-logging-strategy.md file should document a comprehensive logging approach:

```markdown
# Logging Strategy: [Feature Name]

## Log Categories
1. **Initialization Logs**: Component mounting and initial props
2. **Interaction Logs**: User interactions and event handling
3. **State Transition Logs**: State changes and effects
4. **API Interaction Logs**: API requests and responses
5. **Performance Logs**: Timing of critical operations
6. **Error Logs**: Error conditions and handling

## Logging Points

### Component Lifecycle
- Component initialization
- Props changes
- Component unmounting

### State Management
- Initial state setup
- State update triggers
- State transition completion
- Derived state calculation

### User Interactions
- Input events
- Button clicks
- Form submissions
- Navigation actions

### API Interactions
- Request initiation
- Response receipt
- Error handling

### Error Conditions
- Input validation failures
- API errors
- Rendering exceptions

## Log Format Standards

### Standard Log Format
```
[ComponentName] Action/Description: { relevantData }
```

### Error Log Format
```
[ComponentName] ERROR - Description: { errorDetails, context }
```

### Performance Log Format
```
[ComponentName] PERF - Operation: duration
```

## Log Analysis Approach
- Group logs by component for workflow analysis
- Track state changes through sequential logs
- Analyze error patterns across related components
- Measure performance through timing logs
```

### 3. Component Implementation Planning with Logging

The implementation-component.md file should include logging in the implementation plan:

```markdown
# Implementation Plan: [Component Name]

## Component Structure
```typescript
interface Props {
  // Props definition
}

const [ComponentName]: React.FC<Props> = (props) => {
  // State definitions
  
  // Logging on initialization
  console.log('[ComponentName] Initializing with props:', props);
  
  // Effects with logging
  
  // Event handlers with logging
  
  // Render with conditional logging for complex logic
};
```

## Key Implementation Points with Logging

### State Management
```typescript
// State with initialization logging
const [state, setState] = useState<StateType>(() => {
  const initialState = // ... initialization logic
  console.log('[ComponentName] Initializing state:', initialState);
  return initialState;
});

// State updates with logging
const updateState = useCallback((newValue: StateType) => {
  console.log('[ComponentName] Updating state:', { current: state, new: newValue });
  setState(newValue);
}, [state]);
```

### Effect Implementation
```typescript
// Effect with comprehensive logging
useEffect(() => {
  console.log('[ComponentName] Effect running with dependencies:', dependencies);
  
  const performEffect = async () => {
    try {
      // Effect logic
      console.log('[ComponentName] Effect completed successfully');
    } catch (error) {
      console.error('[ComponentName] Effect error:', error);
    }
  };
  
  performEffect();
  
  return () => {
    console.log('[ComponentName] Effect cleanup');
  };
}, [dependencies]);
```

### Event Handler Implementation
```typescript
// Event handler with logging
const handleEvent = useCallback((event) => {
  console.log('[ComponentName] Handling event:', { event, type: event.type });
  
  try {
    // Event handling logic
    console.log('[ComponentName] Event handled successfully');
  } catch (error) {
    console.error('[ComponentName] Event handling error:', error);
  }
}, [dependencies]);
```

### API Interaction Implementation
```typescript
// API call with request/response logging
const fetchData = async () => {
  console.log('[ComponentName] Initiating API request:', { endpoint, params });
  
  try {
    setLoading(true);
    const response = await api.getData(params);
    console.log('[ComponentName] API response received:', response);
    
    setData(response.data);
    console.log('[ComponentName] State updated with API data');
  } catch (error) {
    console.error('[ComponentName] API error:', error);
    setError(error.message);
  } finally {
    setLoading(false);
  }
};
```
```

### 4. Log Analysis Implementation Planning

The implementation-log-analysis.md file should document the approach to analyzing logs:

```markdown
# Log Analysis Plan: [Feature Name]

## Log Collection Strategy
- Front-end application logs
- Network request logs
- Performance monitoring logs
- Error tracking logs

## Analysis Workflows

### Functional Verification Workflow
1. Check component initialization logs 
2. Verify proper props and initial state
3. Follow interaction log sequence
4. Confirm expected state transitions
5. Validate successful operation completion

### Error Diagnosis Workflow
1. Identify error logs and exception stack traces
2. Trace component state before error
3. Examine related component interactions
4. Review relevant API interactions
5. Analyze error patterns and frequency

### Performance Analysis Workflow
1. Collect timing logs for critical operations
2. Identify slow operations exceeding thresholds
3. Analyze component rendering frequency
4. Review state update patterns
5. Check for unnecessary re-renders

## Log Query Patterns

### Component Initialization Queries
```
grep "\\[ComponentName\\] Initializing" logs
```

### State Transition Queries
```
grep "\\[ComponentName\\] Updating state" logs
```

### Error Pattern Queries
```
grep "ERROR\\|Exception\\|failed" logs
```

### Performance Analysis Queries
```
grep "PERF" logs | sort -k5 -n
```

## Visualization Approaches
- Timeline view of component lifecycle
- State transition graphs
- Error frequency charts
- Performance heat maps
```

### 5. Testing with Expected Log Outputs

The test-cheatsheet.md file should include expected log patterns for testing:

```markdown
# Testing Cheatsheet: [Feature Name]

## Test Scenarios with Expected Logs

### Scenario 1: Normal Component Initialization
**Steps:**
1. Navigate to component
2. Observe initial render

**Expected Logs:**
```
[ComponentName] Initializing with props: { ... }
[ComponentName] Initializing state: { ... }
[ComponentName] Effect running with dependencies: ...
```

### Scenario 2: User Interaction
**Steps:**
1. Click interactive element
2. Enter input data
3. Submit form

**Expected Logs:**
```
[ComponentName] Handling event: { event: "click", ... }
[ComponentName] Updating state: { current: {...}, new: {...} }
[ComponentName] Effect running with dependencies: ...
```

### Scenario 3: API Interaction
**Steps:**
1. Trigger action requiring API call
2. Wait for response
3. Verify UI update

**Expected Logs:**
```
[ComponentName] Initiating API request: { endpoint: "/api/resource", ... }
[ComponentName] API response received: { data: [...], ... }
[ComponentName] State updated with API data
```

### Scenario 4: Error Handling
**Steps:**
1. Trigger error condition (invalid input, etc.)
2. Observe error handling

**Expected Logs:**
```
[ComponentName] Validating input: { input: "...", valid: false }
[ComponentName] ERROR - Validation failed: { details: "..." }
```

### Scenario 5: Performance Critical Path
**Steps:**
1. Perform performance-sensitive operation
2. Check timing logs

**Expected Logs:**
```
[ComponentName] PERF - Starting operation
[ComponentName] PERF - Operation completed: 150ms
```

## UX Situation Instructions

To properly test this component, instruct Tyler to execute the following UX situation:

```
recreate-ux-situation: Please test the [ComponentName] by navigating to [path] and performing these steps:
1. [Step 1]
2. [Step 2]
3. [Step 3]
```

After execution, analyze logs using:

```
Get-Content -Path "logs-main/front-end/$(Get-Date -Format 'yyyy-MM-dd').log" -Tail 50
```
```

## Log-Based Planning Completion Checklist

Before signaling planning completion, verify:

1. **Requirements with Log-Based Success Criteria**:
   - All functional requirements are defined
   - Log-based success criteria are established for each key function

2. **Comprehensive Logging Strategy**:
   - Logging points are identified for all critical paths
   - Log formats are standardized for consistency
   - Analysis approaches are defined

3. **Implementation Plan with Logging**:
   - Component structure includes strategic logging points
   - State management includes proper logging
   - Error handling with appropriate error logging

4. **Log Analysis Plan**:
   - Collection strategy is defined
   - Analysis workflows are documented
   - Query patterns are established

5. **Testing with Expected Logs**:
   - Test scenarios include expected log outputs
   - UX situation instructions are clear
   - Log analysis commands are provided

Once all items are verified, signal completion with:

```
📋 1000xdev [front-end-workflow]

planning-document-complete
```

## Implementation Transition

After planning completion, transition to implementation with:

```
dev-mode: front-end-workflow @parameters/front-end/dev-mode/dev-mode-log-based.mdc
``` 