# Environment Variables for Steam Web API Integration

This document provides an overview of the environment variables used in the Steam Web API integration.

## Steam API Keys

| Variable | Description | Current Value |
|----------|-------------|---------------|
| `STEAM_WEB_API_KEY` | Official Steam Web API key registered with Steam Community | `57F7FFCCAEC7C7C95725D683AD91F505` |
| `THIRD_PARTY_STEAM_WEB_API_KEY` | Third-party Steam Web API access key for all endpoints we are integrating | `LITUJ4KSYS7D1QC0` |

### Steam Account Information
- **Bot Account**: `gigaswap_trade_bot_1`
- **Domain Registration**: `gigaswap.dev`
- **Note**: Account is protected by Steam Guard Mobile Authenticator

## Caching Configuration

| Variable | Description | Current Value |
|----------|-------------|---------------|
| `REDIS_URL` | Connection string for Redis Cloud instance used for caching API responses | `redis://default:l042ScCnnVfZsOJOMx6IboGsl6LPMDRB@redis-14997.c326.us-east-1-3.ec2.redns.redis-cloud.com:14997` |

## Rate Limiting

| Variable | Description | Current Value |
|----------|-------------|---------------|
| `RATE_LIMIT_REQUESTS` | Maximum number of requests allowed in the time window | `5` |
| `RATE_LIMIT_WINDOW` | Time window in seconds for rate limiting | `60` |

## Authentication

| Variable | Description | Current Value |
|----------|-------------|---------------|
| `JWT_SECRET` | Secret key used for generating and validating JWT tokens | `96d7c6cc2f9a2986bbf6bf900285f30bdd4749d9178a3d1132ee1ba2eb0b1a36` |

## Database

| Variable | Description | Current Value |
|----------|-------------|---------------|
| `NEON_DATABASE_URL` | Connection string for Neon PostgreSQL database | `postgresql://database-1_owner:LZ1gJfFTi3zq@ep-withered-lake-a50r5a9i.us-east-2.aws.neon.tech/gigaland_database?sslmode=require` |

## Monitoring & Logging

| Variable | Description | Current Value |
|----------|-------------|---------------|
| `AWS_DEV_IAM_ACCESS_KEY` | AWS access key for CloudWatch integration | `AKIATQPD7L4Y33ZSF6OJ` |
| `AWS_DEV_IAM_SECRET` | AWS secret key for CloudWatch integration | `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` |
| `AWS_REGION` | AWS region for CloudWatch | `us-east-1` |

## API Testing

| Variable | Description | Current Value |
|----------|-------------|---------------|
| `POSTMAN_API_KEY` | API key for Postman integration | `PMAK-67b655554ba862000191c032-cf314a75e65545aedc0745cc6ccb1249fc` |
| `POSTMAN_COLLECTION_UID` | UID for the Postman collection | `42478057-97c9d599-eb70-4596-a657-3d95b5323294` |

## Usage in the Steam Integration

These environment variables are used throughout the Steam Web API integration:

1. **API Authentication**:
   - The `STEAM_WEB_API_KEY` is used by `SteamWebAPIClient` to authenticate requests to the official Steam Web API.
   - The `THIRD_PARTY_STEAM_WEB_API_KEY` provides access to additional endpoints via third-party services.

2. **Response Caching**:
   - `REDIS_URL` is used to configure the Redis connection for caching API responses.
   - Each service (`ItemsClient`, `InventoryClient`, `TradeClient`) utilizes Redis caching with different TTL values.

3. **Rate Limit Protection**:
   - `RATE_LIMIT_REQUESTS` and `RATE_LIMIT_WINDOW` prevent exceeding API quotas.
   - Implemented in the base client to ensure all requests respect rate limits.

4. **Security & Authentication**:
   - `JWT_SECRET` is used for user authentication and session management.
   - Enables secure access to user inventories and trade functionality.

## Security Considerations

- **DO NOT** commit the `.env` file to version control.
- Rotate API keys periodically for security.
- Consider using AWS Secrets Manager or similar services for production deployments.
- Keep the Steam Guard Mobile Authenticator secure for the bot account.

## Setting Up Environment Variables

During development:
1. Copy the `.env.example` file to `.env`
2. Set the appropriate values
3. Ensure the `.env` file is in the `.gitignore` list

For production:
1. Set environment variables directly in the hosting environment
2. Use a secure secrets management service
3. Ensure different keys are used for development and production
