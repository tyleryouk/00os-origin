# Back-End Dependencies

> **[Updated 2025-06-26]**

# Back-End Dependencies Overview

This document provides a comprehensive list of all dependencies used in the GigaSwap back-end application. This list is generated from the actual `requirements.txt` and should be checked each cycle for accuracy. Do not manually maintain this file—always cross-reference with `requirements.txt`.

## Core Framework Dependencies

- **FastAPI**: `fastapi>=0.110.0` - High-performance async web framework for building APIs
- **Uvicorn**: `uvicorn[standard]==0.24.0` - ASGI server for FastAPI
- **Starlette**: `starlette>=0.36.3` - Lightweight ASGI framework/toolkit (FastAPI is built on Starlette)

## Database & Storage

- **Psycopg2**: `psycopg2-binary>=2.9.9` - PostgreSQL adapter for Python
- **DJ Database URL**: `dj-database-url==1.0.0` - Database URL configuration utility

## Authentication & Security

- **Python-JOSE**: `python-jose[cryptography]==3.3.0` - JavaScript Object Signing and Encryption implementation
- **PyJWT**: `pyjwt==2.10.1` - JSON Web Token implementation
- **Bcrypt**: `bcrypt==4.2.1` - Password hashing
- **Passlib**: `passlib[bcrypt]==1.7.4` - Password hashing library
- **Cryptography**: `cryptography==44.0.0` - Cryptographic recipes and primitives
- **Pydantic**: `pydantic>=2.0` - Data validation and settings management
- **Email Validator**: `email-validator==2.2.0` - Email validation
- **DNSPython**: `dnspython==2.7.0` - DNS toolkit for Python (used by email-validator)

## Web3 Integration

- **Web3.py**: `web3==6.11.3` - Python interface for Ethereum blockchain
- **Eth-Account**: `eth-account==0.8.0` - Account management for Ethereum
- **Eth-Utils**: `eth-utils==2.3.1` - Utility functions for Ethereum code

## Caching & Session Management

- **Redis**: `redis==5.0.1` - Redis client
- **AioRedis**: `aioredis==2.0.1` - Async Redis client

## Task Scheduling

- **APScheduler**: `apscheduler==3.10.4` - Advanced Python Scheduler for periodic tasks

## Monitoring & Logging

- **Watchtower**: `watchtower==3.0.1` - Log handler for AWS CloudWatch
- **Python JSON Logger**: `python-json-logger==2.0.7` - JSON formatter for Python's standard logging

## API Documentation & Validation

- **Python Multipart**: `python-multipart==0.0.6` - Multipart form parser (for file uploads)
- **Swagger UI Bundle**: `swagger-ui-bundle==0.0.9` - Swagger UI for API documentation

## Development & Testing

- **Pytest**: `pytest==7.4.3` - Testing framework
- **Pytest-AsyncIO**: `pytest-asyncio==0.21.1` - Pytest support for asyncio
  - *Critical for testing async API endpoints against live servers*
  - *Enables `@pytest.mark.asyncio` decorator for async test functions*
  - *Required for our dual-approach testing strategy*
- **Pytest-Cov**: `pytest-cov==4.1.0` - Coverage reporting for pytest
- **HTTPX**: `httpx==0.25.2` - Async HTTP client (for testing APIs)
  - *Essential for making async HTTP requests in tests*
  - *Used in both formal test suites and script-based testing*
  - *Provides AsyncClient for testing FastAPI endpoints against a live server*
  - *More modern alternative to the requests library with async support*
- **Python-Dotenv**: `python-dotenv>=1.0.0` - Environment variable loading from .env files
- **Black**: `black==23.11.0` - Code formatter
- **Flake8**: `flake8==6.1.0` - Linting tool
- **Requests**: `requests==2.32.3` - HTTP client for synchronous API calls
  - *Used primarily in script-based testing for simplicity*

## AWS Integration

- **Boto3**: `boto3==1.34.34` - AWS SDK for Python
- **Botocore**: `botocore==1.34.34` - Low-level AWS API client

## Utilities

- **Pip-Chill**: `pip-chill==1.0.3` - Output installed packages without dependencies
- **Pipreqs**: `pipreqs==0.4.13` - Generate requirements.txt based on imports

## Testing Strategy Dependencies

GigaSwap uses a dual-approach testing strategy that relies on specific packages:

1. **Script-based Testing** (`/scripts`):
   - **Requests**: Simple synchronous HTTP client for direct API testing
   - **JSON**: Standard library for JSON handling
   - **Dotenv**: For loading environment variables with API keys

2. **Formal Test Suite** (`/tests`):
   - **Pytest**: Core testing framework
   - **Pytest-AsyncIO**: For async test support
   - **HTTPX**: Modern async HTTP client
   - **AsyncClient**: From HTTPX, for async requests to live server
   - **Pytest-Cov**: For test coverage reporting

### Installing Testing Dependencies

```bash
# Activate virtual environment
.\.gigaland\Scripts\Activate.ps1

# Install core testing dependencies
pip install pytest pytest-asyncio httpx pytest-cov

# Install additional dependencies for script-based testing
pip install requests python-dotenv
```

## Dependency Management Best Practices

1. **Version Pinning**:
   - Most dependencies are pinned to specific versions to ensure reproducibility
   - Some critical libraries use `>=` to allow patch updates while maintaining compatibility

2. **Security Updates**:
   - Regularly update dependencies to address security vulnerabilities
   - Use `pip list --outdated` to check for updates

3. **Dependency Conflicts**:
   - When experiencing conflicts, use `pip check` to verify dependency compatibility
   - Consider using virtual environments for testing dependency changes

4. **Adding New Dependencies**:
   - Always add new dependencies to requirements.txt with specific versions
   - Document the purpose of the dependency in this file
   - Test thoroughly before committing changes

5. **Environment Isolation**:
   - Use virtual environments for development and deployment
   - Current Python version: Check .python-version file in the repository root 