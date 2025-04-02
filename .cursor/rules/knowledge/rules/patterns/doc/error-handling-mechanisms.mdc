# USE WHEN implementing error handling, creating recovery mechanisms, or developing validation systems

# Error Handling Mechanisms

## File Purpose and Relationship

This file establishes standardized error handling mechanisms for file operations within the cognitive architecture. It defines patterns for detecting, reporting, and recovering from boundary violations and validation errors to prevent hallucinations and ensure system stability. It should be used when:

- Implementing error handling for file operations
- Creating recovery mechanisms for validation failures
- Designing robust error reporting systems
- Establishing structured error handling processes
- Preventing cascading failures from boundary violations

This file is part of the documentation patterns in the knowledge/rules/patterns/doc directory and complements the file-operation-boundaries.md, file-validation-mechanisms.md, and context-preservation-mechanisms.md files.

## Error Handling Fundamentals

### Core Error Handling Principles

1. **Explicit Error Detection**: All errors must be explicitly detected
2. **Structured Error Reporting**: Errors must be reported in a structured format
3. **Recovery Mechanisms**: Critical errors require recovery mechanisms
4. **Error Categorization**: Errors must be categorized by type and severity
5. **User Feedback**: Error handling must provide clear user feedback

### Error Categories

The cognitive architecture handles these primary error categories:

1. **Boundary Violations**: Unauthorized operations or domain access
   - Unauthorized domain access
   - Unauthorized operation type
   - Unauthorized context
   - Domain boundary crossing

2. **Validation Errors**: Failures to meet validation requirements
   - Structure validation failures
   - Content validation failures
   - Reference validation failures
   - Template adherence failures

3. **Reference Failures**: Issues with reference resolution
   - Broken references
   - Invalid reference formats
   - Reference context violations
   - Reference resolution failures

4. **System Errors**: Underlying system issues
   - File access failures
   - Network failures
   - Resource limitations
   - Timing issues

## Error Detection Mechanisms

### Boundary Violation Detection

Implement boundary violation detection with these mechanisms:

```typescript
// Boundary violation detection pattern
function detectBoundaryViolations(operation, path, context) {
  const violations = [];
  
  // Determine domain
  const domain = determineDomainForPath(path);
  if (!domain) {
    violations.push({
      type: 'unauthorized_domain',
      severity: 'critical',
      message: `Path does not match any authorized domain: ${path}`,
      details: { path, domains: Object.keys(domainBoundaries) }
    });
    return violations;
  }
  
  // Check operation authorization
  if (!domainBoundaries[domain].authorizedOperations.includes(operation)) {
    violations.push({
      type: 'unauthorized_operation',
      severity: 'critical',
      message: `Operation "${operation}" not authorized in domain "${domain}"`,
      details: { operation, domain, authorizedOperations: domainBoundaries[domain].authorizedOperations }
    });
  }
  
  // Check context authorization
  if (!domainBoundaries[domain].authorizedContexts.includes(context.type)) {
    violations.push({
      type: 'unauthorized_context',
      severity: 'critical',
      message: `Context "${context.type}" not authorized for operations in domain "${domain}"`,
      details: { context: context.type, domain, authorizedContexts: domainBoundaries[domain].authorizedContexts }
    });
  }
  
  // Check for cross-domain operations
  if (context.activeDomains && context.activeDomains.length > 1) {
    violations.push({
      type: 'cross_domain_operation',
      severity: 'warning',
      message: `Operation spans multiple domains: ${context.activeDomains.join(', ')}`,
      details: { domains: context.activeDomains, operation }
    });
  }
  
  return violations;
}

// Example usage
const violations = detectBoundaryViolations(
  'create',
  '/1000xbrain/core/unauthorized-file.md',
  { type: 'knowledge-creation', activeDomains: ['core', 'knowledge'] }
);
```

### Validation Error Detection

Implement validation error detection with these mechanisms:

