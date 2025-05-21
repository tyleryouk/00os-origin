# Front-End Types System Overview

The `front-end/src/types` directory contains TypeScript type definitions that form the foundation of the application's type system. This well-structured collection of interfaces and types ensures type safety throughout the project and will be extended to support the Steam API integration.

## Directory Structure and Purpose

The types directory is organized around several key areas:

- **Base API types**: Foundational interfaces for API interactions
- **Data models**: Types representing business entities
- **UI components**: Type definitions for UI elements
- **State management**: Types for managing application state

## Key Type Definitions

### API Types (`api/` subdirectory)

The API types are particularly important for our Steam integration work:

- **`api/base.ts`**: Contains fundamental entity interfaces like `BaseEntity`, `NamedEntity`, and response types like `PaginatedResponse` and `ApiResponse`
- **`api/common.ts`**: Provides common API response and request types including pagination and error handling
- **`api/index.ts`**: Re-exports and extends types from other files with utility types
- **`api/validation.ts`**: Contains type guards and validation functions for API data

### API Response Types

Several files define API response patterns:

- **`api.ts`**: Contains the core `ApiResponse<T>` interface with success/error handling
- **`api-types.ts`**: Defines specific response types for various API endpoints (will need extension for Steam API)

### Data Models and Parameters

- **`profile.ts`**: User profile and wallet related types
- **`params.ts`**: Route and request parameter types
- **`routes.ts`**: Route-specific props and parameters

### State Management

- **`store.ts`**: Defines state store interfaces for order management
- **`react-query.ts`**: Extends React Query types for data fetching

### Other Types

- **`mock-system.ts`**: Types for the mock system implementation
- **`pages.d.ts`**: Page and layout type definitions
- **`icons.ts`**: Icon component type definitions

## Extending for Steam API Integration

For the Steam API integration, we will need to:

1. Create new interfaces for Steam item entities
2. Define Steam API request and response types
3. Extend the API validation for Steam-specific data
4. Create new query types for Steam data fetching

These extensions should follow the existing patterns in the codebase, particularly the API response handling and entity modeling approaches.

## Type Safety Best Practices

The existing type system follows several best practices:

- Consistent interfaces for API responses
- Type guards for runtime validation
- Hierarchical type composition
- Proper handling of optional fields
- Clear separation of concerns between different type categories

Our Steam API integration will adhere to these same principles to maintain code quality and type safety.

# Front-End API Architecture

The `front-end/src/api` directory contains a well-structured, modular API client implementation organized around domain-specific modules. This architecture will serve as the foundation for implementing our Steam Web API integration.

## Directory Structure and Organization

The API directory follows a domain-driven design with these key components:

```
front-end/src/api/
├── client.ts                # Core Axios client configuration
├── index.ts                 # Central export point
├── auth.ts                  # Authentication handling
├── cs2-sales.ts             # CS2 items & marketplace (key for Steam integration)
├── layout.ts                # Site layout and navigation
├── mock.ts                  # Mock system configuration
├── orders.ts                # Order management
├── profile.ts               # User profile management
├── support/                 # Support ticket functionality
├── user/                    # User-related operations
├── vendor/                  # Vendor management
├── shop/                    # Shop functionality
├── sales/                   # Sales operations
├── dashboard/               # Analytics and reporting
├── product/                 # Product management
├── mock-data/               # Mock response data
└── mock-utils/              # Mock system infrastructure
```

## Core API Components

### API Client (client.ts)

- Configures Axios instance with proper environment settings
- Implements error handling and logging via ConsolidatedLogger
- Provides development/production environment detection
- Handles mock system initialization for development

### Main Module (index.ts)

- Centralizes API exports and initialization
- Re-exports domain-specific API modules
- Handles API initialization with proper timing
- Manages mock system setup

### CS2 Sales (cs2-sales.ts)

This module is particularly relevant for Steam API integration:

- Implements CS2 skins marketplace functionality
- Provides methods for categories, products, and sales
- Uses cached React methods for data fetching
- Includes fallback mechanisms for development/errors
- Contains logging specifically for CS2-related operations

