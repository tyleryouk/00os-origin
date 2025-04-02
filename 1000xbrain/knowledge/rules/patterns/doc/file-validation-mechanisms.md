# USE WHEN implementing file validation, creating validation mechanisms, or ensuring documentation quality

# File Validation Mechanisms

## File Purpose and Relationship

This file establishes standardized validation mechanisms for file operations within the cognitive architecture. It defines patterns for validating file structure, content, and references to prevent hallucinations and ensure system stability. It should be used when:

- Implementing file validation for new or modified files
- Creating structure validation mechanisms
- Implementing content validation rules
- Establishing reference validation systems
- Preventing hallucinations through validation

This file is part of the documentation patterns in the knowledge/rules/patterns/doc directory and complements the file-operation-boundaries.md, context-preservation-mechanisms.md, and hierarchical-relationship-guide.md files.

## Validation Fundamentals

### Core Validation Principles

1. **Explicit Validation**: All file operations require explicit validation
2. **Template Adherence**: Files must adhere to domain-specific templates
3. **Reference Integrity**: All references must resolve to valid targets
4. **Content Structure**: Content must follow standard organization patterns
5. **Error Recovery**: Validation errors require explicit handling

### Validation Domains

The cognitive architecture implements validation across these domains:

1. **Structure Validation**: Ensuring file follows proper structure and organization
   - Section presence and ordering
   - Header hierarchy and formatting
   - Standard layout patterns
   - Template adherence

2. **Content Validation**: Verifying content quality and correctness
   - Terminology consistency
   - Format adherence
   - Content completeness
   - Domain-specific rules

3. **Reference Validation**: Ensuring all references are valid and accessible
   - Reference resolution
   - Reference format consistency
   - Reference context appropriateness
   - Reference integrity

## Structure Validation Mechanisms

### Section Validation

Implement section validation with these mechanisms:

```typescript
// Section validation pattern
function validateFileSections(fileContent, template) {
  const validationResult = {
    valid: true,
    errors: [],
    warnings: []
  };
  
  // Extract sections from file
  const sections = extractSections(fileContent);
  
  // Check required sections
  for (const requiredSection of template.requiredSections) {
    if (!sections.some(s => s.title === requiredSection)) {
      validationResult.valid = false;
      validationResult.errors.push(`Missing required section: ${requiredSection}`);
    }
  }
  
  // Check section order
  const sectionOrder = sections.map(s => s.title);
  const expectedOrder = template.sectionOrder.filter(s => sectionOrder.includes(s));
  
  for (let i = 0; i < expectedOrder.length; i++) {
    const expectedSection = expectedOrder[i];
    const actualIndex = sectionOrder.indexOf(expectedSection);
    const expectedIndex = i;
    
    if (actualIndex !== expectedIndex) {
      validationResult.valid = false;
      validationResult.errors.push(
        `Section order error: ${expectedSection} should be at position ${expectedIndex}, found at ${actualIndex}`
      );
    }
  }
  
  // Check optional but recommended sections
  for (const recommendedSection of template.recommendedSections || []) {
    if (!sections.some(s => s.title === recommendedSection)) {
      validationResult.warnings.push(`Missing recommended section: ${recommendedSection}`);
    }
  }
  
  return validationResult;
}

// Example usage
const template = {
  requiredSections: [
    'File Purpose and Relationship',
    'Core Principles',
    'Implementation Patterns',
    'Best Practices'
  ],
  recommendedSections: [
    'Related Patterns',
    'Verification Mechanisms'
  ],
  sectionOrder: [
    'File Purpose and Relationship',
    'Core Principles',
    'Implementation Patterns',
    'Best Practices',
    'Related Patterns',
    'Verification Mechanisms'
  ]
};

const validationResult = validateFileSections(fileContent, template);
```

### Header Structure Validation

Implement header structure validation with these mechanisms:

