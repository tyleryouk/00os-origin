# Front-End Dependencies Overview

This document provides a comprehensive list of all dependencies used in the GigaSwap front-end application. Understanding these dependencies is crucial for implementing the Steam API integration effectively.

## Core Framework Dependencies

- **Next.js**: `next@15.0.3` - React framework with server-side rendering capabilities
- **React**: `react@18.3.1` - UI library
- **React DOM**: `react-dom@18.3.1` - React renderer for web applications

## UI Component Libraries

- **Material UI**: 
  - `@mui/material@6.1.10` - Component library
  - `@mui/icons-material@6.1.10` - Icon library
  - `@mui/lab@6.0.0-beta.18` - Experimental components
  - `@mui/material-nextjs@6.1.9` - Next.js integration
  - `@mui/x-date-pickers@7.23.0` - Date/time pickers

- **Emotion (Styling)**:
  - `@emotion/cache@11.13.5` - Stylesheet cache
  - `@emotion/react@11.13.5` - CSS-in-JS library
  - `@emotion/styled@11.13.5` - Styled component API

- **Other UI Components**:
  - `notistack@3.0.1` - Notification system
  - `react-slick@0.30.2` / `slick-carousel@1.8.1` - Carousel component
  - `overlayscrollbars@2.11.1` / `overlayscrollbars-react@0.5.6` - Custom scrollbars
  - `nprogress@0.2.0` - Progress bar for page transitions
  - `react-insta-stories@2.7.0` - Instagram-like stories component
  - `react-scroll@1.9.0` - Scroll animations
  - `react-dropzone@14.3.5` - File upload component

## 3D Visualization

- **Three.js**: `three@0.175.0` - 3D library
- **React Three Fiber**: `@react-three/fiber@8.15.19` - React renderer for Three.js
- **React Three Drei**: `@react-three/drei@9.88.17` - Helpers for React Three Fiber

## Data Management

- **React Query**: `@tanstack/react-query@5.66.0` - Data fetching and state management
- **React Hook Form**: `react-hook-form@7.53.2` - Form state management
- **Yup**: `yup@1.5.0` - Schema validation
- **Hookform Resolvers**: `@hookform/resolvers@3.9.1` - Integration between React Hook Form and validation libraries

## API & Networking

- **Axios**: `axios@1.7.9` - HTTP client for API requests
- **Axios Mock Adapter**: `axios-mock-adapter@2.1.0` - Mock API requests for testing/development

## Web3 & Blockchain

- **Ethers.js**: `ethers@6.13.5` - Ethereum library
- **Rainbow Kit**: `@rainbow-me/rainbowkit@2.2.3` - Wallet connection UI
- **Wagmi**: `wagmi@2.14.11` - React hooks for Ethereum
- **Viem**: `viem@2.22.23` - TypeScript interface for Ethereum

## Utilities

- **Lodash**: `lodash@4.17.21` - Utility functions
- **Date-fns**: `date-fns@4.1.0` - Date manipulation library
- **clsx**: `clsx@2.1.1` - CSS class name utility
- **Sharp**: `sharp@0.33.5` - Image processing
- **ApexCharts**: `apexcharts@4.1.0` / `react-apexcharts@1.7.0` - Charts
- **i18next**: `i18next@24.0.5` / `next-i18next@15.4.0` / `react-i18next@15.1.3` - Internationalization

## Development Dependencies

- **TypeScript**: `typescript@5.7.2` - Static typing
- **ESLint**: `eslint@8.56.0` - Linting
- **Prettier**: `prettier@3.4.2` - Code formatting
- **Jest**: Various Jest-related packages for testing
- **Testing Library**: Various packages for React component testing

## For Steam API Integration

For our Steam API integration, the following dependencies will be particularly relevant:

1. **Axios** will be used for making HTTP requests to the Steam Web API
2. **React Query** will handle caching and state management of Steam item data
3. **Material UI** components will be used for rendering Steam item cards and marketplace UI
4. **Three.js/React Three Fiber** could be utilized for 3D visualization of CS2 skins
5. **TypeScript** type definitions will need to be created for Steam API responses

Additional dependencies may be needed based on specific requirements, but the existing dependency set provides a solid foundation for implementing the Steam API integration.
