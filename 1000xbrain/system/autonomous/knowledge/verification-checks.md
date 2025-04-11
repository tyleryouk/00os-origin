# Knowledge: Autonomous Verification Checks

## Standard Verification Checks

### File Existence Checks

* **Created Files**: Check all files reported as created exist.
* **Modified Files**: Verify all modified files exist and maintain expected structure.
* **Deleted Files**: Confirm files marked for deletion no longer exist.
* **Directory Structure**: Verify directory organization matches expected patterns.

### Content Verification

* **Markdown Structure**: For .md files, verify:
  * Presence of header sections
  * Consistent heading hierarchy
  * Proper list formatting
  * Balanced code blocks

* **Command File Structure**: For command files, check:
  * Clear descriptive title
  * Dynamic execution section (when appropriate)
  * Proper tool call patterns
  * Next step guidance
  
* **Process File Structure**: For process files, verify:
  * Goal statement
  * Clearly defined steps with numbering
  * Error handling sections
  * Complete structure within size limit (250 lines)

* **Knowledge File Structure**: For knowledge files, verify:
  * Appropriate section organization
  * Comprehensive content
  * Consistent terminology

### Reference Validation

* **File Path References**: Check references to other files point to existing targets.
* **Command References**: Verify command invocation syntax is correct and consistent.
* **Knowledge References**: Ensure knowledge files referenced by processes exist.
* **Cross-References**: Validate proper linking between related files.

### System Integration

* **Operational Feedback Structure**: Verify proper structure of cycle logs and state tracking.
* **Command Chaining**: Check next step references are correct and consistent.
* **Process-Knowledge Alignment**: Verify knowledge files properly inform their linked processes.

## Implementation Guidance

The verification process should implement these checks progressively:
1. First, verify basic file existence
2. Then check structural consistency
3. Followed by content validation
4. Finally, validate cross-file references and system integration

Issue severity should be categorized as:
* **Critical**: Prevents system operation
* **Major**: Affects functionality but doesn't prevent operation
* **Minor**: Cosmetic or non-functional issues