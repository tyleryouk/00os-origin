# workflow: front-end-workflow | pathway: steam-web-api | message-command: dev-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/front-end/dev-mode/steam-web-api.md

## Parameter Purpose

This parameter provides specialized implementation guidance for Steam Web API integration in front-end components while in Developer Mode.

## Knowledge Access

For detailed implementation guidance, access the following knowledge components:

```typescript
fetch_rules(["knowledge/front-end/steam-web-api/authentication"], 
           "Understanding Steam authentication implementation")

fetch_rules(["knowledge/front-end/steam-web-api/inventory"], 
           "Understanding Steam inventory integration")

fetch_rules(["knowledge/front-end/steam-web-api/market-data"], 
           "Understanding Steam market data visualization")

fetch_rules(["knowledge/front-end/steam-web-api/trading"], 
           "Understanding Steam trading implementation")
```

## Implementation Guidance

### Authentication Implementation

1. **Add Steam Authentication Service**:
   ```typescript
   edit_file("front-end/src/api/auth.ts",
             "Add Steam authentication service",
             "// ... existing code ...\n\n// Steam authentication methods\nexport const steamAuth = {\n  login: async () => {\n    try {\n      ConsolidatedLogger.log('INFO', 'AUTH', 'Redirecting to Steam login');\n      window.location.href = '/api/auth/steam';\n    } catch (error) {\n      ConsolidatedLogger.logError(\n        error instanceof Error ? error : new Error(String(error)),\n        'steamAuth.login'\n      );\n      throw error;\n    }\n  },\n  \n  getStatus: async () => {\n    try {\n      const response = await authAPI.get('/auth/steam/status');\n      return response.data;\n    } catch (error) {\n      ConsolidatedLogger.logError(\n        error instanceof Error ? error : new Error(String(error)),\n        'steamAuth.getStatus'\n      );\n      return { authenticated: false };\n    }\n  },\n  \n  logout: async () => {\n    try {\n      await authAPI.post('/auth/steam/logout');\n      return true;\n    } catch (error) {\n      ConsolidatedLogger.logError(\n        error instanceof Error ? error : new Error(String(error)),\n        'steamAuth.logout'\n      );\n      return false;\n    }\n  }\n};\n\n// ... existing code ...")
   ```

2. **Create Steam User Model**:
   ```typescript
   edit_file("front-end/src/models/SteamUser.model.ts",
             "Create Steam User model",
             "export interface SteamUser {\n  steamId: string;\n  displayName: string;\n  avatarUrl: string;\n  profileUrl: string;\n  tradeUrl?: string;\n  inventoryPrivacy: 'private' | 'friends' | 'public';\n}")
   ```

3. **Implement Steam Authentication Hook**:
   ```typescript
   edit_file("front-end/src/hooks/useSteamAuth.ts",
             "Create Steam authentication hook",
             "import { useState, useEffect } from 'react';\nimport { steamAuth } from 'api/auth';\nimport { SteamUser } from 'models/SteamUser.model';\nimport { ConsolidatedLogger } from 'utils/consolidated-logger';\n\nexport const useSteamAuth = () => {\n  const [user, setUser] = useState<SteamUser | null>(null);\n  const [loading, setLoading] = useState(true);\n  \n  useEffect(() => {\n    const checkAuth = async () => {\n      try {\n        setLoading(true);\n        const authStatus = await steamAuth.getStatus();\n        \n        if (authStatus.authenticated) {\n          setUser(authStatus.user);\n          ConsolidatedLogger.log('INFO', 'AUTH', 'Steam authentication successful', { \n            steamId: authStatus.user.steamId \n          });\n        }\n      } catch (error) {\n        ConsolidatedLogger.logError(\n          error instanceof Error ? error : new Error(String(error)),\n          'useSteamAuth.checkAuth'\n        );\n      }\n    };\n    \n    checkAuth();\n  }, []);\n  \n  const logout = async () => {\n    try {\n      await steamAuth.logout();\n      setUser(null);\n      ConsolidatedLogger.log('INFO', 'AUTH', 'Steam logout successful');\n    } catch (error) {\n      ConsolidatedLogger.logError(\n        error instanceof Error ? error : new Error(String(error)),\n        'useSteamAuth.logout'\n      );\n    }\n  };\n  \n  return { \n    user, \n    loading, \n    isAuthenticated: !!user,\n    logout\n  };\n};")
   ```

