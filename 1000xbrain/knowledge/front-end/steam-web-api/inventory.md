# USE WHEN implementing Steam inventory functionality in front-end components

## Overview

This knowledge file provides implementation guidance for integrating Steam inventory functionality into the GigaSwap marketplace front-end. It covers inventory data models, UI components, state management, and best practices for CS2 skin display and interaction.

## Inventory Data Model

The inventory system extends the existing CS2Gun model to incorporate Steam-specific properties:

```tsx
// models/CS2Gun.model.ts - Extended with Steam inventory properties
export interface SteamInventoryItem extends CS2Gun {
  assetId: string;        // Steam inventory asset ID
  marketable: boolean;    // Whether item can be listed on market
  tradable: boolean;      // Whether item can be traded
  tradeHoldDuration?: number; // Trade hold duration in days
  inspectLink?: string;   // Steam inspect link
  wear?: number;          // Float value (0-1) representing weapon wear
  patternId?: number;     // Pattern template ID
  stickers?: SteamSticker[]; // Applied stickers
  isStatTrak?: boolean;   // Whether the weapon tracks kills
  nameTag?: string;       // Custom name tag if applied
}

export interface SteamSticker {
  name: string;           // Sticker name
  image: string;          // Sticker image URL
  slot: number;           // Position (0-3)
  wear?: number;          // Sticker wear (0-1)
}
```

## Inventory API Integration

### Inventory API Service

```tsx
// api/cs2-sales.ts - Add Steam inventory methods
import { SteamInventoryItem } from 'models/CS2Gun.model';
import { cache } from 'utils/api-cache';
import { ConsolidatedLogger } from 'utils/consolidated-logger';

// Add to existing cs2SalesAPI
export const cs2SalesAPI = {
  // ... existing methods

  /**
   * Get user's Steam inventory
   * @returns Promise with inventory items
   */
  getSteamInventory: cache(async (): Promise<SteamInventoryItem[]> => {
    try {
      // Log the inventory loading operation
      ConsolidatedLogger.logCS2('Loading Steam inventory', 'INFO', { source: 'getSteamInventory' });
      
      // Fetch inventory from API
      const response = await apiClient.get('/inventory/steam');
      
      // Map API response to SteamInventoryItem
      const inventory = response.data.map((item: any) => ({
        ...item,
        // Ensure all required properties are present
        id: item.id || item.assetId,
        assetId: item.assetId,
        marketable: !!item.marketable,
        tradable: !!item.tradable,
        // Add any additional processing needed
      }));
      
      return inventory;
    } catch (error) {
      // Log any errors
      ConsolidatedLogger.logCS2Error(
        error instanceof Error ? error : new Error(String(error)),
        'getSteamInventory'
      );
      
      // Return fallback data in case of error
      return [];
    }
  }, {
    // Cache for 2 minutes
    ttl: 2 * 60 * 1000,
    // Cache key based on user ID
    cacheKeyFn: () => `steam-inventory-${localStorage.getItem('userId') || 'anonymous'}`
  }),

  /**
   * Refresh Steam inventory (bypass cache)
   * @returns Promise with inventory items
   */
  refreshSteamInventory: async (): Promise<SteamInventoryItem[]> => {
    try {
      ConsolidatedLogger.logCS2('Refreshing Steam inventory', 'INFO', { source: 'refreshSteamInventory' });
      
      // Fetch inventory with refresh flag
      const response = await apiClient.get('/inventory/steam?refresh=true');
      
      // Map API response to SteamInventoryItem
      const inventory = response.data.map((item: any) => ({
        ...item,
        // Ensure all required properties are present
        id: item.id || item.assetId,
        assetId: item.assetId,
        marketable: !!item.marketable,
        tradable: !!item.tradable,
      }));
      
      return inventory;
    } catch (error) {
      ConsolidatedLogger.logCS2Error(
        error instanceof Error ? error : new Error(String(error)),
        'refreshSteamInventory'
      );
      
      return [];
    }
  },
};
```

## Inventory UI Components

### Inventory Grid Component

