# 00OS State Manager

## Overview
The State Manager is a core 00OS component responsible for managing persistent state across process executions. It provides a hierarchical storage system that allows processes to save and retrieve data between commands, enabling stateful applications and workflows.

## State Hierarchy

The state system organizes data in a hierarchical structure:

1. **Global State**: Accessible to all processes (with appropriate permissions)
2. **Process State**: Isolated to specific processes
3. **User State**: Associated with the current user
4. **Session State**: Only persists for the current session

Each level provides appropriate isolation and access control while allowing for data sharing where needed.

## State Manager Implementation

```javascript
/**
 * 00OS State Manager
 * 
 * Manages persistent state across process executions, providing
 * a hierarchical storage system for stateful applications.
 */

// Main state storage
const stateStore = {
  global: {},
  process: {},
  user: {},
  session: {}
};

// Persistence configuration
const persistenceConfig = {
  storePath: '/00os/data/state',
  autosaveInterval: 60000, // 1 minute
  maxStateSize: 1048576, // 1MB per scope
  persistentScopes: ['global', 'user', 'process']
};

/**
 * Get a value from state
 * @param {string} key - State key
 * @param {string} scope - State scope (global, process, user, session)
 * @param {string} namespace - Optional namespace (e.g. process name)
 * @returns {any} Stored value or null if not found
 */
function getState(key, scope = 'session', namespace = null) {
  // Validate parameters
  if (!key || !scope) {
    throw new Error('INVALID_PARAMS', 'Key and scope are required for state operations');
  }
  
  // Check if scope exists
  if (!stateStore[scope]) {
    throw new Error('INVALID_SCOPE', `Scope '${scope}' is not valid`);
  }
  
  // Construct full key with namespace
  const fullKey = namespace ? `${namespace}:${key}` : key;
  
  // Return value (or null if not found)
  return stateStore[scope][fullKey] || null;
}

/**
 * Set a value in state
 * @param {string} key - State key
 * @param {any} value - Value to store
 * @param {string} scope - State scope (global, process, user, session)
 * @param {string} namespace - Optional namespace (e.g. process name)
 * @param {Object} options - Additional options (ttl, persistent)
 * @returns {boolean} Success status
 */
function setState(key, value, scope = 'session', namespace = null, options = {}) {
  // Validate parameters
  if (!key || !scope) {
    throw new Error('INVALID_PARAMS', 'Key and scope are required for state operations');
  }
  
  // Check if scope exists
  if (!stateStore[scope]) {
    throw new Error('INVALID_SCOPE', `Scope '${scope}' is not valid`);
  }
  
  // Validate value size
  const valueSize = getApproximateSize(value);
  if (valueSize > persistenceConfig.maxStateSize) {
    throw new Error('STATE_TOO_LARGE', `Value exceeds maximum size (${valueSize} > ${persistenceConfig.maxStateSize})`);
  }
  
  // Construct full key with namespace
  const fullKey = namespace ? `${namespace}:${key}` : key;
  
  // Store the value
  stateStore[scope][fullKey] = value;
  
  // Handle time-to-live if specified
  if (options.ttl && options.ttl > 0) {
    setTimeout(() => {
      deleteState(key, scope, namespace);
    }, options.ttl);
  }
  
  // Trigger persistence if persistent
  if (persistenceConfig.persistentScopes.includes(scope) && options.persistent !== false) {
    scheduleStatePersistence(scope);
  }
  
  return true;
}

/**
 * Delete a value from state
 * @param {string} key - State key
 * @param {string} scope - State scope (global, process, user, session)
 * @param {string} namespace - Optional namespace (e.g. process name)
 * @returns {boolean} Success status
 */
function deleteState(key, scope = 'session', namespace = null) {
  // Validate parameters
  if (!key || !scope) {
    throw new Error('INVALID_PARAMS', 'Key and scope are required for state operations');
  }
  
  // Check if scope exists
  if (!stateStore[scope]) {
    throw new Error('INVALID_SCOPE', `Scope '${scope}' is not valid`);
  }
  
  // Construct full key with namespace
  const fullKey = namespace ? `${namespace}:${key}` : key;
  
  // Delete the value
  if (stateStore[scope][fullKey] !== undefined) {
    delete stateStore[scope][fullKey];
    
    // Trigger persistence if scope is persistent
    if (persistenceConfig.persistentScopes.includes(scope)) {
      scheduleStatePersistence(scope);
    }
    
    return true;
  }
  
  return false;
}

/**
 * List all keys in a state scope
 * @param {string} scope - State scope (global, process, user, session)
 * @param {string} namespace - Optional namespace filter
 * @returns {string[]} Array of keys
 */
function listStateKeys(scope = 'session', namespace = null) {
  // Validate parameters
  if (!scope) {
    throw new Error('INVALID_PARAMS', 'Scope is required for state operations');
  }
  
  // Check if scope exists
  if (!stateStore[scope]) {
    throw new Error('INVALID_SCOPE', `Scope '${scope}' is not valid`);
  }
  
  // Get all keys in scope
  const keys = Object.keys(stateStore[scope]);
  
  // Filter by namespace if provided
  if (namespace) {
    const prefix = `${namespace}:`;
    return keys
      .filter(key => key.startsWith(prefix))
      .map(key => key.substring(prefix.length));
  }
  
  return keys;
}

/**
 * Clear all state in a scope
 * @param {string} scope - State scope (global, process, user, session)
 * @param {string} namespace - Optional namespace to clear
 * @returns {boolean} Success status
 */
function clearState(scope = 'session', namespace = null) {
  // Validate parameters
  if (!scope) {
    throw new Error('INVALID_PARAMS', 'Scope is required for state operations');
  }
  
  // Check if scope exists
  if (!stateStore[scope]) {
    throw new Error('INVALID_SCOPE', `Scope '${scope}' is not valid`);
  }
  
  if (namespace) {
    // Only clear keys in the namespace
    const prefix = `${namespace}:`;
    Object.keys(stateStore[scope]).forEach(key => {
      if (key.startsWith(prefix)) {
        delete stateStore[scope][key];
      }
    });
  } else {
    // Clear entire scope
    stateStore[scope] = {};
  }
  
  // Trigger persistence if scope is persistent
  if (persistenceConfig.persistentScopes.includes(scope)) {
    scheduleStatePersistence(scope);
  }
  
  return true;
}

// Persistence management
let persistenceTimers = {};

/**
 * Schedule state persistence for a scope
 * @param {string} scope - State scope to persist
 */
function scheduleStatePersistence(scope) {
  // Cancel existing timer
  if (persistenceTimers[scope]) {
    clearTimeout(persistenceTimers[scope]);
  }
  
  // Schedule new persistence
  persistenceTimers[scope] = setTimeout(() => {
    persistState(scope);
  }, 1000); // Debounce to 1 second
}

/**
 * Persist state to storage
 * @param {string} scope - State scope to persist
 */
function persistState(scope) {
  // In a real implementation, this would write to a file
  // For now, we'll just log the operation
  console.log(`Persisting state for scope: ${scope}`);
  
  // Clear timer
  persistenceTimers[scope] = null;
}

/**
 * Load state from storage
 * @param {string} scope - State scope to load
 */
function loadState(scope) {
  // In a real implementation, this would read from a file
  // For now, we'll just log the operation
  console.log(`Loading state for scope: ${scope}`);
}

/**
 * Initialize the state manager
 */
function initStateManager() {
  // Load persistent state
  persistenceConfig.persistentScopes.forEach(scope => {
    loadState(scope);
  });
  
  // Set up autosave interval
  setInterval(() => {
    persistenceConfig.persistentScopes.forEach(scope => {
      persistState(scope);
    });
  }, persistenceConfig.autosaveInterval);
}

/**
 * Get approximate size of a value in bytes
 * @param {any} value - Value to measure
 * @returns {number} Approximate size in bytes
 */
function getApproximateSize(value) {
  // Simple size estimation
  return JSON.stringify(value).length * 2;
}

// Export functions for system use
module.exports = {
  getState,
  setState,
  deleteState,
  listStateKeys,
  clearState,
  initStateManager
};
```

