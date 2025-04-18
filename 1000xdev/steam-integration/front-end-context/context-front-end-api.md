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