```typescript
// Header structure validation pattern
function validateHeaderStructure(fileContent) {
  const validationResult = {
    valid: true,
    errors: [],
    warnings: []
  };
  
  // Extract all headers
  const headers = extractHeaders(fileContent);
  
  // Check H1 title existence
  if (!headers.some(h => h.level === 1)) {
    validationResult.valid = false;
    validationResult.errors.push('Missing H1 title');
  }
  
  // Check H1 uniqueness
  const h1Headers = headers.filter(h => h.level === 1);
  if (h1Headers.length > 1) {
    validationResult.valid = false;
    validationResult.errors.push(`Multiple H1 titles found: ${h1Headers.map(h => h.text).join(', ')}`);
  }
  
  // Check header hierarchy (no skipping levels)
  let maxLevel = 1;
  for (const header of headers) {
    if (header.level > maxLevel + 1) {
      validationResult.valid = false;
      validationResult.errors.push(`Header level skipped: H${maxLevel} to H${header.level} - "${header.text}"`);
    }
    maxLevel = Math.max(maxLevel, header.level);
  }
  
  // Check header nesting
  const headerStack = [];
  for (const header of headers) {
    while (headerStack.length > 0 && headerStack[headerStack.length - 1].level >= header.level) {
      headerStack.pop();
    }
    
    if (headerStack.length > 0) {
      header.parent = headerStack[headerStack.length - 1];
    }
    
    headerStack.push(header);
  }
  
  // Check for empty sections
  for (let i = 0; i < headers.length - 1; i++) {
    const currentHeader = headers[i];
    const nextHeader = headers[i + 1];
    
    if (currentHeader.end === nextHeader.start - 1) {
      validationResult.warnings.push(`Empty section: "${currentHeader.text}"`);
    }
  }
  
  return validationResult;
}

// Example usage
const headerStructureResult = validateHeaderStructure(fileContent);
```

### Template Adherence Validation

Implement template adherence validation with these mechanisms:

```typescript
// Template adherence validation pattern
function validateTemplateAdherence(fileContent, templatePath) {
  const validationResult = {
    valid: true,
    errors: [],
    warnings: []
  };
  
  // Load template
  const templateContent = loadTemplate(templatePath);
  
  // Extract template structure
  const templateStructure = analyzeTemplateStructure(templateContent);
  
  // Check top-level structure matches
  const fileStructure = analyzeFileStructure(fileContent);
  
  // Compare section count
  if (fileStructure.sections.length < templateStructure.requiredSections.length) {
    validationResult.valid = false;
    validationResult.errors.push(
      `File has too few sections: has ${fileStructure.sections.length}, needs at least ${templateStructure.requiredSections.length}`
    );
  }
  
  // Check for required elements
  for (const element of templateStructure.requiredElements) {
    if (!fileStructure.elements.includes(element)) {
      validationResult.valid = false;
      validationResult.errors.push(`Missing required element: ${element}`);
    }
  }
  
  // Check for recommended elements
  for (const element of templateStructure.recommendedElements) {
    if (!fileStructure.elements.includes(element)) {
      validationResult.warnings.push(`Missing recommended element: ${element}`);
    }
  }
  
  return validationResult;
}

// Example usage
const templateAdherenceResult = validateTemplateAdherence(
  fileContent, 
  'knowledge/rules/patterns/doc/templates/pattern-template.md'
);
```

## Content Validation Mechanisms

### Terminology Validation

Implement terminology validation with these mechanisms:

```typescript
// Terminology validation pattern
function validateTerminology(fileContent, domain) {
  const validationResult = {
    valid: true,
    errors: [],
    warnings: []
  };
  
  // Load domain-specific terminology rules
  const terminologyRules = loadTerminologyRules(domain);
  
  // Check for required terminology
  for (const term of terminologyRules.requiredTerms) {
    if (!contentContainsTerm(fileContent, term)) {
      validationResult.valid = false;
      validationResult.errors.push(`Missing required terminology: ${term}`);
    }
  }
  
  // Check for consistent terminology
  for (const [preferred, alternatives] of Object.entries(terminologyRules.preferredTerms)) {
    for (const alternative of alternatives) {
      if (contentContainsTerm(fileContent, alternative)) {
        validationResult.warnings.push(
          `Use of non-preferred terminology: "${alternative}" (use "${preferred}" instead)`
        );
      }
    }
  }
  
  // Check for prohibited terminology
  for (const term of terminologyRules.prohibitedTerms) {
    if (contentContainsTerm(fileContent, term)) {
      validationResult.valid = false;
      validationResult.errors.push(`Use of prohibited terminology: ${term}`);
    }
  }
  
  return validationResult;
}

// Example usage
const terminologyResult = validateTerminology(fileContent, 'knowledge-patterns');
```

