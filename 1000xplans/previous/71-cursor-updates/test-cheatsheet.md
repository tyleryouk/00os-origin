# Test Cheatsheet: Plan-Mode System Enhancement

## 1. File Size Verification Tests

### Test Case 1: File Size Compliance
```typescript
// Check all plan-mode related files
1. Verify plan-mode-core.md ≤ 250 lines
2. Verify plan-mode-knowledge.md ≤ 250 lines
3. Verify plan-mode-documentation.md ≤ 250 lines
4. Verify plan-mode-transitions.md ≤ 250 lines
```

### Test Case 2: Functionality Preservation
```typescript
// Test each split file maintains required functionality
1. Test core plan-mode operations
2. Test knowledge access patterns
3. Test documentation standards
4. Test mode transitions
```

## 2. Planning Intelligence Tests

### Test Case 1: Complexity Assessment
```typescript
// Test with varying complexity levels
1. Simple feature (single subsystem)
2. Medium feature (2-3 subsystems)
3. Complex feature (4+ subsystems)
4. System-wide enhancement
```

### Test Case 2: Folder Splitting
```typescript
// Verify appropriate folder structure creation
1. Test single folder for simple features
2. Test core + subsystem folders for medium features
3. Test multiple subsystem folders for complex features
```

### Test Case 3: Cross-References
```typescript
// Test cross-folder reference system
1. Verify reference format: ref: ../path/to/file.md#section
2. Test reference resolution across folders
3. Verify documentation linking
```

## 3. System Integration Tests

### Test Case 1: Mode Transitions
```typescript
// Test transitions with split folders
1. Verify plan-mode to dev-mode transition
2. Test context preservation across folders
3. Verify completion signaling
```

### Test Case 2: Documentation Coherence
```typescript
// Test documentation structure
1. Verify README clarity
2. Test cross-folder navigation
3. Check reference accuracy
```

### Test Case 3: Knowledge Access
```typescript
// Test knowledge system integration
1. Verify fetch_rules across folders
2. Test knowledge sharing between folders
3. Validate pattern application
```

## 4. Context Management Tests

### Test Case 1: Context Window Management
```typescript
// Test context window handling
1. Verify context window monitoring
2. Test conversation summarization
3. Check context preservation
4. Validate cross-folder context
```

### Test Case 2: @ Symbol Integration
```typescript
// Test @ symbol functionality
1. Verify @ symbol suggestions
2. Test context inclusion patterns
3. Check cross-reference resolution
```

### Test Case 3: Model Selection
```typescript
// Test model integration
1. Verify model preselection
2. Test conversation length handling
3. Check context-aware model switching
```

## 5. Mode System Tests

### Test Case 1: Agent Mode
```typescript
// Test agent mode configuration
1. Verify available tools setup
2. Test auto-run functionality
3. Check error auto-fix
4. Validate tool workflows
```

### Test Case 2: Custom Modes UI
```typescript
// Test custom mode creation interface
1. Verify "Enter a name" field functionality
2. Test "Model" dropdown selection
3. Check "Keybinding" configuration ("Set keys" button)
4. Validate tool category structure:
   - Search: Codebase, Web, Grep, List directory, Search files, Read file, Fetch rules
   - Edit: Edit & Reapply, Delete file
   - Run: Terminal
   - MCP Servers
5. Test toggle options:
   - Auto-apply edits
   - Auto-run
   - Auto-fix errors
6. Verify "Add custom instructions" button
```

### Test Case 3: Custom Mode Functionality
```typescript
// Test custom mode operation
1. Verify tool selection persistence
2. Test mode-specific settings application
3. Check custom instructions application
4. Validate toggle state preservation
```

### Test Case 4: Tool Integration
```typescript
// Test tool category functionality
1. Verify Search tools operation
2. Test Edit tools functionality
3. Check Run commands operation
4. Validate tool toggling
```

### Test Case 5: Custom Mode Integration
```typescript
// Test custom mode with existing system
1. Verify integration with planning intelligence
2. Test compatibility with split folders
3. Check custom instructions effectiveness 
4. Validate tool selection constraints
```

## Success Verification Checklist

### File Size Compliance
- [ ] All files ≤ 250 lines
- [ ] No functionality loss
- [ ] Clear organization

### Planning Intelligence
- [ ] Accurate complexity detection
- [ ] Appropriate folder splitting
- [ ] Working cross-references

### System Integration
- [ ] Seamless mode transitions
- [ ] Clear documentation
- [ ] Efficient knowledge access

### Context Management
- [ ] Context window monitoring
- [ ] @ symbol handling
- [ ] Model selection
- [ ] Conversation management

### Mode System Integration
- [ ] Agent mode configuration
- [ ] Custom mode UI functionality
- [ ] Tool category structure
- [ ] Toggle options functionality
- [ ] Custom instructions integration
- [ ] Model selection
- [ ] Keybinding configuration

## Test Scenarios

### Scenario 1: Simple Feature
1. Create basic feature requirements
2. Verify single folder creation
3. Check file size compliance
4. Test mode transitions

### Scenario 2: Complex Feature
1. Create complex requirements
2. Verify folder splitting
3. Test cross-folder references
4. Validate knowledge access

### Scenario 3: System-Wide Enhancement
1. Create system-wide requirements
2. Test multi-folder organization
3. Verify cross-system documentation
4. Check integration points

### Scenario 4: Context Management
1. Create long-running planning session
2. Test context window management
3. Verify @ symbol integration
4. Check model selection
5. Validate conversation handling

### Scenario 5: Mode System Workflow
1. Configure agent mode settings
2. Create custom mode with specific tools
3. Configure auto-toggle options
4. Set custom instructions
5. Test mode with specific tool combinations 