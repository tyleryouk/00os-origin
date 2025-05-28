# Front-End Extension Points

This document describes where and how to add new features, modules, or integrations to the GigaSwap front-end based on the actual codebase structure.

## Adding New Features or Modules

### Components
Create new component directories in `components/` for feature-specific UI:
- **Market Components**: `components/market/` (already exists with category filters)
- **Authentication**: `components/auth/` for wallet connection UI
- **Common UI**: `components/common/` for shared components (ErrorBoundary, Loading, etc.)
- **UI Library**: `components/ui/` for base reusable components

### Models & Types
Implement models in `models/` for new business entities:
- **SteamInventoryItem**: Raw Steam inventory data from steamwebapi.com (in `types/api/steam.ts`)
- **ProcessedInventoryItem**: Processed Steam items for display (in `types/api/steam.ts`)
- **Product.model.ts**: Base product interface used for compatibility with existing components
- **Category.model.ts**: Category model used by marketplace components
- **auth.models.ts**: Authentication and user types
- **api.model.ts**: API response and request types

### API Integration
Add API client functions in `api/` for new endpoints:
- **steam.ts**: Steam API integration (already implemented)
- **client.ts**: Base Axios configuration with interceptors
- **mock-data/**: Development mocking system
- Follow existing patterns for error handling and type safety

### Routing
Create new routes in `app/` for new pages:
- **market/**: Marketplace pages (already implemented)
- **api/**: API route handlers for Next.js
- Use App Router conventions for layouts and loading states

### Custom Hooks
Use the `hooks/` directory for state management:
- **useWalletAuth.ts**: Web3 authentication (already implemented)
- **useOrders.ts**: Order management
- **useProfile.ts**: User profile management
- Follow React hooks conventions and include proper TypeScript types

## Steam Integration Extensions

### Current Steam Implementation
- **steamInventoryAPI**: Fetches CS2 inventory data from Steam
- **Category Mapping**: Maps Steam items to application categories
- **CS2Gun Model**: Extends Product with Steam-specific fields
- **Market Page**: Server-side rendering with real Steam data

### Extension Opportunities
1. **Enhanced Item Data**: Add more Steam API fields to CS2Gun model
2. **User Inventories**: Personal Steam inventory management
3. **Trading System**: Steam item trading functionality
4. **Price Analytics**: Historical pricing and market trends
5. **Item Inspection**: 3D model viewing and detailed item information

## Authentication Extensions

### Current Web3 Implementation
- **useWalletAuth**: Primary authentication hook
- **AuthContext**: Global authentication state
- **RainbowKit**: Wallet connection UI
- **JWT Management**: Token storage and refresh

### Extension Opportunities
1. **Multi-wallet Support**: Support additional wallet providers
2. **Social Login**: Traditional email/password authentication
3. **Profile Management**: Extended user profiles and preferences
4. **Permission System**: Role-based access control

## Logging & Monitoring Extensions

### Current Logging System
- **ConsolidatedLogger**: Centralized logging to `/logs-main`
- **Category-based**: API, AUTH, USER, ORDERS, CS2, MOCK categories
- **Error Boundaries**: React error boundaries with logging

### Extension Opportunities
1. **Analytics Integration**: User behavior tracking
2. **Performance Monitoring**: Core Web Vitals and performance metrics
3. **Error Reporting**: External error reporting services
4. **Real-time Monitoring**: Live application health monitoring

## UI/UX Extensions

### Current UI System
- **Material-UI**: Component library with custom theming
- **Responsive Design**: Mobile-first approach
- **Error Overlay**: Fixed Next.js error visibility
- **Loading States**: Reusable loading components

### Extension Opportunities
1. **Dark Mode**: Theme switching functionality
2. **Accessibility**: Enhanced ARIA support and keyboard navigation
3. **Animations**: Advanced transitions and micro-interactions
4. **Mobile App**: React Native or PWA implementation

## Development Workflow Extensions

### Current Development Setup
- **Next.js 15**: App Router with TypeScript
- **Hot Reloading**: Fast development iteration
- **Mock System**: API mocking for offline development
- **Error Handling**: Screenshot-based error reporting

### Extension Opportunities
1. **Testing Framework**: Unit and integration tests
2. **Storybook**: Component documentation and testing
3. **CI/CD Pipeline**: Automated testing and deployment
4. **Code Quality**: Enhanced linting and formatting rules

## Integration Patterns

### Adding External APIs
1. Create API client in `api/` directory
2. Define TypeScript interfaces in `models/`
3. Implement error handling and logging
4. Add mock data for development
5. Create custom hooks for data fetching

### Adding New Pages
1. Create page component in `app/` directory
2. Implement page-specific components in `pages-sections/`
3. Add navigation links in appropriate components
4. Implement loading and error states
5. Add proper SEO metadata

### Adding New Features
1. Plan component architecture and data flow
2. Create necessary models and types
3. Implement API integration if needed
4. Build UI components with proper error handling
5. Add comprehensive logging for debugging
6. Test with mock data and real APIs

---
This document is updated as extension points evolve. Remove or revise any section not directly relevant to the current cycle. 