### Authentication (auth.ts)

- Manages Web3 wallet-based authentication
- Implements token management (get, set, remove)
- Provides request/response interceptors for auth
- Handles auth failures and token refreshing

## Mock System Architecture

The API includes a sophisticated mock system that will be valuable for Steam API development:

### Mock Utils (/mock-utils)

- **endpoint-registry.ts**: Maps API endpoints to mock handlers
- **api-interceptor.ts**: Routes requests to handlers
- **events.ts**: Notification system for mock operations
- **initialize.ts**: Mock system initialization logic
- **mock-context.ts**: State management for mock system
- **types.ts**: Type definitions for mock system

### Mock Data (/mock-data)

- Contains structured mock data for various endpoints
- Includes sales, tickets, and vendor information

## Integration Points for Steam API

Based on this architecture, the Steam Web API integration should:

1. **Create a new steam.ts module** for Steam-specific API calls
2. **Extend cs2-sales.ts** to incorporate Steam item data
3. **Add Steam-specific mock data** for development
4. **Implement Steam authentication** extensions in auth.ts if needed

The existing pattern of cached React functions with fallback data will be particularly valuable for creating a robust integration that works well in both development and production environments.

## API Usage Patterns

The API consistently follows these patterns:

- Functions are wrapped with React's `cache` for optimized data fetching
- Comprehensive error handling with ConsolidatedLogger
- Fallback data mechanisms for development and error cases
- Type-safe request and response handling
- Structured logging for operations and errors

Our Steam API integration will follow these same patterns to maintain consistency and reliability across the application.

# Front-End Components Architecture

The `front-end/src/components` directory contains a comprehensive library of React components that provide the UI building blocks for the application. These components will be critical for implementing the visual elements of our Steam Web API integration.

## Directory Structure and Organization

The components directory is organized into functional categories:

```
front-end/src/components/
├── market/                  # Empty directory (potential location for Steam marketplace components)
├── product-cards/           # Various product card designs
├── products-view/           # Grid and list views for products
│   └── filters/             # Product filtering components
├── categories/              # Category navigation and listing
├── category-cards/          # Category display cards
├── layouts/                 # Page layout templates
│   └── market-layout/       # Specific layout for marketplace
├── header/                  # Header components including navigation
├── dashboard/               # User dashboard components
├── profile/                 # User profile components
├── common/                  # Reusable utility components
├── ui/                      # Basic UI elements
└── [various utility components]
```

## Core Component Categories

### Product Display Components

The application has a robust set of product display components that will be useful for showing Steam items:

- **Product Cards**: Multiple variations (product-card-1 through product-card-16) for different display styles
- **Product Grid/List Views**: Components for displaying products in different layouts
- **Product Filters**: Components for filtering products by various attributes

### Navigation and Categorization

Components for organizing and navigating products:

- **Category List/Menu**: Components for displaying and navigating categories
- **Header Components**: Navigation, user account, and cart functionality
- **Mobile Navigation**: Responsive navigation for mobile devices

### Layout Components

Page structure components:

- **Market Layout**: Specific layout for marketplace pages (key for Steam integration)
- **Shop Layouts**: Various layout options for product display
- **Dashboard Layout**: Layout for user dashboard pages

### User Interface Components

Common UI elements:

- **Loading/Error States**: Components for handling loading and error states
- **Pagination**: For navigating through multi-page results
- **Forms and Inputs**: Components for user input
- **Typography**: Text formatting components

### User Management Components

Components for user-related functionality:

- **Profile Components**: Display and edit user profile information
- **Dashboard Components**: User dashboard interface
- **Order Components**: Display and manage orders

## Integration Points for Steam API

Based on the component architecture, our Steam API integration should:

1. **Create new marketplace components** in the currently empty `market/` directory
2. **Extend existing product display components** to work with Steam item data
3. **Use the market layout** for consistent page structure
4. **Leverage filtering components** for Steam-specific filters (wear, item type, etc.)
5. **Implement Steam authentication** components that integrate with the existing auth flow

