# USE WHEN implementing Steam authentication in front-end components

## Overview

This knowledge file provides implementation guidance for integrating Steam authentication into the GigaSwap marketplace front-end components. It covers the authentication flow, component design, state management, and best practices for handling Steam user sessions.

## Authentication Flow

The Steam authentication flow follows these steps:

1. **Redirect to Steam**: User clicks a "Login with Steam" button which redirects to Steam's OpenID provider
2. **Steam Authentication**: User authenticates on Steam's website
3. **Return to Application**: Steam redirects back to our application with authentication data
4. **Session Creation**: Back-end processes the authentication and establishes a session
5. **State Management**: Front-end updates UI based on the authenticated state

## Implementation Components

### Steam Login Button

```tsx
import React from 'react';
import Button from '@mui/material/Button';
import SteamIcon from 'components/icons/SteamIcon';
import { steamAuth } from 'api/auth';
import { ConsolidatedLogger } from 'utils/consolidated-logger';

const SteamLoginButton: React.FC = () => {
  const handleLogin = () => {
    ConsolidatedLogger.log('INFO', 'AUTH', 'Steam login initiated');
    steamAuth.login();
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

### Steam Authentication Hook

```tsx
import { useState, useEffect } from 'react';
import { steamAuth } from 'api/auth';
import { SteamUser } from 'models/SteamUser.model';
import { ConsolidatedLogger } from 'utils/consolidated-logger';

export const useSteamAuth = () => {
  const [user, setUser] = useState<SteamUser | null>(null);
  const [loading, setLoading] = useState(true);
  
  useEffect(() => {
    const checkAuth = async () => {
      try {
        setLoading(true);
        const authStatus = await steamAuth.getStatus();
        
        if (authStatus.authenticated) {
          setUser(authStatus.user);
          ConsolidatedLogger.log('INFO', 'AUTH', 'Steam authentication successful', { 
            steamId: authStatus.user.steamId 
          });
        }
      } catch (error) {
        ConsolidatedLogger.logError(
          error instanceof Error ? error : new Error(String(error)),
          'useSteamAuth.checkAuth'
        );
      } finally {
        setLoading(false);
      }
    };
    
    checkAuth();
  }, []);
  
  const logout = async () => {
    try {
      await steamAuth.logout();
      setUser(null);
      ConsolidatedLogger.log('INFO', 'AUTH', 'Steam logout successful');
    } catch (error) {
      ConsolidatedLogger.logError(
        error instanceof Error ? error : new Error(String(error)),
        'useSteamAuth.logout'
      );
    }
  };
  
  return { 
    user, 
    loading, 
    isAuthenticated: !!user,
    logout
  };
};
```

### Steam Authentication API Service

```tsx
// Add to api/auth.ts
export const steamAuth = {
  login: async () => {
    try {
      ConsolidatedLogger.log('INFO', 'AUTH', 'Redirecting to Steam login');
      window.location.href = '/api/auth/steam';
    } catch (error) {
      ConsolidatedLogger.logError(
        error instanceof Error ? error : new Error(String(error)),
        'steamAuth.login'
      );
      throw error;
    }
  },
  
  getStatus: async () => {
    try {
      const response = await authAPI.get('/auth/steam/status');
      return response.data;
    } catch (error) {
      ConsolidatedLogger.logError(
        error instanceof Error ? error : new Error(String(error)),
        'steamAuth.getStatus'
      );
      return { authenticated: false };
    }
  },
  
  logout: async () => {
    try {
      await authAPI.post('/auth/steam/logout');
      return true;
    } catch (error) {
      ConsolidatedLogger.logError(
        error instanceof Error ? error : new Error(String(error)),
        'steamAuth.logout'
      );
      return false;
    }
  }
};
```

### Steam User Profile Component

```tsx
import React from 'react';
import { Box, Avatar, Typography, Menu, MenuItem, IconButton } from '@mui/material';
import { KeyboardArrowDown } from '@mui/icons-material';
import { useSteamAuth } from 'hooks/useSteamAuth';

const SteamUserProfile: React.FC = () => {
  const { user, logout } = useSteamAuth();
  const [anchorEl, setAnchorEl] = React.useState<null | HTMLElement>(null);
  
  const handleMenuOpen = (event: React.MouseEvent<HTMLElement>) => {
    setAnchorEl(event.currentTarget);
  };
  
  const handleMenuClose = () => {
    setAnchorEl(null);
  };
  
  const handleLogout = () => {
    logout();
    handleMenuClose();
  };
  
  if (!user) return null;
  
  return (
    <Box sx={{ display: 'flex', alignItems: 'center' }}>
      <Avatar src={user.avatarUrl} alt={user.displayName} />
      <Box sx={{ ml: 1, display: { xs: 'none', md: 'block' } }}>
        <Typography variant="subtitle2">{user.displayName}</Typography>
      </Box>
      <IconButton onClick={handleMenuOpen} size="small">
        <KeyboardArrowDown />
      </IconButton>
      
      <Menu
        anchorEl={anchorEl}
        open={Boolean(anchorEl)}
        onClose={handleMenuClose}
      >
        <MenuItem onClick={handleMenuClose}>Profile</MenuItem>
        <MenuItem onClick={handleMenuClose}>Inventory</MenuItem>
        <MenuItem onClick={handleMenuClose}>Trades</MenuItem>
        <MenuItem onClick={handleLogout}>Logout</MenuItem>
      </Menu>
    </Box>
  );
};

export default SteamUserProfile;
```

## Steam User Model

```tsx
// models/SteamUser.model.ts
export interface SteamUser {
  steamId: string;
  displayName: string;
  avatarUrl: string;
  profileUrl: string;
  tradeUrl?: string;
  inventoryPrivacy: 'private' | 'friends' | 'public';
}
```

## Authentication Context Provider

```tsx
import React, { createContext, useContext, ReactNode } from 'react';
import { useSteamAuth } from 'hooks/useSteamAuth';
import { SteamUser } from 'models/SteamUser.model';

interface AuthContextType {
  user: SteamUser | null;
  loading: boolean;
  isAuthenticated: boolean;
  logout: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const auth = useSteamAuth();
  
  return (
    <AuthContext.Provider value={auth}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};
```

## Error Handling Patterns

1. **Authentication Failures**:
   - Log detailed error information
   - Provide user-friendly error messages
   - Implement automatic retry for transient failures
   - Fallback to non-authenticated experience

2. **Session Expiration**:
   - Detect expired sessions
   - Prompt for re-authentication
   - Preserve user state when possible
   - Handle graceful session recovery

3. **Network Issues**:
   - Implement offline detection
   - Queue authentication requests
   - Provide clear status updates
   - Resume authentication flow when connection restores

## Best Practices

1. **Security Guidelines**:
   - Never store Steam credentials in the front-end
   - Use secure HTTP-only cookies for session persistence
   - Implement proper CSRF protection
   - Use HTTPS for all authentication requests

2. **Performance Optimization**:
   - Minimize authentication redirects
   - Cache user profile data appropriately
   - Lazy-load authentication components
   - Implement proper loading states

3. **UX Considerations**:
   - Provide clear loading indicators during authentication
   - Support deep linking with authentication redirection
   - Preserve pre-authentication state
   - Implement smooth transitions between authenticated states

## Cross-References

- **Inventory Management**: See `knowledge/front-end/steam-web-api/inventory.md`
- **API Integration**: See `knowledge/front-end/steam-web-api/api-integration.md`
- **Back-End Authentication**: See `knowledge/back-end/steam-web-api/authentication.md`
- **State Management**: See `knowledge/front-end/steam-web-api/state-management.md` 