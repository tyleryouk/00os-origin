# Runtime Errors & Logging

This document provides concise, actionable guidance for runtime error resolution and logging in the GigaSwap project.

## Runtime Error Resolution

### Process
- **Error Discovery**: Runtime errors are identified by Tyler in the live development environment
- **Error Communication**: Errors are sent to 1000xdev via screenshots showing the Next.js error overlay
- **Error Resolution**: 1000xdev analyzes the error information and implements fixes directly in the code
- **No Build Commands**: 1000xdev never runs `npm run build` or any other npm/build commands to check for errors

### Next.js Error Information
Runtime errors typically include:
- Error message and type
- Stack trace with file locations
- Component tree (for React errors)
- Line numbers and code context

### Resolution Workflow
1. Tyler identifies runtime error in the browser
2. Tyler takes screenshot of the error overlay
3. Tyler sends screenshot to 1000xdev
4. 1000xdev analyzes the error details
5. 1000xdev implements fix in the relevant files
6. Tyler confirms fix in the running application

## Logging

### Logger Implementation
- Use a centralized logger service for consistent logging
- Log levels: ERROR, WARN, INFO, DEBUG
- In production, send logs to the server using Beacon API or fetch

### Usage Example
```typescript
import { logger } from '@/services/logger';
logger.info('User logged in successfully');
logger.error('Failed to load product data', { context: { productId: '123' } });
```

### Error Tracking
- Use error boundaries in React to catch component errors
- Implement global error handlers for unhandled promise rejections and uncaught exceptions

---
This document is updated as practices evolve. 