## Component Patterns and Best Practices

The existing components follow these patterns:

- **Component Modularity**: Small, focused components with single responsibilities
- **Consistent Props Interface**: Clear prop definitions with TypeScript typing
- **Styled Component Approach**: Uses Material UI and custom styling
- **Responsive Design**: Mobile-first approach with responsive layouts
- **Error Boundary Usage**: Components wrapped in error boundaries for resilience

Our Steam API integration should follow these same patterns to maintain consistency with the existing codebase and ensure a cohesive user experience.

# Front-End Models Overview

The `front-end/src/models` directory contains TypeScript interface definitions that represent the core data structures used throughout the application. These models provide the foundation for type-safe data handling and will be extended to support the Steam API integration.

## Directory Structure and Purpose

The models directory consists of a flat structure of TypeScript files, each defining one or more related interfaces:

```
front-end/src/models/
├── Address.model.ts         # User address interfaces
├── api.model.ts             # API request/response interfaces
├── auth.models.ts           # Authentication-related interfaces
├── Blog.model.ts            # Blog content interfaces
├── Brand.model.ts           # Product brand interfaces
├── Carousel.model.ts        # Carousel UI component interfaces
├── Category.model.ts        # Product category interfaces
├── CategoryNavList.model.ts # Category navigation interfaces
├── Common.ts                # Shared utility interfaces
├── CS2Gun.model.ts          # CS2 weapon skin interfaces (key for Steam integration)
├── Filters.ts               # Product filtering interfaces
├── Layout.model.ts          # UI layout interfaces
├── Navigation.model.ts      # Navigation menu interfaces
├── Order.model.ts           # Order and transaction interfaces
├── polygonuser.model.ts     # Blockchain user interfaces
├── Product.model.ts         # Core product interfaces
├── Shop.model.ts            # Seller shop interfaces
├── Ticket.model.ts          # Support ticket interfaces
├── User.model.ts            # User profile interfaces
```

## Key Model Definitions

### CS2 Gun Model (CS2Gun.model.ts)

The CS2Gun model is particularly important for our Steam integration:

- Extends the base Product model with CS2-specific properties
- Includes fields for gun skin details (wear, rarity, collection)
- Contains 3D model reference (`glbFile` property)
- Includes Steam-specific properties (`steamCommunityLink`, `steamInGameLink`)
- Captures market data like `suggestedPriceUSD` and `communitySentiment`

### Product Model (Product.model.ts)

The base product model defines core properties for marketplace items:

- Standard fields: id, title, price, description, image
- Categorization through category and brand fields
- Inventory management with stock and status fields
- Shopping-related properties like discount and sale_price

### Order Model (Order.model.ts)

The order model defines transaction properties critical for marketplace operations:

- Comprehensive order status tracking (PENDING, COMPLETED, CANCELLED, etc.)
- Detailed order items with product information
- Blockchain transaction details with wallet addresses
- Shipping and billing information
- Seller information tracking

### Authentication Models (auth.models.ts and polygonuser.model.ts)

These models define authentication structures:

- Wallet-based authentication flow
- Challenge/response pattern for wallet signatures
- Token storage and management
- Error handling specific to authentication

## Integration Points for Steam API

Based on the model architecture, our Steam API integration should:

1. **Extend the CS2Gun model** with additional properties from Steam inventory
2. **Create new Steam-specific interfaces** for API responses
3. **Add inventory tracking models** for Steam items
4. **Implement transaction models** for Steam trading

The CS2Gun model already provides a solid foundation for representing Steam items, but we'll need to extend it with properties specific to the Steam Web API's response format and trading capabilities.

## Model Usage Patterns

The models follow consistent patterns:

- Default exports with named type exports for backward compatibility
- DEFAULT_X constants for providing empty model instances
- Structured nested interfaces for complex properties
- Clear separation between core properties and optional extensions
- Type enumeration for status fields and other constrained values

Our Steam API integration will follow these same patterns to maintain consistency and enable seamless integration with existing components that expect these model structures.
