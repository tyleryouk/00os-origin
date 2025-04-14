# Process: counter

## Metadata
- Name: counter
- Description: Simple counter example that demonstrates state persistence
- Category: examples
- Permissions: basic, process.state
- Author: 00reaper
- Version: 1.0

## Input
- action: Optional action to perform (increment, decrement, reset, set)
- value: Optional value for the set action

## Output
- Current counter value and status information

## Execution

This process demonstrates the use of the state management system to maintain a counter value between command executions. It shows how processes can use state to remember information across multiple invocations.

### Process Execution

```javascript
// Get state manager tools
const stateTools = tools.state;

// Get the current counter value from state (defaults to 0)
let counter = stateTools.get('value', 'process') || 0;

// Parse the current value as a number
if (typeof counter === 'string') {
  counter = parseInt(counter) || 0;
}

// Get action from input (default to 'get')
const action = inputs.action ? inputs.action.toLowerCase() : 'get';

// Track history of operations (uses process state)
const history = stateTools.get('history', 'process') || [];

// Get last execution timestamp
const lastExecution = stateTools.get('lastExecution', 'process') || 'Never';

// Process the action
switch (action) {
  case 'increment':
    counter += 1;
    history.push({ action: 'increment', timestamp: new Date().toISOString() });
    break;
    
  case 'decrement':
    counter -= 1;
    history.push({ action: 'decrement', timestamp: new Date().toISOString() });
    break;
    
  case 'reset':
    counter = 0;
    history.push({ action: 'reset', timestamp: new Date().toISOString() });
    break;
    
  case 'set':
    if (inputs.value !== undefined) {
      const newValue = parseInt(inputs.value);
      if (!isNaN(newValue)) {
        counter = newValue;
        history.push({ action: 'set', value: newValue, timestamp: new Date().toISOString() });
      } else {
        return `❌ Error: Invalid value "${inputs.value}" - must be a number`;
      }
    } else {
      return `❌ Error: The 'set' action requires a value parameter`;
    }
    break;
    
  case 'get':
    // Just return the current value - no change
    break;
    
  default:
    return `❌ Error: Unknown action "${action}"
    
Supported actions:
- increment: Add 1 to counter
- decrement: Subtract 1 from counter
- reset: Set counter to 0
- set <value>: Set counter to specific value
- get: Get current counter value (default)`;
}

// Keep history limited to last 10 operations
if (history.length > 10) {
  history.splice(0, history.length - 10);
}

// Calculate time since last execution
let timeSinceLastExecution = 'First execution';
if (lastExecution !== 'Never') {
  const lastTime = new Date(lastExecution);
  const now = new Date();
  const diffMs = now - lastTime;
  
  if (diffMs < 1000) {
    timeSinceLastExecution = `${diffMs}ms ago`;
  } else if (diffMs < 60000) {
    timeSinceLastExecution = `${Math.floor(diffMs / 1000)}s ago`;
  } else if (diffMs < 3600000) {
    timeSinceLastExecution = `${Math.floor(diffMs / 60000)}m ago`;
  } else {
    timeSinceLastExecution = `${Math.floor(diffMs / 3600000)}h ago`;
  }
}

// Update state with new values
stateTools.set('value', counter, 'process');
stateTools.set('history', history, 'process');
stateTools.set('lastExecution', new Date().toISOString(), 'process');

// Format the output
const output = `✅ Counter: ${counter}

Last executed: ${timeSinceLastExecution}
Total executions: ${history.length + 1}

Recent operations:
${history.length > 0 
  ? history.slice().reverse().map(entry => {
      let description = entry.action;
      if (entry.action === 'set' && entry.value !== undefined) {
        description += ` to ${entry.value}`;
      }
      return `- ${description} (${formatTimestamp(entry.timestamp)})`;
    }).join('\n')
  : 'None'}

Use 'counter increment' to add 1
Use 'counter decrement' to subtract 1
Use 'counter reset' to reset to 0
Use 'counter set <value>' to set a specific value`;

return output;

/**
 * Format a timestamp in a human-readable way
 */
function formatTimestamp(timestamp) {
  const date = new Date(timestamp);
  const now = new Date();
  const diffMs = now - date;
  
  if (diffMs < 1000) {
    return 'just now';
  } else if (diffMs < 60000) {
    return `${Math.floor(diffMs / 1000)}s ago`;
  } else if (diffMs < 3600000) {
    return `${Math.floor(diffMs / 60000)}m ago`;
  } else if (date.toDateString() === now.toDateString()) {
    return `today at ${date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}`;
  } else {
    return `${date.toLocaleDateString()} ${date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}`;
  }
}
```

### Response Examples

#### First Execution
```
> counter
✅ Counter: 0

Last executed: First execution
Total executions: 1

Recent operations:
None

Use 'counter increment' to add 1
Use 'counter decrement' to subtract 1
Use 'counter reset' to reset to 0
Use 'counter set <value>' to set a specific value
```

#### After Increment
```
> counter increment
✅ Counter: 1

Last executed: 5s ago
Total executions: 2

Recent operations:
- increment (just now)

Use 'counter increment' to add 1
Use 'counter decrement' to subtract 1
Use 'counter reset' to reset to 0
Use 'counter set <value>' to set a specific value
```

#### After Multiple Operations
```
> counter increment
✅ Counter: 5

Last executed: 2m ago
Total executions: 8

Recent operations:
- increment (just now)
- increment (2m ago)
- set to 3 (5m ago)
- reset (10m ago)
- decrement (15m ago)

Use 'counter increment' to add 1
Use 'counter decrement' to subtract 1
Use 'counter reset' to reset to 0
Use 'counter set <value>' to set a specific value
```

### Error Handling

#### Invalid Action
```
> counter unknown
❌ Error: Unknown action "unknown"
    
Supported actions:
- increment: Add 1 to counter
- decrement: Subtract 1 from counter
- reset: Set counter to 0
- set <value>: Set counter to specific value
- get: Get current counter value (default)
```

#### Invalid Value
```
> counter set abc
❌ Error: Invalid value "abc" - must be a number
```

### How State Is Used

This example process demonstrates several ways to use the state management system:

1. **Persistent Counter Value**: Stores and retrieves the counter value between executions
2. **Operation History**: Maintains a record of previous operations
3. **Execution Timing**: Tracks when the process was last executed
4. **User Guidance**: Provides contextual help based on the current state

The process uses process-scoped state to ensure that each instance of the counter process has its own isolated state data.

This example could be extended to demonstrate additional features like:
- State expiration (TTL)
- Global vs. process-specific state
- State across multiple related processes
- State persistence across sessions 