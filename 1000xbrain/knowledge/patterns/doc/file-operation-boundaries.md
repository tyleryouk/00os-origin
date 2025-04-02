# USE WHEN implementing file operations, defining authorization boundaries, or establishing domain-specific validation rules

# File Operation Boundaries

## File Purpose and Relationship

This file establishes explicit boundaries for file operations within the cognitive architecture to prevent hallucinations and ensure system stability. It defines clear authorization rules, validation mechanisms, and error handling for file-related operations. It should be used when:

- Implementing file creation or modification operations
- Defining authorization boundaries for system components
- Creating validation mechanisms for file structure
- Implementing error handling for boundary violations
- Preventing hallucinations related to file operations

This file is part of the documentation patterns in the knowledge/patterns/doc directory and complements the context-preservation-mechanisms.md, information-chunking-guide.md, and hierarchical-relationship-guide.md files.

## File Operation Authorization Framework

### Core Authorization Principles

1. **Explicit Authorization**: File operations require explicit authorization
2. **Domain Boundaries**: Clear boundaries between operational domains
3. **Validation Requirements**: All file operations must pass validation
4. **Structure Adherence**: Files must adhere to standard structure
5. **Recovery Mechanisms**: Error handling for boundary violations

### Authorization Domains

The cognitive architecture recognizes these primary authorization domains:

1. **Core Domain**: Files within the core identity and cognitive system
   - Location: `/1000xbrain/core/`
   - Authorization Level: Highly restricted
   - Validation Requirements: Strict structure adherence
   - Error Handling: Explicit error reporting with recovery

2. **Workflow Domain**: Files within specific workflow systems
   - Location: `/1000xbrain/workflows/`
   - Authorization Level: Workflow-specific
   - Validation Requirements: Workflow structure adherence
   - Error Handling: Contextual error handling with recovery options

3. **Parameter Domain**: Files within parameter definitions
   - Location: `/1000xbrain/parameters/`
   - Authorization Level: Parameter-specific
   - Validation Requirements: Parameter structure adherence
   - Error Handling: Parameter-specific error handling

4. **Knowledge Domain**: Files within knowledge components
   - Location: `/1000xbrain/knowledge/`
   - Authorization Level: Knowledge-specific
   - Validation Requirements: Knowledge structure adherence
   - Error Handling: Knowledge-specific error handling

## File Operation Authorization Rules

### File Creation Authorization

Implement explicit file creation authorization with these rules:

1. **Core Domain Files**:
   - Only explicitly authorized core system operations can create core files
   - Must follow exact core file structure templates
   - Must be properly integrated with existing core system
   - Must be documented in the core domain registry

2. **Workflow Domain Files**:
   - Only authorized within specific workflow contexts
   - Must follow workflow-specific templates
   - Must be integrated with existing workflow
   - Must be documented in workflow registry

3. **Parameter Domain Files**:
   - Only authorized for parameter definition tasks
   - Must follow parameter structure templates
   - Must be properly linked to existing parameters
   - Must be documented in parameter registry

4. **Knowledge Domain Files**:
   - Only authorized for knowledge management tasks
   - Must follow knowledge structure templates
   - Must be properly integrated with knowledge system
   - Must be documented in knowledge registry

### File Modification Authorization

Implement explicit file modification authorization with these rules:

1. **Core Domain Modifications**:
   - Only authorized for core system enhancement tasks
   - Must preserve core system integrity
   - Must maintain backward compatibility
   - Must be documented in the modification registry

2. **Workflow Domain Modifications**:
   - Only authorized within workflow enhancement context
   - Must preserve workflow integrity
   - Must maintain workflow compatibility
   - Must be documented in workflow modification registry

3. **Parameter Domain Modifications**:
   - Only authorized for parameter enhancement tasks
   - Must preserve parameter integrity
   - Must maintain parameter compatibility
   - Must be documented in parameter modification registry

4. **Knowledge Domain Modifications**:
   - Only authorized for knowledge enhancement tasks
   - Must preserve knowledge system integrity
   - Must maintain knowledge compatibility
   - Must be documented in knowledge modification registry

## Boundary Enforcement Mechanisms

### Domain Boundary Enforcement

Implement domain boundary enforcement with these patterns:

