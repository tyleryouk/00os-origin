# workflow: rules-workflow | pathway: front-end-steam-web-api | message-command: dev-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/rules/dev-mode/front-end-steam-web-api.md

## Parameter Purpose

This parameter provides specialized guidance for enhancing and maintaining the Steam Web API integration in front-end components while in Developer Mode. It focuses on best practices, implementation patterns, and quality standards for integrating Steam functionality into the GigaSwap marketplace.

## Usage Context

Use this parameter when implementing or modifying rules related to front-end Steam Web API integration, including:

- Authentication components and flows
- Inventory display and management
- Market data visualization
- Trading interface components
- Error handling and security patterns

## Implementation Guidelines

### Rule Enhancement Implementation

1. Begin by analyzing current front-end implementations and identifying enhancement opportunities:

```typescript
// Analyze current implementation
read_file("front-end/src/components/steam/SteamLoginButton.tsx", should_read_entire_file=true)

// Check existing patterns
grep_search("Steam.*Authentication", false, "front-end/src/**/*.tsx")

// Identify improvement opportunities
codebase_search("Steam API integration patterns", ["front-end/src"])
```

2. Create or enhance rules documentation following established patterns:

```typescript
// Create or update authentication patterns
edit_file("1000xbrain/knowledge/rules/front-end-steam-web-api/authentication-patterns.md",
          "Enhance authentication patterns documentation",
          "# USE WHEN implementing authentication patterns for Steam API integration\n\n## Overview\n\nThis file documents best practices and patterns for implementing Steam authentication in front-end components...\n\n// ... implementation details ...")

// Create or update inventory patterns
edit_file("1000xbrain/knowledge/rules/front-end-steam-web-api/inventory-patterns.md",
          "Create inventory display patterns documentation",
          "# USE WHEN implementing inventory display patterns for Steam API integration\n\n## Overview\n\nThis file documents best practices and patterns for displaying Steam inventory items...\n\n// ... implementation details ...")
```

3. Implement cross-references between knowledge components:

```typescript
// Add cross-references between components
edit_file("1000xbrain/knowledge/rules/front-end-steam-web-api/best-practices.md",
          "Update cross-references in best practices",
          "// ... existing content ...\n\n## Cross-References\n\n- **Authentication Patterns**: `knowledge/rules/front-end-steam-web-api/authentication-patterns.md`\n- **Inventory Patterns**: `knowledge/rules/front-end-steam-web-api/inventory-patterns.md`\n- **Market Data Patterns**: `knowledge/rules/front-end-steam-web-api/market-patterns.md`\n\n// ... existing content ...")
```

### Quality Standards Implementation

Ensure all rule documentation adheres to these quality standards:

1. **Documentation Standards**:
   - Clear, concise language
   - Proper markdown formatting
   - Consistent terminology
   - Comprehensive code examples

2. **Content Requirements**:
   - Problem statement and solution
   - Implementation guidelines
   - Error handling considerations
   - Security best practices
   - Performance optimization tips

3. **Code Examples**:
   - TypeScript with proper types
   - React best practices
   - Error handling patterns
   - Consistent logging
   - Performance optimization

### Pattern Development Guidelines

When developing new patterns for Steam Web API integration:

1. **Pattern Research**:
   - Explore existing patterns in the codebase
   - Research industry best practices
   - Consider front-end framework specifics
   - Analyze performance implications

```typescript
// Research existing patterns
codebase_search("authentication pattern", ["front-end/src", "1000xbrain/knowledge"])

// Examine related files
read_file("1000xbrain/knowledge/front-end/steam-web-api/authentication.md", should_read_entire_file=true)
```

2. **Pattern Documentation**:
   - Document pattern purpose and context
   - Provide implementation examples
   - Include error handling strategies
   - Document known limitations
   - Add cross-references to related patterns

```typescript
// Create new pattern documentation
edit_file("1000xbrain/knowledge/rules/front-end-steam-web-api/real-time-updates.md",
          "Create real-time updates pattern documentation",
          "# USE WHEN implementing real-time updates for Steam market data\n\n## Overview\n\nThis pattern provides guidance for implementing real-time updates for Steam market data using WebSockets and fallback polling...\n\n// ... implementation details ...")
```

### Knowledge Access Pattern

Use the fetch_rules tool to access specialized knowledge for Steam Web API integration:

```typescript
fetch_rules(["knowledge/rules/front-end-steam-web-api/best-practices"], 
           "Understanding best practices for Steam API integration")

fetch_rules(["knowledge/rules/front-end-steam-web-api/authentication-patterns"], 
           "Understanding Steam authentication patterns")

fetch_rules(["knowledge/rules/front-end-steam-web-api/inventory-patterns"], 
           "Understanding Steam inventory integration patterns")

fetch_rules(["knowledge/rules/front-end-steam-web-api/market-patterns"], 
           "Understanding Steam market data patterns")
```

## Verification Guidelines

Before committing rule enhancements, verify:

1. **Documentation Quality**:
   - No typos or grammatical errors
   - Proper markdown formatting
   - Consistent terminology
   - Complete cross-references

2. **Pattern Consistency**:
   - Alignment with existing patterns
   - Consistent with front-end architecture
   - Proper error handling
   - Security considerations addressed

3. **Knowledge Accessibility**:
   - Properly organized in correct directories
   - Accessible via fetch_rules
   - Clear USE WHEN header
   - Comprehensive overview section

## Cross-References

- **Front-End Authentication**: `knowledge/front-end/steam-web-api/authentication.md`
- **Front-End Inventory**: `knowledge/front-end/steam-web-api/inventory.md`
- **Front-End Best Practices**: `knowledge/rules/front-end-steam-web-api/best-practices.md`
- **Back-End Authentication**: `knowledge/back-end/steam-web-api/authentication.md` 