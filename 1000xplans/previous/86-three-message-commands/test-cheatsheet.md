# Test Cheatsheet: Three Message-Commands System

## Line Count Verification

Use these commands to verify total line count in the core directory:

```powershell
# Count lines in all .md files in core directory and subdirectories
# Current count: 2177 lines (target: <2200 lines)
(Get-ChildItem -Path "1000xbrain/core" -Filter "*.md" -Recurse | Get-Content | Measure-Object -Line).Lines

# Count lines by subdirectory
(Get-ChildItem -Path "1000xbrain/core/identity" -Filter "*.md" -Recurse | Get-Content | Measure-Object -Line).Lines
(Get-ChildItem -Path "1000xbrain/core/communication" -Filter "*.md" -Recurse | Get-Content | Measure-Object -Line).Lines
(Get-ChildItem -Path "1000xbrain/core/modes" -Filter "*.md" -Recurse | Get-Content | Measure-Object -Line).Lines

# Count lines in specific files
(Get-Content "1000xbrain/core/identity/global-rules.md" | Measure-Object -Line).Lines
```

## Knowledge Access Tests

Test fetch_rules tool on migrated knowledge components:

```typescript
// Test symbol guidelines access
fetch_rules(["knowledge/rules/patterns/communication/symbol-usage"], 
           "Testing access to migrated symbol usage patterns")

// Test syntax patterns access
fetch_rules(["knowledge/rules/patterns/communication/syntax-patterns"], 
           "Testing access to migrated syntax patterns")

// Test mode patterns access
fetch_rules(["knowledge/rules/patterns/modes/plan-mode-patterns"], 
           "Testing access to migrated plan mode patterns")

// Test transition patterns access
fetch_rules(["knowledge/rules/guides/mode-system/transitions"], 
           "Testing access to migrated mode transition guidance")
```

## Message-Command Testing

Test the three message-commands format:

```
# Test plan-mode message-command
plan-mode: rules-workflow

# Test dev-mode message-command
dev-mode: rules-workflow

# Test direct-mode message-command
direct-mode: rules-workflow
```

## Brain-Files Terminology Check

Use this command to verify consistent "brain-files" terminology:

```powershell
# Search for variations like "files", "documentation" instead of "brain-files"
Get-ChildItem -Path "1000xbrain/core" -Filter "*.md" -Recurse | Select-String -Pattern "files(?!.*brain)" -SimpleMatch
Get-ChildItem -Path "1000xbrain/core" -Filter "*.md" -Recurse | Select-String -Pattern "documentation" -SimpleMatch
```

## Workflow References Check

Use this command to verify references to only the four valid workflows:

```powershell
# Search for potential invalid workflow references
$validWorkflows = "rules-workflow|front-end-workflow|back-end-workflow|scripts-workflow"
Get-ChildItem -Path "1000xbrain/core" -Filter "*.md" -Recurse | Select-String -Pattern "\[.*workflow" | Where-Object { $_ -notmatch $validWorkflows }
```

## README.md Header Check

Use this command to verify README.md headers follow the "workflow | pathway" format:

```powershell
# Check README.md files for proper header format
Get-ChildItem -Path "1000xbrain" -Filter "README.md" -Recurse | ForEach-Object { 
    $content = Get-Content $_.FullName -TotalCount 1
    if ($content -notmatch "^# .*workflow \| .*$") {
        Write-Output "$($_.FullName): Invalid header format"
    }
}
```

## Cross-Reference Verification

Test these critical cross-references to ensure they remain valid:

1. **Critical Identity References**:
   - Core essentials to global-rules
   - Global-rules to file-editing-safety
   - Mode indicators to mode transitions

2. **Critical Safety References**:
   - File editing safety guidelines
   - Symbol usage requirements
   - Mode transition protocols

3. **Knowledge Access References**:
   - fetch_rules patterns in global-rules
   - Knowledge directory structure references
   - Tool usage patterns

## Functionality Tests

Verify these key operations still function correctly:

1. **Mode Transitions**:
   - Plan-mode to dev-mode transition
   - Dev-mode to plan-mode transition
   - Direct-mode implementation

2. **Parameter System**:
   - Standard parameter usage
   - Project-rule parameter usage
   - Multiple parameters usage

3. **Knowledge Access**:
   - Basic fetch_rules access
   - Multiple rules access
   - Explanation parameter usage 