```typescript
// Domain boundary definition
const domainBoundaries = {
  core: {
    basePath: '/1000xbrain/core/',
    authorizedOperations: ['read', 'modify', 'enhance'],
    authorizedContexts: ['core-enhancement', 'system-update'],
    validationLevel: 'strict',
    templates: {
      identity: 'templates/core/identity-template.md',
      mode: 'templates/core/mode-template.md',
      communication: 'templates/core/communication-template.md'
    }
  },
  workflows: {
    basePath: '/1000xbrain/workflows/',
    authorizedOperations: ['read', 'modify', 'enhance', 'create'],
    authorizedContexts: ['workflow-enhancement', 'workflow-creation'],
    validationLevel: 'standard',
    templates: {
      workflow: 'templates/workflows/workflow-template.md',
      process: 'templates/workflows/process-template.md'
    }
  },
  parameters: {
    basePath: '/1000xbrain/parameters/',
    authorizedOperations: ['read', 'modify', 'enhance', 'create'],
    authorizedContexts: ['parameter-enhancement', 'parameter-creation'],
    validationLevel: 'standard',
    templates: {
      parameter: 'templates/parameters/parameter-template.md'
    }
  },
  knowledge: {
    basePath: '/1000xbrain/knowledge/',
    authorizedOperations: ['read', 'modify', 'enhance', 'create'],
    authorizedContexts: ['knowledge-enhancement', 'knowledge-creation'],
    validationLevel: 'flexible',
    templates: {
      pattern: 'templates/knowledge/pattern-template.md',
      guide: 'templates/knowledge/guide-template.md',
      reference: 'templates/knowledge/reference-template.md'
    }
  }
};

// Domain boundary check
function isAuthorizedInDomain(operation, path, context) {
  // Determine domain
  const domain = determineDomainForPath(path);
  if (!domain) {
    return {
      authorized: false,
      message: `Path does not match any authorized domain: ${path}`
    };
  }
  
  // Check operation authorization
  if (!domainBoundaries[domain].authorizedOperations.includes(operation)) {
    return {
      authorized: false,
      message: `Operation "${operation}" not authorized in domain "${domain}"`
    };
  }
  
  // Check context authorization
  if (!domainBoundaries[domain].authorizedContexts.includes(context.type)) {
    return {
      authorized: false,
      message: `Context "${context.type}" not authorized for operations in domain "${domain}"`
    };
  }
  
  return {
    authorized: true,
    domain: domain,
    template: determineTemplateForPath(path, domain),
    validationLevel: domainBoundaries[domain].validationLevel
  };
}

// Example usage
const authorizationResult = isAuthorizedInDomain(
  'create',
  '/1000xbrain/knowledge/patterns/doc/new-pattern.md',
  { type: 'knowledge-creation', operation: 'pattern-enhancement' }
);
```

### Authorization Registry System

Implement an authorization registry system to track operations:

```typescript
// Operation registration system
const operationRegistry = {
  registerOperation(operation, path, context, result) {
    const registryEntry = {
      operation: operation,
      path: path,
      context: context,
      timestamp: Date.now(),
      result: result,
      hash: generateOperationHash(operation, path, context)
    };
    
    // Add to registry
    appendToRegistry(registryEntry);
    
    // Log registration
    logRegistryEntry(registryEntry);
    
    return registryEntry;
  },
  
  findOperation(criteria) {
    return searchRegistry(criteria);
  },
  
  verifyOperation(operationHash) {
    return verifyRegistryEntry(operationHash);
  }
};

// Example usage
const registrationResult = operationRegistry.registerOperation(
  'create',
  '/1000xbrain/knowledge/patterns/doc/new-pattern.md',
  { type: 'knowledge-creation', operation: 'pattern-enhancement' },
  { success: true, timestamp: Date.now() }
);
```

## Best Practices

### File Operation Boundary Checklist

Follow this checklist for effective file operation boundaries:

1. **Verify Authorization**: Ensure operation is authorized in the target domain
2. **Validate Structure**: Verify content follows required structure templates
3. **Check References**: Validate all references in content
4. **Create Checkpoints**: Create recovery checkpoints before modifications
5. **Register Operations**: Register all file operations in appropriate registry
6. **Implement Error Handling**: Handle boundary violations appropriately
7. **Document Boundaries**: Clearly document domain boundaries
8. **Verify After Operation**: Validate file after creation or modification
9. **Log Operations**: Maintain comprehensive operation logs
10. **Implement Recovery**: Create recovery mechanisms for failures

### Boundary Violation Warning Signs

Watch for these signs of boundary issues:

1. **Unauthorized Domain Access**: Attempts to create files in restricted domains
2. **Structure Violations**: Files not following required templates
3. **Invalid References**: References to non-existent files
4. **Multiple Domain Operations**: Operations spanning multiple domains without authorization
5. **Template Bypassing**: Content creation without proper templates
6. **Registry Avoidance**: Operations not properly registered
7. **Recovery Failure**: Failed recovery from operation errors
8. **Checkpoint Bypass**: Operations without proper checkpoints
9. **Validation Skipping**: Operations bypassing validation
10. **Unclear Boundaries**: Ambiguous responsibility domains

### Boundary-First Implementation Approach

Follow this approach to prioritize boundary enforcement:

1. **Define Clear Domains**: Establish explicit domain boundaries
2. **Create Domain Templates**: Define templates for each domain
3. **Implement Validation**: Create validation mechanisms for each domain
4. **Establish Authorization Rules**: Define clear authorization rules
5. **Create Recovery Mechanisms**: Implement robust recovery for failures
6. **Test Boundaries**: Verify boundary enforcement with tests
7. **Document Boundaries**: Create clear boundary documentation
8. **Implement Logging**: Create comprehensive logging system
9. **Create Registry System**: Establish registry for all operations
10. **Verify Implementation**: Confirm boundary system effectiveness

## Domain-Specific Boundary Rules

### Core Domain Boundary Rules

Core domain files have these specific boundary requirements:

1. **Structure Requirements**:
   - Must include file purpose and relationship section
   - Must define clear responsibility boundaries
   - Must explicitly state relationships to other core components
   - Must follow standard core file template

2. **Integration Requirements**:
   - Must properly integrate with existing core system
   - Must not disrupt core system functionality
   - Must maintain backward compatibility
   - Must preserve core system integrity

3. **Authorization Context**:
   - Only authorized in explicit core enhancement context
   - Must be part of documented core enhancement plan
   - Must be verifiable through the registry system
   - Must include purpose documentation

### Workflow Domain Boundary Rules

Workflow domain files have these specific boundary requirements:

1. **Structure Requirements**:
   - Must include workflow purpose and process definitions
   - Must define clear workflow boundaries
   - Must explicitly state relationships to other workflows
   - Must follow standard workflow file template

2. **Integration Requirements**:
   - Must properly integrate with existing workflows
   - Must maintain workflow compatibility
   - Must preserve workflow system integrity
   - Must not create workflow conflicts

3. **Authorization Context**:
   - Authorized in workflow enhancement or creation context
   - Must be part of documented workflow enhancement plan
   - Must be verifiable through the registry system
   - Must include workflow documentation

### Parameter Domain Boundary Rules

Parameter domain files have these specific boundary requirements:

1. **Structure Requirements**:
   - Must include parameter purpose and usage definitions
   - Must define clear parameter boundaries
   - Must explicitly state relationships to other parameters
   - Must follow standard parameter file template

2. **Integration Requirements**:
   - Must properly integrate with existing parameters
   - Must maintain parameter compatibility
   - Must preserve parameter system integrity
   - Must not create parameter conflicts

3. **Authorization Context**:
   - Authorized in parameter enhancement or creation context
   - Must be part of documented parameter enhancement plan
   - Must be verifiable through the registry system
   - Must include parameter documentation

### Knowledge Domain Boundary Rules

Knowledge domain files have these specific boundary requirements:

1. **Structure Requirements**:
   - Must include knowledge purpose and relationship section
   - Must define clear knowledge boundaries
   - Must explicitly state relationships to other knowledge components
   - Must follow standard knowledge file template

2. **Integration Requirements**:
   - Must properly integrate with existing knowledge system
   - Must maintain knowledge compatibility
   - Must preserve knowledge system integrity
   - Must not create knowledge conflicts

3. **Authorization Context**:
   - Authorized in knowledge enhancement or creation context
   - Must be part of documented knowledge enhancement plan
   - Must be verifiable through the registry system
   - Must include knowledge documentation

## Related Patterns

- [Context Preservation Mechanisms](context-preservation-mechanisms.md): Preserving context across operations
- [Information Chunking Guide](information-chunking-guide.md): Organizing information into logical chunks
- [Hierarchical Relationship Guide](hierarchical-relationship-guide.md): Establishing parent-child relationships
- [Progressive Disclosure Guide](progressive-disclosure-guide.md): Revealing information progressively