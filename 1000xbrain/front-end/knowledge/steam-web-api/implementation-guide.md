# USE WHEN implementing Steam Web API functionality in front-end components

## Overview

This guide provides comprehensive implementation guidance for integrating Steam Web API functionality into the GigaSwap front-end application. It covers all essential components including authentication, inventory management, market data, and trading operations.

## Implementation Approach

Follow this phased implementation approach for the front-end Steam Web API integration:

### Phase 1: Authentication Implementation

1. **Create Authentication Components**:
   - Implement `SteamAuth.tsx` component for login button
   - Develop `useSteamAuth.ts` hook for auth state management
   - Create Redux slice for Steam authentication state

2. **Authentication Flow Implementation**:
   - Implement redirect to Steam OpenID
   - Handle callback and token processing
   - Set up session management
   - Implement logout functionality

3. **User Profile Components**:
   - Create Steam user profile display components
   - Implement avatar and username display
   - Add authenticated user menu options

### Phase 2: Inventory Implementation

1. **Create Inventory Components**:
   - Implement `SteamInventory.tsx` component for inventory display
   - Develop `useSteamInventory.ts` hook for inventory data management
   - Create Redux slice for inventory state

2. **Inventory Display Features**:
   - Implement grid/list views for inventory items
   - Add filtering and search functionality
   - Create detailed item view component
   - Implement progressive loading for large inventories

3. **Item Interaction Components**:
   - Add select/deselect functionality
   - Implement drag-and-drop for item organization
   - Create item inspection components

### Phase 3: Market Data Implementation

1. **Create Market Data Components**:
   - Implement `SteamMarketData.tsx` component for price display
   - Develop `useSteamMarketData.ts` hook for market data management
   - Create Redux slice for market data state

2. **Price Display Features**:
   - Implement current price display
   - Create price history chart components
   - Add price alert functionality
   - Implement price trend indicators

3. **Market Listing Components**:
   - Create listing view for market items
   - Implement buy/sell functionality
   - Add listing filtering and sorting

### Phase 4: Trading Implementation

1. **Create Trading Components**:
   - Implement `SteamTrading.tsx` component for trade interface
   - Develop `useSteamTrading.ts` hook for trade management
   - Create Redux slice for trading state

2. **Trade Offer Features**:
   - Implement trade offer creation interface
   - Create trade partner selection components
   - Add item selection for trades
   - Implement trade offer validation

3. **Trade Management**:
   - Create trade status tracking components
   - Implement trade history view
   - Add trade cancellation functionality
   - Create trade completion confirmation

## Component Structure

### Authentication Components

```tsx
// src/components/auth/SteamAuth.tsx
import React from 'react';
import { Button } from '@mui/material';
import SteamIcon from 'components/icons/SteamIcon';
import { ConsolidatedLogger } from 'utils/consolidated-logger';

const SteamLoginButton: React.FC = () => {
  const handleLogin = () => {
    ConsolidatedLogger.log('INFO', 'AUTH', 'Steam login clicked');
    
    // Redirect to the back-end auth endpoint
    window.location.href = '/api/auth/steam';
  };
  
  return (
    <Button
      variant="contained"
      startIcon={<SteamIcon />}
      onClick={handleLogin}
      sx={{ backgroundColor: '#171a21', '&:hover': { backgroundColor: '#2a475e' } }}
    >
      Login with Steam
    </Button>
  );
};

export default SteamLoginButton;
```

```tsx
// src/hooks/useSteamAuth.ts
import { useState, useEffect } from 'react';
import { SteamUser } from 'models/SteamUser.model';
import { ConsolidatedLogger } from 'utils/consolidated-logger';

export const useSteamAuth = () => {
  const [user, setUser] = useState<SteamUser | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);
  
  useEffect(() => {
    const checkAuth = async () => {
      try {
        setLoading(true);
        const response = await fetch('/api/auth/steam/status', {
          credentials: 'include'
        });
        
        if (!response.ok) {
          throw new Error('Authentication check failed');
        }
        
        const data = await response.json();
        
        if (data.authenticated) {
          setUser(data.user);
        }
      } catch (error) {
        ConsolidatedLogger.logError(
          error instanceof Error ? error : new Error(String(error)),
          'useSteamAuth.checkAuth'
        );
        setError(error instanceof Error ? error : new Error(String(error)));
      } finally {
        setLoading(false);
      }
    };
    
    checkAuth();
  }, []);
  
  return { 
    user, 
    loading, 
    error,
    isAuthenticated: !!user,
    // Additional authentication methods
    logout: async () => {/* implementation */} 
  };
};
```

### Inventory Components

