# 00OS Command Testing Standards

## Overview

This document outlines the testing standards and best practices for 00OS commands. These standards ensure commands work as expected across various scenarios, including edge cases and error conditions. For technical implementation details, see testing-framework.md.

## Testing Principles

1. **Comprehensive Coverage**: Test all possible execution paths
2. **Repeatability**: Tests should produce the same results on repeated runs
3. **Isolation**: Tests should not depend on other tests or external state
4. **Clarity**: Test failures should clearly indicate what went wrong
5. **Maintenance**: Tests should be easy to maintain as commands evolve

## Test Categories

### Unit Tests

Unit tests verify the behavior of individual functions within a command:

- Input parsing functions
- Flag handling logic
- Parameter validation
- Core business logic
- Helper utilities

### Integration Tests

Integration tests verify the command works correctly when integrated with other components:

- Command routing through the command registry
- Interactions with the state system
- Interactions with the file system
- Communications with other commands

### Functional Tests

Functional tests verify the command behaves as expected from the user's perspective:

- Command executes successfully with valid inputs
- Command generates proper error responses with invalid inputs
- Command outputs follow expected format
- Command handles various combinations of parameters and flags

### Error Tests

Error tests verify the command handles error conditions gracefully:

- Missing required parameters
- Invalid parameter types
- Invalid parameter values
- Invalid flags
- Resource access errors
- Permission errors
- Unexpected runtime errors

## Test Structure

### Test File Organization

Each command should have a corresponding test file:

```
00os/processes/category/command-name.js
00os/tests/processes/category/command-name.test.js
```

### Test File Structure

Test files should follow this structure:

```javascript
/**
 * Tests for the command-name command
 */

const { expect } = require('chai');
const command = require('../../../processes/category/command-name');

describe('command-name', () => {
  // Test valid usage
  describe('valid usage', () => {
    it('should execute successfully with valid parameters', () => {
      // Test code
    });
    
    it('should handle optional parameters correctly', () => {
      // Test code
    });
    
    it('should handle flags correctly', () => {
      // Test code
    });
  });
  
  // Test invalid usage
  describe('invalid usage', () => {
    it('should return error when required parameters are missing', () => {
      // Test code
    });
    
    it('should return error when parameters have invalid types', () => {
      // Test code
    });
    
    it('should return error when parameters have invalid values', () => {
      // Test code
    });
    
    it('should return error when invalid flags are provided', () => {
      // Test code
    });
  });
  
  // Test error conditions
  describe('error conditions', () => {
    it('should handle resource access errors gracefully', () => {
      // Test code
    });
    
    it('should handle permission errors gracefully', () => {
      // Test code
    });
    
    it('should handle unexpected errors gracefully', () => {
      // Test code
    });
  });
});
```

## Writing Effective Tests

### Test Cases

Each test case should:

1. **Arrange**: Set up test conditions
2. **Act**: Execute the command with test inputs
3. **Assert**: Verify the command produced the expected output

```javascript
it('should execute successfully with valid parameters', () => {
  // Arrange
  const args = ['param1', 'param2'];
  const env = { /* environment */ };
  
  // Act
  const result = command.execute(args, env);
  
  // Assert
  expect(result.success).to.be.true;
  expect(result.data).to.deep.equal(expectedData);
});
```

### Testing Error Responses

When testing error responses, verify all aspects of the error:

```javascript
it('should return error when required parameters are missing', () => {
  // Arrange
  const args = [];
  const env = { /* environment */ };
  
  // Act
  const result = command.execute(args, env);
  
  // Assert
  expect(result.success).to.be.false;
  expect(result.error.type).to.equal('INPUT_ERROR');
  expect(result.error.code).to.equal('MISSING_REQUIRED_PARAMETER');
  expect(result.suggestions).to.be.an('array').that.is.not.empty;
});
```

### Using Mocks and Stubs

Use mocks and stubs to isolate the command from external dependencies:

```javascript
const sinon = require('sinon');
const fs = require('fs');

it('should handle file not found errors gracefully', () => {
  // Arrange
  const args = ['/path/to/nonexistent/file.txt'];
  const env = { /* environment */ };
  
  // Create a stub for fs.readFileSync that throws a file not found error
  const readFileStub = sinon.stub(fs, 'readFileSync').throws({
    code: 'ENOENT',
    path: args[0]
  });
  
  try {
    // Act
    const result = command.execute(args, env);
    
    // Assert
    expect(result.success).to.be.false;
    expect(result.error.type).to.equal('RESOURCE_ERROR');
    expect(result.error.code).to.equal('RESOURCE_NOT_FOUND');
    expect(result.error.details.path).to.equal(args[0]);
  } finally {
    // Restore the stub
    readFileStub.restore();
  }
});
```

