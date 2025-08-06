# Iterative Development Commands Guide

> **Last Updated:** 2025-01-08  
> **Author:** 00reaper  
> **Domain:** 1000xdev

## Overview

This guide documents the four new iterative development commands created for 1000xdev. These commands automate the process of reading logs, analyzing errors, and making code changes based on TODO.md tasks.

## Command Architecture

All iterative commands follow a consistent pattern:

1. **Initialize**: Set working directory and read TODO.md
2. **Analyze**: Read and parse application logs for errors
3. **Plan**: Identify files to modify based on error analysis
4. **Execute**: Make targeted code changes
5. **Iterate**: Repeat until tasks complete (except for `dev-analyze-logs`)

## Commands

### 1. dev-iterate-back-end

**Purpose:** Automate back-end development by reading Python/FastAPI logs and fixing issues iteratively.

**Process Flow:**
```
1. cd to workspace root
2. Read logs-main/*.log files
3. Parse ERROR and WARNING messages
4. Read TODO.md for back-end tasks
5. Identify affected Python files
6. Make code edits
7. Repeat until tasks complete
```

**Domain Boundary:** Only modifies files in `back-end/` directory

### 2. dev-iterate-front-end  

**Purpose:** Automate front-end development by reading Next.js/React logs and fixing issues iteratively.

**Process Flow:**
```
1. cd to workspace root
2. Read npm/yarn build logs
3. Parse compilation errors and warnings
4. Read TODO.md for front-end tasks
5. Identify affected TypeScript/React files
6. Make code edits
7. Repeat until tasks complete
```

**Domain Boundary:** Only modifies files in `front-end/` directory

### 3. dev-iterate-full-stack

**Purpose:** Coordinate changes across both back-end and front-end domains.

**Process Flow:**
```
1. cd to workspace root
2. Read both back-end and front-end logs
3. Identify cross-domain dependencies
4. Read TODO.md for full-stack tasks
5. Coordinate API contract changes
6. Update both domains in sync
7. Repeat until tasks complete
```

**Domain Boundary:** Can modify both `back-end/` and `front-end/` directories

### 4. dev-analyze-logs

**Purpose:** One-off log analysis with optional single edit cycle.

**Required Flags:**
- `--back-end` OR `--front-end` (specify which logs to analyze)

**Optional Flags:**
- `--edit` (if provided, make one round of edits after analysis)

**Process Flow:**
```
1. cd to workspace root
2. Read specified logs (back-end or front-end)
3. Parse and analyze errors
4. If --edit flag:
   - Read TODO.md
   - Make one round of edits
   - Complete
5. Else:
   - Return analysis summary
```

## Log Reading Patterns

### Back-end Log Locations
- Primary: `logs-main/`
- Format: JSON structured logs with timestamp, level, message
- Key fields: ERROR, WARNING, INFO levels
- Python tracebacks included

### Front-end Log Locations  
- Build logs: Terminal output from `npm run dev` or `npm run build`
- Runtime logs: Browser console (not directly accessible)
- Format: TypeScript/webpack compilation errors
- Key patterns: Module not found, Type errors, Import errors

## PowerShell Commands

All processes use PowerShell commands that start with:
```powershell
cd C:\Users\ethde\Desktop\GigaSwap;
```

Common log reading commands:
```powershell
# Back-end logs
Get-Content logs-main/*.log -Tail 100 | Select-String "ERROR"

# Front-end build output
npm run build 2>&1 | Select-String "error"
```

## Error Handling

Each command includes robust error handling:

1. **Working Directory Validation**: Ensures correct path before execution
2. **Log Access Errors**: Graceful handling if log files are locked/missing
3. **Domain Boundary Enforcement**: Prevents cross-contamination of changes
4. **TODO.md Validation**: Checks for valid task format
5. **Iteration Limits**: Maximum iterations to prevent infinite loops

## TODO.md Integration

Commands expect TODO.md to follow this format:
```markdown
## Back-end Tasks
- [ ] Fix authentication middleware
- [ ] Update user model validation

## Front-end Tasks  
- [ ] Fix TypeScript errors in components
- [ ] Update API client types

## Full-stack Tasks
- [ ] Sync API contracts between domains
- [ ] Update shared types
```

## Best Practices

1. **Run servers first**: Ensure applications are running to generate logs
2. **Clear old logs**: Archive old logs before starting new iteration cycles
3. **Use specific commands**: Use domain-specific commands when possible
4. **Monitor progress**: Check cycle-status.md for iteration progress
5. **Review changes**: Validate automated changes before committing

## Troubleshooting

### Common Issues

**Issue:** Command can't find logs
**Solution:** Ensure application is running and generating logs

**Issue:** No tasks found in TODO.md
**Solution:** Update TODO.md with properly formatted task lists

**Issue:** Command makes incorrect edits
**Solution:** Use `dev-analyze-logs` first to review analysis without edits

**Issue:** Infinite iteration loop
**Solution:** Commands have built-in iteration limits (default: 10)

## Future Enhancements

Potential improvements for next cycles:
- Integration with test runners to validate fixes
- Automatic git commits after successful iterations
- Parallel processing of independent tasks
- Machine learning for better error-to-fix mapping
- Integration with CI/CD pipeline results

---

For implementation details, see the process files in `00OS/processes/1000xdev/`