### Content Completeness Validation

Implement content completeness validation with these mechanisms:

```typescript
// Content completeness validation pattern
function validateContentCompleteness(fileContent, domain) {
  const validationResult = {
    valid: true,
    errors: [],
    warnings: []
  };
  
  // Load domain-specific completeness rules
  const completenessRules = loadCompletenessRules(domain);
  
  // Check for content patterns
  for (const pattern of completenessRules.requiredPatterns) {
    if (!contentMatchesPattern(fileContent, pattern)) {
      validationResult.valid = false;
      validationResult.errors.push(`Missing required content pattern: ${pattern.description}`);
    }
  }
  
  // Check for minimum content length
  const contentLength = calculateContentLength(fileContent);
  if (contentLength < completenessRules.minimumLength) {
    validationResult.valid = false;
    validationResult.errors.push(
      `Content too short: ${contentLength} characters (minimum: ${completenessRules.minimumLength})`
    );
  }
  
  // Check for section content length
  for (const section of extractSections(fileContent)) {
    if (section.content.length < completenessRules.minimumSectionLength) {
      validationResult.warnings.push(
        `Section "${section.title}" is too short: ${section.content.length} characters (minimum: ${completenessRules.minimumSectionLength})`
      );
    }
  }
  
  return validationResult;
}

// Example usage
const completenessResult = validateContentCompleteness(fileContent, 'knowledge-patterns');
```

### Formatting Validation

Implement formatting validation with these mechanisms:

```typescript
// Formatting validation pattern
function validateFormatting(fileContent, domain) {
  const validationResult = {
    valid: true,
    errors: [],
    warnings: []
  };
  
  // Load domain-specific formatting rules
  const formattingRules = loadFormattingRules(domain);
  
  // Check for code block formatting
  const codeBlocks = extractCodeBlocks(fileContent);
  for (const codeBlock of codeBlocks) {
    if (!codeBlock.language) {
      validationResult.warnings.push(`Code block without language specification at line ${codeBlock.line}`);
    }
    
    if (codeBlock.content.length > formattingRules.maxCodeBlockLength) {
      validationResult.warnings.push(
        `Code block too long: ${codeBlock.content.length} lines at line ${codeBlock.line} (maximum: ${formattingRules.maxCodeBlockLength})`
      );
    }
  }
  
  // Check for list formatting
  const lists = extractLists(fileContent);
  for (const list of lists) {
    if (list.items.length < 2) {
      validationResult.warnings.push(`List with only one item at line ${list.line}`);
    }
    
    if (list.items.length > formattingRules.maxListItems) {
      validationResult.warnings.push(
        `List too long: ${list.items.length} items at line ${list.line} (maximum: ${formattingRules.maxListItems})`
      );
    }
  }
  
  // Check for paragraph length
  const paragraphs = extractParagraphs(fileContent);
  for (const paragraph of paragraphs) {
    if (paragraph.content.length > formattingRules.maxParagraphLength) {
      validationResult.warnings.push(
        `Paragraph too long: ${paragraph.content.length} characters at line ${paragraph.line} (maximum: ${formattingRules.maxParagraphLength})`
      );
    }
  }
  
  return validationResult;
}

// Example usage
const formattingResult = validateFormatting(fileContent, 'knowledge-patterns');
```

## Reference Validation Mechanisms

### Link Resolution Validation

Implement link resolution validation with these mechanisms:

```typescript
// Link resolution validation pattern
function validateLinkResolution(fileContent, basePath) {
  const validationResult = {
    valid: true,
    errors: [],
    warnings: []
  };
  
  // Extract all links
  const links = extractLinks(fileContent);
  
  // Check each link
  for (const link of links) {
    // Skip external links
    if (isExternalLink(link.target)) {
      continue;
    }
    
    // Resolve relative path
    const resolvedPath = resolvePath(link.target, basePath);
    
    // Check if file exists
    if (!fileExists(resolvedPath)) {
      validationResult.valid = false;
      validationResult.errors.push(
        `Broken link: "${link.text}" targets non-existent file "${link.target}" at line ${link.line}`
      );
      continue;
    }
    
    // Check if link is to a valid section
    if (link.hasSection && !sectionExists(resolvedPath, link.section)) {
      validationResult.valid = false;
      validationResult.errors.push(
        `Broken section link: "${link.text}" targets non-existent section "${link.section}" in file "${link.target}" at line ${link.line}`
      );
    }
  }
  
  return validationResult;
}

// Example usage
const linkResolutionResult = validateLinkResolution(
  fileContent, 
  'knowledge/rules/patterns/doc/'
);
```

