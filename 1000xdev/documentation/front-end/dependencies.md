# Front-End Dependencies

This document provides a comprehensive list of all dependencies used in the GigaSwap front-end application based on the actual `package.json`.

## Core Framework Dependencies

- **Next.js**: `next@^15.0.3` - React framework with App Router and server-side rendering
- **React**: `react@^18.3.1` - UI library
- **React DOM**: `react-dom@^18.3.1` - React renderer for the DOM
- **TypeScript**: `typescript@^5` - Type safety and development tooling

## UI Libraries & Components

- **Material UI Core**: `@mui/material@^5.15.14` - React component library
- **Material UI Icons**: `@mui/icons-material@^5.15.11` - Material Design icons
- **Material UI Lab**: `@mui/lab@^5.0.0-alpha.170` - Experimental MUI components
- **Material UI Date Pickers**: `@mui/x-date-pickers@^7.1.1` - Date/time picker components
- **Material UI Next.js**: `@mui/material-nextjs@^5.15.11` - Next.js integration for MUI

## Web3 & Blockchain

- **Wagmi**: `wagmi@^2.5.7` - React hooks for Ethereum
- **Viem**: `viem@^2.7.15` - TypeScript interface for Ethereum
- **RainbowKit**: `@rainbow-me/rainbowkit@^2.0.5` - Wallet connection UI
- **TanStack Query**: `@tanstack/react-query@^5.28.6` - Data fetching and caching

## HTTP & API

- **Axios**: `axios@^1.6.8` - HTTP client for API requests
- **Axios Mock Adapter**: `axios-mock-adapter@^1.22.0` - API mocking for development

## Utilities & Helpers

- **Lodash**: `lodash@^4.17.21` - Utility functions
- **Date-fns**: `date-fns@^3.6.0` - Date manipulation library
- **React Hook Form**: `react-hook-form@^7.51.1` - Form state management
- **React Hot Toast**: `react-hot-toast@^2.4.1` - Toast notifications

## Development Dependencies

- **ESLint**: `eslint@^8` - Code linting
- **ESLint Next.js Config**: `eslint-config-next@15.0.3` - Next.js specific linting rules
- **TypeScript Types**: Various `@types/*` packages for type definitions

## Key Configuration Files

- **tsconfig.json**: TypeScript configuration with path aliases
- **next.config.js**: Next.js configuration for build and runtime
- **package.json**: Dependency management and scripts

## Path Aliases (from tsconfig.json)

The application uses TypeScript path aliases for clean imports:
- `@/*` → `./src/*`
- `models/*` → `./src/models/*`
- `components/*` → `./src/components/*`
- `hooks/*` → `./src/hooks/*`
- `contexts/*` → `./src/contexts/*`
- `utils/*` → `./src/utils/*`
- `pages-sections/*` → `./src/pages-sections/*`
- `theme/*` → `./src/theme/*`
- `data/*` → `./src/data/*`

## Dependency Management

- Always check `package.json` for the most current dependency versions
- Dependencies are managed through npm/yarn
- Development dependencies are separated from production dependencies
- Lock files ensure consistent installations across environments 