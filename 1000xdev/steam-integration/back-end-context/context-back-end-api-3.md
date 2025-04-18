## Utilities System
Folder filepath: back-end\app\utils

The utilities directory contains essential helper functions and services that support the entire GigaSwap backend. These components provide cross-cutting functionality like logging, database migrations, Redis integration, and AWS CloudWatch connectivity.

### Key Components

#### logger.py
Implements a robust, configurable logging system:

- **Logger Class**:
  - Creates a customized logger that outputs to the `logs-main` directory
  - Supports organization with optional subdirectories
  - Uses rotating file handlers with configurable size limits (10MB default)
  - Maintains up to 5 backup files for each log

- **Specialized Logging Methods**:
  - Standard log levels (info, error, warning, debug)
  - API-specific logging with `log_api(method, endpoint, status_code, error)`
  - Database operation logging with `log_db(operation, table, success, duration_ms)`

- **Backward Compatibility**:
  - `setup_logger()` function for existing code
  - Maintains compatibility with older logging patterns
  - Ensures consistent logging behavior across the application

#### migration_utils.py
Provides tooling for database schema management:

- **Migration Management**:
  - `check_migrations()`: Determines if migrations are needed
  - `reset_migrations()`: Resets migration history (with safety warnings)
  - `get_migration_status()`: Reports on applied migrations

- **Version Tracking**:
  - Uses a dedicated `migration_versions` table
  - Compares current version with expected version
  - Provides clear logging about migration status

#### redis_config.py
Manages Redis connectivity for caching and session storage:

- **Singleton Pattern**:
  - `RedisClient` class with singleton implementation
  - Ensures only one Redis connection is created
  - Provides consistent connection management

- **Connection Management**:
  - Loads Redis URL from environment variables
  - Includes thorough error handling and logging
  - Contains debug logging for connection troubleshooting

- **Simple Interface**:
  - `get_redis_connection()` function for easy access
  - Consistent access pattern for Redis throughout the application

#### cloudwatch_handler.py
Facilitates AWS CloudWatch integration for cloud logging:

- **Cloud Integration**:
  - Creates and manages AWS CloudWatch log groups and streams
  - Configures watchtower handlers for Python logging
  - Ensures log groups exist before attempting to write

- **Stream Management**:
  - Maps application log types to appropriate CloudWatch streams
  - Maintains organized log structure in AWS
  - Provides defaults for unmapped log types

- **Configuration**:
  - Uses environment variables for AWS credentials and region
  - Configurable batch size and sending intervals
  - Optimized for efficient CloudWatch API usage

#### clear_logs.py
Simple utility for log management:

- **Log Cleanup**:
  - Recursively clears log files while preserving directory structure
  - Can be run as a standalone script
  - Provides detailed output of removed files

### Integration with Other Modules

The utilities system integrates with all other parts of the application:

- **Authentication**: Logger for auth events, Redis for session management
- **Database**: Migration utilities for schema management
- **API Routes**: Logging of request/response details
- **Error Handling**: Standardized error logging patterns
- **Configuration**: Environment variable integration

These utilities provide essential infrastructure that enables the reliable operation of the entire GigaSwap backend, ensuring proper logging, database migrations, caching, and cloud integration across all application components.

## Application Entry Point
Folder filepath: back-end\app\main.py

The main.py file serves as the entry point for the GigaSwap backend FastAPI application. It orchestrates all components, configures middleware, and manages the application lifecycle.

### Key Components

#### Application Initialization
- Creates the FastAPI application instance
- Configures Cross-Origin Resource Sharing (CORS) to allow frontend integration
- Sets up the main application logger with the custom logging system

```python
app = FastAPI()

# Setup logger
logger = get_logger('main', 'app')
logger.info("Main application starting")

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

#### Middleware Configuration
- Adds the custom LoggingMiddleware for request tracking and performance monitoring
- Configures CORS middleware with development-friendly settings (permissive origins)

#### Router Integration
Integrates all module-specific routers into the main application:
- `user_router`: User management endpoints
- `auth_router`: Authentication and authorization endpoints
- `order_router`: Order processing endpoints
- `logs_router`: Frontend logging endpoints

```python
# Include routers
app.include_router(user_router)
app.include_router(auth_router)
app.include_router(order_router)
app.include_router(logs_router)
```

#### Application Lifecycle Events
Defines event handlers for application startup and shutdown:

- **Startup Event**:
  - Initializes the database schema using `init_database()`
  - Starts the analytics background tasks scheduler
  - Logs application initialization

- **Shutdown Event**:
  - Stops the analytics background tasks gracefully
  - Performs logging cleanup
  - Ensures proper resource release

```python
@app.on_event("startup")
async def startup_event():
    logger.info("Application starting up")
    
    await init_database()
    
    # Start analytics background task scheduler
    start_analytics_scheduler()
    logger.info("Analytics background tasks initialized")

@app.on_event("shutdown")
async def shutdown_event():
    logger.info("Application shutting down")
    
    # Stop analytics background task scheduler
    stop_analytics_scheduler()
    logger.info("Analytics background tasks stopped")
    
    logging.shutdown()
```

#### Root Endpoint
Provides a simple welcome endpoint at the application root:
- Responds to GET requests at "/"
- Returns a welcome message
- Logs access to this endpoint

```python
@app.get("/")
async def root():
    logger.info("Root endpoint accessed", {"component": "API"})
    return {"message": "WELCOME TO POLYGON EXPRESS"}
```

### Integration with Other Modules
Filepath: 
The main.py file integrates with all other parts of the application:

- **User System**: Includes user management routes
- **Authentication System**: Includes auth routes
- **Orders System**: Includes order processing routes
- **Logging System**: Configures application-wide logging
- **Database System**: Ensures database is initialized on startup
- **Analytics System**: Manages background tasks lifecycle

As the central orchestrator, main.py binds together all the different components of GigaSwap into a cohesive application, ensuring proper initialization, configuration, and resource management throughout the application lifecycle.
