# Front-End Context

# Front-End Context for Steam Integration

This document describes the structure and conventions of the GigaSwap front-end type system, API client architecture, and data models. It is based on the current codebase and should be checked for accuracy each cycle. Do not rely on static directory trees—always cross-reference with the actual codebase.

## Type System Organization

TypeScript types are organized by purpose:
- **API Types**: Found in `src/types/api/`, these define base entity interfaces, API response/request types, pagination, and type guards/validation functions. They are re-exported and extended via `src/types/api/index.ts`.
- **Model Types**: Found in `src/models/`, these represent business entities (e.g., Product, CS2Gun, Order, User, etc.) and are used throughout the app for type-safe data handling.
- **Other Types**: Additional files in `src/types/` cover UI, state, params, and utility types.

### Key API Type Patterns
- **BaseEntity, NamedEntity, SlugEntity**: Common entity interfaces for API data.
- **ApiResponse, PaginatedResponse**: Standardized response types for all API endpoints.
- **Validation Functions**: Type guards and runtime validators for API data (see `validation.ts`).
- **Utility Types**: Helpers for required/optional fields, request/response config, and error handling.

### Model Patterns
- **Product Model**: Defines core product properties (id, title, price, category, etc.).
- **CS2Gun Model**: Extends Product with CS2/Steam-specific fields (skin, wear, rarity, Steam links, etc.).
- **Order Model**: Comprehensive order structure with status enums, item details, and transaction info.
- **User/Auth Models**: Wallet-based authentication, user profile, and blockchain user types.

All models use TypeScript interfaces and are exported as both default and named exports for compatibility. Many provide `DEFAULT_*` constants for empty instances.

## API Client Architecture

API modules are organized by domain in `src/api/`:
- **client.ts**: Configures the Axios instance, error handling, and environment detection.
- **index.ts**: Central export and initialization for all API modules.
- **Domain Modules**: Each domain (auth, cs2-sales, orders, product, etc.) has its own file or subfolder. There is currently no dedicated Steam API module; Steam/CS2 logic is handled in `cs2-sales.ts` and related modules.
- **Mock System**: The API layer includes a robust mock system for development/testing, with mock data and utilities in `mock-data/` and `mock-utils/`.

### API Usage Patterns
- All API functions use standardized response types and error handling.
- Data fetching is often wrapped with React's `cache` for performance.
- Mock data and fallback logic are used for development and error resilience.
- Type safety is enforced throughout via shared types and validation functions.

## Component & Model Integration

- **Product Display**: Product and CS2Gun models are used in product cards, grids, and filters.
- **Order Management**: Order models are used in order components and transaction flows.
- **Authentication**: Auth and PolygonUser models are used in wallet login and user state.
- **Marketplace/Steam Integration**: The CS2Gun model is the foundation for Steam/CS2 item representation. Steam-specific extensions should be added here as needed.

## Steam API Integration Extension Points
- Extend the CS2Gun model with new fields as required by Steam API responses.
- Add new API types and validation functions for Steam-specific endpoints if/when a dedicated module is created.
- Use the existing mock system to develop and test Steam integration features.
- Follow the established patterns for type safety, error handling, and modularity.

## Best Practices
- Always check this documentation against the codebase before making changes.
- Use interfaces and type guards for all API and model data.
- Prefer composition and extension over duplication for new types/models.
- Keep all type and model files focused and single-purpose.
- Use the mock system for rapid development and testing of new API features.

---
This documentation is a living reference and must be updated as the codebase evolves. Do not rely on static directory trees or outdated file lists—always verify with the current source. 