4. **Create Steam Login Button Component**:
   ```typescript
   edit_file("front-end/src/components/auth/SteamLoginButton.tsx",
             "Create Steam login button component",
             "import React from 'react';\nimport Button from '@mui/material/Button';\nimport SteamIcon from 'components/icons/SteamIcon';\nimport { steamAuth } from 'api/auth';\nimport { ConsolidatedLogger } from 'utils/consolidated-logger';\n\nconst SteamLoginButton: React.FC = () => {\n  const handleLogin = () => {\n    ConsolidatedLogger.log('INFO', 'AUTH', 'Steam login initiated');\n    steamAuth.login();\n  };\n  \n  return (\n    <Button\n      variant=\"contained\"\n      startIcon={<SteamIcon />}\n      onClick={handleLogin}\n      sx={{ backgroundColor: '#171a21', '&:hover': { backgroundColor: '#2a475e' } }}\n    >\n      Login with Steam\n    </Button>\n  );\n};\n\nexport default SteamLoginButton;")
   ```

### Inventory Integration

1. **Extend CS2Gun Model**:
   ```typescript
   edit_file("front-end/src/models/CS2Gun.model.ts",
             "Extend CS2Gun model with Steam inventory properties",
             "// ... existing code ...\n\nexport interface SteamInventoryItem extends CS2Gun {\n  assetId: string;        // Steam inventory asset ID\n  marketable: boolean;    // Whether item can be listed on market\n  tradable: boolean;      // Whether item can be traded\n  tradeHoldDuration?: number; // Trade hold duration in days\n  inspectLink?: string;   // Steam inspect link\n  wear?: number;          // Float value (0-1) representing weapon wear\n  patternId?: number;     // Pattern template ID\n  stickers?: SteamSticker[]; // Applied stickers\n  isStatTrak?: boolean;   // Whether the weapon tracks kills\n  nameTag?: string;       // Custom name tag if applied\n}\n\nexport interface SteamSticker {\n  name: string;           // Sticker name\n  image: string;          // Sticker image URL\n  slot: number;           // Position (0-3)\n  wear?: number;          // Sticker wear (0-1)\n}\n\n// ... existing code ...")
   ```

2. **Add Steam Inventory API Methods**:
   ```typescript
   edit_file("front-end/src/api/cs2-sales.ts",
             "Add Steam inventory methods to cs2SalesAPI",
             "// ... existing code ...\n\n  /**\n   * Get user's Steam inventory\n   * @returns Promise with inventory items\n   */\n  getSteamInventory: cache(async (): Promise<SteamInventoryItem[]> => {\n    try {\n      // Log the inventory loading operation\n      ConsolidatedLogger.logCS2('Loading Steam inventory', 'INFO', { source: 'getSteamInventory' });\n      \n      // Fetch inventory from API\n      const response = await apiClient.get('/inventory/steam');\n      \n      // Map API response to SteamInventoryItem\n      const inventory = response.data.map((item: any) => ({\n        ...item,\n        // Ensure all required properties are present\n        id: item.id || item.assetId,\n        assetId: item.assetId,\n        marketable: !!item.marketable,\n        tradable: !!item.tradable,\n        // Add any additional processing needed\n      }));\n      \n      return inventory;\n    } catch (error) {\n      // Log any errors\n      ConsolidatedLogger.logCS2Error(\n        error instanceof Error ? error : new Error(String(error)),\n        'getSteamInventory'\n      );\n      \n      // Return fallback data in case of error\n      return [];\n    }\n  }, {\n    // Cache for 2 minutes\n    ttl: 2 * 60 * 1000,\n    // Cache key based on user ID\n    cacheKeyFn: () => `steam-inventory-${localStorage.getItem('userId') || 'anonymous'}`\n  }),\n\n  /**\n   * Refresh Steam inventory (bypass cache)\n   * @returns Promise with inventory items\n   */\n  refreshSteamInventory: async (): Promise<SteamInventoryItem[]> => {\n    try {\n      ConsolidatedLogger.logCS2('Refreshing Steam inventory', 'INFO', { source: 'refreshSteamInventory' });\n      \n      // Fetch inventory with refresh flag\n      const response = await apiClient.get('/inventory/steam?refresh=true');\n      \n      // Map API response to SteamInventoryItem\n      const inventory = response.data.map((item: any) => ({\n        ...item,\n        // Ensure all required properties are present\n        id: item.id || item.assetId,\n        assetId: item.assetId,\n        marketable: !!item.marketable,\n        tradable: !!item.tradable,\n      }));\n      \n      return inventory;\n    } catch (error) {\n      ConsolidatedLogger.logCS2Error(\n        error instanceof Error ? error : new Error(String(error)),\n        'refreshSteamInventory'\n      );\n      \n      return [];\n    }\n  },\n\n// ... existing code ...")
   ```

