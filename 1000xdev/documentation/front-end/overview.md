# Front-End Overview

# Front-End Architecture Overview

This document provides a high-level overview of the GigaSwap front-end architecture. It is designed to be the starting point for understanding the front-end structure, key components, and patterns. For specific integrations like Steam, see the dedicated documentation in the `/1000xdev/documentation/steam/` folder.

## Application Framework

GigaSwap uses **Next.js** as its core framework, providing:
- Server-side rendering (SSR) and static site generation (SSG) capabilities
- File-based routing system with dynamic routes
- Built-in API routes for backend functionality
- React component model with hooks
- Image optimization and other performance features

## Directory Structure

The main application code resides in the `front-end/src` directory with the following organization:

```text
front-end/
├── src/
│   ├── api/             - API client functions and utilities
│   ├── app/             - Next.js App Router pages and layouts
│   ├── components/      - Reusable React components
│   ├── contexts/        - React context providers
│   ├── hooks/           - Custom React hooks
│   ├── models/          - TypeScript models and interfaces
│   ├── types/           - TypeScript type definitions
│   ├── utils/           - Utility functions and helpers
│   ├── styles/          - Global CSS and theme configuration
│   └── lib/             - Third-party library wrappers
├── public/              - Static assets (images, fonts, etc.)
├── .next/               - Next.js build output (generated)
└── package.json         - Dependencies and scripts
```

## Key Components

### Routing (App Router)

The application uses Next.js 13+ App Router which:
- Organizes pages in the `app/` directory
- Provides server components by default with client components when needed
- Handles layouts, loading states, and error boundaries
- Supports nested routes and dynamic segments

Example route structure:
```text
app/
├── layout.tsx          - Root layout (applies to all pages)
├── page.tsx            - Homepage
├── market/             - Market routes
│   ├── layout.tsx      - Market layout
│   ├── page.tsx        - Market homepage
│   └── [slug]/         - Dynamic product routes
│       └── page.tsx    - Individual product page
└── api/                - API routes
    └── [...]/          - API endpoints
```

### Component Organization

Components follow a hierarchical organization:
- **Layout Components**: Define the structure of pages (`layouts/`)
- **Page Components**: Main views rendered for routes (`app/*/page.tsx`)
- **Feature Components**: Specific to a particular feature or domain (`components/market/`, etc.)
- **UI Components**: Reusable UI elements (`components/ui/`)
- **Composite Components**: Combinations of UI components for specific use cases (`components/product-cards/`)

### State Management

The application uses a combination of state management approaches:
- **React Context**: For global state like authentication, theme, cart
- **React Query**: For server state management and data fetching
- **Local Component State**: For UI state specific to components
- **URL State**: For shareable and bookmarkable state via query parameters

Example context usage:
```tsx
// In a provider component
export const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  // Authentication logic...
  
  return (
    <AuthContext.Provider value={{ user, login, logout, isLoading }}>
      {children}
    </AuthContext.Provider>
  );
}

// In a consumer component
function ProfileButton() {
  const { user, logout } = useAuth(); // Custom hook that uses AuthContext
  
  return user ? (
    <Button onClick={logout}>Logout {user.username}</Button>
  ) : (
    <Button href="/login">Login</Button>
  );
}
```

## Type System

The application uses TypeScript throughout with:
- **API Types**: Interfaces for API requests and responses (`types/api/`)
- **Model Types**: Business domain models (`models/`)
- **Component Props**: Type definitions for component properties
- **Utility Types**: Helper types and type transformations

API types follow a consistent pattern:
```typescript
// Base response type
export interface ApiResponse<T> {
  success: boolean;
  data?: T;
  error?: {
    code: string;
    message: string;
  };
}

// Specific response types
export interface ProductResponse extends ApiResponse<Product> {}
export interface ProductsListResponse extends ApiResponse<Product[]> {}
```

## API Integration

The front-end connects to backend services through:
- **API Client Functions**: Wrapper functions around `fetch` or Axios (`api/`)
- **Custom Hooks**: React hooks that encapsulate API calls and state management
- **Server Components**: Next.js server components that fetch data on the server

Example API client function:
```typescript
// API client function
export async function fetchProducts(
  category?: string,
  sort?: string,
  page = 1
): Promise<ProductsListResponse> {
  const params = new URLSearchParams();
  if (category) params.append('category', category);
  if (sort) params.append('sort', sort);
  params.append('page', page.toString());
  
  const response = await fetch(`/api/products?${params.toString()}`);
  return await response.json();
}

// Custom hook using the API client
export function useProducts(category?: string, sort?: string, page = 1) {
  return useQuery(
    ['products', category, sort, page],
    () => fetchProducts(category, sort, page),
    {
      keepPreviousData: true,
      staleTime: 5 * 60 * 1000, // 5 minutes
    }
  );
}
```

## Steam Integration Points

The front-end architecture includes several extension points for Steam integration:

1. **CS2 Models**: The `models/CS2Gun.model.ts` extends the base `Product` model with CS2-specific properties.

2. **Market Components**: The `components/market/` directory is prepared for CS2 marketplace UI components.

3. **Steam API Integration**: API client functions in `api/` can be extended with Steam-specific endpoints.

4. **Inventory Pages**: The app router includes routes for user inventories and marketplace listings.

## Styling and Theming

The application uses a combined styling approach:
- **CSS Modules**: For component-specific styling
- **Tailwind CSS**: For utility-based styling
- **Theme Provider**: For consistent theming across the application
- **Global Styles**: For base styling and CSS variables

## Testing Strategy

The front-end has a comprehensive testing strategy:
- **Unit Tests**: For individual components and utilities (`__tests__/`)
- **Integration Tests**: For connected components and pages
- **E2E Tests**: For critical user flows
- **Mock Service Worker**: For API mocking during tests

## Extension Points

The architecture is designed to be extensible in the following ways:

1. **New Feature Modules**:
   - Create new component directories in `components/`
   - Implement models in `models/`
   - Add API client functions in `api/`
   - Create routes in `app/`

2. **External Integrations**:
   - Follow the API client pattern for external APIs
   - Use React Query for data fetching and caching
   - Implement appropriate TypeScript interfaces

3. **Enhanced UI Components**:
   - Extend the UI component library in `components/ui/`
   - Use composition to create feature-specific components

## Environment Variables

The application is configured via environment variables:
- `.env.local` for local development
- `.env.production` for production builds
- `.env.test` for test environment

## Performance Considerations

Performance optimization strategies include:
- Component-level code splitting
- Image optimization via Next.js Image component
- Server-side rendering for SEO and initial load performance
- Caching strategies for API responses
- Lazy loading for non-critical components

## Further Information

For more detailed information on specific components, refer to:
- [Front-End Dependencies](./dependencies.md)
- [Front-End Context for Steam Integration](./context.md)
- [Steam Integration](../steam/steam.md) 