```typescript
// Validation error detection pattern
function detectValidationErrors(validationResult) {
  const errors = [];
  
  // Process structure errors
  for (const domain in validationResult.details.structure) {
    const result = validationResult.details.structure[domain];
    for (const error of result.errors) {
      errors.push({
        type: `structure_${domain}`,
        severity: 'error',
        message: error,
        details: { domain, validation: 'structure' }
      });
    }
  }
  
  // Process content errors
  for (const domain in validationResult.details.content) {
    const result = validationResult.details.content[domain];
    for (const error of result.errors) {
      errors.push({
        type: `content_${domain}`,
        severity: 'error',
        message: error,
        details: { domain, validation: 'content' }
      });
    }
  }
  
  // Process reference errors
  for (const domain in validationResult.details.references) {
    const result = validationResult.details.references[domain];
    for (const error of result.errors) {
      errors.push({
        type: `reference_${domain}`,
        severity: 'error',
        message: error,
        details: { domain, validation: 'references' }
      });
    }
  }
  
  // Process warnings as low severity errors
  if (validationResult.warnings && validationResult.warnings.length > 0) {
    for (const warning of validationResult.warnings) {
      errors.push({
        type: 'validation_warning',
        severity: 'warning',
        message: warning,
        details: { validation: 'warning' }
      });
    }
  }
  
  return errors;
}

// Example usage
const validationErrors = detectValidationErrors(validationResult);
```

### System Error Detection

Implement system error detection with these mechanisms:

```typescript
// System error detection pattern
function detectSystemErrors(error, operation, context) {
  // Initialize error object
  const systemError = {
    type: 'unknown_system_error',
    severity: 'critical',
    message: error.message || 'Unknown system error',
    details: {
      operation,
      stack: error.stack,
      context
    }
  };
  
  // Try to determine more specific error type
  if (error.code === 'ENOENT') {
    systemError.type = 'file_not_found';
    systemError.message = `File not found: ${error.path}`;
    systemError.details.path = error.path;
  } else if (error.code === 'EACCES') {
    systemError.type = 'permission_denied';
    systemError.message = `Permission denied: ${error.path}`;
    systemError.details.path = error.path;
  } else if (error.code === 'EMFILE') {
    systemError.type = 'too_many_files';
    systemError.message = 'Too many open files';
  } else if (error.code === 'ENOSPC') {
    systemError.type = 'no_space';
    systemError.message = 'No space left on device';
  } else if (error.name === 'SyntaxError') {
    systemError.type = 'syntax_error';
    systemError.message = `Syntax error: ${error.message}`;
  } else if (error.name === 'ReferenceError') {
    systemError.type = 'reference_error';
    systemError.message = `Reference error: ${error.message}`;
  }
  
  return systemError;
}

// Example usage
try {
  // Attempt operation
  performOperation();
} catch (error) {
  const systemError = detectSystemErrors(error, 'read_file', { type: 'file_access' });
  handleSystemError(systemError);
}
```

## Error Reporting Mechanisms

### Structured Error Reporting

Implement structured error reporting with these mechanisms:

```typescript
// Structured error reporting pattern
function reportError(error, options = {}) {
  const {
    includeStack = true,
    includeDetails = true,
    format = 'text',
    logToConsole = true,
    logToFile = false,
    logFilePath = 'error-log.txt'
  } = options;
  
  // Create error report
  const timestamp = new Date().toISOString();
  const errorId = generateErrorId();
  
  const errorReport = {
    id: errorId,
    timestamp,
    type: error.type,
    severity: error.severity,
    message: error.message
  };
  
  // Add stack if available and requested
  if (includeStack && error.stack) {
    errorReport.stack = error.stack;
  }
  
  // Add details if available and requested
  if (includeDetails && error.details) {
    errorReport.details = error.details;
  }
  
  // Format report based on requested format
  let formattedReport;
  
  if (format === 'json') {
    formattedReport = JSON.stringify(errorReport, null, 2);
  } else if (format === 'text') {
    formattedReport = 
      `ERROR REPORT [${errorId}]\n` +
      `Timestamp: ${timestamp}\n` +
      `Type: ${error.type}\n` +
      `Severity: ${error.severity}\n` +
      `Message: ${error.message}\n`;
    
    if (includeDetails && error.details) {
      formattedReport += `Details: ${JSON.stringify(error.details, null, 2)}\n`;
    }
    
    if (includeStack && error.stack) {
      formattedReport += `Stack: ${error.stack}\n`;
    }
  }
  
  // Log to console if requested
  if (logToConsole) {
    if (error.severity === 'critical' || error.severity === 'error') {
      console.error(formattedReport);
    } else if (error.severity === 'warning') {
      console.warn(formattedReport);
    } else {
      console.log(formattedReport);
    }
  }
  
  // Log to file if requested
  if (logToFile) {
    appendToFile(logFilePath, formattedReport + '\n---\n');
  }
  
  return {
    report: formattedReport,
    errorReport
  };
}

// Example usage
const reportResult = reportError(error, {
  includeStack: true,
  includeDetails: true,
  format: 'text',
  logToConsole: true,
  logToFile: true,
  logFilePath: 'error-logs/boundary-violations.log'
});
```

