### REQ-000: Styling for front-end

**Context**: Previously integrated Steam inventory endpoints in the front-end to display CS2 skin inventories from two Skinport bots on the /market page.

**Primary Data Sources**:
- **Skinport Bot #2331**: `GET /api/steam/profile/inventory/76561199562411448`
- **Skinport Bot #3257**: `GET /api/steam/profile/inventory/76561199800276630`

**Styling workflow**
I will send screenshots and work with you on specific front-end styling issues. I will always have the front-end server running. I will also have the node and uvicorn terminal in the context so that you can understand the logs as well.

### REQ-001: Better documentation for market page (ensure 100% accuracy)
Remove all legacy references to "CS2 Guns" and related models


### REQ-002
(After full stack testing)
Migrate all logs to the `back-end/logs` folder. Update all logger configurations, file paths, and related scripts to use the new log directory. Validate that all logging, log rotation, and log reading tools work as expected with the new structure. Update documentation to reflect the new log organization.

### REQ-003: Implement Next.js Runtime Error Logging System

**🚨 PRIORITY FOR FUTURE CYCLE, LONG IMPLEMENTATION**: This request addresses critical debugging challenges currently blocking efficient development. The inability to properly capture and view runtime errors is significantly impacting development velocity.

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

### REQ-004: Implement Pagination for Large Steam Inventory Datasets

**Objective**: Add pagination functionality to the market page to handle large Steam inventory datasets efficiently and improve user experience when browsing thousands of items.

**Context**: Current Steam inventory endpoints return large datasets (800+ items per bot, 1600+ combined) which can cause performance issues and poor user experience. The market page needs pagination to display manageable chunks of data.

**Implementation Requirements**:

1. **Pagination Controls**:
   - Add pagination component with page numbers, previous/next buttons
   - Display current page information (e.g., "Page 2 of 15")
   - Add "Go to page" input for quick navigation
   - Ensure pagination controls are accessible and keyboard navigable

2. **Page Size Options**:
   - Implement configurable page sizes (25, 50, 100 items per page)
   - Add page size selector dropdown
   - Remember user's preferred page size in local storage
   - Default to 50 items per page for optimal performance

3. **API Service Updates**:
   - Modify Steam API service to handle pagination parameters
   - Implement client-side pagination for cached inventory data
   - Add pagination state management in market page
   - Optimize data fetching to avoid re-fetching entire datasets

4. **Loading States**:
   - Add loading indicators for page transitions
   - Implement skeleton loaders for new page content
   - Ensure smooth transitions between pages
   - Handle loading states during page size changes

5. **URL State Management**:
   - Update URL parameters to reflect current page and page size
   - Enable browser back/forward navigation between pages
   - Preserve pagination state when applying filters or search
   - Support deep linking to specific pages

**Success Criteria**:
- Pagination works smoothly with large Steam inventory datasets
- Page transitions are fast and responsive
- User preferences are preserved across sessions
- URL state properly reflects pagination state
- Performance improves with paginated data display

### REQ-005: Implement Comprehensive Loading States and Error Handling

**Objective**: Create robust loading states and error handling throughout the market page to provide excellent user experience during API calls, failures, and edge cases.

**Context**: The Steam API integration involves large datasets, potential network issues, and various failure scenarios that need graceful handling with informative user feedback.

**Implementation Requirements**:

1. **Skeleton Loaders**:
   - Create skeleton loader components for inventory item cards
   - Implement skeleton loaders for category filters and search results
   - Add skeleton loaders for pagination controls
   - Ensure skeleton loaders match actual content layout and sizing

2. **Error Boundaries**:
   - Implement React error boundaries for Steam API failures
   - Create error boundary components for individual item cards
   - Add error boundaries for the entire market page section
   - Ensure error boundaries log errors via ConsolidatedLogger

3. **Retry Mechanisms**:
   - Add retry functionality for failed Steam API requests
   - Implement exponential backoff for retry attempts
   - Provide manual retry buttons for persistent failures
   - Display retry attempt counts and remaining attempts

4. **User-Friendly Error Messages**:
   - Create specific error messages for different failure types
   - Add contextual help text for common issues
   - Implement error message styling consistent with application theme
   - Provide actionable suggestions for error resolution

5. **Loading State Management**:
   - Implement global loading state for initial page load
   - Add per-section loading states (filters, search, pagination)
   - Create loading indicators for background operations
   - Ensure loading states don't interfere with user interactions

6. **Network Error Handling**:
   - Handle timeout errors with appropriate messaging
   - Manage offline/online state detection
   - Implement fallback behavior for partial API failures
   - Add network status indicators when relevant

**Success Criteria**:
- All loading states provide clear feedback to users
- Error messages are helpful and actionable
- Retry mechanisms work reliably for recoverable errors
- Error boundaries prevent application crashes
- Loading performance feels responsive and smooth

### REQ-006: Ensure Responsive Design Across All Device Sizes

**Objective**: Optimize the market page layout and interactions for mobile, tablet, and desktop devices, ensuring excellent user experience across all screen sizes.

**Context**: The market page displays complex inventory grids, filters, and controls that need to work seamlessly on mobile devices while maintaining the rich desktop experience.

**Implementation Requirements**:

1. **Mobile Layout Optimization**:
   - Optimize inventory item grid for mobile screens
   - Implement touch-friendly card sizing and spacing
   - Ensure category filter buttons are easily tappable
   - Adapt pagination controls for mobile interaction patterns

2. **Touch-Friendly Controls**:
   - Increase touch target sizes for all interactive elements
   - Implement swipe gestures for category navigation
   - Add touch feedback and hover states for mobile
   - Ensure search and filter controls work well with touch input

3. **Image Loading Optimization**:
   - Implement responsive image sizing for different screen densities
   - Add lazy loading specifically optimized for mobile data usage
   - Provide image loading placeholders with appropriate sizing
   - Optimize image formats and compression for mobile networks

4. **Cross-Device Testing**:
   - Test layout on phones (320px-480px width)
   - Verify tablet experience (768px-1024px width)
   - Ensure desktop functionality (1200px+ width)
   - Test on various device orientations and zoom levels

5. **Performance Optimization**:
   - Minimize layout shifts during loading on mobile
   - Optimize CSS and JavaScript delivery for mobile
   - Implement efficient scroll handling for large item lists
   - Reduce memory usage for mobile device limitations

6. **Accessibility on Mobile**:
   - Ensure proper focus management on touch devices
   - Implement screen reader compatibility for mobile
   - Add appropriate ARIA labels for touch interactions
   - Test with mobile accessibility tools

**Success Criteria**:
- Market page works seamlessly on all device sizes
- Touch interactions feel natural and responsive
- Image loading is optimized for mobile networks
- Performance remains good on lower-end mobile devices
- Accessibility standards are met across all devices

