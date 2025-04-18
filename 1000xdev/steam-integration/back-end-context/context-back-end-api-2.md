## Orders System
Folder filepath: back-end\app\orders

The Orders system in GigaSwap handles blockchain-based transactions for NFTs and digital products, providing a complete e-commerce solution with clear separation between buyers and sellers. The system manages the entire order lifecycle from creation to completion, with support for cryptocurrency payments and blockchain transaction tracking.

### Key Components

#### order_models.py
Defines the data structures using Pydantic models:

- **Enum Types**:
  - `OrderStatus`: Represents order states (PENDING, COMPLETED, CANCELLED, FAILED)

- **Base Models**:
  - `OrderItemBase`: Details of individual items within an order (product info, quantity, price)
  - `OrderBase`: Common fields for all order operations
  - `OrderCreate`: Model for creating new orders
  - `OrderUpdate`: Model for updating order status and transaction hash
  - `OrderInDB`: Internal representation with database-specific fields
  - `OrderResponse`: API response format for order details
  - `OrderListResponse`: Paginated list of order responses
  - `OrderSummary`: Aggregated order statistics and metrics
  - `OrderFilterParams`: Query parameters for filtering orders

#### order_queries.py
Contains raw SQL queries for database operations:

- **Create Operations**:
  - `create_order_query()`: Creates a new blockchain order with buyer/seller info
  - `create_order_items_query()`: Adds product items to an order

- **Retrieve Operations**:
  - `get_orders_by_user_query()`: Fetches paginated orders for a wallet address
  - `get_order_by_id_query()`: Gets details of a specific order
  - `get_order_summary_query()`: Retrieves aggregated order statistics

- **Update Operations**:
  - `update_order_status_query()`: Updates order status and transaction hash

Each function includes comprehensive error handling and transaction management.

#### order_services.py
Business logic layer that manages database connections and implements core functionality:

- **Service Methods**:
  - `create_order()`: Initiates new blockchain order transactions
  - `get_user_orders()`: Retrieves orders with pagination and filtering
  - `get_order_by_id()`: Fetches complete details for a specific order
  - `update_order_status()`: Changes order status with transaction ID updates
  - `cancel_order()`: Cancels pending orders
  - `get_order_summary()`: Generates statistics and metrics for user orders
  - `format_orders_response()`: Transforms database rows into API response models

- **Logging System**:
  - `log_order_service()`: Standardized logging helper for consistency

#### order_routes.py
FastAPI endpoints that expose the order functionality:

- **Order Management Endpoints**:
  - `POST /orders/create-order/`: Creates a new order for NFT or digital product purchase
  - `GET /orders/user/{wallet_address}`: Gets paginated orders for a specific user
  - `GET /orders/{order_id}`: Retrieves details of a specific order
  - `PATCH /orders/{order_id}/status`: Updates order status with transaction details
  - `POST /orders/{order_id}/cancel`: Cancels a pending order
  - `GET /orders/summary/`: Gets order statistics and recent order history

- **Authentication Integration**:
  - Uses `get_current_user` dependency for secure access
  - Verifies that order operations are performed by authorized users
  - Enforces role-specific permissions (buyer vs. seller actions)

- **Logging**:
  - `log_order_event()`: Standardized logging for order-related events

### Key Features

1. **Blockchain Integration**:
   - Orders store transaction hashes when completed
   - Supports cryptocurrency payments (MATIC)
   - Maintains product-specific metadata for different blockchain assets

2. **Role-Based Permissions**:
   - Distinguishes between buyers and sellers
   - Enforces rules like "only buyers can cancel" and "only sellers can complete"
   - Secures order data by verifying wallet ownership

3. **Order Lifecycle Management**:
   - Complete order flow from creation to completion
   - Status transitions with appropriate validation
   - Cancellation handling with proper authorization

4. **Analytics and Reporting**:
   - Summary statistics (total orders, total spent)
   - Status-based grouping for insights
   - Calculation of metrics like average order value
   - Recent order history for quick reference

5. **Error Handling and Logging**:
   - Comprehensive error handling at every level
   - Detailed logging with structured contexts
   - Service-level and route-level logging separation

### Integration with Other Modules

The Orders system integrates with:
- **Authentication Module**: For wallet address verification and authorization
- **Database System**: For persistent storage of order data and relationships
- **User Module**: For buyer/seller information and validation
- **Blockchain Services**: For transaction verification (implied)

This modular approach allows the Orders system to operate efficiently while maintaining clear boundaries with other system components.

## Routes System
Folder filepath: back-end\app\routes

The routes directory contains additional FastAPI routers that don't fit into the domain-specific modules like auth, users, or orders. These routes handle cross-cutting concerns or functionality that isn't tied to a specific business domain.

### Key Components

#### logs_routes.py
This file implements a dedicated endpoint for frontend logging:

- **Frontend Log Collection**:
  - Provides a `POST /logs-main` endpoint for receiving log entries from the frontend
  - Processes logs according to their specified level (ERROR, DEBUG, INFO)
  - Uses the backend's centralized logging system to store frontend logs

- **User Context Enhancement**:
  - Uses `get_current_user_optional` dependency to detect authenticated users
  - Enriches log entries with user information when available
  - Preserves logs from unauthenticated users for complete visibility

- **Log Level Processing**:
  - Routes logs to appropriate logger methods based on their level
  - Maintains consistent logging patterns across frontend and backend
  - Preserves log details in structured format

- **Error Handling**:
  - Catches and logs exceptions during log processing
  - Returns appropriate HTTP status codes for client issues
  - Provides detailed error information for debugging

### Implementation Details

The logs endpoint demonstrates several best practices:

