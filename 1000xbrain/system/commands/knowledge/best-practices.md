# Command Best Practices

## Overview

This document outlines best practices for creating effective, maintainable, and reliable `1000xcommands`.

## Core Principles

1.  **Delegate Logic to `1000xbrain`**: 
    *   Complex logic, conditional execution, extensive context analysis, and interaction sequences belong in `1000xbrain` process files (`processes/`).
    *   Commands (`1000xcommands`) should primarily act as triggers, defining the target process and necessary context (knowledge files, parameters, context files) via the Dynamic Execution block.
    *   **Anti-Pattern**: Embedding complex scripts or long sequences of explicit tool calls directly within the command `.md` file.

2.  **Clear Purpose and Scope**: 
    *   Each command should have a single, well-defined purpose.
    *   Avoid creating overly broad commands that try to do too many unrelated things.
    *   Use descriptive names following the `verb-noun` convention (e.g., `create-rule`, `verify-command-syntax`).

3.  **Leverage Dynamic Execution**: 
    *   Use the `# --- BEGIN DYNAMIC EXECUTION ---` block for any command involving more than a few simple, sequential tool calls.
    *   Specify the guiding `Process:` file clearly.
    *   Include relevant `Knowledge:` files to provide necessary domain context to the process.
    *   Use `Parameter:` for simple, static configuration values.
    *   Use `ContextFile:` to pass relevant file contents directly to the process.

4.  **Gather Sufficient Context (Explicitly)**: 
    *   If a command uses explicit tool calls *before* dynamic execution, ensure these calls gather all necessary context (e.g., reading relevant plan files, existing code, related knowledge) required by the subsequent process.
    *   The process file should be able to assume the necessary context has been pre-loaded.

5.  **Adhere to Directory Structure**: 
    *   Place commands in the correct domain (`system`, `frontend`, `backend`) and component subdirectory within `1000xcommands/`.
    *   Reference `1000xbrain` files using correct, full paths relative to the workspace root.
    *   See `1000xbrain/system/commands/knowledge/directory-organization.md`.

6.  **Use Guidelines**: 
    *   Consult and apply relevant standards from `1000xbrain/system/guidelines/` (e.g., for tool usage, coding standards if the command generates code via a process).

7.  **Idempotency (Where Possible)**: 
    *   Design commands and their underlying processes to be idempotent if feasible. Running the command multiple times should ideally produce the same end state without unintended side effects.
    *   Example: A `create-file` command might first check if the file exists.

8.  **Verification**: 
    *   Include verification steps within the command's process or have dedicated verification commands (`verify-<artifact>`).
    *   Ensure commands reliably achieve their stated purpose.

## Example (Good Practice)

**`1000xcommands/system/rules/create-rule.md`**
```markdown
# Command: Create Core Rule

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/system/rules/processes/create-rule-process.md
# Knowledge: 1000xbrain/system/rules/knowledge/rules-architecture.md
# Knowledge: 1000xbrain/system/guidelines/file-structure/markdown-standards.md 
# Parameter: rule_name=new-core-safety-rule
# ContextFile: 1000xplans/system/requirements.md 
# --- END DYNAMIC EXECUTION --- 
```

*This command clearly delegates logic to a specific process, provides necessary knowledge context, a parameter, and relevant planning context.*

## Example (Anti-Pattern)

**`1000xcommands/system/rules/bad-create-rule.md`**
```markdown
# Command: Create Rule (Bad Example)

# Read plan
tool_code
print(default_api.read_file(target_file="1000xplans/system/plan.md"))

# Check if rule exists (complex logic embedded)
tool_code
print(f"Checking for rule file path = 1000xrules/core/{rule_name}.md") # Logic should be in process
# ... more embedded checks ...

# Create the file with basic template
tool_code
print(default_api.edit_file(target_file=f"1000xrules/core/{rule_name}.md", instructions="Create basic rule file", code_edit="# New Rule\n\n## Overview\n"))

# Add to index (manual, brittle)
tool_code
print(default_api.edit_file(target_file="1000xplans/system/rules-index.md", instructions="Append rule", code_edit="// ... existing code ...\n- `1000xrules/core/{rule_name}.md`"))

# ... maybe more steps ...
```

*This command embeds logic, performs brittle manual updates, and doesn't use a guiding process, making it hard to maintain and prone to errors.* 