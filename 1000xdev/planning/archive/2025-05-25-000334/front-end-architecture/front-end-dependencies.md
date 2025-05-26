# Front-End Dependencies Overview

This document provides a comprehensive list of all dependencies used in the GigaSwap front-end application. This list is generated from the actual `package.json` and should be checked each cycle for accuracy. Do not manually maintain this file—always cross-reference with `package.json`.

## Core Framework Dependencies

- **Next.js**: `next@^15.0.3` - React framework with server-side rendering capabilities
- **React**: `react@^18.3.1` - UI library
- **React DOM**: `react-dom@^18.3.1` - React renderer for the DOM

## UI Libraries & Components

- **Material UI**: `@mui/material@^5.15.14` - React UI components
- **Material UI Icons**: `@mui/icons-material@^5.15.11` - Material Design icons
- **Material UI Lab**: `@mui/lab@^5.0.0-alpha.168` - Experimental components
- **Material UI Styles**: `@mui/styles@^5.15.11` - Styling solution
- **Material UI System**: `@mui/system@^5.15.11` - System utilities
- **Emotion**: `@emotion/react@^11.11.4`, `@emotion/styled@^11.11.4` - CSS-in-JS library
- **Tailwind CSS**: `tailwindcss@^3.4.1` - Utility-first CSS framework
- **Framer Motion**: `framer-motion@^11.0.20` - Animation library
- **React Hook Form**: `react-hook-form@^7.51.3` - Form validation
- **Date-fns**: `date-fns@^3.6.0` - Date utility library
- **Yup**: `yup@^1.4.0` - Schema validation

## Data Management & API

- **SWR**: `swr@^2.2.5` - React Hooks for data fetching
- **React Query**: `@tanstack/react-query@^5.28.4` - Data synchronization
- **Axios**: `axios@^1.6.8` - HTTP client
- **Lodash**: `lodash@^4.17.21` - Utility library

## Visualization & Media

- **Chart.js**: `chart.js@^4.4.2` - Charting library
- **React Chartjs 2**: `react-chartjs-2@^5.2.0` - React wrapper for Chart.js
- **Three.js**: `three@^0.162.0` - 3D library
- **React Three Fiber**: `@react-three/fiber@^8.15.19` - React renderer for Three.js
- **React Three Drei**: `@react-three/drei@^9.102.3` - Helpers for React Three Fiber

## Utilities

- **Clsx**: `clsx@^2.1.0` - Utility for constructing className strings
- **React Dropzone**: `react-dropzone@^14.2.3` - File upload
- **UUID**: `uuid@^9.0.1` - UUID generation
- **Formik**: `formik@^2.4.5` - Form handling
- **React Markdown**: `react-markdown@^9.0.1` - Markdown renderer
- **React Helmet**: `react-helmet-async@^2.0.4` - Document head manager
- **React Copy to Clipboard**: `react-copy-to-clipboard@^5.1.0` - Copy text to clipboard

## Development & Testing

- **TypeScript**: `typescript@^5.4.2` - Static type checking
- **ESLint**: `eslint@^8.57.0` - Code linting
- **Prettier**: `prettier@^3.2.5` - Code formatting
- **Jest**: `jest@^29.7.0` - Testing framework
- **React Testing Library**: `@testing-library/react@^14.2.1` - Testing utilities

## Authentication & Security

- **NextAuth.js**: `next-auth@^4.24.7` - Authentication for Next.js
- **JWT Decode**: `jwt-decode@^4.0.0` - JWT decoding
- **Crypto-js**: `crypto-js@^4.2.0` - Cryptographic functions

## DevOps & Build Tools

- **PostCSS**: `postcss@^8.4.35` - CSS transformation tool
- **Autoprefixer**: `autoprefixer@^10.4.18` - PostCSS plugin
- **Webpack**: Bundled with Next.js
- **Babel**: Bundled with Next.js

## Performance Optimization

- **React Window**: `react-window@^1.8.10` - Virtualized list component
- **React Virtualized**: `react-virtualized@^9.22.5` - Components for efficiently rendering large lists
- **Web Vitals**: `web-vitals@^3.5.2` - Metrics for web performance

## Dependency Management Best Practices

1. **Version Management**:
   - Use exact versions (`1.2.3`) for critical dependencies
   - Use caret ranges (`^1.2.3`) for minor/patch updates
   - Lock dependencies with package-lock.json

2. **Security Updates**:
   - Run `npm audit` regularly
   - Keep dependencies up to date
   - Use npm audit fix for automatic security updates

3. **Dependency Conflicts**:
   - Resolve peer dependency warnings promptly
   - Check for duplicate packages with `npm ls`
   - Use tools like `depcheck` to find unused dependencies

4. **Adding New Dependencies**:
   - Evaluate bundle size impact
   - Check license compatibility
   - Consider maintenance status and community support 