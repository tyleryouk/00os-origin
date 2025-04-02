# USE WHEN implementing best practices for Steam API integration in front-end components

## Overview

This file provides comprehensive guidance on best practices for integrating the Steam Web API in front-end components of the GigaSwap marketplace. It covers implementation patterns, optimization strategies, error handling, and component architecture.

## Key Patterns

### Authentication Flow Pattern

Follow this pattern for implementing Steam authentication:

1. **Delegation Pattern**: 
   - Front-end initiates by redirecting to back-end endpoint
   - Never communicate directly with Steam from front-end
   - All OpenID logic remains on back-end

2. **Token Management Pattern**:
   - Token stored in both memory and persistent storage
   - Memory for active session
   - Persistent storage (localStorage/cookie) for session restoration

3. **Status Check Pattern**:
   - Check authentication status on app initialization
   - Use a dedicated authentication context provider
   - Implement loading state handling

### Inventory Management Pattern

For displaying Steam inventory items:

1. **Data Fetching Pattern**:
   - Fetch inventory through back-end proxy
   - Implement pagination for large inventories
   - Cache inventory data with appropriate TTL

2. **Refresh Strategy Pattern**:
   - Provide explicit refresh action
   - Implement automatic refresh on token refresh
   - Use optimistic updates for inventory changes

3. **Filtering and Sorting Pattern**:
   - Implement client-side filtering and sorting
   - Use memoized selectors for derived inventory views
   - Support multiple sorting criteria

### Market Data Visualization Pattern

For displaying market prices and trends:

1. **Price History Pattern**:
   - Display price history with interactive charts
   - Implement time range selection
   - Show minimum, maximum, and average prices

2. **Market Aggregation Pattern**:
   - Aggregate data from multiple sources through back-end
   - Compare prices across platforms
   - Highlight best deals

3. **Real-time Updates Pattern**:
   - Use WebSockets for real-time price updates
   - Implement fallback to polling if WebSockets unavailable
   - Batch updates to prevent UI flicker

### Trading Interface Pattern

For implementing trading features:

1. **Trade Offer Creation Pattern**:
   - Multi-step wizard interface
   - Preview trade offers before submission
   - Clear error handling for each step

2. **Trade Status Tracking Pattern**:
   - Real-time status updates
   - Clear visualization of trade state
   - Notifications for status changes

3. **Trade History Pattern**:
   - Paginated trade history
   - Filtering by status and date
   - Detailed transaction information

## Implementation Guidelines

### Component Architecture

Organize Steam-related components using this architecture:

```
/components
  /steam
    /auth
      SteamLoginButton.tsx
      UserProfile.tsx
      AuthContext.tsx
    /inventory
      InventoryGrid.tsx
      ItemCard.tsx
      FilterBar.tsx
    /market
      PriceChart.tsx
      MarketListings.tsx
      PriceAlert.tsx
    /trading
      TradeOfferForm.tsx
      TradeStatus.tsx
      TradeHistory.tsx
```

### State Management

1. **Authentication State**:
   - Use React Context for authentication state
   - Implement custom hooks for authentication actions
   - Keep token handling logic encapsulated

```tsx
// AuthContext.tsx
const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const auth = useSteamAuth();
  
  return (
    <AuthContext.Provider value={auth}>
      {children}
    </AuthContext.Provider>
  );
};

// Custom hook for accessing auth context
export const useAuth = () => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};
```

2. **Inventory State**:
   - Implement caching with SWR or React Query
   - Use pagination for performance
   - Implement optimistic updates for inventory changes

```tsx
// useInventory.ts
export const useInventory = (steamId?: string) => {
  const { isAuthenticated } = useAuth();
  
  return useQuery(
    ['inventory', steamId],
    () => fetchInventory(steamId),
    {
      enabled: isAuthenticated && !!steamId,
      staleTime: 5 * 60 * 1000, // 5 minutes
      retry: 3,
      onError: (error) => {
        ConsolidatedLogger.logError(error, 'useInventory');
      }
    }
  );
};
```

3. **Market Data State**:
   - Implement time-based caching
   - Use WebSockets for real-time updates
   - Batch updates to prevent UI flicker

### API Integration

1. **API Client Setup**:
   - Create dedicated API client for Steam endpoints
   - Implement automatic token handling
   - Add request/response interceptors for logging