```tsx
import React, { useState, useEffect } from 'react';
import { Grid, Typography, Box, CircularProgress, Button } from '@mui/material';
import RefreshIcon from '@mui/icons-material/Refresh';
import InventoryItemCard from './InventoryItemCard';
import { cs2SalesAPI } from 'api/cs2-sales';
import { SteamInventoryItem } from 'models/CS2Gun.model';
import { useAuth } from 'hooks/useAuth';
import { ConsolidatedLogger } from 'utils/consolidated-logger';

const SteamInventoryGrid: React.FC = () => {
  const [inventory, setInventory] = useState<SteamInventoryItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const { isAuthenticated } = useAuth();
  
  const loadInventory = async (refresh = false) => {
    if (!isAuthenticated) {
      setError('Please log in with Steam to view your inventory');
      setLoading(false);
      return;
    }
    
    try {
      setLoading(true);
      setError(null);
      
      const items = refresh 
        ? await cs2SalesAPI.refreshSteamInventory()
        : await cs2SalesAPI.getSteamInventory();
        
      setInventory(items);
      
      ConsolidatedLogger.logCS2(
        `Loaded ${items.length} inventory items`,
        'INFO',
        { source: 'SteamInventoryGrid', refresh }
      );
    } catch (error) {
      ConsolidatedLogger.logCS2Error(
        error instanceof Error ? error : new Error(String(error)),
        'SteamInventoryGrid.loadInventory'
      );
      setError('Failed to load inventory. Please try again.');
    } finally {
      setLoading(false);
    }
  };
  
  useEffect(() => {
    loadInventory();
  }, [isAuthenticated]);
  
  const handleRefresh = () => {
    loadInventory(true);
  };
  
  if (!isAuthenticated) {
    return (
      <Box sx={{ py: 4, textAlign: 'center' }}>
        <Typography variant="h6">Please log in with Steam to view your inventory</Typography>
      </Box>
    );
  }
  
  return (
    <Box>
      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', mb: 2 }}>
        <Typography variant="h5">My CS2 Inventory</Typography>
        <Button 
          startIcon={<RefreshIcon />}
          onClick={handleRefresh}
          disabled={loading}
        >
          Refresh
        </Button>
      </Box>
      
      {loading ? (
        <Box sx={{ display: 'flex', justifyContent: 'center', py: 4 }}>
          <CircularProgress />
        </Box>
      ) : error ? (
        <Box sx={{ py: 2 }}>
          <Typography color="error">{error}</Typography>
        </Box>
      ) : inventory.length === 0 ? (
        <Box sx={{ py: 4, textAlign: 'center' }}>
          <Typography>No items found in your CS2 inventory</Typography>
        </Box>
      ) : (
        <Grid container spacing={2}>
          {inventory.map((item) => (
            <Grid item xs={12} sm={6} md={4} lg={3} key={item.assetId}>
              <InventoryItemCard item={item} />
            </Grid>
          ))}
        </Grid>
      )}
    </Box>
  );
};

export default SteamInventoryGrid;
```

### Inventory Item Card Component

```tsx
import React from 'react';
import { Card, CardMedia, CardContent, Typography, Box, Chip, Tooltip } from '@mui/material';
import { SteamInventoryItem } from 'models/CS2Gun.model';
import { formatCurrency } from 'utils/formatters';

interface InventoryItemCardProps {
  item: SteamInventoryItem;
  onClick?: (item: SteamInventoryItem) => void;
}

const InventoryItemCard: React.FC<InventoryItemCardProps> = ({ item, onClick }) => {
  const handleClick = () => {
    if (onClick) {
      onClick(item);
    }
  };
  
  const wearLabel = getWearLabel(item.wear);
  
  return (
    <Card 
      sx={{ 
        cursor: onClick ? 'pointer' : 'default',
        transition: 'transform 0.2s',
        '&:hover': onClick ? { transform: 'scale(1.02)' } : {}
      }}
      onClick={handleClick}
    >
      <Box sx={{ position: 'relative' }}>
        <CardMedia
          component="img"
          height="140"
          image={item.imageUrl}
          alt={item.name}
        />
        {!item.tradable && (
          <Chip 
            label="Not Tradable" 
            size="small"
            color="error"
            sx={{ position: 'absolute', top: 8, right: 8 }}
          />
        )}
        {item.tradeHoldDuration && item.tradeHoldDuration > 0 && (
          <Tooltip title="Trade will be held in escrow">
            <Chip 
              label={`Hold: ${item.tradeHoldDuration}d`} 
              size="small"
              color="warning"
              sx={{ position: 'absolute', top: 8, left: 8 }}
            />
          </Tooltip>
        )}
      </Box>
      
      <CardContent>
        <Typography variant="subtitle2" color="text.secondary" gutterBottom>
          {item.weapon}
        </Typography>
        <Typography variant="body2" component="div" sx={{ fontWeight: 'bold' }}>
          {item.isStatTrak && (
            <Box component="span" sx={{ color: 'orange.main', mr: 0.5 }}>
              StatTrak™
            </Box>
          )}
          {item.name}
          {item.wear !== undefined && (
            <Typography variant="caption" color="text.secondary" sx={{ ml: 0.5 }}>
              ({wearLabel})
            </Typography>
          )}
        </Typography>
        
        {item.nameTag && (
          <Typography variant="caption" color="text.secondary" sx={{ display: 'block', mt: 0.5 }}>
            "{item.nameTag}"
          </Typography>
        )}
        
        <Box sx={{ mt: 1.5 }}>
          <Typography variant="body2" component="div" sx={{ fontWeight: 'bold' }}>
            {formatCurrency(item.price)}
          </Typography>
        </Box>
      </CardContent>
    </Card>
  );
};

// Helper function to get wear label from float value
function getWearLabel(wear?: number): string {
  if (wear === undefined) return '';
  if (wear < 0.07) return 'Factory New';
  if (wear < 0.15) return 'Minimal Wear';
  if (wear < 0.38) return 'Field-Tested';
  if (wear < 0.45) return 'Well-Worn';
  return 'Battle-Scarred';
}

export default InventoryItemCard;
```

