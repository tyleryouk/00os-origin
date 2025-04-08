# workflow: front-end-workflow | pathway: steam-web-api | message-command: direct-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/front-end/direct-mode/steam-web-api.md

## Parameter Purpose

This parameter provides specialized implementation guidance for Steam Web API integration in front-end components while in Direct Mode.

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

## Direct Implementation Pattern

In Direct Mode, follow these research-first steps before implementation:

1. **Research Phase** (minimum 20 tool calls):
   - Analyze existing CS2 models
   - Examine authentication implementation
   - Investigate UI component patterns
   - Understand API integration patterns
   - Identify error handling strategies
   - Research caching mechanisms

2. **Implementation Phase**:
   - Follow existing patterns strictly
   - Implement components incrementally
   - Test at each implementation stage
   - Document through code comments
   - Ensure proper error handling

## Component Implementation Guide

### Authentication Implementation

```typescript
// Step 1: Add Steam authentication methods to auth.ts
edit_file("front-end/src/api/auth.ts",
          "Add Steam authentication service",
          "// ... existing code ...\n\n// Steam authentication methods\nexport const steamAuth = {\n  login: async () => {\n    try {\n      ConsolidatedLogger.log('INFO', 'AUTH', 'Redirecting to Steam login');\n      window.location.href = '/api/auth/steam';\n    } catch (error) {\n      ConsolidatedLogger.logError(\n        error instanceof Error ? error : new Error(String(error)),\n        'steamAuth.login'\n      );\n      throw error;\n    }\n  },\n  \n  getStatus: async () => {\n    try {\n      const response = await authAPI.get('/auth/steam/status');\n      return response.data;\n    } catch (error) {\n      ConsolidatedLogger.logError(\n        error instanceof Error ? error : new Error(String(error)),\n        'steamAuth.getStatus'\n      );\n      return { authenticated: false };\n    }\n  },\n  \n  logout: async () => {\n    try {\n      await authAPI.post('/auth/steam/logout');\n      return true;\n    } catch (error) {\n      ConsolidatedLogger.logError(\n        error instanceof Error ? error : new Error(String(error)),\n        'steamAuth.logout'\n      );\n      return false;\n    }\n  }\n};\n\n// ... existing code ...")

// Step 2: Create Steam User model
edit_file("front-end/src/models/SteamUser.model.ts",
          "Create Steam User model",
          "export interface SteamUser {\n  steamId: string;\n  displayName: string;\n  avatarUrl: string;\n  profileUrl: string;\n  tradeUrl?: string;\n  inventoryPrivacy: 'private' | 'friends' | 'public';\n}")

// Step 3: Create authentication hook
edit_file("front-end/src/hooks/useSteamAuth.ts",
          "Create Steam authentication hook",
          "import { useState, useEffect } from 'react';\nimport { steamAuth } from 'api/auth';\nimport { SteamUser } from 'models/SteamUser.model';\nimport { ConsolidatedLogger } from 'utils/consolidated-logger';\n\nexport const useSteamAuth = () => {\n  const [user, setUser] = useState<SteamUser | null>(null);\n  const [loading, setLoading] = useState(true);\n  \n  useEffect(() => {\n    const checkAuth = async () => {\n      try {\n        setLoading(true);\n        const authStatus = await steamAuth.getStatus();\n        \n        if (authStatus.authenticated) {\n          setUser(authStatus.user);\n          ConsolidatedLogger.log('INFO', 'AUTH', 'Steam authentication successful', { \n            steamId: authStatus.user.steamId \n          });\n        }\n      } catch (error) {\n        ConsolidatedLogger.logError(\n          error instanceof Error ? error : new Error(String(error)),\n          'useSteamAuth.checkAuth'\n        );\n      } finally {\n        setLoading(false);\n      }\n    };\n    \n    checkAuth();\n  }, []);\n  \n  const logout = async () => {\n    try {\n      await steamAuth.logout();\n      setUser(null);\n      ConsolidatedLogger.log('INFO', 'AUTH', 'Steam logout successful');\n    } catch (error) {\n      ConsolidatedLogger.logError(\n        error instanceof Error ? error : new Error(String(error)),\n        'useSteamAuth.logout'\n      );\n    }\n  };\n  \n  return { \n    user, \n    loading, \n    isAuthenticated: !!user,\n    logout\n  };\n};")

// Step 4: Create login button component
edit_file("front-end/src/components/auth/SteamLoginButton.tsx",
          "Create Steam login button component",
          "import React from 'react';\nimport Button from '@mui/material/Button';\nimport SteamIcon from 'components/icons/SteamIcon';\nimport { steamAuth } from 'api/auth';\nimport { ConsolidatedLogger } from 'utils/consolidated-logger';\n\nconst SteamLoginButton: React.FC = () => {\n  const handleLogin = () => {\n    ConsolidatedLogger.log('INFO', 'AUTH', 'Steam login initiated');\n    steamAuth.login();\n  };\n  \n  return (\n    <Button\n      variant=\"contained\"\n      startIcon={<SteamIcon />}\n      onClick={handleLogin}\n      sx={{ backgroundColor: '#171a21', '&:hover': { backgroundColor: '#2a475e' } }}\n    >\n      Login with Steam\n    </Button>\n  );\n};\n\nexport default SteamLoginButton;")
```

### Inventory Implementation