### Reference Format Validation

Implement reference format validation with these mechanisms:

```typescript
// Reference format validation pattern
function validateReferenceFormat(fileContent, domain) {
  const validationResult = {
    valid: true,
    errors: [],
    warnings: []
  };
  
  // Load domain-specific reference format rules
  const referenceRules = loadReferenceRules(domain);
  
  // Extract all references
  const references = extractReferences(fileContent);
  
  // Check each reference
  for (const reference of references) {
    // Check reference type
    const referenceType = determineReferenceType(reference);
    
    // Check format against type-specific rules
    if (!matchesReferenceFormat(reference, referenceRules[referenceType])) {
      validationResult.warnings.push(
        `Non-standard reference format for ${referenceType} reference: "${reference.raw}" at line ${reference.line}`
      );
    }
    
    // Check for missing reference text
    if (!reference.text && referenceRules[referenceType].requiresText) {
      validationResult.warnings.push(
        `Missing reference text for ${referenceType} reference at line ${reference.line}`
      );
    }
    
    // Check for reference target format
    if (!matchesTargetFormat(reference.target, referenceRules[referenceType].targetFormat)) {
      validationResult.warnings.push(
        `Non-standard target format for ${referenceType} reference: "${reference.target}" at line ${reference.line}`
      );
    }
  }
  
  return validationResult;
}

// Example usage
const referenceFormatResult = validateReferenceFormat(fileContent, 'knowledge-patterns');
```

### Reference Context Validation

Implement reference context validation with these mechanisms:

```typescript
// Reference context validation pattern
function validateReferenceContext(fileContent, domain) {
  const validationResult = {
    valid: true,
    errors: [],
    warnings: []
  };
  
  // Load domain-specific reference context rules
  const contextRules = loadReferenceContextRules(domain);
  
  // Extract all references
  const references = extractReferences(fileContent);
  
  // Extract sections
  const sections = extractSections(fileContent);
  
  // Check each reference
  for (const reference of references) {
    // Determine reference section
    const referenceSection = findSectionForReference(reference, sections);
    
    // Check if reference type is allowed in this section
    const referenceType = determineReferenceType(reference);
    
    if (
      referenceSection && 
      contextRules.sectionRestrictions[referenceSection.title] &&
      !contextRules.sectionRestrictions[referenceSection.title].includes(referenceType)
    ) {
      validationResult.warnings.push(
        `${referenceType} reference in inappropriate section "${referenceSection.title}": "${reference.raw}" at line ${reference.line}`
      );
    }
    
    // Check if reference domain is allowed in this file
    const referenceDomain = determineReferenceDomain(reference);
    
    if (!contextRules.allowedDomains.includes(referenceDomain)) {
      validationResult.warnings.push(
        `Reference to restricted domain "${referenceDomain}": "${reference.raw}" at line ${reference.line}`
      );
    }
  }
  
  return validationResult;
}

// Example usage
const referenceContextResult = validateReferenceContext(fileContent, 'knowledge-patterns');
```

## Complete Validation Implementation

### Combined Validation System

Implement a complete validation system with these mechanisms:

