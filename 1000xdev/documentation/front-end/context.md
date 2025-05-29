# Front-End Context

This document provides essential context about the GigaSwap front-end codebase based on actual implementation.

## Current Implementation Status

### Core Features (Implemented)
- **Steam Marketplace**: Live CS2 inventory integration via Steam API
- **Web3 Authentication**: Polygon wallet connection with wagmi/RainbowKit
- **Market Page**: Server-side rendered marketplace with real Steam data
- **Category Filtering**: CS2 weapon categories (rifles, pistols, knives, etc.)
- **Comprehensive Logging**: ConsolidatedLogger with centralized log management
- **Error Handling**: Error boundaries and Next.js error overlay fixes

### Key Models & Types
- **SteamInventoryItem**: Raw Steam inventory data from steamwebapi.com
- **ProcessedInventoryItem**: Processed Steam items for display with pricing and metadata
- **SteamCategoryKey**: Type-safe category system for CS2 items (rifles, pistols, knives, etc.)
- **Product**: Base product interface used for compatibility with existing components
- **Category**: Category model used by marketplace components
- **ApiResponse, PaginatedResponse**: Standardized response types for all API endpoints

## Authentication Architecture

### Web3 Integration
- **useWalletAuth**: Primary authentication hook managing wallet connection state
- **AuthContext**: Global authentication state provider
- **Automatic Re-authentication**: Handles wallet address changes and disconnections
- **JWT Token Management**: Secure token storage and refresh logic

### Authentication Flow
1. Wallet connection via RainbowKit
2. Signature request for authentication
3. JWT token generation and storage
4. Automatic state restoration on page reload
5. Re-authentication on wallet address changes

## Steam API Integration

### Current Implementation
- **steamInventoryAPI**: Client for fetching CS2 inventory data
- **Category Mapping**: Maps Steam items to application categories
- **Real-time Data**: Live pricing and item condition information
- **Server-side Rendering**: Market page pre-renders with Steam data

### Data Flow
1. Market page requests Steam inventory data
2. API client fetches from Steam endpoints
3. Items mapped to Product interface for compatibility
4. Category filtering applied based on URL parameters
5. Paginated results rendered with MUI components

## Logging System

### ConsolidatedLogger Features
- **Centralized Logging**: All logs written to `/logs-main` directory
- **Category-based Organization**: API, AUTH, USER, ORDERS, CS2, MOCK categories
- **Development Console Output**: Configurable console logging for development
- **Retry Logic**: Failed log entries queued and retried
- **Legacy Compatibility**: Supports existing logging patterns

### Usage Patterns
```typescript
// Standard logging
ConsolidatedLogger.log('INFO', 'CS2', 'Market page loaded', { productCount: 20 });

// Specialized methods
ConsolidatedLogger.logCS2('Category filter applied', 'INFO', { category: 'rifles' });
ConsolidatedLogger.logAuth('Wallet connected', { address: '0x...' });
ConsolidatedLogger.logAPIError(error, '/api/steam/inventory');
```

## Component Architecture

### Organization Pattern
- **Feature-based**: Components grouped by domain (market, auth, common)
- **Page Sections**: Large page components in `pages-sections/`
- **Reusable UI**: Common components in `components/ui/` and `components/common/`
- **MUI Integration**: Extensive use of Material-UI components with custom theming

### Key Components
- **MarketPageView**: Main marketplace component with Steam integration
- **ErrorBoundary**: React error boundary with logging integration
- **Loading**: Reusable loading component with animations
- **UnifiedHeader**: Main navigation header with wallet connection

## Next.js Error Overlay System

### Implementation Files
- **globals.css**: Contains all error overlay handling logic (consolidated from previous JavaScript implementation)
- **emergency-css-injector.js**: CSS injection for error overlay visibility
- **ErrorOverlayTest**: React component for testing error overlay functionality

### Automatic Application
The error overlay fix is automatically applied when the application loads. The system works globally by:
- Injecting critical CSS at the document level
- Running periodic checks for error overlay elements
- Applying fixes dynamically when errors appear
- Cleaning up styles when errors are dismissed

## Development Patterns

### TypeScript Configuration
- **Strict Mode**: Enabled with some relaxed settings for rapid development
- **Path Aliases**: Comprehensive alias system for clean imports
- **Module Resolution**: Bundler resolution for Next.js compatibility

### API Client Pattern
- **Axios-based**: HTTP client with interceptors for logging
- **Mock System**: Development mocking with axios-mock-adapter
- **Error Handling**: Consistent error response patterns
- **Type Safety**: Full TypeScript coverage for API responses

## Extension Points

### Adding New Features
- **Components**: Create in appropriate feature directory
- **API Integration**: Extend existing API client patterns
- **Models**: Add TypeScript interfaces in `models/`
- **Hooks**: Custom hooks in `hooks/` directory
- **Pages**: New routes in `app/` directory

### Steam Integration Extensions
- **Inventory Management**: Extend CS2Gun model for additional Steam fields
- **Trading Features**: Add trading-specific components and API calls
- **Price Tracking**: Implement price history and analytics
- **User Inventories**: Personal inventory management features

---
This documentation is a living reference and must be updated as the codebase evolves. Do not rely on static directory trees or outdated file lists—always verify with the current source. 