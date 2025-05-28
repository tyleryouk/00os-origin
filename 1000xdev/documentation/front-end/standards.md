# Front-End Standards

This document defines the core standards, best practices, and architectural principles for front-end development in the GigaSwap project based on actual implementation patterns.

## Code Organization

### Component Structure
- **Feature-based Organization**: Components grouped by domain (`market/`, `auth/`, `common/`)
- **Page Sections**: Large page components in `pages-sections/` directory
- **Reusable UI**: Base components in `components/ui/` and `components/common/`
- **Single Responsibility**: Each component has a focused, single purpose

### File Naming Conventions
- **Components**: PascalCase (e.g., `MarketPageView.tsx`, `ErrorBoundary.tsx`)
- **Hooks**: camelCase with `use` prefix (e.g., `useWalletAuth.ts`, `useOrders.ts`)
- **Models**: PascalCase with `.model.ts` suffix (e.g., `CS2Gun.model.ts`)
- **API Clients**: kebab-case (e.g., `steam.ts`, `client.ts`)
- **Utilities**: camelCase (e.g., `consolidated-logger.ts`)

## TypeScript Standards

### Type Safety
- **Strict Mode**: Enabled with selective relaxation for rapid development
- **Interface Definitions**: All data structures use TypeScript interfaces
- **API Types**: Standardized response types (`ApiResponse<T>`, `PaginatedResponse<T>`)
- **Model Extensions**: Use interface extension for specialized types (CS2Gun extends Product)

### Import Patterns
```typescript
// Path aliases for clean imports
import { ConsolidatedLogger } from '@/utils/consolidated-logger';
import { CS2Gun } from 'models/CS2Gun.model';
import { useWalletAuth } from 'hooks/useWalletAuth';
```

### Type Definitions
```typescript
// Standard API response pattern
export interface ApiResponse<T> {
  success: boolean;
  data?: T;
  error?: {
    code: string;
    message: string;
  };
}

// Model extension pattern
export default interface CS2Gun extends Product {
  glbFile: string;
  collection: string;
  rarity: string;
  wear: number;
}
```

## Component Standards

### React Patterns
- **Functional Components**: Use function components with hooks
- **TypeScript Props**: All props interfaces defined with TypeScript
- **Error Boundaries**: Wrap components with ErrorBoundary for error handling
- **Loading States**: Use Loading component for async operations

### Component Structure
```typescript
'use client'; // For client components

import { useState, useEffect } from 'react';
import { Box, Typography } from '@mui/material';
import { ConsolidatedLogger } from '@/utils/consolidated-logger';

interface ComponentProps {
  data: SomeType;
  onAction: (id: string) => void;
}

export default function ComponentName({ data, onAction }: ComponentProps) {
  // Component logic
  return (
    <Box>
      {/* Component JSX */}
    </Box>
  );
}
```

## API Integration Standards

### Client Configuration
- **Axios-based**: HTTP client with interceptors for logging
- **Error Handling**: Consistent error response patterns
- **Type Safety**: Full TypeScript coverage for API responses
- **Mock System**: Development mocking with axios-mock-adapter

### API Function Pattern
```typescript
export async function fetchSteamInventory(params: InventoryParams): Promise<ApiResponse<InventoryData>> {
  try {
    const response = await apiClient.get('/steam/inventory', { params });
    return response.data;
  } catch (error) {
    ConsolidatedLogger.logAPIError(error, '/steam/inventory');
    throw error;
  }
}
```

## State Management

### Authentication State
- **AuthContext**: Global authentication state provider
- **useWalletAuth**: Primary authentication hook
- **Automatic Re-authentication**: Handle wallet changes and disconnections

### Local State
- **useState**: For component-specific state
- **useEffect**: For side effects and lifecycle management
- **Custom Hooks**: Extract complex logic into reusable hooks

## Logging Standards

### ConsolidatedLogger Usage
```typescript
// Standard logging
ConsolidatedLogger.log('INFO', 'CS2', 'Market page loaded', { productCount: 20 });

// Specialized methods
ConsolidatedLogger.logCS2('Category filter applied', 'INFO', { category: 'rifles' });
ConsolidatedLogger.logAuth('Wallet connected', { address: '0x...' });
ConsolidatedLogger.logAPIError(error, '/api/steam/inventory');
```

### Log Categories
- **API**: API requests and responses
- **AUTH**: Authentication and wallet operations
- **USER**: User actions and interactions
- **CS2**: Steam/CS2 specific operations
- **CLIENT**: Client-side errors and events

## Error Handling

### Error Boundaries
- **React Error Boundaries**: Catch and handle component errors
- **Logging Integration**: All errors logged via ConsolidatedLogger
- **User-friendly Messages**: Display helpful error messages to users
- **Retry Functionality**: Allow users to retry failed operations

### Runtime Error Resolution
- **Screenshot-based**: Errors reported via screenshots of Next.js overlay
- **Direct Code Fixes**: Implement fixes directly in code without build commands
- **Error Overlay Fixes**: Ensure Next.js errors are visible above UI elements

## Styling Standards

### Material-UI Integration
- **MUI Components**: Use Material-UI components as base
- **Custom Theming**: Extend MUI theme for brand consistency
- **Responsive Design**: Mobile-first approach with MUI breakpoints
- **CSS-in-JS**: Use MUI's sx prop for component styling

### Global Styles
- **globals.css**: Global styles and CSS variables
- **Error Overlay Fixes**: CSS fixes for Next.js error visibility
- **Z-index Management**: Consistent z-index hierarchy

## Performance Standards

### Optimization Patterns
- **Server-side Rendering**: Use Next.js SSR for initial page loads
- **Code Splitting**: Component-level code splitting for large features
- **Image Optimization**: Use Next.js Image component
- **Caching**: Implement appropriate caching strategies

### Monitoring
- **Performance Logging**: Track page load times and user interactions
- **Error Tracking**: Monitor and log client-side errors
- **User Analytics**: Track user behavior and feature usage

## Development Workflow

### Development Practices
- **Hot Reloading**: Use Next.js development server
- **Mock Data**: Develop with mock APIs for offline work
- **Type Checking**: Continuous TypeScript checking
- **Error Visibility**: Ensure development errors are always visible

### Code Quality
- **ESLint**: Code linting with Next.js configuration
- **TypeScript**: Strict type checking
- **Consistent Formatting**: Follow established code formatting
- **Documentation**: Document complex logic and API integrations

---
This document is updated as standards evolve. 