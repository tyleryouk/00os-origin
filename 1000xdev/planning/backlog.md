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

### REQ-003: Implement Next.js Runtime Error Logging System

**🚨 URGENT - PRIORITY FOR NEXT CYCLE**: This request addresses critical debugging challenges currently blocking efficient development. The inability to properly capture and view runtime errors is significantly impacting development velocity.

**Objective**: Create a comprehensive error logging system for the Next.js front-end that captures runtime errors and makes them accessible to 1000xdev for debugging without requiring manual error reporting.

**Context**: Currently, Next.js runtime errors are shown in an overlay during development but are difficult to capture systematically. These errors are often partially hidden under navbars and require manual reporting. We need an automated solution to log these errors for easier debugging.

**Implementation Requirements**:

1. **Browser-Side Error Capture**:
   - Implement global error handlers using `window.addEventListener('error')` and `window.addEventListener('unhandledrejection')`
   - Create a custom error boundary component for React component errors
   - Capture error details including: error message, stack trace, component tree, user actions leading to error
   - Handle both synchronous and asynchronous errors

2. **Structured Logging with Pino**:
   - Install and configure Pino for Next.js: `npm install pino pino-pretty`
   - Configure in `next.config.js`: add to `serverComponentsExternalPackages`
   - Create `lib/logger.ts` with environment-specific configuration (JSON in production, pretty-print in development)
   - Use child loggers for different modules/components

3. **Error Logging API**:
   - Create API endpoint `/api/logs/error` to receive error reports from the browser
   - Store errors in structured format with timestamps, error types, and context
   - Implement rate limiting to prevent log spam
   - Add authentication/validation to prevent abuse

4. **Development Tools Integration**:
   - Configure VSCode for both client and server-side debugging (`.vscode/launch.json`)
   - Set up source maps for production error tracking
   - Ensure errors are logged but don't interrupt user experience

5. **Error Display Dashboard**:
   - Create a development-only page (`/dev/errors`) to view logged errors
   - Display errors in a searchable, filterable interface
   - Include stack traces, timestamps, and error frequency
   - Add ability to clear error logs

6. **Integration with Next.js Error Handling**:
   - Create custom `_error.tsx` page for production error handling
   - Ensure errors are logged before displaying user-friendly error pages
   - Maintain Next.js error overlay functionality while adding logging

**Technical Implementation Notes**:
- Use `instrumentation.ts` for initializing error handlers
- Store errors in `front-end/logs/errors/` directory (create if not exists)
- Implement log rotation to prevent disk space issues
- Consider using circular buffer for in-memory error storage during development

**Benefits**:
- Autonomous error discovery without manual reporting
- Better debugging with full error context and history
- Improved development workflow with centralized error viewing
- Foundation for future production error monitoring

**Success Criteria**:
- All runtime errors are automatically captured and logged
- Error logs are easily accessible through dashboard or log files
- No performance impact on application
- Error context is sufficient for debugging
- Integration doesn't interfere with existing Next.js error handling

**Future Enhancements**:
- Integration with external monitoring services (Sentry, LogRocket)
- Error grouping and deduplication
- Performance metrics alongside errors
- Session replay for complex UI errors

