# USE WHEN running PowerShell commands in Windows environments

# PowerShell Command Patterns

## Overview

This document provides essential patterns for PowerShell commands in Windows environments. These patterns ensure correct syntax and command chaining for PowerShell, which differs significantly from Bash/Unix shell commands.

## ⚠️ CRITICAL: Command Chaining Syntax ⚠️

### PowerShell vs Bash Command Chaining

| Operation | PowerShell Syntax | Bash/Unix Syntax (NEVER USE IN POWERSHELL) |
|-----------|------------------|-------------------------------------------|
| Command Chaining | `command1; command2` | ~~`command1 && command2`~~ |
| Directory Navigation and Command | `cd directory; command` | ~~`cd directory && command`~~ |
| Conditional Execution | `if ($?) { command2 }` | ~~`command1 && command2`~~ |

### Critical Rules for PowerShell Commands

1. **ALWAYS use semicolon (`;`) for command chaining in PowerShell, NEVER use double ampersand (`&&`)**
2. **CORRECT: `cd directory; command`**
3. **INCORRECT: `cd directory && command`** - This will cause syntax errors in PowerShell

The `&&` operator is a bash/shell operator that doesn't work in PowerShell. Using `&&` will always result in syntax errors in PowerShell environments, which is the default environment on Windows systems.

## PowerShell Command Chaining Pattern

### Pattern Structure

```
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│               PowerShell Command Chaining Pattern            │
│                                                             │
│  ┌───────────┐     ┌───────────┐     ┌───────────┐          │
│  │           │     │           │     │           │          │
│  │ Command 1 │────▶│ Semicolon │────▶│ Command 2 │          │
│  │           │     │     ;     │     │           │          │
│  └───────────┘     └───────────┘     └───────────┘          │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Implementation Guide

1. **Use semicolon (`;`) for simple command chaining**:
   ```powershell
   command1; command2; command3
   ```

2. **Directory navigation followed by command**:
   ```powershell
   cd directory; command
   ```

3. **For conditional execution, use PowerShell syntax**:
   ```powershell
   # Using IF statement
   if (Test-Path file.txt) { command }
   
   # Using &&-equivalent in PowerShell
   command1; if ($?) { command2 }
   ```

### Common Examples

```powershell
# Changing directory and running a command
cd C:\Project; .\script.ps1

# Running multiple commands in sequence
Get-ChildItem; Write-Host "Directory listing complete"

# Command with error checking
Test-Path file.txt; if ($?) { Write-Host "File exists" }
```

## PowerShell Directory Navigation Pattern

### Pattern Structure

```
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│            PowerShell Directory Navigation Pattern           │
│                                                             │
│  ┌───────────┐     ┌───────────┐     ┌───────────┐          │
│  │           │     │           │     │           │          │
│  │ Change    │────▶│ Semicolon │────▶│ Execute   │          │
│  │ Directory │     │     ;     │     │ Command   │          │
│  └───────────┘     └───────────┘     └───────────┘          │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Implementation Guide

1. **Navigate to directory and execute command**:
   ```powershell
   cd path\to\directory; .\script.ps1
   ```

2. **Navigate to directory and list contents**:
   ```powershell
   cd path\to\directory; Get-ChildItem
   ```

3. **Navigate to parent directory and run command**:
   ```powershell
   cd ..; .\script.ps1
   ```

### Practical Examples

In AI tool calls, always use the semicolon separator:

```typescript
// CORRECT PowerShell command chaining
run_terminal_cmd("cd 1000xscripts; .\Update-Cheatsheets.ps1", false, 
                "Navigate to scripts directory and run the cheatsheet update script")

// INCORRECT - Will cause PowerShell syntax error
// run_terminal_cmd("cd 1000xscripts && .\Update-Cheatsheets.ps1", false, 
//                "Navigate to scripts directory and run the cheatsheet update script")
```

## Checking PowerShell Execution Status

Unlike bash where `&&` serves for both chaining and conditional execution, PowerShell separates these concepts:

```powershell
# To check if previous command succeeded
command1; if ($LASTEXITCODE -eq 0) { command2 }

# For cmdlets that don't set exit code
command1; if ($?) { command2 }
```

## Related Patterns
- [Command Verification Pattern](#pattern-command-verification-pattern)
- [Command Sequence Pattern](#pattern-command-sequence) 