# GigaSwap Back-End API

## Authentication System 
Folder Filepath: back-end\app\auth

The GigaSwap backend implements a secure wallet-based authentication system, found in the `app/auth` directory. This system allows users to authenticate using their blockchain wallet addresses, adding an additional layer of security through cryptographic signature verification.

### Authentication Flow

1. **Request Authentication**:
   - User sends their wallet address to `/auth/request`
   - Backend generates a unique nonce and returns a message to be signed
   - Message includes welcome text and the generated nonce

2. **Signature Verification**:
   - User signs the message with their wallet's private key10
   - User sends the signature back to `/auth/verify` along with their wallet address and nonce
   - Backend verifies the signature using web3 libraries
   - If valid, a JWT token is generated and returned to the user

3. **Session Management**:
   - JWT tokens are used for subsequent API requests
   - Sessions are tracked in Redis for fast validation
   - Rate limiting protects against abuse

### Key Components

#### auth_services.py
The core business logic for authentication, implementing:
- `initiate_auth()`: Creates a new authentication session with nonce
- `verify_signature()`: Verifies Ethereum signatures using web3
- `get_current_user()`: FastAPI dependency for extracting the current user from JWT

#### auth_queries.py
Handles the data persistence aspects of authentication:
- Currently uses an in-memory session store for development
- Functions for creating and verifying sessions
- Automatic cleanup of expired sessions

#### token_manager.py
A utility class for JWT operations:
- Token generation with configurable expiration
- Token verification and payload extraction
- Uses the JWT_SECRET from environment variables

#### session_manager.py
Manages user sessions with Redis integration:
- Creates sessions with appropriate TTL (Time-To-Live)
- Validates session tokens
- Designed for future PostgreSQL persistence

#### auth_routes.py
Defines the FastAPI routes for authentication:
- `POST /auth/request`: Initiates the authentication process
- `POST /auth/verify`: Verifies signatures and issues tokens
- Comprehensive error handling and logging

#### Models
- `auth_models.py`: Core authentication models (AuthRequest, SignatureRequest, etc.)
- `models/session_models.py`: Session-specific data models

#### Middleware
- `middleware/rate_limiter.py`: Prevents abuse through Redis-backed rate limiting

### Special Features

1. **Test Address Support**: The system includes special handling for addresses prefixed with "test_", bypassing signature verification for testing purposes.

2. **Rate Limiting**: Protects authentication endpoints from abuse by limiting requests per wallet address within a configurable time window.

3. **Comprehensive Logging**: Detailed logging throughout the authentication process for monitoring and debugging.

4. **Redis Integration**: Fast in-memory storage for sessions and rate limiting.

### Integration with Other Modules

The authentication system integrates with other parts of the application:
- User module for retrieving user details based on wallet address
- FastAPI dependency system for protecting routes
- Redis for session management and rate limiting
- Database for long-term session persistence (planned)

## Dependencies System
Folder filepath: back-end\app\dependencies

The dependencies directory contains reusable dependency injection components that are used across different routes in the FastAPI application. In FastAPI, dependencies are functions that can be injected into route handlers to perform common tasks like authentication, validation, or database access.

### Key Components

#### auth.py
This file provides authentication-related dependencies for the FastAPI routes:

- **JWT Token Validation**: Uses the `jose` library to decode and validate JWT tokens from request headers
- **Dependency Functions**:
  - `get_current_user_optional()`: A non-strict authentication dependency that:
    - Extracts and validates the JWT token from the Authorization header
    - Decodes the token to extract the wallet address
    - Retrieves the corresponding user from the database
    - Returns the user if authenticated, or None if no token or invalid token
    - Does not raise exceptions for unauthenticated requests
  - `get_current_user()`: A strict authentication dependency that:
    - Performs the same token validation and user retrieval as the optional version
    - Raises HTTP 401 Unauthorized exceptions for missing or invalid tokens
    - Returns the authenticated user or throws an exception
- **Security Scheme**: Uses FastAPI's HTTPBearer security scheme to extract tokens from Authorization headers
- **Environment Integration**: Loads the JWT secret from environment variables using dotenv

### Usage in Routes

These dependencies are used throughout the application to:

1. **Protect Routes**: Ensure only authenticated users can access certain endpoints
2. **Retrieve User Context**: Provide route handlers with the current user's information
3. **Optional Authentication**: Allow endpoints to behave differently for authenticated vs. anonymous users

### Integration with Other Modules

The dependencies system integrates with:
- The auth module for JWT token validation
- The users module to retrieve user information
- FastAPI's dependency injection system
- Environment configuration via dotenv

## Database System
Filepath: back-end\app\gigaland_database

The GigaSwap backend uses a PostgreSQL database (via Neon) with a robust architecture that includes connection pooling, schema migrations, and transaction management. This module provides a comprehensive data layer that ensures reliable database operations while maintaining schema versioning and data integrity.

### Key Components