### Error Classification and Prioritization

Implement error classification and prioritization with these mechanisms:

```typescript
// Error classification pattern
function classifyError(error) {
  // Initialize classification
  const classification = {
    category: 'unknown',
    priority: 'medium',
    requiresImmediate: false,
    requiresRecovery: false,
    actionable: false,
    suggestedActions: []
  };
  
  // Classify based on error type
  if (error.type.startsWith('unauthorized_')) {
    classification.category = 'boundary_violation';
    classification.priority = 'high';
    classification.requiresImmediate = true;
    classification.requiresRecovery = false;
    classification.actionable = true;
    classification.suggestedActions = ['abort_operation', 'report_violation'];
  } else if (error.type.startsWith('structure_') || error.type.startsWith('content_') || error.type.startsWith('reference_')) {
    classification.category = 'validation_error';
    classification.priority = 'medium';
    classification.requiresImmediate = false;
    classification.requiresRecovery = false;
    classification.actionable = true;
    classification.suggestedActions = ['attempt_automatic_fix', 'request_manual_fix'];
  } else if (error.type === 'file_not_found' || error.type === 'permission_denied') {
    classification.category = 'system_error';
    classification.priority = 'high';
    classification.requiresImmediate = true;
    classification.requiresRecovery = true;
    classification.actionable = true;
    classification.suggestedActions = ['retry_operation', 'abort_operation'];
  } else if (error.severity === 'critical') {
    classification.category = 'critical_error';
    classification.priority = 'critical';
    classification.requiresImmediate = true;
    classification.requiresRecovery = true;
    classification.actionable = false;
    classification.suggestedActions = ['abort_operation', 'rollback_changes'];
  }
  
  return classification;
}

// Example usage
const errorClassification = classifyError(error);
```

### User Feedback Generation

Implement user feedback generation with these mechanisms:

```typescript
// User feedback pattern
function generateUserFeedback(error, classification) {
  // Initialize feedback object
  const feedback = {
    message: '',
    details: '',
    actions: []
  };
  
  // Generate appropriate message based on error type and classification
  if (classification.category === 'boundary_violation') {
    feedback.message = 'Operation not authorized.';
    feedback.details = `The operation "${error.details.operation}" is not authorized in the ${error.details.domain} domain.`;
    feedback.actions = [
      { label: 'Abort', action: 'abort_operation' },
      { label: 'Change Domain', action: 'change_domain' }
    ];
  } else if (classification.category === 'validation_error') {
    feedback.message = 'Validation failed.';
    feedback.details = `The file failed validation with ${error.details.errorCount} errors.`;
    feedback.actions = [
      { label: 'View Details', action: 'view_validation_details' },
      { label: 'Fix Automatically', action: 'attempt_automatic_fix' },
      { label: 'Edit Manually', action: 'edit_manually' }
    ];
  } else if (classification.category === 'system_error') {
    feedback.message = 'System error occurred.';
    feedback.details = error.message;
    feedback.actions = [
      { label: 'Retry', action: 'retry_operation' },
      { label: 'Abort', action: 'abort_operation' }
    ];
  } else {
    feedback.message = 'An error occurred.';
    feedback.details = error.message;
    feedback.actions = [
      { label: 'Abort', action: 'abort_operation' }
    ];
  }
  
  return feedback;
}

// Example usage
const userFeedback = generateUserFeedback(error, errorClassification);
```

## Error Recovery Mechanisms

### Automatic Error Recovery

Implement automatic error recovery with these mechanisms:

```typescript
// Automatic error recovery pattern
function attemptAutomaticRecovery(error, context) {
  // Initialize recovery result
  const recoveryResult = {
    success: false,
    actions: [],
    message: '',
    error: null
  };
  
  // Apply recovery strategy based on error type
  try {
    if (error.type === 'unauthorized_domain') {
      // Attempt domain recovery
      const domainRecovery = recoverFromDomainViolation(error, context);
      if (domainRecovery.success) {
        recoveryResult.success = true;
        recoveryResult.actions = domainRecovery.actions;
        recoveryResult.message = `Recovered from domain violation: ${domainRecovery.message}`;
      }
    } else if (error.type.startsWith('structure_') || error.type.startsWith('content_')) {
      // Attempt validation recovery
      const validationRecovery = recoverFromValidationError(error, context);
      if (validationRecovery.success) {
        recoveryResult.success = true;
        recoveryResult.actions = validationRecovery.actions;
        recoveryResult.message = `Recovered from validation error: ${validationRecovery.message}`;
      }
    } else if (error.type === 'file_not_found') {
      // Attempt file recovery
      const fileRecovery = recoverFromMissingFile(error, context);
      if (fileRecovery.success) {
        recoveryResult.success = true;
        recoveryResult.actions = fileRecovery.actions;
        recoveryResult.message = `Recovered from missing file: ${fileRecovery.message}`;
      }
    } else {
      // Generic recovery attempt
      const genericRecovery = attemptGenericRecovery(error, context);
      if (genericRecovery.success) {
        recoveryResult.success = true;
        recoveryResult.actions = genericRecovery.actions;
        recoveryResult.message = `Recovered from error: ${genericRecovery.message}`;
      }
    }
  } catch (recoveryError) {
    // Handle recovery failure
    recoveryResult.success = false;
    recoveryResult.error = detectSystemErrors(recoveryError, 'recovery', context);
    recoveryResult.message = `Recovery failed: ${recoveryError.message}`;
  }
  
  // Log recovery attempt
  logRecoveryAttempt({
    originalError: error,
    recoveryResult,
    context,
    timestamp: Date.now()
  });
  
  return recoveryResult;
}

// Example usage
const recoveryResult = attemptAutomaticRecovery(error, context);
```

### Checkpoint-Based Recovery

Implement checkpoint-based recovery with these mechanisms:

```typescript
// Checkpoint-based recovery pattern
function recoverFromCheckpoint(error, context) {
  // Initialize recovery result
  const recoveryResult = {
    success: false,
    actions: [],
    message: '',
    checkpoint: null
  };
  
  // Find most appropriate checkpoint
  const checkpoints = findCheckpointsForContext(context);
  if (!checkpoints || checkpoints.length === 0) {
    recoveryResult.message = 'No checkpoints found for recovery';
    return recoveryResult;
  }
  
  // Sort checkpoints by recency and specificity
  const sortedCheckpoints = sortCheckpointsByRelevance(checkpoints, error, context);
  const mostRelevantCheckpoint = sortedCheckpoints[0];
  
  // Attempt to restore from checkpoint
  try {
    const restorationResult = restoreFromCheckpoint(mostRelevantCheckpoint);
    
    if (restorationResult.success) {
      recoveryResult.success = true;
      recoveryResult.actions = restorationResult.actions;
      recoveryResult.message = `Recovered using checkpoint: ${mostRelevantCheckpoint.name}`;
      recoveryResult.checkpoint = mostRelevantCheckpoint;
    } else {
      recoveryResult.message = `Failed to restore from checkpoint: ${restorationResult.message}`;
    }
  } catch (restorationError) {
    recoveryResult.message = `Checkpoint restoration error: ${restorationError.message}`;
  }
  
  return recoveryResult;
}

// Example usage
const checkpointRecovery = recoverFromCheckpoint(error, context);
```

### Fallback Mechanism Implementation

Implement fallback mechanisms with these patterns:

```typescript
// Fallback mechanism pattern
function implementFallbackMechanism(operation, error, context) {
  // Initialize fallback result
  const fallbackResult = {
    success: false,
    result: null,
    message: '',
    fallbackUsed: ''
  };
  
  // Determine available fallbacks for this operation and error
  const fallbacks = determineFallbacks(operation, error, context);
  
  // Try each fallback in order
  for (const fallback of fallbacks) {
    try {
      const fallbackOperation = createFallbackOperation(operation, fallback, context);
      const result = executeFallbackOperation(fallbackOperation);
      
      if (isSuccessfulResult(result, fallback)) {
        // Fallback succeeded
        fallbackResult.success = true;
        fallbackResult.result = result;
        fallbackResult.message = `Successfully used fallback: ${fallback.name}`;
        fallbackResult.fallbackUsed = fallback.name;
        
        // Log successful fallback
        logSuccessfulFallback({
          operation,
          error,
          fallback: fallback.name,
          result,
          context
        });
        
        return fallbackResult;
      }
    } catch (fallbackError) {
      // Fallback failed, continue to next one
      logFailedFallback({
        operation,
        error,
        fallback: fallback.name,
        fallbackError,
        context
      });
    }
  }
  
  // All fallbacks failed
  fallbackResult.message = `All fallbacks failed for operation: ${operation}`;
  return fallbackResult;
}

// Example usage
const fallbackResult = implementFallbackMechanism('file_read', error, context);
```

