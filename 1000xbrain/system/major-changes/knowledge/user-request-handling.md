# User Request Handling in Major Changes Workflow

## Purpose

This knowledge component defines the standardized approach for creating, reading, processing, and preserving the user request template for the major-changes workflow. The approach uses a dedicated section in `1000xplans/system/notes.md` as the interface for users to submit change requests.

## Workflow Overview

The user request handling follows this sequence:

1. **Command 1 (Initiate Cycle)**:
   - Creates/updates the notes.md file with the USER REQUEST SECTION template
   - Sets up the operational feedback structure
   - Instructs the user to fill out the template and run command 2

2. **User Action**:
   - User fills out the USER REQUEST SECTION with their change request details

3. **Command 2 (Assess Request)**:
   - Reads the user-filled request from notes.md
   - Validates the request has substantive content
   - Processes the request and documents it in operational feedback
   - Preserves the notes.md structure while resetting the template

## User Request Section Format

The USER REQUEST SECTION in `1000xplans/system/notes.md` follows this structure:

```markdown
## USER REQUEST SECTION
<!-- 
INSTRUCTIONS FOR TYLER:
Fill out this section with your explicit change request before running the major-changes workflow.
The workflow will read ONLY this section when processing your request.
After processing, this section will be cleared automatically for the next request.

FORMAT:
1. Provide a clear description of the change you want implemented
2. List any specific requirements or constraints
3. Indicate priority and timeline if applicable
4. Add any other relevant information
-->

# Change Request
[Your change request description goes here]

# Requirements
[List specific requirements here]

# Priority
[Indicate priority level and/or timeline]

# Additional Notes
[Any other information relevant to this request]

## END USER REQUEST SECTION
```

## Creating the User Request Template

When initializing a new cycle (command 1), the workflow should:

1. Read the existing notes.md file
2. Preserve the Tyler Youk section (between `## Tyler Youk` and `## end`)
3. Create or update the file with:
   - The preserved Tyler Youk section
   - A new USER REQUEST SECTION template
   - The 1000XDEV NOTES section

This provides a clear interface for the user to specify their change request.

## Reading User Requests

When assessing a change request (command 2), the workflow should:

1. Use `read_file` to read the entire `1000xplans/system/notes.md` file.
2. Extract the content between the markers `## USER REQUEST SECTION` and `## END USER REQUEST SECTION`.
3. Parse for specific sections:
   - `# Change Request` - The core description of the requested change
   - `# Requirements` - Specific requirements or constraints
   - `# Priority` - Priority level and/or timeline
   - `# Additional Notes` - Any supplementary information

4. Validation checks:
   - Check if any section contains only placeholder text (e.g., "[Your change request description goes here]")
   - Check if the Change Request section is substantive (not empty or placeholder)
   - Determine if enough information is provided to proceed

## Checking for Valid Requests

A request is considered valid if:

1. The Change Request section contains substantive content (not just the placeholder).
2. At least one of the other sections (Requirements, Priority, or Additional Notes) contains non-placeholder content.

If the request is invalid:
- Signal an error to the user
- Provide instructions for properly filling out the request section
- Do not proceed with the workflow until a valid request is provided

## Preserving the Template Structure

After processing a request, the workflow should:

1. Use `read_file` to read the current `1000xplans/system/notes.md`.
2. Extract and preserve the Tyler Youk section.
3. Extract and preserve the 1000XDEV NOTES section.
4. Use `edit_file` to update notes.md:
   - Restore the USER REQUEST SECTION template with placeholders
   - This prepares the file for the next request while maintaining the section structure

## Error Handling

### Empty or Placeholder Content

If the user request section contains only placeholder text or is substantively empty:

1. Signal an error with a clear message.
2. Provide instructions for filling out the request.
3. Do not proceed with assessment or implementation.

### Partial Information

If only partial information is provided (e.g., Change Request is filled but no Requirements):

1. Proceed if the Change Request section has substantive content.
2. Note in the logs that some sections were not provided.
3. Make reasonable assumptions based on the information available.

## Integration with Workflow

This request handling process is integrated at two key points in the major-changes workflow:

1. **Initiation Phase** (`1.md`):
   - Creates/updates the USER REQUEST SECTION template
   - Sets up the operational feedback structure
   - Instructs the user to fill out the template

2. **Assessment Phase** (`2.md`):
   - Validates that the user has filled out the request
   - Reads and parses the user request in detail
   - Documents the request in operational_feedback
   - Resets the template while preserving file structure
   - Analyzes technical implications of the request 