```typescript
// Combined validation system
function validateFile(filePath, domain) {
  // Initialize validation result
  const validationResult = {
    valid: true,
    errors: [],
    warnings: [],
    details: {}
  };
  
  // Load file content
  const fileContent = loadFile(filePath);
  if (!fileContent) {
    return {
      valid: false,
      errors: [`Failed to load file: ${filePath}`],
      warnings: [],
      details: {}
    };
  }
  
  // Determine template
  const templatePath = determineTemplateForFile(filePath, domain);
  
  // 1. Validate structure
  const sectionValidation = validateFileSections(fileContent, loadSectionTemplate(templatePath));
  const headerValidation = validateHeaderStructure(fileContent);
  const templateValidation = validateTemplateAdherence(fileContent, templatePath);
  
  // 2. Validate content
  const terminologyValidation = validateTerminology(fileContent, domain);
  const completenessValidation = validateContentCompleteness(fileContent, domain);
  const formattingValidation = validateFormatting(fileContent, domain);
  
  // 3. Validate references
  const basePath = extractBasePath(filePath);
  const linkValidation = validateLinkResolution(fileContent, basePath);
  const referenceFormatValidation = validateReferenceFormat(fileContent, domain);
  const referenceContextValidation = validateReferenceContext(fileContent, domain);
  
  // Combine all validation results
  validationResult.details = {
    structure: {
      sections: sectionValidation,
      headers: headerValidation,
      template: templateValidation
    },
    content: {
      terminology: terminologyValidation,
      completeness: completenessValidation,
      formatting: formattingValidation
    },
    references: {
      links: linkValidation,
      format: referenceFormatValidation,
      context: referenceContextValidation
    }
  };
  
  // Combine all errors
  validationResult.errors = [
    ...sectionValidation.errors,
    ...headerValidation.errors,
    ...templateValidation.errors,
    ...terminologyValidation.errors,
    ...completenessValidation.errors,
    ...formattingValidation.errors,
    ...linkValidation.errors,
    ...referenceFormatValidation.errors,
    ...referenceContextValidation.errors
  ];
  
  // Combine all warnings
  validationResult.warnings = [
    ...sectionValidation.warnings,
    ...headerValidation.warnings,
    ...templateValidation.warnings,
    ...terminologyValidation.warnings,
    ...completenessValidation.warnings,
    ...formattingValidation.warnings,
    ...linkValidation.warnings,
    ...referenceFormatValidation.warnings,
    ...referenceContextValidation.warnings
  ];
  
  // Determine overall validity
  validationResult.valid = validationResult.errors.length === 0;
  
  return validationResult;
}

// Example usage
const validationResult = validateFile(
  'knowledge/rules/patterns/doc/new-pattern.md',
  'knowledge-patterns'
);
```

### Validation Results Reporting

Implement validation results reporting with these mechanisms:

```typescript
// Validation results reporting
function reportValidationResults(validationResult, options = {}) {
  const {
    includeWarnings = true,
    detailedReport = false,
    formatOutput = 'text'
  } = options;
  
  // Determine overall status
  const status = validationResult.valid ? 'PASS' : 'FAIL';
  
  // Create report
  let report = '';
  
  // Text format
  if (formatOutput === 'text') {
    report += `Validation: ${status}\n`;
    report += `Errors: ${validationResult.errors.length}\n`;
    report += `Warnings: ${validationResult.warnings.length}\n`;
    
    if (validationResult.errors.length > 0) {
      report += '\nERRORS:\n';
      validationResult.errors.forEach((error, index) => {
        report += `${index + 1}. ${error}\n`;
      });
    }
    
    if (includeWarnings && validationResult.warnings.length > 0) {
      report += '\nWARNINGS:\n';
      validationResult.warnings.forEach((warning, index) => {
        report += `${index + 1}. ${warning}\n`;
      });
    }
    
    if (detailedReport) {
      report += '\nDETAILED REPORT:\n';
      report += JSON.stringify(validationResult.details, null, 2);
    }
  } 
  // JSON format
  else if (formatOutput === 'json') {
    const jsonReport = {
      status,
      errorCount: validationResult.errors.length,
      warningCount: validationResult.warnings.length,
      errors: validationResult.errors,
      warnings: includeWarnings ? validationResult.warnings : undefined,
      details: detailedReport ? validationResult.details : undefined
    };
    
    report = JSON.stringify(jsonReport, null, 2);
  }
  
  return report;
}

// Example usage
const report = reportValidationResults(validationResult, {
  includeWarnings: true,
  detailedReport: false,
  formatOutput: 'text'
});

console.log(report);
```

### Validation-Based Error Handling

Implement validation-based error handling with these mechanisms:

```typescript
// Validation-based error handling
function handleValidationErrors(validationResult, options = {}) {
  const {
    abortOnError = true,
    fixAutomatically = false,
    logErrors = true,
    errorCallback = null
  } = options;
  
  // Check if validation passed
  if (validationResult.valid) {
    return {
      success: true,
      message: 'Validation successful',
      fixed: false
    };
  }
  
  // Log errors if needed
  if (logErrors) {
    console.error('Validation errors:');
    validationResult.errors.forEach((error, index) => {
      console.error(`${index + 1}. ${error}`);
    });
  }
  
  // Try to fix errors automatically if requested
  if (fixAutomatically) {
    const fixResult = attemptAutomaticFix(validationResult);
    
    if (fixResult.success) {
      return {
        success: true,
        message: `Fixed ${fixResult.fixedCount} validation errors automatically`,
        fixed: true,
        fixResult
      };
    }
  }
  
  // Call error callback if provided
  if (errorCallback) {
    errorCallback(validationResult);
  }
  
  // Abort if needed
  if (abortOnError) {
    throw new Error(`Validation failed with ${validationResult.errors.length} errors.`);
  }
  
  // Return error result
  return {
    success: false,
    message: `Validation failed with ${validationResult.errors.length} errors.`,
    fixed: false
  };
}

// Automatic fix attempt
function attemptAutomaticFix(validationResult) {
  const fixResult = {
    success: false,
    fixedCount: 0,
    unfixableErrors: [],
    fixedErrors: []
  };
  
  // Try to fix each error
  for (const error of validationResult.errors) {
    const fix = attemptFixForError(error, validationResult.details);
    
    if (fix.success) {
      fixResult.fixedCount++;
      fixResult.fixedErrors.push({ error, fix });
    } else {
      fixResult.unfixableErrors.push(error);
    }
  }
  
  // Success if we fixed all errors
  fixResult.success = fixResult.unfixableErrors.length === 0;
  
  return fixResult;
}

// Example usage
try {
  const handleResult = handleValidationErrors(validationResult, {
    abortOnError: true,
    fixAutomatically: true,
    logErrors: true
  });
  
  if (handleResult.fixed) {
    console.log(`Fixed ${handleResult.fixResult.fixedCount} validation errors.`);
  }
} catch (error) {
  console.error(`Validation handling failed: ${error.message}`);
}
```

## Best Practices

### Validation Implementation Checklist

Follow this checklist for effective validation implementation:

1. **Define Domain-Specific Templates**: Create templates for each file type
2. **Implement Structure Validation**: Validate against template structure
3. **Apply Content Validation**: Verify content quality and completeness
4. **Enforce Reference Validation**: Ensure all references are valid
5. **Create Validation Reports**: Generate clear validation reports
6. **Implement Error Handling**: Handle validation errors appropriately
7. **Apply Automatic Fixes**: Create automatic fixes for common errors
8. **Document Validation Rules**: Clearly document validation requirements
9. **Provide User Feedback**: Create user-friendly validation messages
10. **Implement Progressive Validation**: Apply validation in stages

### Validation Failure Warning Signs

Watch for these signs of validation issues:

1. **Inconsistent Structure**: File structure doesn't match templates
2. **Broken References**: References to non-existent files or sections
3. **Terminology Inconsistency**: Inconsistent use of terminology
4. **Incompleteness**: Missing required sections or content
5. **Format Violations**: Formatting doesn't follow standards
6. **Context Violations**: References used in inappropriate contexts
7. **Excessive Errors**: High number of validation errors
8. **Unfixable Errors**: Errors that can't be fixed automatically
9. **Pattern Violations**: Content doesn't follow required patterns
10. **Domain Boundary Violations**: References outside allowed domains

### Validation-First Implementation Approach

Follow this approach to prioritize validation:

1. **Define Clear Templates**: Create explicit templates for each domain
2. **Document Validation Rules**: Clearly document all validation rules
3. **Implement Validation System**: Create comprehensive validation mechanisms
4. **Apply Early Validation**: Validate as early as possible
5. **Create Automatic Fixes**: Implement fixes for common errors
6. **Provide Clear Feedback**: Generate user-friendly validation reports
7. **Implement Progressive Validation**: Apply validation in stages
8. **Create Recovery Mechanisms**: Implement recovery for validation failures
9. **Establish Validation Process**: Define clear validation process
10. **Monitor Validation Effectiveness**: Track validation success rates

## Related Patterns

- [File Operation Boundaries](file-operation-boundaries.md): Establishing operation boundaries
- [Context Preservation Mechanisms](context-preservation-mechanisms.md): Preserving context across operations
- [Information Chunking Guide](information-chunking-guide.md): Organizing information into logical chunks
- [Hierarchical Relationship Guide](hierarchical-relationship-guide.md): Establishing parent-child relationships 