## Comprehensive Error Handling System

### Integrated Error Handling

Implement an integrated error handling system with these mechanisms:

```typescript
// Integrated error handling pattern
function handleError(error, operation, context, options = {}) {
  // Default options
  const {
    attemptRecovery = true,
    useFallbacks = true,
    reportErrors = true,
    abortOnUnrecoverable = true,
    generateFeedback = true
  } = options;
  
  // 1. Ensure error is properly structured
  const structuredError = ensureStructuredError(error);
  
  // 2. Classify error
  const classification = classifyError(structuredError);
  
  // 3. Report error if needed
  let errorReport = null;
  if (reportErrors) {
    errorReport = reportError(structuredError, {
      includeStack: classification.priority === 'high' || classification.priority === 'critical',
      includeDetails: true,
      format: 'text',
      logToConsole: true,
      logToFile: classification.priority === 'high' || classification.priority === 'critical'
    });
  }
  
  // 4. Attempt recovery if needed
  let recoveryResult = { success: false, message: 'Recovery not attempted' };
  if (attemptRecovery && classification.requiresRecovery) {
    recoveryResult = attemptAutomaticRecovery(structuredError, context);
    
    // If recovery failed but checkpoints might help
    if (!recoveryResult.success && context.hasCheckpoints) {
      recoveryResult = recoverFromCheckpoint(structuredError, context);
    }
  }
  
  // 5. Try fallbacks if recovery failed and fallbacks are enabled
  let fallbackResult = { success: false, message: 'Fallbacks not attempted' };
  if (!recoveryResult.success && useFallbacks) {
    fallbackResult = implementFallbackMechanism(operation, structuredError, context);
  }
  
  // 6. Generate user feedback if requested
  let userFeedback = null;
  if (generateFeedback) {
    userFeedback = generateUserFeedback(structuredError, classification);
    
    // Add recovery/fallback information to feedback
    if (recoveryResult.success) {
      userFeedback.message = `Recovered: ${recoveryResult.message}`;
    } else if (fallbackResult.success) {
      userFeedback.message = `Used alternative approach: ${fallbackResult.message}`;
    }
  }
  
  // 7. Determine if we need to abort
  const shouldAbort = !recoveryResult.success && 
                     !fallbackResult.success && 
                     abortOnUnrecoverable && 
                     (classification.priority === 'high' || classification.priority === 'critical');
  
  // 8. Create final result
  const handlingResult = {
    error: structuredError,
    classification,
    recovery: recoveryResult,
    fallback: fallbackResult,
    report: errorReport,
    feedback: userFeedback,
    success: recoveryResult.success || fallbackResult.success,
    aborted: shouldAbort
  };
  
  // 9. Abort if necessary
  if (shouldAbort) {
    throw new ErrorHandlingAbort('Operation aborted due to unrecoverable error', handlingResult);
  }
  
  return handlingResult;
}

// Helper error class for aborts
class ErrorHandlingAbort extends Error {
  constructor(message, handlingResult) {
    super(message);
    this.name = 'ErrorHandlingAbort';
    this.handlingResult = handlingResult;
  }
}

// Example usage
try {
  // Attempt operation
  performOperation();
} catch (error) {
  const handlingResult = handleError(error, 'perform_operation', operationContext, {
    attemptRecovery: true,
    useFallbacks: true,
    reportErrors: true,
    abortOnUnrecoverable: true,
    generateFeedback: true
  });
  
  if (handlingResult.success) {
    console.log(`Error handled successfully: ${handlingResult.feedback.message}`);
  } else {
    console.error(`Error handling failed: ${handlingResult.feedback.message}`);
  }
}
```

### Error Handling in File Operations

Implement error handling specifically for file operations:

```typescript
// Safe file operation pattern with error handling
function safeFileOperation(operation, path, options, context) {
  // Create operation context if not provided
  const operationContext = context || createDefaultContext();
  
  try {
    // 1. Validate authorization
    const authResult = authorizeFileOperation(operation, path, operationContext);
    if (!authResult.authorized) {
      const error = {
        type: 'unauthorized_operation',
        severity: 'critical',
        message: authResult.message,
        details: { operation, path, context: operationContext }
      };
      
      return handleError(error, operation, operationContext);
    }
    
    // 2. Create checkpoint if this is a modification
    let checkpoint = null;
    if (operation === 'write' || operation === 'modify' || operation === 'delete') {
      checkpoint = createOperationCheckpoint(operation, path, operationContext);
      operationContext.hasCheckpoints = true;
      operationContext.checkpoints = [checkpoint];
    }
    
    // 3. Perform operation
    const result = performFileOperation(operation, path, options);
    
    // 4. Validate result if this is a creation or modification
    if (operation === 'create' || operation === 'write' || operation === 'modify') {
      const validationResult = validateFileAfterOperation(path, operation, operationContext);
      
      if (!validationResult.valid) {
        // Handle validation errors
        const error = {
          type: 'validation_error',
          severity: 'error',
          message: `File validation failed after ${operation}`,
          details: { 
            operation, 
            path, 
            errors: validationResult.errors,
            warnings: validationResult.warnings
          }
        };
        
        return handleError(error, operation, operationContext);
      }
    }
    
    // 5. Register operation
    registerSuccessfulOperation(operation, path, result, operationContext);
    
    // 6. Return success result
    return {
      success: true,
      result,
      message: `Operation ${operation} completed successfully on ${path}`,
      path
    };
  } catch (error) {
    // Handle any errors
    return handleError(error, operation, operationContext);
  }
}

// Example usage
const readResult = safeFileOperation('read', 'knowledge/rules/patterns/doc/error-handling-mechanisms.md', {}, {
  type: 'documentation_reference',
  domain: 'knowledge'
});

if (readResult.success) {
  console.log(`Successfully read file: ${readResult.path}`);
} else {
  console.error(`Failed to read file: ${readResult.feedback.message}`);
}
```

## Best Practices

### Error Handling Checklist

Follow this checklist for effective error handling:

1. **Define Clear Error Categories**: Clearly define and categorize all possible errors
2. **Implement Explicit Detection**: Explicitly check for and detect all potential errors
3. **Create Structured Reports**: Generate structured error reports with detailed information
4. **Classify by Severity**: Classify errors by severity and priority
5. **Implement Recovery Mechanisms**: Create specific recovery mechanisms for critical errors
6. **Use Checkpoints**: Create operation checkpoints before potentially dangerous operations
7. **Implement Fallbacks**: Define fallback approaches for common error scenarios
8. **Generate User Feedback**: Provide clear, actionable feedback for users
9. **Log All Errors**: Maintain comprehensive error logs
10. **Review Error Patterns**: Regularly analyze error patterns for system improvements

### Error Handling Warning Signs

Watch for these signs of error handling issues:

1. **Unhandled Errors**: Errors that aren't caught or handled
2. **Cascading Failures**: One error causing a series of additional errors
3. **Silent Failures**: Operations failing without visible errors
4. **Uninformative Error Messages**: Error messages that don't clearly explain the issue
5. **Missing Recovery**: Critical errors without recovery mechanisms
6. **Checkpoint Failures**: Inability to restore from checkpoints
7. **Inconsistent Error Formats**: Error reports with inconsistent structure
8. **Recovery Loops**: Repeated recovery attempts that don't resolve the issue
9. **Excessive Technical Details**: Error messages with unnecessarily technical details
10. **Inadequate User Feedback**: Errors without clear guidance for resolution

### Error-First Implementation Approach

Follow this approach to prioritize robust error handling:

1. **Identify Potential Errors**: Identify all possible error scenarios before implementation
2. **Define Error Categories**: Define clear categories and severity levels
3. **Create Detection Mechanisms**: Implement explicit detection for each error type
4. **Establish Recovery Strategies**: Define recovery strategies for critical errors
5. **Implement Checkpoints**: Create checkpoint mechanisms for potentially dangerous operations
6. **Define Fallbacks**: Implement fallback approaches for common errors
7. **Create User Feedback**: Design clear, actionable user feedback
8. **Implement Logging**: Create comprehensive error logging
9. **Test Error Scenarios**: Explicitly test error scenarios
10. **Analyze Error Patterns**: Regularly review and analyze error patterns

## Related Patterns

- [File Operation Boundaries](file-operation-boundaries.md): Establishing operation boundaries
- [File Validation Mechanisms](file-validation-mechanisms.md): Validating file structure and content
- [Context Preservation Mechanisms](context-preservation-mechanisms.md): Preserving context across operations
- [Hierarchical Relationship Guide](hierarchical-relationship-guide.md): Establishing parent-child relationships 