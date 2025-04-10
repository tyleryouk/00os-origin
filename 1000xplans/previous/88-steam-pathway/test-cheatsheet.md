# Test Cheatsheet: Steam Web API Integration

This document provides testing scenarios and verification methods for the Steam Web API integration across different components of the cognitive architecture.

## Knowledge Component Testing

### 1. Knowledge Access Testing

| Test Scenario | Expected Result | Verification Method |
|---------------|-----------------|---------------------|
| Access front-end knowledge | Knowledge components retrieved successfully | Use fetch_rules tool with front-end steam-web-api path |
| Access back-end knowledge | Knowledge components retrieved successfully | Use fetch_rules tool with back-end steam-web-api path |
| Access cross-referenced knowledge | All related knowledge components accessible | Follow cross-references from primary knowledge components |

Test with:
```typescript
// Test front-end knowledge access
fetch_rules(["knowledge/front-end/steam-web-api/authentication"], 
           "Testing access to Steam authentication knowledge")

// Test back-end knowledge access
fetch_rules(["knowledge/back-end/steam-web-api/api-endpoints"], 
           "Testing access to Steam API endpoints knowledge")

// Test cross-referenced knowledge
fetch_rules([
  "knowledge/front-end/steam-web-api/authentication",
  "knowledge/back-end/steam-web-api/authentication"
], "Testing cross-referenced knowledge access")
```

### 2. Knowledge Content Testing

| Test Scenario | Expected Result | Verification Method |
|---------------|-----------------|---------------------|
| Verify knowledge headers | All headers follow the USE WHEN format | Check header format in each knowledge file |
| Verify content structure | All knowledge files follow standard structure | Check for required sections in each file |
| Verify cross-references | All referenced files exist and are accurate | Follow all cross-references and verify targets |

## Parameter File Testing

### 1. Parameter Accessibility Testing

| Test Scenario | Expected Result | Verification Method |
|---------------|-----------------|---------------------|
| Access front-end parameters | Parameters correctly referenced in message-commands | Test message-commands with steam-web-api parameters |
| Access back-end parameters | Parameters correctly referenced in message-commands | Test message-commands with steam-web-api parameters |
| Test across all modes | Parameters work in plan-mode, dev-mode, and direct-mode | Test message-commands in each mode |

Test with message-commands:
```
plan-mode: front-end-workflow @parameters/front-end/plan-mode/steam-web-api.mdc
dev-mode: front-end-workflow @parameters/front-end/dev-mode/steam-web-api.mdc
direct-mode: front-end-workflow @parameters/front-end/direct-mode/steam-web-api.mdc

plan-mode: back-end-workflow @parameters/back-end/plan-mode/steam-web-api.mdc
dev-mode: back-end-workflow @parameters/back-end/dev-mode/steam-web-api.mdc
direct-mode: back-end-workflow @parameters/back-end/direct-mode/steam-web-api.mdc
```

### 2. Parameter Content Testing

| Test Scenario | Expected Result | Verification Method |
|---------------|-----------------|---------------------|
| Verify parameter headers | All headers follow the standard format | Check header format in each parameter file |
| Verify parameter structure | All parameter files follow standard structure | Check for required sections in each file |
| Verify knowledge references | All knowledge references are valid | Check fetch_rules calls in parameter files |

## Workflow Component Testing

### 1. Auto-Attachment Testing

| Test Scenario | Expected Result | Verification Method |
|---------------|-----------------|---------------------|
| Front-end workflow auto-attachment | Workflow auto-attaches for Steam-related files | Test with sample Steam-related front-end files |
| Back-end workflow auto-attachment | Workflow auto-attaches for Steam-related files | Test with sample Steam-related back-end files |
| Multiple workflow integration | No conflicts between different workflows | Test files that should trigger multiple workflows |

### 2. Workflow Content Testing

| Test Scenario | Expected Result | Verification Method |
|---------------|-----------------|---------------------|
| Verify workflow structure | All workflow files follow standard structure | Check for required sections in each file |
| Verify file patterns | File patterns correctly identify Steam-related files | Test with various file types and names |
| Verify parameter references | All parameter references use correct syntax | Check parameter references in workflow files |

## Cross-System Testing

### 1. Terminology Consistency

| Test Scenario | Expected Result | Verification Method |
|---------------|-----------------|---------------------|
| Check key terms across files | Terminology used consistently in all files | Search for key terms across all files |
| Check abbreviations and acronyms | Abbreviations consistently defined | Verify abbreviation usage across files |
| Check parameter naming | Parameter naming follows consistent patterns | Compare parameter names across workflows |