#### connection.py
This file handles all database connectivity concerns:
- **Connection Pooling**: Uses psycopg2's SimpleConnectionPool for efficient connection management (1-20 connections)
- **Result Formatting**: Configures connections with RealDictCursor for JSON-like query results
- **Error Handling**: Comprehensive error handling with logging
- **Query Execution**: Provides the `execute_query()` function for running parameterized SQL queries safely

#### migrations.py
Implements a version-controlled database migration system:
- **Ordered Migrations**: Applies SQL migration files in sequential order
- **Version Tracking**: Records applied migrations in a dedicated database table
- **Transactional Safety**: Executes migrations within transactions with rollback capability
- **Idempotence**: Skips already-applied migrations to prevent duplicate execution

#### initialize.py
Handles database initialization and verification:
- **Table Verification**: Ensures all required database tables exist
- **Error Handling**: Custom error handling with DatabaseInitError
- **Integration**: Works with the migration system to ensure schema is up-to-date
- **Required Tables**: Verifies critical tables (users, sessions, migration_versions, orders)

#### run_migrations.py
A standalone executable script for database migrations:
- **Migration Table**: Creates and manages the migration_versions tracking table
- **File Discovery**: Automatically discovers migration files in the migrations directory
- **Sequential Execution**: Applies migrations in the correct order based on filename
- **Command-line Interface**: Can be run directly to update the database schema

### Database Schema

The database schema evolves through a series of migrations:

1. **Users Table** (001_create_users_table.sql):
   - UUID primary key with polygon wallet address as unique identifier
   - Basic user profile fields (firstname, lastname, status)
   - UUID extension for generating unique identifiers

2. **Sessions Table** (002_create_sessions_tables.sql):
   - Stores authentication sessions with expiration
   - Links sessions to wallet addresses

3. **Order Management** (005_create_orders_tables.sql):
   - Orders table with total price, tax, shipping, and status
   - Order items with product details and quantities
   - Foreign key relationships and constraints
   - Optimized indexes for common queries

4. **User Analytics** (006_add_user_analytics_fields.sql):
   - Transaction tracking (total transactions, volume)
   - Performance metrics (success/failure rates)
   - Temporal data (last transaction date)
   - Optimized indexes for analytics queries

### Migration System

The migration system follows best practices for database schema evolution:

- **Version Control**: Each migration is numbered and tracked in the database
- **Idempotent Design**: Migrations use IF EXISTS/IF NOT EXISTS to allow safe re-execution
- **Forward-Only**: Migrations are designed to only move forward, with rollback comments provided
- **Transactional Safety**: Each migration runs in a transaction that can be rolled back on failure
- **Progressive Evolution**: Schema evolves incrementally through focused migrations

### Integration with Other Modules

The database system integrates with other parts of the application:
- Provides data access for authentication and user management
- Supports order processing and transaction tracking
- Enables analytics through properly indexed tables
- Connects with the FastAPI application through dependency injection

### Test Queries

The test_queries directory contains SQL files for database testing and verification:
- User information queries for authentication testing
- Sample order creation for e-commerce functionality testing

## Middleware System
Folder filepath: back-end\app\middleware

The middleware system in GigaSwap provides request processing capabilities that execute before and after route handlers. These components handle cross-cutting concerns like logging, timing, and error handling without cluttering the business logic in route handlers.

### Key Components

#### logging_middleware.py
This file implements a comprehensive request logging middleware:

- **Request Timing**: 
  - Records the start time of each request
  - Calculates and logs the duration in milliseconds
  - Adds an X-Process-Time header to responses for client-side timing awareness

- **Detailed Logging**:
  - Captures HTTP method, URL path, status code, and processing time
  - Records unsuccessful requests with error details
  - Uses Python's standard logging module with configurable levels

- **Selective Processing**:
  - Skips logging for specific paths (static files, health checks)
  - Reduces log volume and improves performance for high-frequency endpoints

- **Error Handling**:
  - Catches exceptions during request processing
  - Ensures errors are properly logged with details
  - Re-raises exceptions to be handled by FastAPI's exception handlers

### Implementation Details

The middleware is implemented using Starlette's BaseHTTPMiddleware class, which provides:

- **ASGI Compatibility**: Works with the ASGI standard for asynchronous web applications
- **Non-blocking Operation**: Uses async/await patterns for efficient request handling
- **Integration Points**: Easy integration with FastAPI's middleware stack
- **Extensibility**: Clear pattern for adding additional middleware components

### Integration with Other Modules

The middleware system integrates with other parts of the application:

- **FastAPI Application**: Registered in the main.py startup sequence
- **Logging System**: Works with the application's centralized logging configuration
- **Performance Monitoring**: Provides timing data for identifying bottlenecks
- **Error Tracking**: Ensures all errors are properly logged before being handled

This middleware layer serves as an essential part of the application's observability system, providing insights into request patterns, performance characteristics, and error conditions without requiring changes to individual route handlers.