## Test Fixtures

Use test fixtures to provide consistent test data:

```javascript
// fixtures/file-read.fixtures.js
module.exports = {
  validFiles: {
    'test-file.txt': 'Line 1\nLine 2\nLine 3',
    'empty-file.txt': ''
  },
  invalidFiles: {
    'permission-denied.txt': { code: 'EACCES', path: '/path/to/permission-denied.txt' },
    'not-found.txt': { code: 'ENOENT', path: '/path/to/not-found.txt' }
  }
};
```

Then use these fixtures in tests:

```javascript
const fixtures = require('./fixtures/file-read.fixtures');

beforeEach(() => {
  // Set up stubs using fixtures
  sinon.stub(fs, 'readFileSync').callsFake((path) => {
    if (path.includes('permission-denied.txt')) {
      throw fixtures.invalidFiles['permission-denied.txt'];
    }
    if (path.includes('not-found.txt')) {
      throw fixtures.invalidFiles['not-found.txt'];
    }
    
    const fileName = path.split('/').pop();
    if (fixtures.validFiles[fileName]) {
      return fixtures.validFiles[fileName];
    }
    
    throw new Error(`Unexpected file path in test: ${path}`);
  });
});

afterEach(() => {
  // Restore all stubs
  sinon.restore();
});
```

## Test Automation

### Running Tests

Use a consistent command to run tests:

```bash
npm run test:commands           # Run all command tests
npm run test:commands:system    # Run tests for system commands
npm run test:commands:tools     # Run tests for tool commands
npm run test:commands:specific  # Run tests for a specific command
```

### Continuous Integration

Integrate tests into the CI pipeline:

1. Run tests on every push
2. Block merges if tests fail
3. Generate test coverage reports
4. Track test performance over time

## Test Coverage

Aim for high test coverage:

- 100% coverage of parameter validation logic
- 100% coverage of error handling logic
- 90%+ coverage of core business logic
- 80%+ overall code coverage

Track coverage with tools like Istanbul/NYC:

```bash
npm run test:coverage
```

## Testing Patterns

### Testing Command Metadata

Verify that command metadata is complete and valid:

```javascript
describe('metadata', () => {
  it('should have required metadata properties', () => {
    expect(command.metadata).to.have.property('name');
    expect(command.metadata).to.have.property('description');
    expect(command.metadata).to.have.property('usage');
    expect(command.metadata).to.have.property('category');
    expect(command.metadata).to.have.property('permissions').that.is.an('array');
  });
  
  it('should have correctly formatted examples', () => {
    expect(command.metadata).to.have.property('examples').that.is.an('array');
    command.metadata.examples.forEach(example => {
      expect(example).to.have.property('command').that.is.a('string');
      expect(example).to.have.property('description').that.is.a('string');
    });
  });
});
```

### Testing Parameter Validation

Test all aspects of parameter validation:

```javascript
describe('parameter validation', () => {
  it('should validate required parameters', () => {
    const result = command.execute([], {});
    expect(result.success).to.be.false;
    expect(result.error.code).to.equal('MISSING_REQUIRED_PARAMETER');
  });
  
  it('should validate parameter types', () => {
    const result = command.execute(['valid-param', 'not-a-number'], {});
    expect(result.success).to.be.false;
    expect(result.error.code).to.equal('INVALID_PARAMETER_TYPE');
  });
  
  it('should validate parameter values', () => {
    const result = command.execute(['valid-param', '-10'], {});
    expect(result.success).to.be.false;
    expect(result.error.code).to.equal('INVALID_PARAMETER_VALUE');
  });
});
```

### Testing Flag Handling

Test flag parsing and validation:

```javascript
describe('flag handling', () => {
  it('should handle valid flags', () => {
    const result = command.execute(['param', '--flag1', '--flag2=value'], {});
    expect(result.success).to.be.true;
    // Verify flags were processed correctly
  });
  
  it('should reject invalid flags', () => {
    const result = command.execute(['param', '--invalid-flag'], {});
    expect(result.success).to.be.false;
    expect(result.error.code).to.equal('INVALID_FLAG');
  });
});
```

### Testing Response Format

Verify the response format adheres to standards:

```javascript
describe('response format', () => {
  it('should return success response in standard format', () => {
    const result = command.execute(['valid-param'], {});
    expect(result).to.have.property('success', true);
    expect(result).to.have.property('message').that.is.a('string');
    expect(result).to.have.property('data').that.is.an('object');
  });
  
  it('should return error response in standard format', () => {
    const result = command.execute([], {});
    expect(result).to.have.property('success', false);
    expect(result).to.have.property('message').that.is.a('string');
    expect(result).to.have.property('error').that.is.an('object');
    expect(result).to.have.property('suggestions').that.is.an('array');
  });
});
```

## Example Test Suite

Here's a complete example test suite for a file-read command:

```javascript
/**
 * Tests for the file-read command
 */

const { expect } = require('chai');
const sinon = require('sinon');
const fs = require('fs');
const path = require('path');
const fileReadCommand = require('../../../processes/tools/file-read');

describe('file-read command', () => {
  afterEach(() => {
    // Clean up all stubs after each test
    sinon.restore();
  });

  describe('metadata', () => {
    it('should have required metadata properties', () => {
      expect(fileReadCommand.metadata).to.have.property('name', 'file-read');
      expect(fileReadCommand.metadata).to.have.property('description').that.is.a('string');
      expect(fileReadCommand.metadata).to.have.property('usage').that.is.a('string');
      expect(fileReadCommand.metadata).to.have.property('category', 'tools');
      expect(fileReadCommand.metadata).to.have.property('permissions').that.includes('filesystem:read');
    });
    
    it('should have correctly formatted examples', () => {
      expect(fileReadCommand.metadata).to.have.property('examples').that.is.an('array');
      fileReadCommand.metadata.examples.forEach(example => {
        expect(example).to.have.property('command').that.is.a('string');
        expect(example).to.have.property('description').that.is.a('string');
      });
    });
  });

  describe('parameter validation', () => {
    it('should validate required file path parameter', () => {
      const result = fileReadCommand.execute([], {});
      
      expect(result.success).to.be.false;
      expect(result.error.type).to.equal('INPUT_ERROR');
      expect(result.error.code).to.equal('MISSING_REQUIRED_PARAMETER');
      expect(result.error.details.parameter).to.equal('file-path');
    });
    
    it('should validate line limit parameter type', () => {
      const result = fileReadCommand.execute(['/path/to/file.txt', 'not-a-number'], {});
      
      expect(result.success).to.be.false;
      expect(result.error.type).to.equal('INPUT_ERROR');
      expect(result.error.code).to.equal('INVALID_PARAMETER_TYPE');
      expect(result.error.details.parameter).to.equal('line-limit');
    });
    
    it('should validate line limit parameter value', () => {
      const result = fileReadCommand.execute(['/path/to/file.txt', '-10'], {});
      
      expect(result.success).to.be.false;
      expect(result.error.type).to.equal('INPUT_ERROR');
      expect(result.error.code).to.equal('INVALID_PARAMETER_VALUE');
      expect(result.error.details.parameter).to.equal('line-limit');
    });
    
    it('should validate flags', () => {
      const result = fileReadCommand.execute(['/path/to/file.txt', '--invalid-flag'], {});
      
      expect(result.success).to.be.false;
      expect(result.error.type).to.equal('INPUT_ERROR');
      expect(result.error.code).to.equal('INVALID_FLAG');
      expect(result.error.details.invalidFlags).to.include('invalid-flag');
    });
  });

  describe('success scenarios', () => {
    it('should read entire file when no line limit is provided', () => {
      const testFilePath = '/path/to/test-file.txt';
      const testFileContent = 'Line 1\nLine 2\nLine 3';
      
      // Stub fs.readFileSync to return test content
      const readFileStub = sinon.stub(fs, 'readFileSync').returns(testFileContent);
      
      const result = fileReadCommand.execute([testFilePath], {});
      
      expect(result.success).to.be.true;
      expect(result.message).to.include('successfully');
      expect(result.data.content).to.include('1: Line 1');
      expect(result.data.content).to.include('2: Line 2');
      expect(result.data.content).to.include('3: Line 3');
      expect(result.data.lineCount).to.equal(3);
      expect(result.data.totalLines).to.equal(3);
      expect(result.data.path).to.equal(testFilePath);
      
      // Verify readFileSync was called with correct parameters
      expect(readFileStub.calledWith(testFilePath, 'utf8')).to.be.true;
    });
    
    it('should read limited lines when line limit is provided', () => {
      const testFilePath = '/path/to/test-file.txt';
      const testFileContent = 'Line 1\nLine 2\nLine 3\nLine 4\nLine 5';
      
      // Stub fs.readFileSync to return test content
      sinon.stub(fs, 'readFileSync').returns(testFileContent);
      
      const result = fileReadCommand.execute([testFilePath, '2'], {});
      
      expect(result.success).to.be.true;
      expect(result.data.content).to.include('1: Line 1');
      expect(result.data.content).to.include('2: Line 2');
      expect(result.data.content).to.not.include('3: Line 3');
      expect(result.data.lineCount).to.equal(2);
      expect(result.data.totalLines).to.equal(5);
    });
    
    it('should format output according to raw flag', () => {
      const testFilePath = '/path/to/test-file.txt';
      const testFileContent = 'Line 1\nLine 2\nLine 3';
      
      // Stub fs.readFileSync to return test content
      sinon.stub(fs, 'readFileSync').returns(testFileContent);
      
      const result = fileReadCommand.execute([testFilePath, '--raw'], {});
      
      expect(result.success).to.be.true;
      expect(result.data.content).to.equal(testFileContent);
      expect(result.data.content).to.not.include('1: ');
    });
    
    it('should format output according to no-line-numbers flag', () => {
      const testFilePath = '/path/to/test-file.txt';
      const testFileContent = 'Line 1\nLine 2\nLine 3';
      
      // Stub fs.readFileSync to return test content
      sinon.stub(fs, 'readFileSync').returns(testFileContent);
      
      const result = fileReadCommand.execute([testFilePath, '--no-line-numbers'], {});
      
      expect(result.success).to.be.true;
      expect(result.data.content).to.include('Line 1');
      expect(result.data.content).to.not.include('1: ');
    });
  });

  describe('error handling', () => {
    it('should handle file not found errors', () => {
      const testFilePath = '/path/to/nonexistent/file.txt';
      
      // Stub fs.readFileSync to throw ENOENT error
      sinon.stub(fs, 'readFileSync').throws({
        code: 'ENOENT',
        path: testFilePath
      });
      
      const result = fileReadCommand.execute([testFilePath], {});
      
      expect(result.success).to.be.false;
      expect(result.error.type).to.equal('RESOURCE_ERROR');
      expect(result.error.code).to.equal('RESOURCE_NOT_FOUND');
      expect(result.error.details.path).to.equal(testFilePath);
      expect(result.suggestions).to.be.an('array').that.is.not.empty;
    });
    
    it('should handle permission denied errors', () => {
      const testFilePath = '/path/to/protected/file.txt';
      
      // Stub fs.readFileSync to throw EACCES error
      sinon.stub(fs, 'readFileSync').throws({
        code: 'EACCES',
        path: testFilePath
      });
      
      const result = fileReadCommand.execute([testFilePath], {});
      
      expect(result.success).to.be.false;
      expect(result.error.type).to.equal('PERMISSION_ERROR');
      expect(result.error.code).to.equal('INSUFFICIENT_PERMISSIONS');
      expect(result.error.details.path).to.equal(testFilePath);
      expect(result.suggestions).to.be.an('array').that.is.not.empty;
    });
    
    it('should handle unexpected errors', () => {
      const testFilePath = '/path/to/file.txt';
      
      // Stub fs.readFileSync to throw generic error
      sinon.stub(fs, 'readFileSync').throws(new Error('Unexpected error'));
      
      const result = fileReadCommand.execute([testFilePath], {});
      
      expect(result.success).to.be.false;
      expect(result.error.type).to.equal('EXECUTION_ERROR');
      expect(result.suggestions).to.be.an('array').that.is.not.empty;
    });
  });
});
```

## Testing Environment Setup

Set up a standardized testing environment:

```javascript
// test/setup.js
const chai = require('chai');
const sinon = require('sinon');
const sinonChai = require('sinon-chai');

// Add sinon-chai assertions
chai.use(sinonChai);

// Global test environment setup
before(() => {
  // Set up test environment
  global.testEnv = {
    // Test utilities
    utils: {
      // Utility functions
    },
    // Mock environment
    env: {
      // Mock environment variables
    },
    // Mock state
    state: {
      // Mock state
    }
  };
});

// Global test environment cleanup
after(() => {
  // Clean up test environment
});
```

## Command Quality Checklist

Each command should pass the following testing checklist:

- [ ] All unit tests pass
- [ ] All integration tests pass
- [ ] All functional tests pass
- [ ] All error tests pass
- [ ] Test coverage meets targets
- [ ] All parameter validation tests pass
- [ ] All flag handling tests pass
- [ ] All response format tests pass
- [ ] All error handling tests pass
- [ ] Tests run successfully in CI pipeline

## Conclusion

Thorough testing is essential for maintaining a reliable command system. By following these testing guidelines, 00OS commands will be robust, reliable, and provide a consistent user experience even in edge cases and error conditions. 