- **Optional Authentication**: Allows both authenticated and anonymous logs
- **Structured Logging**: Maintains consistent log format with the rest of the application
- **Exception Handling**: Properly handles and reports errors during log processing
- **API Tagging**: Uses FastAPI's tagging system for API documentation organization

### Integration with Other Modules

The routes system integrates with:

- **Authentication System**: For optional user identification
- **Logging System**: For consistent log processing and storage
- **API Documentation**: Routes are included in the OpenAPI documentation
- **Frontend Application**: Receives and processes logs from client-side code

This approach creates a unified logging experience where both frontend and backend events are captured in a consistent format, enabling better debugging, monitoring, and analytics across the entire application stack.

## Users System
Folder filepath: back-end\app\users

The Users system in GigaSwap provides comprehensive user management with a focus on blockchain wallet addresses as primary identifiers. It handles user profiles, transaction analytics, and offers background processing for efficient data management.

### Key Components

#### user_models.py
Defines the data structures using Pydantic models:

- **Core User Models**:
  - `UserModel`: Primary user data model with wallet address and profile fields
  - `UserUpdateModel`: Model for updating user profile information
  - `UserResponse`: API response format with user details

- **Analytics Models**:
  - `UserAnalytics`: User transaction metrics (volume, success rates)
  - `WalletAnalytics`: Detailed blockchain wallet activity statistics
  - `RecentTransaction`: Simplified transaction representation for API responses
  - `ProfileCompletion`: Tracks profile completeness with recommendations

#### user_queries.py
Contains database operations for user management:

- **Core CRUD Operations**:
  - `create_user_query()`: Register new users with wallet addresses
  - `get_user_by_wallet_query()`: Retrieve users by wallet address
  - `update_user_query()`: Update user profile information
  - `delete_user_by_wallet_query()`: Remove users from the system
  - `get_all_users_query()`: List all users in the database

- **Analytics Operations**:
  - `update_user_analytics_query()`: Update transaction metrics
  - `get_user_analytics_query()`: Retrieve user statistics

Each function includes proper error handling and transaction management with detailed logging.

#### user_services.py
Business logic layer with database connection management:

- **User Management**:
  - `create_user()`: Generate UUIDs and register new users
  - `get_user_by_wallet()`: Retrieve and format user data
  - `update_user()`: Handle profile updates with JSON serialization
  - `delete_user_by_wallet()`: Manage user removal
  - `get_all_users()`: Retrieve user listings

- **Special Features**:
  - JSON handling for user preferences
  - Comprehensive exception management
  - Consistent logging patterns

#### user_routes.py
FastAPI endpoints that expose user functionality:

- **Basic User Management**:
  - `POST /users/create-user/`: Register new users
  - `GET /users/wallet/{address}`: Get user by wallet address
  - `PUT /users/wallet/{address}`: Update user data
  - `DELETE /users/wallet/{address}`: Remove users
  - `GET /users/all_users/`: List all users

- **Profile Management**:
  - `GET /users/profile`: Get authenticated user's profile
  - `PUT /profile`: Update profile information
  - `GET /profile/completion`: Calculate profile completeness with recommendations

- **Analytics Endpoints**:
  - `GET /users/{wallet_address}/analytics`: Get detailed wallet transaction data

- **Authentication Integration**:
  - Uses `get_current_user` dependency for secure access
  - Enforces ownership of wallet data
  - Role-based access control for admin functions

#### wallet_analytics_service.py
Specialized service for blockchain wallet analytics:

- **Data Management**:
  - `get_or_calculate_analytics()`: Cached access to analytics data
  - `calculate_analytics()`: Generate metrics from transaction history
  - `update_analytics_for_transaction()`: Real-time metric updates

- **Caching Architecture**:
  - Redis integration for performance optimization
  - TTL-based cache invalidation
  - Fallback to direct calculation when cache unavailable

- **Metrics Calculation**:
  - Transaction counts and volume
  - Success rates and failure analysis
  - Average transaction amounts
  - Recent transaction history

#### analytics_background_tasks.py
Background processing system for analytics:

- **Scheduled Processing**:
  - `update_all_wallet_analytics()`: Update metrics for all active users
  - `get_active_wallets()`: Identify wallets with recent activity
  - `update_wallet_analytics()`: Process individual wallet updates

- **Task Management**:
  - AsyncIO scheduler for non-blocking operation
  - Hourly scheduled updates
  - Batch processing to manage database load
  - Graceful error handling for reliability

### Key Features

1. **Blockchain-First Design**:
   - Uses wallet addresses as primary identifiers
   - Tracks transaction metrics specific to blockchain operations
   - Specialized wallet analytics for cryptocurrency activity

2. **Comprehensive Analytics**:
   - Real-time and scheduled analytics calculation
   - Transaction volume and success metrics
   - Performance optimizations through caching
   - Background processing for large-scale data

3. **Profile Management**:
   - Complete user profile functionality
   - Profile completion scoring and recommendations
   - Preference storage with JSON serialization
   - Flexible update capabilities

4. **Security Considerations**:
   - Permission checks for accessing wallet data
   - Role-based access control
   - Proper transaction handling for data integrity

5. **Performance Optimizations**:
   - Connection pooling for database access
   - Redis caching for frequently accessed data
   - Asynchronous background processing
   - Batched operations for large datasets

### Integration with Other Modules

The Users system integrates with:
- **Authentication Module**: For wallet address verification and secure access
- **Database System**: For persistent storage of user data and analytics
- **Order Module**: For tracking transaction history and metrics
- **Redis Cache**: For performance optimization of analytics queries
- **Background Processing**: For efficient handling of resource-intensive operations

This architecture allows the Users system to provide a complete solution for blockchain-based user management while maintaining high performance and security standards.