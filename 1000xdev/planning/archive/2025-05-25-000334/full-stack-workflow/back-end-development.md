# GigaSwap Back-End Development Guide

This document provides comprehensive guidance for back-end development in the GigaSwap project, focusing on testing and logging practices.

## Table of Contents

- [Testing](#testing)
  - [Testing Architecture](#testing-architecture)
  - [Setting Up the Test Environment](#setting-up-the-test-environment)
  - [Running Tests](#running-tests)
  - [Unit Testing](#unit-testing)
  - [API Testing](#api-testing)
  - [Database Testing](#database-testing)
  - [Mock Strategies](#mock-strategies)
- [Logging](#logging)
  - [Logger Configuration](#logger-configuration)
  - [Directory Structure](#directory-structure)
  - [Usage Examples](#usage-examples)
  - [Log Rotation](#log-rotation)
  - [Log Analysis](#log-analysis)

## Testing

### Testing Architecture

The back-end testing architecture consists of:

1. **Unit Tests**: Testing individual functions and classes
2. **API Tests**: Testing FastAPI endpoints
3. **Integration Tests**: Testing interactions between services
4. **Database Tests**: Testing repository classes and database operations

### Setting Up the Test Environment

#### Prerequisites

- Python 3.9+
- pip
- pytest
- Access to the GigaSwap repository

#### Installation

```bash
# Navigate to the back-end directory
cd back-end

# Install dependencies
pip install -r requirements-dev.txt
```

### Running Tests

```bash
# Run all tests
python -m pytest

# Run tests for a specific module
python -m pytest tests/auth/

# Run a specific test file
python -m pytest tests/auth/test_auth_service.py

# Run a specific test
python -m pytest tests/auth/test_auth_service.py::test_validate_token

# Run tests with coverage
python -m pytest --cov=app

# Generate HTML coverage report
python -m pytest --cov=app --cov-report=html
```

### Unit Testing

Unit tests focus on testing individual functions and classes in isolation.

#### Example: Testing Utility Functions

```python
# File: tests/utils/test_validators.py
import pytest
from app.utils.validators import validate_email, validate_password

class TestValidators:
    def test_validate_email_with_valid_email(self):
        """Test that validate_email accepts valid email addresses."""
        assert validate_email("user@example.com") == True
        assert validate_email("user.name+tag@example.co.uk") == True
    
    def test_validate_email_with_invalid_email(self):
        """Test that validate_email rejects invalid email addresses."""
        assert validate_email("not-an-email") == False
        assert validate_email("@example.com") == False
        assert validate_email("user@") == False
    
    def test_validate_password_with_valid_password(self):
        """Test that validate_password accepts valid passwords."""
        assert validate_password("StrongP@ss123") == True
        assert validate_password("Another-Valid-P@ssw0rd") == True
    
    def test_validate_password_with_invalid_password(self):
        """Test that validate_password rejects weak passwords."""
        # Too short
        assert validate_password("Short1!") == False
        # No uppercase
        assert validate_password("nouppercasep@ss123") == False
        # No lowercase
        assert validate_password("NOLOWERCASE123!") == False
        # No numbers
        assert validate_password("NoNumbers!@") == False
```

### API Testing

API tests verify that endpoints handle requests correctly and return appropriate responses.

#### Example: Testing FastAPI Endpoints

```python
# File: tests/api/test_user_routes.py
from fastapi.testclient import TestClient
import pytest
from app.main import app
from app.services.user_service import UserService
from unittest.mock import MagicMock

client = TestClient(app)

def test_get_user_profile_authenticated():
    """Test getting user profile when authenticated."""
    # Mock authentication and user service
    mock_user = {"id": "123", "name": "Test User", "email": "user@example.com"}
    
    # Override the dependency
    app.dependency_overrides[UserService] = lambda: MagicMock(
        get_user_by_id=MagicMock(return_value=mock_user)
    )
    
    # Make request with auth token
    response = client.get(
        "/api/users/profile",
        headers={"Authorization": "Bearer test_token"}
    )
    
    # Assert response
    assert response.status_code == 200
    assert response.json() == mock_user

def test_get_user_profile_unauthenticated():
    """Test getting user profile when not authenticated."""
    # Make request without auth token
    response = client.get("/api/users/profile")
    
    # Assert response
    assert response.status_code == 401
    assert "detail" in response.json()
    
    # Clean up dependency override
    app.dependency_overrides = {}
```

### Database Testing

Database tests verify that repository classes correctly interact with the database.

#### Example: Testing Database Operations

```python
# File: tests/repositories/test_user_repository.py
import pytest
import asyncio
from app.repositories.user_repository import UserRepository
from app.models.user import UserCreate, User

@pytest.fixture
async def user_repository():
    """Create a user repository with test database connection."""
    # Connect to test database
    repo = UserRepository(test_database_connection)
    
    # Clean up before test
    await repo.delete_all_users()
    
    yield repo
    
    # Clean up after test
    await repo.delete_all_users()

@pytest.mark.asyncio
async def test_create_user(user_repository):
    """Test creating a new user."""
    # Create test user
    user_data = UserCreate(
        email="test@example.com",
        password="SecureP@ss123",
        name="Test User"
    )
    
    created_user = await user_repository.create_user(user_data)
    
    # Assert user was created
    assert created_user.id is not None
    assert created_user.email == "test@example.com"
    assert created_user.name == "Test User"
    
    # Verify user exists in database
    db_user = await user_repository.get_user_by_email("test@example.com")
    assert db_user is not None
    assert db_user.id == created_user.id

@pytest.mark.asyncio
async def test_get_user_by_id(user_repository):
    """Test retrieving a user by ID."""
    # Create test user
    user_data = UserCreate(
        email="test@example.com",
        password="SecureP@ss123",
        name="Test User"
    )
    created_user = await user_repository.create_user(user_data)
    
    # Get user by ID
    user = await user_repository.get_user_by_id(created_user.id)
    
    # Assert user was retrieved
    assert user is not None
    assert user.id == created_user.id
    assert user.email == "test@example.com"
```

### Mock Strategies

Effective mocking is crucial for isolating components during testing.

#### Mocking Database Connections

```python
# Using pytest-asyncio and unittest.mock
import pytest
from unittest.mock import AsyncMock, MagicMock

@pytest.fixture
def mock_db_session():
    """Create a mock database session."""
    session = MagicMock()
    session.execute = AsyncMock()
    session.commit = AsyncMock()
    session.rollback = AsyncMock()
    session.close = AsyncMock()
    return session

@pytest.mark.asyncio
async def test_user_repository_with_mock_db(mock_db_session):
    """Test user repository with mocked database session."""
    # Setup mock query result
    mock_result = MagicMock()
    mock_result.scalar_one_or_none.return_value = User(
        id="123",
        email="test@example.com",
        name="Test User"
    )
    mock_db_session.execute.return_value = mock_result
    
    # Create repository with mock session
    repo = UserRepository(mock_db_session)
    
    # Test method
    user = await repo.get_user_by_id("123")
    
    # Assert result
    assert user.id == "123"
    assert user.email == "test@example.com"
    
    # Verify mock was called correctly
    mock_db_session.execute.assert_called_once()
```

#### Mocking External Services

```python
# Using unittest.mock
from unittest.mock import AsyncMock, patch

@patch("app.services.steam_service.SteamAPIClient")
@pytest.mark.asyncio
async def test_steam_service(mock_steam_client):
    """Test Steam service with mocked API client."""
    # Setup mock client
    mock_instance = AsyncMock()
    mock_instance.get_user_inventory.return_value = [
        {"item_id": "1", "name": "Test Item", "value": 10.5}
    ]
    mock_steam_client.return_value = mock_instance
    
    # Create service with mock
    service = SteamService()
    
    # Test method
    inventory = await service.get_user_inventory("steam_id_123")
    
    # Assert result
    assert len(inventory) == 1
    assert inventory[0]["name"] == "Test Item"
    
    # Verify mock was called correctly
    mock_instance.get_user_inventory.assert_called_once_with("steam_id_123")
```

## Logging

### Logger Configuration

The back-end uses a custom Logger class built on top of Python's built-in logging module, with enhanced features for structured logging and file management.

```python
# app/utils/logger.py
import logging
import os
import json
from pathlib import Path
from logging.handlers import RotatingFileHandler
from pythonjsonlogger import jsonlogger
from datetime import datetime

class Logger:
    """
    Custom logger for GigaSwap backend
    
    Provides structured logging with consistent formatting
    and automatic log file management.
    """
    
    def __init__(self, name, component):
        """
        Initialize logger
        
        Args:
            name (str): Logger name
            component (str): Component name for categorization
        """
        self.name = name
        self.component = component
        self.logger = logging.getLogger(f"{name}.{component}")
        self.logger.setLevel(logging.DEBUG)
        
        # Set base directory for logs
        self.base_dir = Path("logs-main")
        
        # Create component directory if it doesn't exist
        self.log_dir = self.base_dir / component.lower()
        if not self.log_dir.exists():
            os.makedirs(self.log_dir)
        
        # Create log file handler
        log_file = self.log_dir / f"{name}.{component}.log"
        file_handler = RotatingFileHandler(
            log_file, 
            maxBytes=10 * 1024 * 1024,  # 10 MB
            backupCount=5
        )
        
        # Create combined log file handler
        combined_dir = self.base_dir / "combined"
        if not combined_dir.exists():
            os.makedirs(combined_dir)
        
        combined_file = combined_dir / "app.log"
        combined_handler = RotatingFileHandler(
            combined_file,
            maxBytes=50 * 1024 * 1024,  # 50 MB
            backupCount=10
        )
        
        # Create formatters
        json_formatter = jsonlogger.JsonFormatter(
            '%(timestamp)s %(level)s %(name)s %(component)s %(message)s %(data)s'
        )
        
        # Set formatter for handlers
        file_handler.setFormatter(json_formatter)
        combined_handler.setFormatter(json_formatter)
        
        # Add handlers to logger
        self.logger.addHandler(file_handler)
        self.logger.addHandler(combined_handler)
    
    def _log(self, level, message, data=None):
        """
        Generic logging method
        
        Args:
            level (str): Log level
            message (str): Log message
            data (dict, optional): Additional data to log
        """
        if data is None:
            data = {}
            
        extra = {
            'timestamp': datetime.utcnow().isoformat(),
            'component': self.component,
            'level': level,
            'data': data
        }
        
        getattr(self.logger, level.lower())(message, extra=extra)
    
    def debug(self, message, data=None):
        """Log debug message"""
        self._log('DEBUG', message, data)
    
    def info(self, message, data=None):
        """Log info message"""
        self._log('INFO', message, data)
    
    def warning(self, message, data=None):
        """Log warning message"""
        self._log('WARNING', message, data)
    
    def error(self, message, data=None):
        """Log error message"""
        self._log('ERROR', message, data)
    
    def critical(self, message, data=None):
        """Log critical message"""
        self._log('CRITICAL', message, data)
    
    def log_api_request(self, request, response, component=None):
        """
        Log API request and response
        
        Args:
            request: FastAPI request object
            response: FastAPI response object
            component (str, optional): Component name override
        """
        data = {
            'method': request.method,
            'url': str(request.url),
            'client_ip': request.client.host,
            'status_code': response.status_code,
            'processing_time': getattr(response, 'processing_time', None),
            'user_agent': request.headers.get('user-agent')
        }
        
        # Add request headers (excluding sensitive ones)
        headers = {}
        for key, value in request.headers.items():
            if key.lower() not in ('authorization', 'cookie'):
                headers[key] = value
        data['headers'] = headers
        
        level = 'ERROR' if response.status_code >= 500 else (
            'WARNING' if response.status_code >= 400 else 'INFO'
        )
        
        component = component or self.component
        message = f"API Request: {request.method} {request.url}"
        
        self._log(level, message, data)
    
    def log_database_operation(self, operation, table, duration, success, details=None, component=None):
        """
        Log database operation
        
        Args:
            operation (str): Database operation (e.g., SELECT, INSERT)
            table (str): Database table
            duration (float): Operation duration in milliseconds
            success (bool): Whether operation was successful
            details (dict, optional): Additional operation details
            component (str, optional): Component name override
        """
        if details is None:
            details = {}
            
        data = {
            'operation': operation,
            'table': table,
            'duration_ms': duration,
            'success': success,
            **details
        }
        
        level = 'ERROR' if not success else 'INFO'
        component = component or self.component
        message = f"Database {operation} on {table} - {'Success' if success else 'Failure'}"
        
        self._log(level, message, data)

# Factory function to get a logger instance
def get_logger(component, name="app"):
    """
    Get a logger instance
    
    Args:
        component (str): Component name
        name (str, optional): Logger name
        
    Returns:
        Logger: Logger instance
    """
    return Logger(name, component)
```

### Directory Structure

The back-end logging system organizes logs in the following directory structure:

```
logs-main/
├── api/                  # API-related logs
├── auth/                 # Authentication logs
├── combined/             # Combined logs from all components
│   └── app.log           # Main application log
├── orders/               # Order processing logs
├── steam/                # Steam API integration logs
└── users/                # User management logs
```

### Usage Examples

Here are examples of how to use the logger in different scenarios:

```python
from app.utils.logger import get_logger

# Create logger for authentication service
logger = get_logger("auth_service")

# Basic usage
logger.info("User logged in successfully")

# With additional data
logger.error(
    "Authentication failed", 
    {
        "user_id": "user123",
        "ip_address": "192.168.1.1",
        "reason": "invalid_credentials",
        "attempt": 3
    }
)

# Log API request
@app.get("/api/users/{user_id}")
async def get_user(user_id: str, request: Request, response: Response):
    start_time = time.time()
    try:
        user = await user_service.get_user(user_id)
        response.processing_time = time.time() - start_time
        logger.log_api_request(request, response)
        return user
    except Exception as e:
        response.status_code = 500
        response.processing_time = time.time() - start_time
        logger.log_api_request(request, response)
        logger.error(f"Error retrieving user", {"user_id": user_id, "error": str(e)})
        return {"detail": "Internal server error"}

# Log database operation
async def create_user(user_data: UserCreate):
    start_time = time.time()
    try:
        user = await db.users.insert_one(user_data.dict())
        duration = time.time() - start_time
        logger.log_database_operation(
            operation="INSERT",
            table="users",
            duration=duration * 1000,  # Convert to milliseconds
            success=True,
            details={"user_id": str(user.inserted_id)}
        )
        return user
    except Exception as e:
        duration = time.time() - start_time
        logger.log_database_operation(
            operation="INSERT",
            table="users",
            duration=duration * 1000,
            success=False,
            details={"error": str(e)}
        )
        raise
```

### Log Rotation

The back-end implements log rotation to prevent log files from growing too large:

- Each component log file is limited to 10 MB
- After reaching the size limit, the file is renamed with a suffix (.1, .2, etc.)
- A maximum of 5 backup files are kept per component
- The combined log file is limited to 50 MB with 10 backup files

### Log Analysis

#### Terminal Output Analysis

During development, log messages can be displayed in the terminal:

1. **Adding Console Handler**
   ```python
   # Add this to your logger configuration
   console_handler = logging.StreamHandler()
   console_formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
   console_handler.setFormatter(console_formatter)
   self.logger.addHandler(console_handler)
   ```

2. **Command Line Filtering**
   ```bash
   # Tail logs in real time
   tail -f logs-main/api/app.api.log
   
   # Filter logs by level
   grep "ERROR" logs-main/combined/app.log
   
   # View logs from the last hour
   find logs-main -mmin -60 -type f -name "*.log" -exec cat {} \;
   ```

#### Testing Through Logs

Logs can be used as part of the testing process:

```python
# Test that appropriate log messages are generated
def test_login_logs_success_and_failure(caplog):
    """Test that login attempts are properly logged."""
    # Set log level to ensure capturing
    caplog.set_level(logging.INFO)
    
    # Arrange
    service = AuthService()
    
    # Act - successful login
    service.login("user@example.com", "correct_password")
    
    # Assert successful login was logged
    assert "User logged in successfully" in caplog.text
    assert "user@example.com" in caplog.text
    
    # Clear log
    caplog.clear()
    
    # Act - failed login
    service.login("user@example.com", "wrong_password")
    
    # Assert failed login was logged
    assert "Authentication failed" in caplog.text
    assert "invalid_credentials" in caplog.text
```

#### Log File Analysis

For log files produced during testing or regular operation:

1. **Basic Log Analysis**
   ```python
   import json
   
   # Simple log analyzer
   def analyze_errors(log_file_path):
       error_count = 0
       error_types = {}
       
       with open(log_file_path, 'r') as f:
           for line in f:
               try:
                   log_entry = json.loads(line)
                   if log_entry.get('level') == 'ERROR':
                       error_count += 1
                       error_type = log_entry.get('data', {}).get('error_type', 'unknown')
                       error_types[error_type] = error_types.get(error_type, 0) + 1
               except json.JSONDecodeError:
                   continue
       
       return {
           'total_errors': error_count,
           'error_types': error_types
       }
   ```

2. **Performance Analysis**
   ```python
   # Analyze API performance from logs
   def analyze_api_performance(log_file_path):
       endpoints = {}
       
       with open(log_file_path, 'r') as f:
           for line in f:
               try:
                   log_entry = json.loads(line)
                   if 'API Request' in log_entry.get('message', ''):
                       data = log_entry.get('data', {})
                       url = data.get('url', '')
                       method = data.get('method', '')
                       time = data.get('processing_time')
                       
                       if url and method and time:
                           endpoint = f"{method} {url}"
                           if endpoint not in endpoints:
                               endpoints[endpoint] = {
                                   'count': 0,
                                   'total_time': 0,
                                   'min_time': float('inf'),
                                   'max_time': 0
                               }
                           
                           stats = endpoints[endpoint]
                           stats['count'] += 1
                           stats['total_time'] += time
                           stats['min_time'] = min(stats['min_time'], time)
                           stats['max_time'] = max(stats['max_time'], time)
               except json.JSONDecodeError:
                   continue
       
       # Calculate averages
       for endpoint, stats in endpoints.items():
           if stats['count'] > 0:
               stats['avg_time'] = stats['total_time'] / stats['count']
       
       return endpoints
   