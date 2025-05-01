# 00OS Command Testing Implementation Guide

## Overview

This document provides the technical implementation details for the 00OS command testing framework. It complements the testing standards defined in testing-standards.md by providing concrete examples, code templates, and utilities for implementing tests.

## Testing Principles

1. **Test-Driven Development**
   - Write tests before implementing commands
   - Define expected behavior in tests
   - Use tests to guide implementation

2. **Comprehensive Coverage**
   - Test happy paths (expected usage)
   - Test edge cases and error conditions
   - Test parameter combinations and variations

3. **Automation**
   - Leverage Cursor's Auto-run (YOLO) mode for continuous testing
   - Automate test execution during development
   - Run tests automatically after implementation changes

## Test Structure

### Unit Tests

Each command should have unit tests covering:

1. **Command Registration**
   - Verify the command is properly registered in the command registry
   - Test command metadata (name, description, usage, etc.)

2. **Parameter Parsing**
   - Test required parameters are validated
   - Test optional parameters default correctly
   - Test flag handling

3. **Execution Logic**
   - Test core functionality with various inputs
   - Verify output format matches standards
   - Test execution with minimal permissions

4. **Error Handling**
   - Test invalid input handling
   - Test resource not found scenarios
   - Test permission errors

### Integration Tests

Test commands working together:

1. **Command Chaining**
   - Test piping output between commands
   - Test commands that depend on other commands

2. **System State**
   - Test commands that modify system state
   - Verify state changes are correctly applied and persisted

## Test Implementation

### Test File Structure

```
00os/
  tests/
    unit/
      processes/
        system/
          echo.test.js
          help.test.js
          ...
        tools/
          file-list.test.js
          file-read.test.js
          ...
    integration/
      command-chains.test.js
      state-management.test.js
```

### Basic Test Template

```javascript
const { executeCommand } = require('../../../test-utils');

describe('command-name', () => {
  // Setup before tests
  beforeAll(() => {
    // Prepare test environment
  });

  // Clean up after tests
  afterAll(() => {
    // Clean up test environment
  });

  // Happy path tests
  describe('successful execution', () => {
    test('should perform expected action with valid input', () => {
      // Arrange
      const args = ['param1', 'param2'];
      const expectedOutput = '✅ Expected output';

      // Act
      const result = executeCommand('command-name', args);

      // Assert
      expect(result.success).toBe(true);
      expect(result.message).toContain(expectedOutput);
    });
  });

  // Error path tests
  describe('error handling', () => {
    test('should handle missing required parameter', () => {
      // Arrange
      const args = []; // Missing required parameter

      // Act
      const result = executeCommand('command-name', args);

      // Assert
      expect(result.success).toBe(false);
      expect(result.message).toContain('❌ Error');
      expect(result.message).toContain('Missing required parameter');
    });
  });
});
```

## Testing Utilities

Create testing utilities to streamline test implementation:

```javascript
// test-utils.js

/**
 * Execute a command with arguments and return the result
 * @param {string} commandName - Name of the command to execute
 * @param {string[]} args - Command arguments
 * @param {Object} options - Additional options (flags, etc.)
 * @returns {Object} Command execution result
 */
function executeCommand(commandName, args = [], options = {}) {
  // Mock the execution environment
  const mockEnv = createMockEnvironment();
  
  // Get the command process
  const commandProcess = getCommandProcess(commandName);
  
  // Execute the command
  return commandProcess.execute(args, mockEnv, options);
}

/**
 * Create a mock execution environment
 */
function createMockEnvironment() {
  return {
    filesystem: createMockFilesystem(),
    state: createMockState(),
    output: createMockOutput(),
    permissions: { ... },
  };
}

// Export testing utilities
module.exports = {
  executeCommand,
  createMockEnvironment,
  // ... other utilities
};
```

## Command-Specific Testing Examples

### File Commands

```javascript
describe('file-read', () => {
  // Setup test files
  beforeAll(() => {
    createTestFile('test.txt', 'Test content');
  });

  test('should read existing file', () => {
    const result = executeCommand('file-read', ['test.txt']);
    
    expect(result.success).toBe(true);
    expect(result.message).toContain('Test content');
  });

  test('should handle non-existent file', () => {
    const result = executeCommand('file-read', ['missing.txt']);
    
    expect(result.success).toBe(false);
    expect(result.message).toContain('❌ Error reading file');
    expect(result.suggestions).toBeTruthy();
  });
});
```

### Echo Command

```javascript
describe('echo', () => {
  test('should output the provided message', () => {
    const message = 'Hello world';
    const result = executeCommand('echo', [message]);
    
    expect(result.success).toBe(true);
    expect(result.message).toContain(message);
  });

  test('should handle multiple words', () => {
    const words = ['Hello', 'world', 'today'];
    const result = executeCommand('echo', words);
    
    expect(result.success).toBe(true);
    expect(result.message).toContain(words.join(' '));
  });
});
```

## Test-Driven Development Workflow

1. **Write the Test**
   ```javascript
   test('command should perform specific action', () => {
     const result = executeCommand('command', ['arg1', 'arg2']);
     expect(result.success).toBe(true);
     expect(result.message).toContain('Expected output');
   });
   ```

2. **Run the Test (Fails)**
   ```
   ❌ command should perform specific action
   Error: Command not implemented
   ```

3. **Implement the Command**
   ```javascript
   // command.js
   module.exports = {
     metadata: {
       name: 'command',
       description: 'Performs specific action',
       usage: 'command <arg1> <arg2>'
     },
     execute: (args, env) => {
       // Implementation to make test pass
       return {
         success: true,
         message: `✅ Performed action with ${args[0]} and ${args[1]}`
       };
     }
   };
   ```

4. **Run the Test Again (Passes)**
   ```
   ✅ command should perform specific action
   ```

5. **Refine Implementation and Tests**
   - Add more test cases
   - Improve implementation
   - Refactor as needed

## Continuous Testing with Cursor

Leverage Cursor's Auto-run (YOLO) mode for continuous testing:

1. Configure Auto-run to allow test commands:
   ```
   Allow: npm test, jest, node test
   ```

2. Create test scripts in package.json:
   ```json
   {
     "scripts": {
       "test": "jest",
       "test:watch": "jest --watch",
       "test:cmd": "jest tests/unit/processes/system/COMMAND_NAME.test.js"
     }
   }
   ```

3. Use the test command in Auto-run mode:
   ```
   npm run test:cmd
   ```

## Implementation Plan

1. **Setup Testing Infrastructure**
   - Create test directory structure
   - Implement test utilities
   - Configure test runner

2. **Create Test Templates**
   - Define standard test patterns
   - Create example tests for common commands

3. **Implement Command Tests**
   - Prioritize core system commands
   - Add tests for tool commands
   - Create integration tests

4. **Integrate with Development Workflow**
   - Configure Auto-run mode for testing
   - Document testing requirements for new commands
   - Establish test coverage goals

## Future Enhancements

1. **Performance Testing**
   - Measure command execution time
   - Test with large inputs/outputs
   - Benchmark command performance

2. **Snapshot Testing**
   - Compare command output against stored snapshots
   - Track output changes over time

3. **Mocking Framework**
   - Create better mocks for filesystem, network, etc.
   - Allow testing of commands with external dependencies

4. **Code Coverage Reporting**
   - Track test coverage percentages
   - Identify untested code paths

By implementing this testing framework, we can ensure 00OS commands are reliable, consistent, and follow expected behavior patterns, leading to a more robust and maintainable command system. 