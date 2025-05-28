# Front-End Overview

This document provides a high-level overview of the GigaSwap front-end architecture based on the actual codebase structure.

## Application Framework

**Next.js 15** with App Router:
- TypeScript configuration with path aliases for clean imports
- Server-side rendering for market pages with Steam inventory data
- Client-side components for interactive features
- Material-UI (MUI) v5 for component library and theming

## Core Architecture

### Directory Structure
- `src/app/` - Next.js App Router pages and layouts
- `src/components/` - Reusable UI components organized by feature
- `src/pages-sections/` - Page-specific component sections
- `src/api/` - API client and Steam integration
- `src/hooks/` - Custom React hooks for state management
- `src/contexts/` - React Context providers (auth, settings)
- `src/models/` - TypeScript interfaces and data models
- `src/utils/` - Utility functions and logging
- `src/theme/` - MUI theme configuration and styling
- `src/data/` - Static data and configuration

### Key Features
- **Steam Marketplace Integration**: Live CS2 inventory data via Steam API
- **Web3 Authentication**: Wallet connection with Polygon network
- **Comprehensive Logging**: Centralized logging system with ConsolidatedLogger
- **Error Handling**: Error boundaries and Next.js error overlay fixes
- **Responsive Design**: Mobile-first approach with MUI breakpoints

## Steam Integration

The application fetches real Steam inventory data:
- Market page displays actual CS2 items from Steam API
- Category filtering for weapons, knives, gloves, etc.
- Product models extend base Product interface with Steam-specific fields
- Real-time pricing and item condition data

## Authentication System

Web3-first authentication using wagmi and wallet connections:
- Polygon wallet integration
- JWT token management
- Automatic re-authentication on wallet changes
- Auth context provides global authentication state

## Logging & Error Handling

- **ConsolidatedLogger**: Centralized logging to `/logs-main` directory
- **Error Boundaries**: React error boundaries with retry functionality
- **Next.js Error Overlay**: Fixed z-index issues for development visibility
- **Runtime Error Resolution**: Screenshot-based error reporting workflow

## Development Workflow

- **No Build Commands**: 1000xdev never runs npm/build commands
- **Runtime Error Fixes**: Errors reported via screenshots, fixed directly in code
- **Mock System**: Development API mocking for offline development
- **Hot Reloading**: Next.js development server with fast refresh

## Further Information

For more detailed information on specific components, refer to:
- [Front-End Dependencies](./dependencies.md)
- [Front-End Context for Steam Integration](./context.md)
- [Steam Integration](../steam/steam.md) 