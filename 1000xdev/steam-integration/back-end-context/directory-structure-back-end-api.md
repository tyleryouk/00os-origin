
## Folder Structure

The back-end of GigaSwap follows a well-structured organization pattern that separates concerns and promotes maintainability.

```
back-end/
├── .git/                   # Git repository
├── .gigaland/              # Python virtual environment
├── .vscode/                # VSCode configuration
├── __pycache__/            # Python cache files
├── app/                    # Main application code
│   ├── auth/               # Authentication functionality
│   │   ├── middleware/     # Auth middleware (rate limiter)
│   │   ├── models/         # Auth data models
│   │   ├── auth_models.py  # Authentication models
│   │   ├── auth_queries.py # Database queries for auth
│   │   ├── auth_routes.py  # Authentication endpoints
│   │   ├── auth_services.py # Auth business logic
│   │   ├── session_manager.py # Session handling
│   │   └── token_manager.py   # JWT token operations
│   ├── dependencies/       # FastAPI dependencies
│   ├── gigaland_database/  # Database connection and migrations
│   │   ├── migrations/     # SQL migration files
│   │   ├── test_queries/   # Test SQL queries
│   │   ├── connection.py   # Database connection handler
│   │   ├── initialize.py   # Database initialization
│   │   ├── migrations.py   # Migration framework
│   │   └── run_migrations.py # Migration runner
│   ├── middleware/         # Application middleware
│   ├── orders/             # Order functionality
│   │   ├── order_models.py  # Order data models
│   │   ├── order_queries.py # Database queries for orders
│   │   ├── order_routes.py  # Order-related endpoints
│   │   └── order_services.py # Order business logic
│   ├── routes/             # Additional API routes
│   │   └── logs_routes.py  # Log-related endpoints
│   ├── users/              # User functionality
│   │   ├── analytics_background_tasks.py # Background tasks
│   │   ├── user_models.py  # User data models
│   │   ├── user_queries.py # Database queries for users
│   │   ├── user_routes.py  # User-related endpoints 
│   │   ├── user_services.py # User business logic
│   │   └── wallet_analytics_service.py # Wallet analytics
│   ├── utils/              # Utility functions
│   │   ├── cloudwatch_handler.py # AWS CloudWatch integration
│   │   ├── clear_logs.py   # Log cleanup utilities
│   │   ├── logger.py       # Logging functionality
│   │   ├── migration_utils.py # Migration utilities
│   │   └── redis_config.py # Redis configuration
│   ├── __init__.py         # Package initialization
│   └── main.py             # FastAPI application entry point
├── context/                # Application context
│   ├── api.json            # API specification/documentation
│   └── db_schema.json      # Database schema definition
├── scripts/                # Utility scripts
│   ├── clean.py            # Cleanup script
│   ├── export_schema.py    # Schema export tool
│   ├── generate_jwt_secret.py # JWT secret generation
│   ├── generate_token.py   # Token generation utility
│   ├── setup_logs.py       # Log setup
│   ├── update_postman.py   # Postman collection updater
│   └── verify.py           # Verification script
├── tests/                  # Test suite
│   ├── auth/               # Authentication tests
│   ├── neon_db/            # Database tests
│   ├── redis/              # Redis tests
│   ├── steam/              # Steam integration tests
│   ├── users/              # User functionality tests
│   ├── test_logger.py      # Logger tests
│   └── test_logs_endpoint.py # Log endpoint tests
├── .env                    # Environment variables
├── .gitignore              # Git ignore rules
├── .python-version         # Python version specification
├── README.md               # Project documentation
├── install-pyenv-win.ps1   # PyEnv Windows installer
├── requirements.txt        # Python dependencies
└── run_migrations.ps1      # Migration runner script
```

This folder structure follows a modular approach where each domain of functionality (auth, users, orders) has its own subdirectory containing models, routes, queries, and services. The separation of concerns allows for better maintainability and easier debugging.

The application uses FastAPI as its web framework, with PostgreSQL (via Neon) as the database, and includes Redis for caching and session management. The migration system allows for versioned database schema changes.