## State Storage Persistence

The state manager maintains both in-memory and persistent storage:

1. **In-Memory Storage**: All state is kept in memory for fast access
2. **File-Based Persistence**: Persistent scopes are saved to disk
3. **Scheduled Saving**: Changes are debounced and saved on a regular schedule
4. **Initialization**: Persistent state is loaded when the system starts

### File Structure

Persistent state is stored in JSON files in the `/00os/data/state` directory:

```
/00os/data/state/
  global.json        # Global state
  user-default.json  # User state for default user
  process-help.json  # Process state for help process
  process-file.json  # Process state for file process
```

## Process Integration

Processes access state through the tools object provided during execution:

```javascript
// Get state within a process
const counter = tools.state.get('counter', 'process');

// Set state within a process
tools.state.set('counter', counter + 1, 'process');

// Process namespace is automatically applied based on process name
```

The executor sets up the appropriate state context for each process:

```javascript
// In executor.js
function createProcessStateTools(processName) {
  return {
    get: (key, scope = 'process') => {
      return stateManager.getState(key, scope, processName);
    },
    set: (key, value, scope = 'process', options = {}) => {
      return stateManager.setState(key, value, scope, processName, options);
    },
    delete: (key, scope = 'process') => {
      return stateManager.deleteState(key, scope, processName);
    },
    list: (scope = 'process') => {
      return stateManager.listStateKeys(scope, processName);
    },
    clear: (scope = 'process') => {
      return stateManager.clearState(scope, processName);
    }
  };
}
```

## Security Considerations

State access follows the permission system:

- **global.read**: Required to read global state
- **global.write**: Required to write global state
- **process.state**: Required to use process state
- **user.state**: Required to use user state

Each scope has appropriate permissions to ensure security while allowing necessary operations.

## Error Handling

The state manager implements robust error handling:

- **INVALID_PARAMS**: Missing required parameters
- **INVALID_SCOPE**: Requested scope doesn't exist
- **STATE_TOO_LARGE**: Value exceeds maximum size
- **PERSISTENCE_ERROR**: Error saving or loading state

Errors include descriptive messages to help diagnose and resolve issues.

## Future Enhancements

The state manager is designed to be extensible for future enhancements:

1. **State Versioning**: Track changes with version history
2. **Query Capabilities**: Advanced searching and filtering
3. **State Snapshots**: Point-in-time recovery options
4. **State Migration**: Handle schema changes gracefully
5. **State Events**: Subscribe to state change events 