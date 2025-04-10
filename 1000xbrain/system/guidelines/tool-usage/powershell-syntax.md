# PowerShell Command Syntax Guideline

## CRITICAL: Command Chaining Rules

-   The cognitive architecture operates in a Windows environment using PowerShell as the default shell.
-   **MANDATORY RULE**: 1000xdev MUST use semicolon (`;`) for command chaining in all PowerShell contexts, NEVER double ampersand (`&&`).

### Command Chaining Examples

✅ **CORRECT PowerShell Syntax**:
```powershell
cd 1000xscripts; .\list.ps1
Get-ChildItem; Select-Object Name
mkdir new-dir; cd new-dir; New-Item test.txt
```

❌ **INCORRECT Command Prompt Syntax** (NEVER USE IN POWERSHELL):
```cmd
cd 1000xscripts && .\list.ps1
Get-ChildItem && Select-Object Name
mkdir new-dir && cd new-dir && New-Item test.txt
```

### PowerShell 7 Operators (NOT AVAILABLE BY DEFAULT)

-   While PowerShell 7 supports `&&` and `||` operators, the default Windows PowerShell is version 5.1.
-   ALWAYS assume PowerShell 5.1 environment and use semicolons (`;`) unless explicitly instructed otherwise.

### Error Handling Alternatives

-   For conditional execution based on success/failure, use proper PowerShell constructs:
```powershell
# Run second command only if first succeeds
$ErrorActionPreference = "Stop"; try { command1; command2 } catch { Write-Host "Command1 failed" }

# Or using $? to check success
command1; if ($?) { command2 }
```

### HIGH PRIORITY REMINDER

-   This is a persistent error pattern in command syntax usage.
-   ALWAYS DOUBLE-CHECK terminal commands before execution to ensure proper PowerShell syntax.
-   Command Prompt/Bash-style `&&` chaining is NOT compatible with standard PowerShell. 