```tsx
// src/hooks/useSteamInventory.ts
import { useState, useEffect } from 'react';
import { SteamInventoryItem } from 'models/SteamInventory.model';
import { cs2SalesAPI } from 'api/cs2-sales';
import { useSteamAuth } from 'hooks/useSteamAuth';
import { ConsolidatedLogger } from 'utils/consolidated-logger';

export const useSteamInventory = () => {
  const [inventory, setInventory] = useState<SteamInventoryItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);
  const { isAuthenticated } = useSteamAuth();
  
  const loadInventory = async (refresh = false) => {
    if (!isAuthenticated) {
      setError(new Error('Authentication required'));
      setLoading(false);
      return;
    }
    
    try {
      setLoading(true);
      
      const items = refresh 
        ? await cs2SalesAPI.refreshSteamInventory()
        : await cs2SalesAPI.getSteamInventory();
        
      setInventory(items);
      setError(null);
    } catch (error) {
      ConsolidatedLogger.logError(
        error instanceof Error ? error : new Error(String(error)),
        'useSteamInventory.loadInventory'
      );
      setError(error instanceof Error ? error : new Error(String(error)));
    } finally {
      setLoading(false);
    }
  };
  
  // Load inventory on authentication change
  useEffect(() => {
    if (isAuthenticated) {
      loadInventory();
    }
  }, [isAuthenticated]);
  
  return {
    inventory,
    loading,
    error,
    refresh: () => loadInventory(true),
    // Additional inventory methods
  };
};
```

### Market Data Components

```tsx
// src/hooks/useSteamMarketData.ts
import { useState, useEffect } from 'react';
import { MarketItem, PriceHistory } from 'models/MarketData.model';
import { marketAPI } from 'api/market';
import { ConsolidatedLogger } from 'utils/consolidated-logger';

export const useSteamMarketData = (itemName?: string) => {
  const [marketData, setMarketData] = useState<MarketItem | null>(null);
  const [priceHistory, setPriceHistory] = useState<PriceHistory | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<Error | null>(null);
  
  const loadMarketData = async () => {
    if (!itemName) return;
    
    try {
      setLoading(true);
      
      const data = await marketAPI.getMarketData(itemName);
      setMarketData(data);
      
      // Also load price history
      const history = await marketAPI.getPriceHistory(itemName);
      setPriceHistory(history);
      
      setError(null);
    } catch (error) {
      ConsolidatedLogger.logError(
        error instanceof Error ? error : new Error(String(error)),
        'useSteamMarketData.loadMarketData'
      );
      setError(error instanceof Error ? error : new Error(String(error)));
    } finally {
      setLoading(false);
    }
  };
  
  // Load market data when itemName changes
  useEffect(() => {
    if (itemName) {
      loadMarketData();
    }
  }, [itemName]);
  
  return {
    marketData,
    priceHistory,
    loading,
    error,
    refresh: loadMarketData,
    // Additional market data methods
  };
};
```

### Trading Components

```tsx
// src/hooks/useSteamTrading.ts
import { useState } from 'react';
import { TradeOffer, TradeStatus } from 'models/TradeOffer.model';
import { SteamInventoryItem } from 'models/SteamInventory.model';
import { tradeAPI } from 'api/trade';
import { ConsolidatedLogger } from 'utils/consolidated-logger';

export const useSteamTrading = () => {
  const [activeOffers, setActiveOffers] = useState<TradeOffer[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<Error | null>(null);
  
  const loadActiveOffers = async () => {
    try {
      setLoading(true);
      
      const offers = await tradeAPI.getActiveOffers();
      setActiveOffers(offers);
      
      setError(null);
    } catch (error) {
      ConsolidatedLogger.logError(
        error instanceof Error ? error : new Error(String(error)),
        'useSteamTrading.loadActiveOffers'
      );
      setError(error instanceof Error ? error : new Error(String(error)));
    } finally {
      setLoading(false);
    }
  };
  
  const createTradeOffer = async (
    partnerSteamId: string,
    itemsToGive: SteamInventoryItem[],
    itemsToReceive: SteamInventoryItem[]
  ) => {
    try {
      setLoading(true);
      
      const offer = await tradeAPI.createOffer({
        partnerSteamId,
        itemsToGive: itemsToGive.map(item => item.assetId),
        itemsToReceive: itemsToReceive.map(item => item.assetId)
      });
      
      // Update active offers
      setActiveOffers(prev => [offer, ...prev]);
      
      setError(null);
      return offer;
    } catch (error) {
      ConsolidatedLogger.logError(
        error instanceof Error ? error : new Error(String(error)),
        'useSteamTrading.createTradeOffer'
      );
      setError(error instanceof Error ? error : new Error(String(error)));
      return null;
    } finally {
      setLoading(false);
    }
  };
  
  return {
    activeOffers,
    loading,
    error,
    loadActiveOffers,
    createTradeOffer,
    // Additional trading methods
    cancelOffer: async (offerId: string) => {/* implementation */},
    checkOfferStatus: async (offerId: string) => {/* implementation */}
  };
};
```

## Redux Integration

### Authentication State