### 2. Pattern Implementation Testing

| Test Scenario | Expected Result | Verification Method |
|---------------|-----------------|---------------------|
| Authentication pattern | Pattern implemented consistently | Test authentication flow across front-end and back-end |
| Inventory access pattern | Pattern implemented consistently | Test inventory access across front-end and back-end |
| Market data pattern | Pattern implemented consistently | Test market data access across front-end and back-end |
| Trading flow pattern | Pattern implemented consistently | Test trading functionality across front-end and back-end |

### 3. Mode-Specific Behavior Testing

| Test Scenario | Expected Result | Verification Method |
|---------------|-----------------|---------------------|
| Plan-mode behavior | Plan-mode specific behavior applied correctly | Test planning actions with Steam-related files |
| Dev-mode behavior | Dev-mode specific behavior applied correctly | Test development actions with Steam-related files |
| Direct-mode behavior | Direct-mode specific behavior applied correctly | Test direct implementation with Steam-related files |
| Mode transitions | Transitions between modes work correctly | Test mode transitions with Steam-related tasks |

## Integration Testing Scenarios

### 1. Front-End Integration Testing

| Test Scenario | Description | Verification Steps |
|---------------|-------------|-------------------|
| Steam login implementation | Test Steam OpenID authentication flow | 1. Implement login component<br>2. Connect to back-end auth endpoint<br>3. Verify token handling |
| Inventory display | Test inventory retrieval and display | 1. Implement inventory component<br>2. Connect to inventory API<br>3. Test data rendering |
| Market price display | Test price history visualization | 1. Implement price display component<br>2. Connect to market data API<br>3. Test chart rendering |
| Trade offer creation | Test trade interface | 1. Implement trade UI<br>2. Connect to trade API<br>3. Test offer submission |

### 2. Back-End Integration Testing

| Test Scenario | Description | Verification Steps |
|---------------|-------------|-------------------|
| Authentication endpoint | Test Steam authentication handling | 1. Implement auth endpoint<br>2. Test token verification<br>3. Verify session creation |
| Inventory caching | Test inventory data caching | 1. Implement inventory endpoints<br>2. Test caching mechanism<br>3. Verify cache invalidation |
| Market data aggregation | Test price data handling | 1. Implement market data endpoints<br>2. Test data aggregation<br>3. Verify historical data storage |
| Trade processing | Test trade offer handling | 1. Implement trade endpoints<br>2. Test security verification<br>3. Verify trade completion |

### 3. Rules Enhancement Testing

| Test Scenario | Description | Verification Steps |
|---------------|-------------|-------------------|
| Steam-specific message-commands | Test custom message-commands | 1. Test steam-related commands<br>2. Verify correct parameter loading<br>3. Check behavior customization |
| Knowledge access patterns | Test Steam-specific knowledge access | 1. Test knowledge fetch patterns<br>2. Verify cross-references<br>3. Check content retrieval |
| Mode-specific behavior customization | Test behavior differences by mode | 1. Test in plan-mode<br>2. Test in dev-mode<br>3. Test in direct-mode<br>4. Compare behaviors |

## Verification Checklist

### Structure Verification

- [ ] All required knowledge files created
- [ ] All required parameter files created
- [ ] All required workflow files created
- [ ] Directory structure follows standards
- [ ] File naming follows conventions
- [ ] Headers properly formatted in all files

### Content Verification

- [ ] Knowledge content comprehensive and accurate
- [ ] Parameter behavior properly defined
- [ ] Workflow behavior specialized for Steam operations
- [ ] Cross-references properly implemented
- [ ] Terminology used consistently
- [ ] Patterns implemented consistently

### Functional Verification

- [ ] Knowledge accessible via fetch_rules
- [ ] Parameters accessible via message-commands
- [ ] Workflows auto-attach correctly
- [ ] Mode-specific behavior works properly
- [ ] Cross-system integration functions correctly
- [ ] Error handling implemented consistently

## Testing Tools

1. **fetch_rules Testing**: Use fetch_rules to test knowledge accessibility
2. **Message-Command Testing**: Test parameter files with relevant message-commands
3. **File Pattern Testing**: Create sample files to test auto-attachment
4. **Cross-Reference Validation**: Check all cross-references to ensure they resolve correctly
5. **Terminology Search**: Search across all files for key terms to verify consistency 