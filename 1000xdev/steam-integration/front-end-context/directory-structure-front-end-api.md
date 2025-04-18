# Frontend Directory Structure for Steam API Integration

This document outlines the key directories and files in the GigaSwap frontend codebase that are relevant for Steam Web API integration. Understanding this structure is essential for implementing the marketplace for CS2 skins.

## Root Frontend Structure

```
front-end/
├── .env                      # Environment variables
├── .env.development          # Development environment variables
├── .env.production           # Production environment variables
├── package.json              # Project dependencies and scripts
├── tsconfig.json             # TypeScript configuration
├── next.config.js            # Next.js configuration
├── public/                   # Static assets
└── src/                      # Source code
```

## Source Code Structure

```
src/
├── api/                      # API service layer
│   ├── client.ts             # API client setup and configuration
│   ├── cs2-sales.ts          # CS2 sales-related API endpoints
│   ├── product/              # Product-related API endpoints
│   │   ├── index.ts          # Exports all product API functions
│   │   ├── product.ts        # Product data fetching functions
│   │   └── search.ts         # Product search functionality
│   └── README.md             # API documentation
├── app/                      # Next.js app directory (pages)
│   ├── market/               # Market page and related components
│   │   ├── page.tsx          # Market listing page
│   │   ├── layout.tsx        # Market page layout
│   │   └── [slug]/           # Dynamic product detail routes
│   │       └── page.tsx      # Product detail page
│   └── api/                  # Next.js API routes
├── components/               # Reusable UI components
│   ├── market/               # Market-specific components (currently empty)
│   ├── product-cards/        # Product card components
│   └── ui/                   # UI components
├── contexts/                 # React context providers
│   ├── auth-context.tsx      # Authentication context
│   ├── CartContext.tsx       # Shopping cart context
│   └── Web3Provider.tsx      # Web3 provider for blockchain integration
├── hooks/                    # Custom React hooks
├── models/                   # Data models
│   ├── Product.model.ts      # Product data model
│   ├── User.model.ts         # User data model
│   └── CS2Gun.model.ts       # CS2 gun model
├── types/                    # TypeScript type definitions
│   ├── api/                  # API-related types
│   │   ├── base.ts           # Base API types
│   │   └── common.ts         # Common type definitions
│   └── api-types.ts          # Additional API type definitions
└── utils/                    # Utility functions
    ├── api-config.ts         # API configuration
    ├── axiosInstance.ts      # Axios instance for API requests
    └── constants.ts          # Application constants
```

## Key Areas for Steam API Integration

### API Integration Points

The Steam Web API integration will require adding new files and modifying existing ones:

```
src/api/
├── steam/                    # [NEW] Steam API integration directory
│   ├── index.ts              # [NEW] Exports all Steam API functions
│   ├── items.ts              # [NEW] Steam items API
│   ├── inventory.ts          # [NEW] Steam inventory API
│   ├── trade-offers.ts       # [NEW] Steam trade offers API
│   └── authentication.ts     # [NEW] Steam authentication API
```

### UI Components

New components will need to be created for the Steam marketplace:

```
src/components/
├── market/                   # Market components directory
│   ├── SteamItemCard.tsx     # [NEW] Steam item card component
│   ├── SteamItemGrid.tsx     # [NEW] Grid display for Steam items
│   ├── SteamItemFilter.tsx   # [NEW] Filtering options for Steam items
│   ├── SteamTradeOffer.tsx   # [NEW] Trade offer component
│   └── SteamItemDetail.tsx   # [NEW] Detailed view of Steam item
```

### Data Models

New models will be needed for Steam data:

```
src/models/
├── SteamItem.model.ts        # [NEW] Steam item model
├── SteamInventory.model.ts   # [NEW] Steam inventory model
└── SteamTrade.model.ts       # [NEW] Steam trade model
```

### Types

TypeScript types for Steam API integration:

```
src/types/
├── steam/                    # [NEW] Steam-related types
│   ├── items.ts              # [NEW] Steam items types
│   ├── inventory.ts          # [NEW] Steam inventory types
│   ├── trade.ts              # [NEW] Steam trade types
│   └── auth.ts               # [NEW] Steam authentication types
```

## Implementation Location Guidelines

1. **API Services**: Add new Steam API services in `src/api/steam/`
2. **UI Components**: Create Steam marketplace components in `src/components/market/`
3. **Pages**: Enhance market pages in `src/app/market/`
4. **Data Models**: Define Steam data models in `src/models/`
5. **Types**: Add TypeScript types in `src/types/steam/`
6. **Context**: If needed, create a Steam context provider in `src/contexts/`

## Integration Strategy

Based on the existing codebase structure, the Steam API integration should:

1. Follow the existing patterns for API services
2. Maintain consistency with the current component architecture
3. Leverage the existing authentication and cart systems
4. Extend the product model to accommodate Steam items
5. Create new UI components specifically for Steam items

This directory structure provides a foundation for implementing the Steam Web API integration in a way that's consistent with the existing GigaSwap frontend architecture.
