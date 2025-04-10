# Logging Strategy: 3D Model Viewer

## Log Categories

1. **Component Lifecycle Logs**
   - 3D viewer component mounting/unmounting
   - Scene initialization and disposal
   - Canvas context creation

2. **Model Loading Logs**
   - GLB file loading attempts
   - Loading progress
   - Successful model loading
   - Loading failures

3. **Performance Logs**
   - Frame rate measurements
   - Loading time metrics
   - Memory usage stats
   - Render performance

4. **Error Logs**
   - File loading errors
   - WebGL context errors
   - Model parsing errors
   - Rendering errors

5. **Resource Management Logs**
   - Texture loading
   - Buffer allocation
   - Memory cleanup
   - Resource disposal

## Logging Points

### Component Lifecycle
```typescript
// Component initialization
console.log('[3DViewer] Initializing component', { props });

// Scene setup
console.log('[3DViewer] Setting up Three.js scene');

// Component cleanup
console.log('[3DViewer] Cleaning up resources');
```

### Model Loading
```typescript
// Loading attempt
console.log('[3DViewer] Loading GLB model:', { filePath });

// Loading progress
console.log('[3DViewer] Loading progress:', { 
  file: filePath,
  progress: percentage 
});

// Loading success
console.log('[3DViewer] Model loaded successfully:', {
  file: filePath,
  modelInfo: {
    vertices: count,
    materials: materials.length
  }
});
```

### Performance Monitoring
```typescript
// FPS monitoring
console.log('[3DViewer] Performance metrics:', {
  fps: currentFPS,
  frameTime: msPerFrame,
  memoryUsage: performance.memory?.usedJSHeapSize
});

// Loading time
console.log('[3DViewer] Model loading time:', {
  file: filePath,
  loadTime: endTime - startTime
});
```

### Error Handling
```typescript
// Loading errors
console.error('[3DViewer] Failed to load model:', {
  file: filePath,
  error: error.message,
  stack: error.stack
});

// WebGL errors
console.error('[3DViewer] WebGL context error:', {
  error: error.message,
  contextLost: gl.isContextLost()
});
```

## Log Format Standards

### Standard Log Format
```typescript
[3DViewer] Action: {
  timestamp: ISOString,
  data: relevantData
}
```

### Error Log Format
```typescript
[3DViewer] ERROR: {
  timestamp: ISOString,
  error: errorDetails,
  context: additionalContext
}
```

### Performance Log Format
```typescript
[3DViewer] PERF: {
  timestamp: ISOString,
  metrics: {
    fps: number,
    memory: number,
    operation: string,
    duration: number
  }
}
```

## Log Analysis Approach

### Functional Verification
1. Check component initialization sequence
2. Verify model loading attempts
3. Confirm successful model loading
4. Monitor scene setup and rendering
5. Validate cleanup on unmount

### Performance Analysis
1. Track FPS during model display
2. Measure model loading times
3. Monitor memory usage patterns
4. Identify performance bottlenecks

### Error Pattern Analysis
1. Collect all error logs
2. Group by error type
3. Analyze error frequency
4. Identify common failure points

## Log Query Patterns

### Component Lifecycle Queries
```powershell
Get-Content -Path "logs-main/front-end/$(Get-Date -Format 'yyyy-MM-dd').log" | Select-String "\[3DViewer\] Initializing"
```

### Model Loading Queries
```powershell
Get-Content -Path "logs-main/front-end/$(Get-Date -Format 'yyyy-MM-dd').log" | Select-String "Loading GLB model"
```

### Error Pattern Queries
```powershell
Get-Content -Path "logs-main/front-end/$(Get-Date -Format 'yyyy-MM-dd').log" | Select-String "\[3DViewer\] ERROR"
```

### Performance Analysis Queries
```powershell
Get-Content -Path "logs-main/front-end/$(Get-Date -Format 'yyyy-MM-dd').log" | Select-String "\[3DViewer\] PERF"
``` 