```typescript
// Step 1: Extend CS2Gun model with Steam inventory properties
edit_file("front-end/src/models/CS2Gun.model.ts",
          "Extend CS2Gun model with Steam inventory properties",
          "// ... existing code ...\n\nexport interface SteamInventoryItem extends CS2Gun {\n  assetId: string;        // Steam inventory asset ID\n  marketable: boolean;    // Whether item can be listed on market\n  tradable: boolean;      // Whether item can be traded\n  tradeHoldDuration?: number; // Trade hold duration in days\n  inspectLink?: string;   // Steam inspect link\n  wear?: number;          // Float value (0-1) representing weapon wear\n  patternId?: number;     // Pattern template ID\n  stickers?: SteamSticker[]; // Applied stickers\n  isStatTrak?: boolean;   // Whether the weapon tracks kills\n  nameTag?: string;       // Custom name tag if applied\n}\n\nexport interface SteamSticker {\n  name: string;           // Sticker name\n  image: string;          // Sticker image URL\n  slot: number;           // Position (0-3)\n  wear?: number;          // Sticker wear (0-1)\n}\n\n// ... existing code ...")

// Step 2: Add Steam inventory methods to cs2SalesAPI
edit_file("front-end/src/api/cs2-sales.ts",
          "Add Steam inventory methods to cs2SalesAPI",
          "// ... existing code ...\n\n  /**\n   * Get user's Steam inventory\n   * @returns Promise with inventory items\n   */\n  getSteamInventory: cache(async (): Promise<SteamInventoryItem[]> => {\n    try {\n      // Log the inventory loading operation\n      ConsolidatedLogger.logCS2('Loading Steam inventory', 'INFO', { source: 'getSteamInventory' });\n      \n      // Fetch inventory from API\n      const response = await apiClient.get('/inventory/steam');\n      \n      // Map API response to SteamInventoryItem\n      const inventory = response.data.map((item: any) => ({\n        ...item,\n        // Ensure all required properties are present\n        id: item.id || item.assetId,\n        assetId: item.assetId,\n        marketable: !!item.marketable,\n        tradable: !!item.tradable,\n        // Add any additional processing needed\n      }));\n      \n      return inventory;\n    } catch (error) {\n      // Log any errors\n      ConsolidatedLogger.logCS2Error(\n        error instanceof Error ? error : new Error(String(error)),\n        'getSteamInventory'\n      );\n      \n      // Return fallback data in case of error\n      return [];\n    }\n  }, {\n    // Cache for 2 minutes\n    ttl: 2 * 60 * 1000,\n    // Cache key based on user ID\n    cacheKeyFn: () => `steam-inventory-${localStorage.getItem('userId') || 'anonymous'}`\n  }),\n\n  /**\n   * Refresh Steam inventory (bypass cache)\n   * @returns Promise with inventory items\n   */\n  refreshSteamInventory: async (): Promise<SteamInventoryItem[]> => {\n    try {\n      ConsolidatedLogger.logCS2('Refreshing Steam inventory', 'INFO', { source: 'refreshSteamInventory' });\n      \n      // Fetch inventory with refresh flag\n      const response = await apiClient.get('/inventory/steam?refresh=true');\n      \n      // Map API response to SteamInventoryItem\n      const inventory = response.data.map((item: any) => ({\n        ...item,\n        // Ensure all required properties are present\n        id: item.id || item.assetId,\n        assetId: item.assetId,\n        marketable: !!item.marketable,\n        tradable: !!item.tradable,\n      }));\n      \n      return inventory;\n    } catch (error) {\n      ConsolidatedLogger.logCS2Error(\n        error instanceof Error ? error : new Error(String(error)),\n        'refreshSteamInventory'\n      );\n      \n      return [];\n    }\n  },\n\n// ... existing code ...")
```

## Research Questions

During the research phase, answer these key questions:

1. **Authentication Integration**
   - How is user authentication currently implemented?
   - What API endpoints exist for user management?
   - How are sessions managed in the application?
   - What UI components are used for authentication?

2. **Data Model Research**
   - What properties does the CS2Gun model currently have?
   - What extensions are needed for Steam inventory?
   - How are CS2 items currently rendered?
   - What data transformation is needed?

3. **UI Component Research**
   - What UI component library is being used?
   - What design patterns exist for item display?
   - How are modals and dialogs implemented?
   - What filtering/sorting patterns exist?

4. **API Integration Research**
   - How are API calls organized in the application?
   - What error handling patterns are used?
   - How is caching implemented?
   - What logging mechanisms exist?

## Error Handling Guidelines

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

3. **API Failures**:
   - Implement status code-specific handling
   - Add fallback mechanisms for critical functionality
   - Log detailed error information
   - Show appropriate UI error states

## Testing Guidelines

Use these methods to test your implementation:

1. **Authentication Testing**:
   ```typescript
   run_terminal_cmd("Get-Content -Path \"logs-main/front-end/$(Get-Date -Format 'yyyy-MM-dd').log\" -Tail 50 | Select-String -Pattern 'AUTH'", false)
   ```

2. **Inventory Testing**:
   ```typescript
   run_terminal_cmd("Get-Content -Path \"logs-main/front-end/$(Get-Date -Format 'yyyy-MM-dd').log\" -Tail 50 | Select-String -Pattern 'CS2'", false)
   ```

3. **API Testing**:
   ```typescript
   run_terminal_cmd("Get-Content -Path \"logs-main/back-end/$(Get-Date -Format 'yyyy-MM-dd').log\" -Tail 50", false)
   ``` 