```tsx
// src/store/steamAuthSlice.ts
import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';
import { SteamUser } from 'models/SteamUser.model';
import { steamAuthAPI } from 'api/steamAuth';

interface SteamAuthState {
  user: SteamUser | null;
  isAuthenticated: boolean;
  loading: boolean;
  error: string | null;
}

const initialState: SteamAuthState = {
  user: null,
  isAuthenticated: false,
  loading: false,
  error: null
};

export const checkAuthStatus = createAsyncThunk(
  'steamAuth/checkStatus',
  async () => {
    const response = await steamAuthAPI.getStatus();
    return response;
  }
);

export const logoutUser = createAsyncThunk(
  'steamAuth/logout',
  async () => {
    await steamAuthAPI.logout();
    return null;
  }
);

const steamAuthSlice = createSlice({
  name: 'steamAuth',
  initialState,
  reducers: {
    clearError: (state) => {
      state.error = null;
    }
  },
  extraReducers: (builder) => {
    builder
      // Check auth status
      .addCase(checkAuthStatus.pending, (state) => {
        state.loading = true;
      })
      .addCase(checkAuthStatus.fulfilled, (state, action) => {
        state.loading = false;
        state.isAuthenticated = action.payload.authenticated;
        state.user = action.payload.user || null;
      })
      .addCase(checkAuthStatus.rejected, (state, action) => {
        state.loading = false;
        state.error = action.error.message || 'Authentication check failed';
      })
      
      // Logout
      .addCase(logoutUser.fulfilled, (state) => {
        state.user = null;
        state.isAuthenticated = false;
      });
  }
});

export const { clearError } = steamAuthSlice.actions;
export default steamAuthSlice.reducer;
```

## Implementation Best Practices

1. **Progressive Loading**:
   - Implement lazy loading for inventory items
   - Use pagination for large data sets
   - Add loading skeletons for better UX

2. **Error Handling**:
   - Implement comprehensive error boundaries
   - Provide user-friendly error messages
   - Add retry mechanisms for failed operations

3. **Performance Optimization**:
   - Use memoization for expensive computations
   - Implement efficient rendering with React.memo
   - Optimize Redux selector usage

4. **Security Considerations**:
   - Never store Steam credentials on the client
   - Use secure token handling
   - Implement proper CSRF protection

## Integration with Existing Components

### CS2 Page Integration

```tsx
// src/pages/cs2/index.tsx
import React from 'react';
import { Container, Tabs, Tab, Box } from '@mui/material';
import { useRouter } from 'next/router';
import SteamInventoryGrid from 'components/inventory/SteamInventoryGrid';
import SteamMarketView from 'components/market/SteamMarketView';
import SteamTradingHub from 'components/trading/SteamTradingHub';
import SteamAuthRequired from 'components/auth/SteamAuthRequired';
import { useSteamAuth } from 'hooks/useSteamAuth';

const CS2Hub: React.FC = () => {
  const router = useRouter();
  const { isAuthenticated } = useSteamAuth();
  const [tabValue, setTabValue] = useState(0);
  
  const handleTabChange = (event: React.SyntheticEvent, newValue: number) => {
    setTabValue(newValue);
  };
  
  return (
    <Container maxWidth="lg">
      <Tabs 
        value={tabValue} 
        onChange={handleTabChange}
        variant="fullWidth"
        sx={{ mb: 3 }}
      >
        <Tab label="Inventory" />
        <Tab label="Market" />
        <Tab label="Trading" />
      </Tabs>
      
      <Box mt={3}>
        {tabValue === 0 && (
          <SteamAuthRequired>
            <SteamInventoryGrid />
          </SteamAuthRequired>
        )}
        
        {tabValue === 1 && (
          <SteamMarketView />
        )}
        
        {tabValue === 2 && (
          <SteamAuthRequired>
            <SteamTradingHub />
          </SteamAuthRequired>
        )}
      </Box>
    </Container>
  );
};

export default CS2Hub;
```

## Testing Approach

1. **Component Testing**:
   - Write unit tests for all components
   - Test authentication flows
   - Verify data handling

2. **Integration Testing**:
   - Test end-to-end authentication flow
   - Verify inventory loading and display
   - Test market data integration

3. **User Flow Testing**:
   - Test complete user journeys
   - Verify error handling
   - Test cross-component integration

## Implementation Verification

Verify the implementation using these techniques:

1. **Authentication Verification**:
   - Verify login flow works correctly
   - Test session persistence
   - Verify token handling

2. **Inventory Verification**:
   - Verify items load correctly
   - Test filtering and search
   - Verify item details display

3. **Market Data Verification**:
   - Verify price data accuracy
   - Test historical data display
   - Verify real-time updates

4. **Trading Verification**:
   - Test trade creation flow
   - Verify trade status updates
   - Test trade completion

## Related Knowledge Components

- **Authentication**: `knowledge/front-end/steam-web-api/authentication.md`
- **Inventory**: `knowledge/front-end/steam-web-api/inventory.md`
- **Market Data**: `knowledge/front-end/steam-web-api/market-data.md`
- **Trading**: `knowledge/front-end/steam-web-api/trading.md` 