```tsx
// api/steam.ts
import axios from 'axios';
import { ConsolidatedLogger } from 'utils/consolidated-logger';

const steamAPI = axios.create({
  baseURL: '/api/steam',
  timeout: 10000,
  withCredentials: true,
});

// Request interceptor
steamAPI.interceptors.request.use(
  (config) => {
    // Add token if available in localStorage
    const token = localStorage.getItem('steam_auth_token');
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    ConsolidatedLogger.logError(error, 'steamAPI.request');
    return Promise.reject(error);
  }
);

// Response interceptor
steamAPI.interceptors.response.use(
  (response) => response,
  (error) => {
    ConsolidatedLogger.logError(error, 'steamAPI.response');
    
    // Handle authentication errors
    if (error.response?.status === 401) {
      // Clear token and redirect to login
      localStorage.removeItem('steam_auth_token');
      window.dispatchEvent(new Event('steam_auth_error'));
    }
    
    return Promise.reject(error);
  }
);

export default steamAPI;
```

2. **API Methods**:
   - Create typed API methods
   - Add documentation for each method
   - Implement proper error handling

```tsx
// api/inventory.ts
import steamAPI from './steam';
import { SteamInventoryItem } from 'models/SteamInventoryItem.model';

/**
 * Fetch user's Steam inventory
 * @param steamId Optional Steam ID (uses authenticated user if not provided)
 * @returns Promise with inventory items
 */
export const fetchInventory = async (steamId?: string): Promise<SteamInventoryItem[]> => {
  try {
    const endpoint = steamId ? `/inventory/${steamId}` : '/inventory';
    const response = await steamAPI.get(endpoint);
    return response.data;
  } catch (error) {
    ConsolidatedLogger.logError(error, 'fetchInventory');
    throw error;
  }
};
```

### Performance Optimization

1. **Lazy Loading**:
   - Lazy load Steam components
   - Use code splitting with React.lazy
   - Show appropriate loading indicators

```tsx
// Lazy loaded Steam components
const SteamInventory = React.lazy(() => import('./components/steam/inventory/InventoryGrid'));
const SteamMarket = React.lazy(() => import('./components/steam/market/MarketListings'));
```

2. **Memoization**:
   - Memoize expensive computations
   - Use React.memo for pure components
   - Implement useMemo for derived data

```tsx
// Memoized inventory filtering
const filteredItems = useMemo(() => {
  return items.filter(item => {
    return item.name.toLowerCase().includes(searchTerm.toLowerCase());
  });
}, [items, searchTerm]);
```

3. **Virtual Lists**:
   - Use virtualization for long lists
   - Implement infinite scrolling for paginated data
   - Only render visible items

```tsx
// Virtual inventory grid
import { FixedSizeGrid } from 'react-window';

const InventoryGrid = ({ items }) => {
  return (
    <FixedSizeGrid
      columnCount={5}
      columnWidth={120}
      height={600}
      rowCount={Math.ceil(items.length / 5)}
      rowHeight={120}
      width={600}
      itemData={{ items }}
    >
      {ItemRenderer}
    </FixedSizeGrid>
  );
};
```

### Error Handling

1. **Error Boundary Pattern**:
   - Implement error boundaries around Steam components
   - Show fallback UI on error
   - Log errors to monitoring system

```tsx
// Steam error boundary
const SteamErrorBoundary = ({ children }) => {
  return (
    <ErrorBoundary
      FallbackComponent={SteamErrorFallback}
      onError={(error) => {
        ConsolidatedLogger.logError(error, 'SteamErrorBoundary');
      }}
    >
      {children}
    </ErrorBoundary>
  );
};
```

2. **Api Error Handling**:
   - Categorize errors (network, authentication, validation)
   - Implement specific handling for each error type
   - Provide clear error messages to users

```tsx
// Error handling in inventory hook
export const useInventory = () => {
  const { data, error, isLoading, refetch } = useQuery(
    'inventory',
    fetchInventory,
    {
      onError: (error) => {
        if (axios.isAxiosError(error)) {
          if (error.response?.status === 401) {
            // Handle authentication error
          } else if (error.response?.status === 403) {
            // Handle privacy settings error
          } else if (!error.response && error.request) {
            // Handle network error
          }
        }
        
        // Log error
        ConsolidatedLogger.logError(error, 'useInventory');
      }
    }
  );
  
  return {
    inventory: data,
    isLoading,
    error,
    refetch,
    hasError: !!error,
    errorMessage: getErrorMessage(error),
  };
};
```

3. **Fallback Content**:
   - Provide fallback content for failed data loads
   - Implement retry mechanisms
   - Show skeleton loaders during loading

## Cross-References

- **Front-End Authentication**: `knowledge/front-end/steam-web-api/authentication.md`
- **Front-End Inventory**: `knowledge/front-end/steam-web-api/inventory.md`
- **Front-End Market Data**: `knowledge/front-end/steam-web-api/market-data.md`
- **Front-End Trading**: `knowledge/front-end/steam-web-api/trading.md`
- **Back-End Authentication**: `knowledge/back-end/steam-web-api/authentication.md` 