### Item Detail Modal

```tsx
import React from 'react';
import { 
  Dialog, 
  DialogTitle, 
  DialogContent, 
  IconButton, 
  Box, 
  Typography, 
  Button, 
  Grid, 
  Divider, 
  Chip, 
  Tooltip 
} from '@mui/material';
import CloseIcon from '@mui/icons-material/Close';
import OpenInNewIcon from '@mui/icons-material/OpenInNew';
import { SteamInventoryItem } from 'models/CS2Gun.model';
import { formatCurrency } from 'utils/formatters';

interface ItemDetailModalProps {
  open: boolean;
  onClose: () => void;
  item: SteamInventoryItem | null;
  onSell?: (item: SteamInventoryItem) => void;
}

const ItemDetailModal: React.FC<ItemDetailModalProps> = ({ 
  open, 
  onClose, 
  item, 
  onSell 
}) => {
  if (!item) return null;
  
  const wearLabel = getWearLabel(item.wear);
  
  return (
    <Dialog
      open={open}
      onClose={onClose}
      maxWidth="md"
      fullWidth
    >
      <DialogTitle>
        <Box display="flex" justifyContent="space-between" alignItems="center">
          <Typography variant="h6">
            {item.isStatTrak && (
              <Box component="span" sx={{ color: 'orange.main', mr: 0.5 }}>
                StatTrak™
              </Box>
            )}
            {item.name}
          </Typography>
          <IconButton onClick={onClose} size="small">
            <CloseIcon />
          </IconButton>
        </Box>
      </DialogTitle>
      
      <DialogContent>
        <Grid container spacing={3}>
          <Grid item xs={12} md={6}>
            <img 
              src={item.imageUrl} 
              alt={item.name}
              style={{ width: '100%', height: 'auto', maxHeight: '300px', objectFit: 'contain' }}
            />
          </Grid>
          
          <Grid item xs={12} md={6}>
            <Typography variant="h6" gutterBottom>
              {formatCurrency(item.price)}
            </Typography>
            
            <Box my={2}>
              <Typography variant="body2" color="text.secondary">
                Asset ID: {item.assetId}
              </Typography>
              {item.wear !== undefined && (
                <Typography variant="body2" color="text.secondary">
                  Wear: {item.wear.toFixed(4)} ({wearLabel})
                </Typography>
              )}
              {item.patternId && (
                <Typography variant="body2" color="text.secondary">
                  Pattern ID: {item.patternId}
                </Typography>
              )}
            </Box>
            
            <Box mb={2} display="flex" gap={1} flexWrap="wrap">
              {item.tradable ? (
                <Chip label="Tradable" color="success" size="small" />
              ) : (
                <Chip label="Not Tradable" color="error" size="small" />
              )}
              
              {item.marketable ? (
                <Chip label="Marketable" color="success" size="small" />
              ) : (
                <Chip label="Not Marketable" color="error" size="small" />
              )}
              
              {item.isStatTrak && (
                <Chip label="StatTrak™" color="warning" size="small" />
              )}
            </Box>
            
            {item.stickers && item.stickers.length > 0 && (
              <Box mb={2}>
                <Typography variant="subtitle2" gutterBottom>
                  Stickers:
                </Typography>
                <Box display="flex" gap={1} flexWrap="wrap">
                  {item.stickers.map((sticker, index) => (
                    <Tooltip key={index} title={sticker.name}>
                      <Box 
                        component="img" 
                        src={sticker.image} 
                        alt={sticker.name}
                        sx={{ width: 40, height: 40 }}
                      />
                    </Tooltip>
                  ))}
                </Box>
              </Box>
            )}
            
            <Divider sx={{ my: 2 }} />
            
            <Box display="flex" gap={2} mt={2}>
              {item.tradable && onSell && (
                <Button 
                  variant="contained" 
                  color="primary"
                  onClick={() => onSell(item)}
                  fullWidth
                >
                  Sell Item
                </Button>
              )}
              
              {item.inspectLink && (
                <Button
                  variant="outlined"
                  endIcon={<OpenInNewIcon />}
                  onClick={() => window.open(item.inspectLink, '_blank')}
                  fullWidth
                >
                  Inspect in Game
                </Button>
              )}
            </Box>
          </Grid>
        </Grid>
      </DialogContent>
    </Dialog>
  );
};

// Helper function to get wear label from float value
function getWearLabel(wear?: number): string {
  if (wear === undefined) return '';
  if (wear < 0.07) return 'Factory New';
  if (wear < 0.15) return 'Minimal Wear';
  if (wear < 0.38) return 'Field-Tested';
  if (wear < 0.45) return 'Well-Worn';
  return 'Battle-Scarred';
}

export default ItemDetailModal;
```

