# Front-End Testing & Logging


This document provides concise, actionable guidance for front-end testing and logging in the GigaSwap project.

## Testing

### Testing Architecture
- **Unit Tests**: Test individual functions and components in isolation.
- **Component Tests**: Test React components with their immediate dependencies.
- **Integration Tests**: Test interactions between multiple components.
- **End-to-End Tests**: Test complete user flows across the application.

### Setting Up the Test Environment
- Use Node.js 16+ and npm 7+.
- Install dependencies with `npm install` in the `front-end` directory.

### Running Tests
- `npm test` — Run all tests
- `npm test -- --watch` — Watch mode
- `npm test -- --testPathPattern=auth` — Specific file/pattern
- `npm test -- --coverage` — With coverage

### Mock Strategies
- Use Jest for mocking API calls and context.
- Use MSW (Mock Service Worker) for API mocking in integration tests.

### Example: Unit Test
```typescript
import { formatPrice } from './price-formatter';
describe('formatPrice', () => {
  it('formats prices with 2 decimal places', () => {
    expect(formatPrice(10.5)).toBe('$10.50');
  });
});
```

### Example: Component Test
```typescript
import { render, screen } from '@testing-library/react';
import ProductCard from './ProductCard';
describe('ProductCard', () => {
  it('renders product information', () => {
    render(<ProductCard product={{ id: '1', name: 'Test', price: 10 }} />);
    expect(screen.getByText('Test')).toBeInTheDocument();
  });
});
```

## Logging

### Logger Implementation
- Use a centralized logger service for consistent logging.
- Log levels: ERROR, WARN, INFO, DEBUG.
- In production, send logs to the server using Beacon API or fetch.

### Usage Example
```typescript
import { logger } from '@/services/logger';
logger.info('User logged in successfully');
logger.error('Failed to load product data', { context: { productId: '123' } });
```

### Error Tracking
- Use error boundaries in React to catch component errors.
- Implement global error handlers for unhandled promise rejections and uncaught exceptions.

---
This document is updated as practices evolve. Remove or revise any section not directly relevant to the current cycle. 