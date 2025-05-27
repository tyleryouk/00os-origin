# Steam Inventory Marketplace Integration

## Overview

This document covers the technical implementation of Steam inventory integration in the GigaSwap marketplace frontend. It serves as a reference for future development and maintenance of the Steam inventory display functionality.

## Architecture

The Steam inventory integration follows a layered architecture approach:

1. **API Layer** - Handles communication with backend services
2. **Data Processing Layer** - Transforms API responses into frontend-friendly formats
3. **Component Layer** - Renders inventory items in the marketplace UI
4. **State Management Layer** - Manages inventory data state, filtering, and pagination

### Key Files

- `front-end/src/api/steam.ts` - API service module for Steam inventory
- `front-end/src/types/api/steam.ts` - TypeScript interfaces for Steam API data
- `front-end/src/app/market/page.tsx` - Next.js page component for marketplace
- `front-end/src/components/product-cards/product-card-1/product-card.tsx` - Product card component
- `front-end/src/components/LazyImage.tsx` - Image component with error handling
- `front-end/next.config.js` - Next.js configuration for image domains

## Data Flow

1. User navigates to `/market` page
2. Server-side rendering fetches inventory data from backend
3. Data is transformed into Product format for compatibility with existing components
4. Product cards are rendered with item details and images
5. User can filter and navigate between categories

```mermaid
graph TD
    A[User] --> B[/market Page]
    B --> C[Steam API Client]
    C --> D[Backend API]
    D --> E[steamwebapi.com]
    E --> D
    D --> C
    C --> F[Data Processing]
    F --> G[Product Mapping]
    G --> H[UI Components]
    H --> I[User Interface]
    I --> A
```

## API Client

The Steam API client in `front-end/src/api/steam.ts` provides methods for fetching inventory data:

```typescript
// Key methods
getCombinedInventory: async (options?: FetchOptions): Promise<ApiResponse<CombinedInventoryResponse>>
getInventoryByBotId: async (botId: string, options?: FetchOptions): Promise<ApiResponse<InventoryResponse>>
```

The client handles:
- Fetching from both Skinport bots and combining results
- Error handling for API failures
- Response caching for improved performance
- Rate limiting protection (429 responses)

## Data Model

The Steam inventory data model is complex, with over 50 fields per item. Key interfaces:

```typescript
// Core inventory response
interface InventoryResponse {
  items: SteamInventoryItem[];
  totalItems: number;
  timestamp: string;
}

// Combined inventory from multiple bots
interface CombinedInventoryResponse {
  combined: ProcessedInventoryItem[];
  bots: {
    [botId: string]: ProcessedInventoryItem[];
  };
  totalItems: number;
  timestamp: string;
}

// Processed inventory item (frontend-friendly)
interface ProcessedInventoryItem {
  id: string;
  name: string;
  marketName: string;
  marketHashName: string;
  type: string;
  rarity: string;
  condition?: string;
  weaponType?: string;
  collection?: string;
  
  // Image URL from Steam CDN
  image: string;
  
  // Market data
  tradable: boolean;
  marketable: boolean;
  price?: number;
  currency?: string;
  
  // Display properties
  nameColor: string;
  backgroundColor: string;
  
  // Original Steam data
  steamData: SteamInventoryItem;
}
```

## Image Handling

Steam inventory items use image URLs from the Steam CDN:

- Image URLs format: `https://community.cloudflare.steamstatic.com/economy/image/-9a81dlWLwJ2UUGcVs_nsVtzdOEdtWwKGZZLQHTxDZ7I56KU0Zwwo4NUX4oFJZEHLbXQ9QVcJY8gulReQ0HdUuqkw9acUFJ5KBFZv668FFUwgaeHYTxS6c6JhIWOnMj1DLnemSUGuJF03LCSptyg3FGy-hE9Yzr6INCcJwBsNA3S-Ae2k-7u05XquM7M1zI97QSdFZg-`
- Requires Next.js configuration to allow external images:

```javascript
// next.config.js
images: {
  remotePatterns: [
    { protocol: "https", hostname: "ui-lib.com" },
    { protocol: "https", hostname: "community.cloudflare.steamstatic.com" },
    { protocol: "https", hostname: "steamcommunity-a.akamaihd.net" }
  ]
}
```

### Image Error Handling

The LazyImage component includes error handling for failed image loads:

```typescript
// Enhanced LazyImage with error handling
<LazyImage
  priority
  alt={title}
  width={500}
  height={500}
  src={thumbnail || '/assets/images/products/no-image.png'}
  className="thumbnail"
  onError={(e) => {
    // Log error and set fallback image
    console.error(`Failed to load image: ${thumbnail}`);
    // Cast to HTMLImageElement to access src
    const target = e.target as HTMLImageElement;
    if (target) {
      target.src = '/assets/images/products/no-image.png';
    }
  }}
/>
```

## Categorization System

The marketplace uses a category system that will be expanded to match Skinport's 16 categories:

| Current Category | New Category | Item Properties |
|-----------------|--------------|----------------|
| CS2 KNIVES | KNIFE | `itemgroup: 'knife'` or `tag1: 'Knife'` |
| CS2 RIFLES | RIFLE | `itemgroup: 'rifle'` or weapon type tags |
| CS2 PISTOLS | PISTOL | `itemgroup: 'pistol'` or weapon type tags |
| CS2 SMGS | SMG | `itemgroup: 'smg'` or weapon type tags |
| - | GLOVES | `itemgroup: 'gloves'` or `tag1: 'Gloves'` |
| - | HEAVY | `itemgroup: 'heavy'` or weapon type tags |
| - | AGENT | `itemgroup: 'agent'` or `tag1: 'Agent'` |
| - | CHARM | `itemgroup: 'charm'` or `tag1: 'Charm'` |
| - | STICKER | `itemgroup: 'sticker'` or `tag1: 'Sticker'` |
| - | CONTAINER | `itemgroup: 'container'` or `tag1: 'Container'` |
| - | KEY | `itemgroup: 'key'` or `tag1: 'Key'` |
| - | PATCH | `itemgroup: 'patch'` or `tag1: 'Patch'` |
| - | GRAFFITI | `itemgroup: 'graffiti'` or `tag1: 'Graffiti'` |
| - | COLLECTIBLE | `itemgroup: 'collectible'` or `tag1: 'Collectible'` |
| - | PASS | `itemgroup: 'pass'` or `tag1: 'Pass'` |
| - | MUSIC KIT | `itemgroup: 'musickit'` or `tag1: 'Music Kit'` |

Each category will have its own URL pattern: `/market/knife`, `/market/gloves`, etc.

## Product Mapping

Inventory items are mapped to the existing Product model for compatibility with marketplace components:

```typescript
// Map inventory items to Product format
const products = inventoryData.combined.map(item => ({
  id: item.id,
  slug: item.marketHashName.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9-]/g, ''),
  title: item.name,
  description: `${item.rarity}${item.condition ? ' ' + item.condition : ''} ${item.weaponType || 'Item'}`,
  price: item.price || 0,
  image: item.image,
  thumbnail: item.image,
  category: item.weaponType || 'Unknown',
  brand: 'Steam',
  rating: 5,
  stock: 1,
  created_at: new Date().toISOString(),
  updated_at: new Date().toISOString()
}));
```

## Technical Challenges and Solutions

### 1. Image Display Issues

**Challenge**: Steam CDN image URLs weren't displaying in Next.js.

**Solution**:
- Added Steam domains to Next.js remotePatterns config
- Enhanced LazyImage component with error handling
- Added fallback image support for failed loads

### 2. Rate Limiting (429 Errors)

**Challenge**: steamwebapi.com API returns 429 Too Many Requests errors with frequent calls.

**Solution**:
- Backend caching of responses
- Planned implementation of retry logic with exponential backoff
- Future enhancement: client-side caching of inventory data

### 3. Complex Data Structure

**Challenge**: steamwebapi.com response contains 50+ fields per item.

**Solution**:
- Created comprehensive TypeScript interfaces
- Implemented processing function to transform data
- Use selective field mapping to simplify frontend model

## Performance Considerations

1. **Image Optimization**
   - Use Next.js Image component for automatic optimization
   - Implement lazy loading for off-screen images
   - Provide image dimensions to prevent layout shifts

2. **Data Handling**
   - Use pagination for large datasets (700+ items per bot)
   - Implement client-side filtering when possible
   - Cache API responses to reduce backend calls

3. **Rendering Optimization**
   - Use React.memo for product card components
   - Implement virtualized lists for large inventories
   - Avoid unnecessary re-renders with proper key usage

## Future Enhancements

1. **Category System Implementation**
   - Replace current CS2 categories with 16 Skinport categories
   - Add category-specific filtering options
   - Implement dynamic routing for categories

2. **Advanced Filtering**
   - Price range sliders
   - Rarity filters
   - Condition filters (Factory New, Minimal Wear, etc.)
   - Collection filters
   - StatTrak™ and Souvenir filters

3. **Search Functionality**
   - Implement search across all inventory items
   - Add autocomplete suggestions
   - Support searching by name, type, or collection

4. **Pagination and Sorting**
   - Implement client-side pagination
   - Add sorting options (price, rarity, name)
   - Consider virtual scrolling for performance

## Testing Strategy

1. **Unit Tests**
   - Test API client methods with mocked responses
   - Test data processing functions
   - Test component rendering with various item types

2. **Integration Tests**
   - Test marketplace page with real API data
   - Test category filtering and navigation
   - Test error handling scenarios

3. **Performance Testing**
   - Test rendering performance with 1000+ items
   - Test image loading performance
   - Test filtering and searching performance

## Lessons Learned

1. **Image Domains in Next.js**
   - Next.js requires explicit configuration for external image domains
   - Always add CDN domains to remotePatterns in next.config.js

2. **Error Handling**
   - Implement robust error handling for external image sources
   - Always provide fallback images for failed loads
   - Log detailed error information for debugging

3. **Type Safety**
   - Create comprehensive TypeScript interfaces for complex API responses
   - Use type guards to ensure type safety
   - Document complex data structures for future reference

4. **MVP Approach**
   - Focus on core functionality first (displaying items with images)
   - Add advanced features incrementally
   - Prioritize user experience over complete feature parity

## References

- [steamwebapi.com Documentation](https://www.steamwebapi.com/api/doc)
- [Next.js Image Configuration](https://nextjs.org/docs/app/api-reference/components/image#configuration-options)
- [Skinport.com Category System](https://skinport.com)

---

*Created: 2025-05-27*  
*Last Updated: 2025-05-27*  
*Author: 1000xdev* 