## Inventory Hooks

```tsx
import { useState, useEffect, useCallback } from 'react';
import { cs2SalesAPI } from 'api/cs2-sales';
import { SteamInventoryItem } from 'models/CS2Gun.model';
import { useAuth } from 'hooks/useAuth';
import { ConsolidatedLogger } from 'utils/consolidated-logger';

export const useSteamInventory = () => {
  const [inventory, setInventory] = useState<SteamInventoryItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const { isAuthenticated } = useAuth();
  
  const loadInventory = useCallback(async (refresh = false) => {
    if (!isAuthenticated) {
      setError('Authentication required');
      setLoading(false);
      return;
    }
    
    try {
      setLoading(true);
      setError(null);
      
      const items = refresh 
        ? await cs2SalesAPI.refreshSteamInventory()
        : await cs2SalesAPI.getSteamInventory();
        
      setInventory(items);
      
      ConsolidatedLogger.logCS2(
        `Loaded ${items.length} inventory items`,
        'INFO',
        { source: 'useSteamInventory', refresh }
      );
    } catch (error) {
      ConsolidatedLogger.logCS2Error(
        error instanceof Error ? error : new Error(String(error)),
        'useSteamInventory.loadInventory'
      );
      setError('Failed to load inventory');
    } finally {
      setLoading(false);
    }
  }, [isAuthenticated]);
  
  useEffect(() => {
    if (isAuthenticated) {
      loadInventory();
    }
  }, [isAuthenticated, loadInventory]);
  
  const refreshInventory = useCallback(() => {
    return loadInventory(true);
  }, [loadInventory]);
  
  return {
    inventory,
    loading,
    error,
    refreshInventory,
    isAuthenticated
  };
};
```

## Filtering and Sorting Components

