# Implementation Plan: Project-Rule-Parameters Enhancement

## Target Files
1. `1000xbrain/parameters/rules/template-hallucination.md` → Rename to `template-past-chat-hallucination.md`
2. `1000xbrain/parameters/rules/template-standard-hallucination.md` (new file)

## Implementation Phases

### Phase 1: Rename Existing Template
- Rename `template-hallucination.md` to `template-past-chat-hallucination.md`
- Update any references to the old filename
- Verify the template content accurately reflects its purpose for past-chat hallucinations

### Phase 2: Create Standard Hallucination Template
- Create new file `template-standard-hallucination.md`
- Implement flexible structure for handling standard hallucinations
- Ensure consistent formatting with other templates
- Add clear usage instructions and examples

### Phase 3: Integration Verification
- Verify both templates can be properly referenced in message-commands
- Test template usage in both plan-mode and dev-mode contexts
- Ensure proper integration with the rules workflow system

## Integration Testing
1. Test message-command references:
   ```
   plan-mode: rules-workflow @template-past-chat-hallucination.mdc
   plan-mode: rules-workflow @template-standard-hallucination.mdc
   ```

2. Verify mode compatibility:
   - Test in plan-mode context
   - Test in dev-mode context
   - Verify proper mode transitions with both templates

## Verification Approach
1. **File Structure**:
   - Confirm both templates exist in correct location
   - Verify proper naming convention
   - Check file content formatting

2. **Integration**:
   - Test message-command recognition
   - Verify mode system compatibility
   - Check rules workflow integration

3. **Functionality**:
   - Test past-chat hallucination handling
   - Test standard hallucination handling
   - Verify distinct use cases are properly addressed 