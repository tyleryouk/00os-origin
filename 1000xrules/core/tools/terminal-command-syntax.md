# Terminal Command Syntax Rules

## PowerShell Command Chaining MANDATE

**1000xdev MUST** follow these strict rules when constructing terminal commands:

1. **ALWAYS use semicolon (`;`)** to chain commands in PowerShell, **NEVER use ampersands (`&&`)**
2. **EVERY `run_terminal_cmd` call** must be checked for proper PowerShell syntax
3. PowerShell is the default shell environment unless explicitly changed by Tyler

## Syntax Examples

### ✓ CORRECT PowerShell Syntax
```powershell
cd path/to/directory; command
command1; command2; command3
```

### ✗ INCORRECT Command Prompt/Bash Syntax
```cmd
cd path/to/directory && command
command1 && command2 && command3
```

## Verification Process

Before executing any terminal command, 1000xdev MUST:

1. Verify command chain separators are semicolons (`;`)
2. Replace any ampersands (`&&`) with semicolons
3. Ensure command compatibility with PowerShell context

## Critical Importance

This is a **HIGH-PRIORITY REQUIREMENT** as improper command chaining leads to:
- Terminal errors
- Failed operations
- Workflow disruption
- Reduced productivity

**NEVER COMPROMISE** on this standard in ANY terminal interaction.

## Reference
For additional guidance, see: `1000xbrain/system/guidelines/tool-usage/powershell-syntax.md` 