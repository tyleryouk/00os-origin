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

### ConsolidatedLogger Implementation
- **Centralized Logging**: All logs written to `/logs-main` directory
- **Category-based Organization**: API, AUTH, USER, ORDERS, CS2, MOCK categories
- **Development Console Output**: Configurable console logging for development
- **Retry Logic**: Failed log entries queued and retried

### Usage Examples
```typescript
import { ConsolidatedLogger } from '@/utils/consolidated-logger';

// Standard logging
ConsolidatedLogger.log('INFO', 'CS2', 'Market page loaded', { productCount: 20 });

// Specialized methods
ConsolidatedLogger.logCS2('Category filter applied', 'INFO', { category: 'rifles' });
ConsolidatedLogger.logAuth('Wallet connected', { address: '0x...' });
ConsolidatedLogger.logAPIError(error, '/api/steam/inventory');
```

### Error Tracking
- **Error Boundaries**: React error boundaries with ConsolidatedLogger integration
- **Global Error Handlers**: Unhandled promise rejections and uncaught exceptions
- **Next.js Error Overlay**: Fixed z-index issues for development visibility

### 00OS Log Analysis Command

Need a quick health check on front-end logs?

| Command | Flags | Purpose |
|---------|-------|---------|
| `> dev-analyze-logs --front-end [--edit]` | `--front-end` (required), `--edit` (optional) | Analyze latest front-end logs once. Add `--edit` to apply a single pass of automated fixes based on the analysis. |

Use this instead of manually grepping logs when speed matters.

---
This document is updated as practices evolve. 