3. **Create Steam Inventory Hook**:
   ```typescript
   edit_file("front-end/src/hooks/useSteamInventory.ts",
             "Create Steam inventory hook",
             "import { useState, useEffect, useCallback } from 'react';\nimport { cs2SalesAPI } from 'api/cs2-sales';\nimport { SteamInventoryItem } from 'models/CS2Gun.model';\nimport { useAuth } from 'hooks/useAuth';\nimport { ConsolidatedLogger } from 'utils/consolidated-logger';\n\nexport const useSteamInventory = () => {\n  const [inventory, setInventory] = useState<SteamInventoryItem[]>([]);\n  const [loading, setLoading] = useState(true);\n  const [error, setError] = useState<string | null>(null);\n  const { isAuthenticated } = useAuth();\n  \n  const loadInventory = useCallback(async (refresh = false) => {\n    if (!isAuthenticated) {\n      setError('Authentication required');\n      setLoading(false);\n      return;\n    }\n    \n    try {\n      setLoading(true);\n      setError(null);\n      \n      const items = refresh \n        ? await cs2SalesAPI.refreshSteamInventory()\n        : await cs2SalesAPI.getSteamInventory();\n        \n      setInventory(items);\n      \n      ConsolidatedLogger.logCS2(\n        `Loaded ${items.length} inventory items`,\n        'INFO',\n        { source: 'useSteamInventory', refresh }\n      );\n    } catch (error) {\n      ConsolidatedLogger.logCS2Error(\n        error instanceof Error ? error : new Error(String(error)),\n        'useSteamInventory.loadInventory'\n      );\n      setError('Failed to load inventory');\n    } finally {\n      setLoading(false);\n    }\n  }, [isAuthenticated]);\n  \n  useEffect(() => {\n    if (isAuthenticated) {\n      loadInventory();\n    }\n  }, [isAuthenticated, loadInventory]);\n  \n  const refreshInventory = useCallback(() => {\n    return loadInventory(true);\n  }, [loadInventory]);\n  \n  return {\n    inventory,\n    loading,\n    error,\n    refreshInventory,\n    isAuthenticated\n  };\n};")
   ```

### Implementation Testing

Use the following UX-situation commands to test the implementation:

```typescript
// Test Steam authentication
run_terminal_cmd("Get-Content -Path \"logs-main/front-end/$(Get-Date -Format 'yyyy-MM-dd').log\" -Tail 50", false)

// Verify Steam inventory loading
run_terminal_cmd("Get-Content -Path \"logs-main/back-end/$(Get-Date -Format 'yyyy-MM-dd').log\" -Tail 50", false)
```

## Error Handling

Implement comprehensive error handling for Steam Web API integration:

1. **Authentication Errors**:
   - Log detailed error information using ConsolidatedLogger
   - Provide user-friendly error messages
   - Implement automatic retry for transient failures
   - Fallback to non-authenticated experience

2. **Inventory Loading Failures**:
   - Implement retry mechanisms for transient failures
   - Show user-friendly error messages
   - Provide refresh button for manual retry
   - Fallback to cached inventory data when available

3. **Steam API Rate Limiting**:
   - Implement exponential backoff for retries
   - Cache inventory data to reduce API calls
   - Show meaningful error messages during rate limiting
   - Use the SteamWebAPI.com non-blocking inventory access

## Best Practices

Follow these best practices for Steam Web API integration:

1. **Security Guidelines**:
   - Never store Steam credentials in the front-end
   - Use secure HTTP-only cookies for session persistence
   - Implement proper CSRF protection
   - Use HTTPS for all authentication requests

2. **Performance Optimization**:
   - Minimize authentication redirects
   - Cache user profile and inventory data appropriately
   - Lazy-load authentication components
   - Implement proper loading states

3. **UX Considerations**:
   - Provide clear loading indicators during authentication and inventory loading
   - Support deep linking with authentication redirection
   - Preserve pre-authentication state
   - Implement smooth transitions between authenticated states 