# Active Request

<!--
This file is drafted and updated by 1000xdev based on backlog.md and final-goals.md.
The user reviews and provides feedback; 1000xdev iterates until approved.
Only one request is ever present in this file.
----->

## Requirements: Front-End Steam Inventory Integration for /market Page

### Objective
Integrate Steam inventory endpoints in the front-end to display CS2 skin inventories from two Skinport bots on the /market page, creating a functional marketplace interface.

### Primary Data Sources
- **Skinport Bot #2331**: `GET /api/steam/profile/inventory/76561199562411448`
- **Skinport Bot #3257**: `GET /api/steam/profile/inventory/76561199800276630`

### Requirements

1. **API Integration Layer**
   - Create Steam API service module in `front-end/src/api/` for inventory endpoints
   - Implement proper error handling for large response payloads (6MB+ each)
   - Add loading states and timeout handling for large datasets
   - Handle network errors and implement retry logic

2. **Data Models & Types**
   - Create TypeScript interfaces in `front-end/src/types/api/` based on steamwebapi.com inventory response format
   - Model individual inventory items with pricing, rarity, condition, and image data
   - Create aggregated inventory models for combined bot inventories
   - Implement proper null/undefined handling for optional fields

3. **Market Page Implementation**
   - Update `/market` page to display combined inventory from both Skinport bots
   - Implement inventory item cards with images, names, prices, and rarity information
   - Add filtering capabilities (price range, rarity, condition, weapon type)
   - Add sorting options (price ascending/descending, rarity, name)
   - Implement search functionality across combined inventories
   - Add basic pagination for thousands of items

4. **User Experience**
   - Add loading indicators for inventory fetching
   - Implement error states for failed requests with retry options
   - Add refresh functionality for real-time inventory updates
   - Ensure responsive design for mobile and desktop

## Domain-Specific Context

- **Front-end Context:**
  - Key components: Market page, inventory item cards, filtering/sorting components
  - API integrations: Steam inventory endpoints, existing API client patterns
  - UI/UX considerations: Large dataset handling, responsive design, loading states

- **Back-end Context:**
  - API endpoints: Steam inventory proxy endpoints (already implemented)
  - External services: steamwebapi.com integration
  - Response format: Direct steamwebapi.com JSON arrays (no transformation)

## Technical Considerations

- **Response Size**: Each endpoint returns 6MB+ JSON arrays with thousands of items
- **Base URLs**: `http://127.0.0.1:8000` (development) / `https://gigaland-backend-537p.onrender.com` (production)
- **Response Format**: Direct steamwebapi.com format (no backend transformation needed)
- **Performance**: Basic handling of thousands of items (MVP approach)

## Testing Requirements

- Unit tests for Steam API service functions
- Component tests for inventory item cards and filtering
- Integration tests for market page with mock data
- Error handling tests for network failures

## Documentation Needs

- Update `1000xdev/documentation/steam/` with front-end integration patterns
- Document TypeScript interfaces and API service implementation
- Create front-end testing documentation for Steam endpoints
- Update component documentation for market page

## Success Criteria

- `/market` page successfully displays combined inventory from both bots
- Inventory items render with proper images, pricing, and metadata
- Filtering, sorting, and search functionality works correctly
- Page loads and displays inventory data successfully
- Error handling and loading states provide good user experience
- Responsive design works on mobile and desktop
- Code follows established front-end patterns and standards

## References
- [backlog.md](backlog.md) - REQ-000
- [final-goals.md](final-goals.md) - Phase 2: Marketplace Foundations
- [1000xdev/documentation/front-end/](../documentation/front-end/) - Front-end architecture and patterns
- [1000xdev/documentation/steam/](../documentation/steam/) - Steam API integration documentation 