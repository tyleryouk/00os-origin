# mode: dev-mode | workflow: rules-workflow | pathway: enhance-documentation-perspective | filepath: @parameters/rules/dev-mode/enhance-documentation-perspective.mdc | optional-standard-parameter(s): none

## Implementation Guidance: Enhancing Documentation Perspective

This pathway focuses on implementing the planned conversion of 1000xbrain documentation files to a consistent first-person perspective, based on the finalized planning documents.

### 1. Planning Review
- Thoroughly read and understand the `requirements.md`, `implementation.md`, and `context.md` files from the corresponding planning folder (e.g., `planning/XX-rules-workflow-enhance-documentation-perspective/`).
- Internalize the defined first-person standards, templates, and conversion strategy.

### 2. Implementation Process
- Follow the prioritized file conversion sequence outlined in `implementation.md`.
- **Tool Usage:**
    - Use `read_file` (with `should_read_entire_file=true`) to read each target file completely.
    - Use `edit_file` to apply the perspective changes according to the defined standards and replacements.
    - Apply changes incrementally if files are large, verifying each section.
- Adhere strictly to the defined first-person standards and guidelines.
- Use the created templates when applicable.

### 3. Verification during Implementation
- After editing each file, reread sections or the entire file using `read_file` to confirm:
    - Perspective conversion is complete and consistent.
    - No unintended content changes were made.
    - Markdown formatting remains correct.
- Check against the verification checklist from `implementation.md`.

### 4. Handling Exceptions
- Refer to `implementation.md` for guidance on handling documented exceptions where first-person perspective is not applied.
- If new potential exceptions are found, document them and request clarification if necessary (though autonomous decisions are preferred).

### 5. Completion Signal
- Once all targeted files are converted and verified according to the plan:
    - Signal completion using `implementation-complete`.
    - List the key files/sections converted.
    - Confirm adherence to the plan. 