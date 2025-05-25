# GigaSwap Front-End Development Guide

This document provides comprehensive guidance for front-end development in the GigaSwap project, focusing on testing and logging practices.

## Table of Contents

- [Testing](#testing)
  - [Testing Architecture](#testing-architecture)
  - [Setting Up the Test Environment](#setting-up-the-test-environment)
  - [Running Tests](#running-tests)
  - [Unit Testing](#unit-testing)
  - [Component Testing](#component-testing)
  - [Integration Testing](#integration-testing)
  - [Mock Strategies](#mock-strategies)
- [Logging](#logging)
  - [Logger Implementation](#logger-implementation)
  - [Log Levels](#log-levels)
  - [Usage Examples](#usage-examples)
  - [Error Tracking](#error-tracking)
  - [Log Analysis](#log-analysis)

## Testing

### Testing Architecture

The front-end testing architecture consists of multiple layers:

1. **Unit Tests**: Testing individual functions and components in isolation
2. **Component Tests**: Testing React components with their immediate dependencies
3. **Integration Tests**: Testing interactions between multiple components
4. **End-to-End Tests**: Testing complete user flows across the application

### Setting Up the Test Environment

#### Prerequisites

- Node.js 16+
- npm 7+
- Access to the GigaSwap repository

#### Installation

```bash
# Navigate to the front-end directory
cd front-end

# Install dependencies
npm install
```

### Running Tests

```bash
# Run all tests
npm test

# Run tests in watch mode (for development)
npm test -- --watch

# Run tests for a specific file or pattern
npm test -- --testPathPattern=auth

# Run tests with coverage
npm test -- --coverage
```

### Unit Testing

Unit tests focus on testing individual functions and methods in isolation.

#### Example: Testing a Utility Function

```typescript
// File: src/utils/price-formatter.test.ts
import { formatPrice } from './price-formatter';

describe('formatPrice', () => {
  it('formats prices with 2 decimal places', () => {
    expect(formatPrice(10.5)).toBe('$10.50');
  });

  it('adds commas for thousands', () => {
    expect(formatPrice(1000.5)).toBe('$1,000.50');
  });

  it('handles zero correctly', () => {
    expect(formatPrice(0)).toBe('$0.00');
  });

  it('accepts custom currency symbol', () => {
    expect(formatPrice(10.5, '€')).toBe('€10.50');
  });
});
```

### Component Testing

Component tests verify that React components render correctly and respond appropriately to user interactions.

#### Example: Testing a React Component

```typescript
// File: src/components/ProductCard/ProductCard.test.tsx
import { render, screen, fireEvent } from '@testing-library/react';
import ProductCard from './ProductCard';

const mockProduct = {
  id: '123',
  name: 'Test Product',
  price: 99.99,
  image: '/test-image.jpg'
};

describe('ProductCard', () => {
  it('renders product information correctly', () => {
    render(<ProductCard product={mockProduct} />);
    
    expect(screen.getByText('Test Product')).toBeInTheDocument();
    expect(screen.getByText('$99.99')).toBeInTheDocument();
    expect(screen.getByAltText('Test Product')).toHaveAttribute('src', '/test-image.jpg');
  });

  it('calls onAddToCart when add button is clicked', () => {
    const handleAddToCart = jest.fn();
    render(<ProductCard product={mockProduct} onAddToCart={handleAddToCart} />);
    
    fireEvent.click(screen.getByText('Add to Cart'));
    expect(handleAddToCart).toHaveBeenCalledWith(mockProduct.id);
  });
});
```

### Integration Testing

Integration tests verify that multiple components work together correctly.

#### Example: Testing a Cart Flow

```typescript
// File: src/__tests__/integration/cart-flow.test.tsx
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import { CartProvider } from '@/contexts/CartContext';
import ProductList from '@/components/ProductList';
import Cart from '@/components/Cart';

const mockProducts = [
  { id: '1', name: 'Product 1', price: 10.99 },
  { id: '2', name: 'Product 2', price: 19.99 }
];

jest.mock('@/services/productService', () => ({
  getProducts: jest.fn().mockResolvedValue(mockProducts)
}));

describe('Cart Flow', () => {
  it('allows adding products to cart and updating quantities', async () => {
    render(
      <CartProvider>
        <div>
          <ProductList />
          <Cart />
        </div>
      </CartProvider>
    );

    // Wait for products to load
    await waitFor(() => {
      expect(screen.getByText('Product 1')).toBeInTheDocument();
    });

    // Add product to cart
    fireEvent.click(screen.getAllByText('Add to Cart')[0]);
    
    // Check cart updated
    expect(screen.getByText('1 item')).toBeInTheDocument();
    expect(screen.getByText('$10.99')).toBeInTheDocument();
    
    // Open cart
    fireEvent.click(screen.getByText('1 item'));
    
    // Increase quantity
    fireEvent.click(screen.getByLabelText('Increase quantity'));
    
    // Check quantity and total updated
    expect(screen.getByText('Qty: 2')).toBeInTheDocument();
    expect(screen.getByText('$21.98')).toBeInTheDocument();
  });
});
```

### Mock Strategies

Effective mocking is crucial for isolating components during testing.

#### Mocking API Calls

```typescript
// Using Jest manual mocks
jest.mock('@/services/api', () => ({
  getUser: jest.fn().mockResolvedValue({ id: '123', name: 'Test User' }),
  updateUser: jest.fn().mockResolvedValue({ success: true })
}));

// Using MSW (Mock Service Worker)
import { setupServer } from 'msw/node';
import { rest } from 'msw';

const server = setupServer(
  rest.get('/api/user', (req, res, ctx) => {
    return res(ctx.json({ id: '123', name: 'Test User' }));
  }),
  rest.put('/api/user', (req, res, ctx) => {
    return res(ctx.json({ success: true }));
  })
);

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());
```

#### Mocking Context

```typescript
const mockAuthContext = {
  user: { id: '123', name: 'Test User' },
  isAuthenticated: true,
  login: jest.fn(),
  logout: jest.fn()
};

jest.mock('@/contexts/AuthContext', () => ({
  useAuth: () => mockAuthContext
}));
```

## Logging

### Logger Implementation

The front-end uses a centralized logger service that provides consistent logging across all components and modules.

```typescript
// src/services/logger.ts
export enum LogLevel {
  ERROR = 0,
  WARN = 1,
  INFO = 2,
  DEBUG = 3,
}

interface LogOptions {
  context?: Record<string, any>;
  tags?: string[];
}

class Logger {
  private level: LogLevel;
  private appName: string;

  constructor() {
    // Set log level based on environment
    this.level = process.env.NODE_ENV === 'production' 
      ? LogLevel.INFO 
      : LogLevel.DEBUG;
    this.appName = 'GigaSwap';
  }

  public setLevel(level: LogLevel): void {
    this.level = level;
  }

  public error(message: string, options: LogOptions = {}): void {
    if (this.level >= LogLevel.ERROR) {
      this.logToConsole('error', message, options);
      this.sendToServer('error', message, options);
    }
  }

  public warn(message: string, options: LogOptions = {}): void {
    if (this.level >= LogLevel.WARN) {
      this.logToConsole('warn', message, options);
      this.sendToServer('warn', message, options);
    }
  }

  public info(message: string, options: LogOptions = {}): void {
    if (this.level >= LogLevel.INFO) {
      this.logToConsole('info', message, options);
      this.sendToServer('info', message, options);
    }
  }

  public debug(message: string, options: LogOptions = {}): void {
    if (this.level >= LogLevel.DEBUG) {
      this.logToConsole('debug', message, options);
      // Don't send debug logs to server in production
      if (process.env.NODE_ENV !== 'production') {
        this.sendToServer('debug', message, options);
      }
    }
  }

  private logToConsole(level: string, message: string, options: LogOptions): void {
    const timestamp = new Date().toISOString();
    const prefix = `[${this.appName}][${timestamp}][${level.toUpperCase()}]`;
    
    if (options.context) {
      console[level](`${prefix} ${message}`, options.context);
    } else {
      console[level](`${prefix} ${message}`);
    }
  }

  private sendToServer(level: string, message: string, options: LogOptions): void {
    // In a real implementation, this would send logs to a server
    if (process.env.NODE_ENV === 'production') {
      const logData = {
        level,
        message,
        timestamp: new Date().toISOString(),
        app: this.appName,
        context: options.context || {},
        tags: options.tags || [],
        userAgent: navigator.userAgent,
        url: window.location.href,
      };
      
      // Example implementation using Beacon API for non-blocking logging
      if (navigator.sendBeacon) {
        navigator.sendBeacon('/api/logs', JSON.stringify(logData));
      } else {
        // Fallback to fetch for older browsers
        fetch('/api/logs', {
          method: 'POST',
          body: JSON.stringify(logData),
          keepalive: true,
          headers: {
            'Content-Type': 'application/json'
          }
        }).catch(e => console.error('Failed to send log', e));
      }
    }
  }
}

// Singleton instance
export const logger = new Logger();
```

### Log Levels

The front-end logger supports the following log levels:

- **ERROR**: Critical issues that require immediate attention
- **WARN**: Potential issues that might cause problems
- **INFO**: Informational messages about normal application operation
- **DEBUG**: Detailed debugging information

### Usage Examples

Here are examples of how to use the logger in different scenarios:

```typescript
import { logger } from '@/services/logger';

// Basic usage
logger.info('User logged in successfully');

// With context
logger.error('Failed to load product data', {
  context: {
    productId: '12345',
    errorCode: 'API_ERROR',
    statusCode: 500,
  },
  tags: ['api', 'product-service']
});

// Performance logging
const startTime = performance.now();
// ... perform operation
const endTime = performance.now();
logger.debug('Product search completed', {
  context: {
    query: 'gaming keyboard',
    resultCount: 25,
    duration: endTime - startTime,
  },
  tags: ['performance', 'search']
});

// User action logging
logger.info('User added item to cart', {
  context: {
    userId: user.id,
    productId: product.id,
    quantity: 1,
    cartSize: cart.items.length
  },
  tags: ['user-action', 'cart']
});
```

### Error Tracking

For comprehensive error tracking, the front-end implements error boundaries and global error handlers:

```typescript
// src/components/ErrorBoundary.tsx
import React, { Component, ErrorInfo, ReactNode } from 'react';
import { logger } from '@/services/logger';

interface Props {
  children?: ReactNode;
  fallback?: ReactNode;
}

interface State {
  hasError: boolean;
}

class ErrorBoundary extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(_: Error): State {
    return { hasError: true };
  }

  componentDidCatch(error: Error, errorInfo: ErrorInfo): void {
    // Log the error
    logger.error('Component error caught by boundary', {
      context: {
        error: error.toString(),
        componentStack: errorInfo.componentStack,
        name: error.name,
        message: error.message,
        stack: error.stack
      },
      tags: ['error-boundary', 'react']
    });
  }

  render(): ReactNode {
    if (this.state.hasError) {
      return this.props.fallback || <div>Something went wrong. Please try again.</div>;
    }

    return this.props.children;
  }
}

export default ErrorBoundary;
```

Global error handler for unhandled exceptions:

```typescript
// src/utils/error-handler.ts
import { logger } from '@/services/logger';

export function setupGlobalErrorHandlers(): void {
  // Handle unhandled promise rejections
  window.addEventListener('unhandledrejection', (event) => {
    logger.error('Unhandled Promise Rejection', {
      context: {
        reason: event.reason?.toString(),
        stack: event.reason?.stack
      },
      tags: ['unhandled-rejection']
    });
  });

  // Handle uncaught exceptions
  window.addEventListener('error', (event) => {
    logger.error('Uncaught Exception', {
      context: {
        message: event.message,
        filename: event.filename,
        lineno: event.lineno,
        colno: event.colno,
        stack: event.error?.stack
      },
      tags: ['uncaught-exception']
    });
    
    // Prevent default handling
    event.preventDefault();
  });
}
```

### Log Analysis

#### Console Output Analysis

During development, log messages are sent to the browser console:

1. **Using Browser DevTools**
   - Open browser DevTools (F12 or Ctrl+Shift+I)
   - Navigate to the Console tab
   - Filter logs by level using the dropdown (Errors, Warnings, Info)
   - Search for specific text using the search box

2. **Log Format Analysis**
   - Each log entry follows the format: `[GigaSwap][timestamp][LEVEL] Message`
   - Context objects are expandable in the console
   - Use console grouping to analyze related logs

#### Testing Through Logs

Logs can be used as part of the testing process:

```typescript
// Testing that correct logs are generated
import { logger } from '@/services/logger';

jest.spyOn(logger, 'error');
jest.spyOn(logger, 'info');

test('component logs appropriate messages', async () => {
  // Perform action that should generate logs
  render(<MyComponent />);
  fireEvent.click(screen.getByText('Submit'));
  
  // Verify logs were called with expected parameters
  expect(logger.info).toHaveBeenCalledWith(
    'Form submitted',
    expect.objectContaining({
      context: expect.objectContaining({
        formId: 'test-form'
      })
    })
  );
});
```

#### Analyzing Network-Related Logs

For logs sent to the server, additional monitoring tools are available:

1. **Network Tab Analysis**
   - Open DevTools Network tab
   - Filter for requests to `/api/logs`
   - Inspect request payload to see log data being sent

2. **Performance Analysis**
   - Use logs with the 'performance' tag to identify bottlenecks
   - Look for components with long render times
   - Identify slow API calls or data processing 