### REQ-000: Front-End Steam Inventory Integration for /market Page

**Objective**: Integrate Steam inventory endpoints in the front-end to display CS2 skin inventories from two Skinport bots on the /market page.

**Primary Data Sources**:
- **Skinport Bot #2331**: `GET /api/steam/profile/inventory/76561199562411448`
- **Skinport Bot #3257**: `GET /api/steam/profile/inventory/76561199800276630`

**Context from Backend Analysis**:
- Both endpoints return large JSON arrays (6MB+ each) containing CS2 skin inventory items
- Each inventory contains thousands of items with detailed pricing, rarity, and metadata
- Profile data shows bots are actively in-game (Counter-Strike 2) with public inventories
- All endpoints use simple proxy pattern returning steamwebapi.com response format directly

**Front-End Integration Requirements**:

1. **API Integration Layer**:
   - Create Steam API service module for inventory endpoints
   - Implement proper error handling for large response payloads
   - Add loading states and pagination for inventory display
   - Handle network timeouts and retry logic for large datasets

2. **Data Models & Types**:
   - Create TypeScript interfaces based on steamwebapi.com inventory response format
   - Model individual inventory items with pricing, rarity, condition, and image data
   - Create aggregated inventory models for combined bot inventories
   - Implement proper null/undefined handling for optional fields

3. **Market Page Implementation**:
   - Display combined inventory from both Skinport bots (#2331 and #3257)
   - Implement inventory item cards with images, names, prices, and rarity
   - Add filtering and sorting capabilities (price, rarity, condition, etc.)
   - Implement search functionality across combined inventories
   - Add pagination or virtual scrolling for performance with large datasets

4. **Performance Optimization**:
   - Implement lazy loading for inventory images
   - Add caching strategy for inventory data
   - Optimize rendering for thousands of items
   - Consider implementing virtual scrolling or pagination

5. **User Experience**:
   - Add loading indicators for inventory fetching
   - Implement error states for failed requests
   - Add refresh functionality for real-time inventory updates
   - Ensure responsive design for mobile and desktop

**Technical Implementation Notes**:
- Base URL: `http://127.0.0.1:8000` (development) / `https://gigaland-backend-537p.onrender.com` (production)
- Response format: Direct steamwebapi.com JSON arrays (no transformation needed)
- Expected response size: 6MB+ per endpoint (thousands of items each)
- Bot profiles: Both bots are German-based, actively playing CS2, with public inventories

**Documentation Updates**:
- Update `1000xdev/documentation/steam/` with front-end integration patterns
- Document TypeScript interfaces and API service implementation
- Create front-end testing documentation for Steam endpoints
- Update `1000xdev/TODO.md` with detailed subtasks for Steps 4 and 5

**Success Criteria**:
- /market page successfully displays combined inventory from both bots
- Inventory items render with proper images, pricing, and metadata
- Filtering, sorting, and search functionality works correctly
- Page performance remains acceptable with large datasets
- Error handling and loading states provide good user experience

### REQ-001
(After back-end testing)
Continue working on core API integration. Test the full stack endpoints for both the front-end and back-end. Document the testing process for both the back-end and front-end so that the testing process is clear.

### REQ-002
(After full stack testing)
Migrate all logs to the `back-end/logs` folder. Update all logger configurations, file paths, and related scripts to use the new log directory. Validate that all logging, log rotation, and log reading tools work as expected with the new structure. Update documentation to reflect the new log organization.