```tsx
import React, { useState } from 'react';
import { Box, TextField, Select, MenuItem, FormControl, InputLabel, SelectChangeEvent } from '@mui/material';
import { SteamInventoryItem } from 'models/CS2Gun.model';

interface InventoryFiltersProps {
  onFilterChange: (filteredItems: SteamInventoryItem[]) => void;
  items: SteamInventoryItem[];
}

const InventoryFilters: React.FC<InventoryFiltersProps> = ({ onFilterChange, items }) => {
  const [searchQuery, setSearchQuery] = useState('');
  const [sortBy, setSortBy] = useState('name');
  const [filterBy, setFilterBy] = useState('all');
  
  // Apply filters and sorting
  const applyFilters = () => {
    let filtered = [...items];
    
    // Apply search filter
    if (searchQuery) {
      const query = searchQuery.toLowerCase();
      filtered = filtered.filter(item => 
        item.name.toLowerCase().includes(query) || 
        item.weapon.toLowerCase().includes(query)
      );
    }
    
    // Apply category filter
    if (filterBy !== 'all') {
      switch (filterBy) {
        case 'tradable':
          filtered = filtered.filter(item => item.tradable);
          break;
        case 'non-tradable':
          filtered = filtered.filter(item => !item.tradable);
          break;
        case 'statTrak':
          filtered = filtered.filter(item => item.isStatTrak);
          break;
        case 'knife':
          filtered = filtered.filter(item => item.category === 'Knife');
          break;
        case 'pistol':
          filtered = filtered.filter(item => item.category === 'Pistol');
          break;
        case 'rifle':
          filtered = filtered.filter(item => item.category === 'Rifle');
          break;
        // Add more filters as needed
      }
    }
    
    // Apply sorting
    filtered.sort((a, b) => {
      switch (sortBy) {
        case 'price-asc':
          return (a.price || 0) - (b.price || 0);
        case 'price-desc':
          return (b.price || 0) - (a.price || 0);
        case 'name':
          return a.name.localeCompare(b.name);
        case 'wear':
          return (a.wear || 1) - (b.wear || 1);
        default:
          return 0;
      }
    });
    
    onFilterChange(filtered);
  };
  
  // Handle filter changes
  const handleSearchChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setSearchQuery(event.target.value);
    setTimeout(applyFilters, 300);
  };
  
  const handleSortChange = (event: SelectChangeEvent) => {
    setSortBy(event.target.value);
    setTimeout(applyFilters, 100);
  };
  
  const handleFilterChange = (event: SelectChangeEvent) => {
    setFilterBy(event.target.value);
    setTimeout(applyFilters, 100);
  };
  
  return (
    <Box sx={{ display: 'flex', gap: 2, mb: 3, flexWrap: 'wrap' }}>
      <TextField
        label="Search"
        variant="outlined"
        size="small"
        value={searchQuery}
        onChange={handleSearchChange}
        sx={{ flexGrow: 1 }}
      />
      
      <FormControl size="small" sx={{ minWidth: 120 }}>
        <InputLabel>Filter By</InputLabel>
        <Select
          value={filterBy}
          label="Filter By"
          onChange={handleFilterChange}
        >
          <MenuItem value="all">All Items</MenuItem>
          <MenuItem value="tradable">Tradable</MenuItem>
          <MenuItem value="non-tradable">Non-Tradable</MenuItem>
          <MenuItem value="statTrak">StatTrak™</MenuItem>
          <MenuItem value="knife">Knives</MenuItem>
          <MenuItem value="pistol">Pistols</MenuItem>
          <MenuItem value="rifle">Rifles</MenuItem>
        </Select>
      </FormControl>
      
      <FormControl size="small" sx={{ minWidth: 120 }}>
        <InputLabel>Sort By</InputLabel>
        <Select
          value={sortBy}
          label="Sort By"
          onChange={handleSortChange}
        >
          <MenuItem value="name">Name</MenuItem>
          <MenuItem value="price-asc">Price ↑</MenuItem>
          <MenuItem value="price-desc">Price ↓</MenuItem>
          <MenuItem value="wear">Wear</MenuItem>
        </Select>
      </FormControl>
    </Box>
  );
};

export default InventoryFilters;
```

## Error Handling Patterns

1. **Inventory Loading Failures**:
   - Implement retry mechanisms for transient failures
   - Show user-friendly error messages
   - Provide refresh button for manual retry
   - Fallback to cached inventory data when available

2. **Empty Inventory Handling**:
   - Display appropriate empty state UI
   - Check for privacy settings that might be blocking inventory access
   - Provide guidance on making inventory public if needed
   - Consider potential trade restrictions

3. **Steam API Rate Limiting**:
   - Implement exponential backoff for retries
   - Cache inventory data to reduce API calls
   - Show meaningful error messages during rate limiting
   - Use the SteamWebAPI.com non-blocking inventory access

## Best Practices

1. **Performance Optimization**:
   - Implement virtualized lists for large inventories
   - Use image lazy loading for better performance
   - Optimize render performance with React.memo
   - Implement efficient filtering and sorting

2. **UI/UX Guidelines**:
   - Use consistent item card layouts across the application
   - Implement smooth loading transitions
   - Provide clear visual indicators for trade restrictions
   - Use tooltips for additional information

3. **Inventory Refresh Strategy**:
   - Cache inventory data with appropriate TTL
   - Provide manual refresh option
   - Implement automated refresh on specific actions
   - Maintain inventory state across page navigations

## Cross-References

- **Authentication**: See `knowledge/front-end/steam-web-api/authentication.md`
- **CS2 Models**: See `knowledge/front-end/steam-web-api/cs2-models.md`
- **Trading UI**: See `knowledge/front-end/steam-web-api/trading.md`
- **Market Data**: See `knowledge/front-end/steam-web-api/market-data.md` 