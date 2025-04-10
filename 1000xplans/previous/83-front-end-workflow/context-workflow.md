# Workflow: Log-Based 3D Viewer Debugging

## Overview

This workflow outlines the process of using our enhanced logging system to diagnose and fix issues with the 3D model viewer. It provides step-by-step procedures for identifying, analyzing, and resolving problems using log data.

## Workflow Steps

### 1. Initial Log Collection

1. **Start Application with Full Logging**
   ```powershell
   # Start front-end with debug logging enabled
   $env:DEBUG=true; npm run dev
   ```

2. **Attempt Model Loading**
   - Load each target model:
     - `awp_counter_strike_2.glb`
     - `sandstorm_-_gunblade.glb`
     - `cs2_knife_-_case_hardened__free.glb`

3. **Collect Initial Logs**
   ```powershell
   # Collect all 3D viewer logs
   Get-Content -Path "logs-main/front-end/$(Get-Date -Format 'yyyy-MM-dd').log" | Select-String "\[3DViewer\]" > viewer-debug.log
   ```

### 2. Log Analysis

1. **Component Lifecycle Analysis**
   ```powershell
   # Check initialization sequence
   Get-Content viewer-debug.log | Select-String "Initializing|Setting up|Cleaning"
   ```

2. **Model Loading Analysis**
   ```powershell
   # Check model loading attempts and results
   Get-Content viewer-debug.log | Select-String "Loading GLB model|Model loaded successfully|Failed to load"
   ```

3. **Performance Analysis**
   ```powershell
   # Extract performance metrics
   Get-Content viewer-debug.log | Select-String "PERF" | ConvertFrom-Json
   ```

4. **Error Analysis**
   ```powershell
   # Collect all errors
   Get-Content viewer-debug.log | Select-String "ERROR" > errors.log
   ```

### 3. Issue Identification

1. **Check Component Initialization**
   - Verify proper sequence:
     - Component mount
     - Scene initialization
     - WebGL context creation
     - Resource allocation

2. **Analyze Loading Failures**
   - Check for:
     - File not found errors
     - Parse errors
     - WebGL context errors
     - Memory errors

3. **Review Performance Issues**
   - Look for:
     - Low FPS periods
     - High memory usage
     - Long loading times
     - Resource leaks

### 4. Fix Implementation

1. **Apply Fixes Based on Logs**
   - Address identified issues
   - Implement error handling
   - Add performance optimizations

2. **Verify Fixes with Logging**
   ```powershell
   # Clear old logs
   Remove-Item viewer-debug.log
   
   # Start with fresh logging
   $env:DEBUG=true; npm run dev
   
   # Collect new logs
   Get-Content -Path "logs-main/front-end/$(Get-Date -Format 'yyyy-MM-dd').log" | Select-String "\[3DViewer\]" > viewer-debug-fixed.log
   ```

3. **Compare Before/After**
   ```powershell
   # Compare error counts
   $beforeErrors = (Get-Content errors.log).Count
   $afterErrors = (Get-Content viewer-debug-fixed.log | Select-String "ERROR").Count
   
   # Compare performance
   $beforePerf = Get-Content viewer-debug.log | Select-String "PERF"
   $afterPerf = Get-Content viewer-debug-fixed.log | Select-String "PERF"
   ```

### 5. Verification

1. **Functional Verification**
   - Check logs for successful model loading
   - Verify no unexpected errors
   - Confirm proper cleanup

2. **Performance Verification**
   - Check FPS meets target (60 FPS)
   - Verify loading times (< 2s)
   - Monitor memory usage

3. **Resource Management Verification**
   - Check for resource leaks
   - Verify cleanup on unmount
   - Monitor memory patterns

## Log Analysis Patterns

### Component Lifecycle Pattern
```typescript
// Check initialization sequence
const initSequence = logs
  .filter(log => log.includes('Initializing'))
  .map(log => ({
    timestamp: extractTimestamp(log),
    action: extractAction(log)
  }));

// Verify proper order
verifySequence(initSequence, [
  'component_mount',
  'scene_init',
  'context_creation'
]);
```

### Error Pattern Analysis
```typescript
// Group errors by type
const errorGroups = logs
  .filter(log => log.includes('ERROR'))
  .reduce((groups, log) => {
    const type = extractErrorType(log);
    groups[type] = (groups[type] || 0) + 1;
    return groups;
  }, {});

// Sort by frequency
const commonErrors = Object.entries(errorGroups)
  .sort(([,a], [,b]) => b - a);
```

### Performance Pattern Analysis
```typescript
// Analyze FPS over time
const fpsData = logs
  .filter(log => log.includes('PERF'))
  .map(log => ({
    timestamp: extractTimestamp(log),
    fps: extractFPS(log)
  }));

// Find performance dips
const performanceIssues = fpsData
  .filter(data => data.fps < 60);
```

## Success Verification

### Log-Based Success Criteria
1. No error logs for model loading
2. Consistent 60+ FPS in performance logs
3. Complete resource cleanup logs
4. Proper initialization sequence logs

### Verification Commands
```powershell
# Check for errors
$errors = Get-Content viewer-debug-fixed.log | Select-String "ERROR"
if ($errors.Count -eq 0) {
    Write-Host "No errors found"
}

# Check performance
$perfIssues = Get-Content viewer-debug-fixed.log | 
    Select-String "PERF" |
    Where-Object { $_ -match '"fps":\s*(\d+)' -and $matches[1] -lt 60 }
if ($perfIssues.Count -eq 0) {
    Write-Host "Performance meets target"
}

# Check cleanup
$cleanup = Get-Content viewer-debug-fixed.log | 
    Select-String "Cleaning up resources" |
    Where-Object { $_ -match '"count":\s*0' }
if ($cleanup.Count -gt 0) {
    Write-Host "Resources properly cleaned up"
}
``` 