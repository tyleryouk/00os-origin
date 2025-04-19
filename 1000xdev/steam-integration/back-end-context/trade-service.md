# Steam Trade Service

## Overview

The Steam Trade Service provides a comprehensive interface for interacting with the Steam Trade API. It allows for the creation, management, and tracking of trade offers, as well as retrieval of trade history. This service is built on top of the SteamWebAPIClient and utilizes Redis caching for improved performance and rate limit management.

## Architecture

The Trade Service follows a layered architecture:

1. **Models Layer**: Pydantic models for request/response validation
2. **Service Layer**: Business logic for trade operations
3. **API Layer**: REST endpoints for client interaction
4. **Cache Layer**: Redis-based caching for trade data

## Key Components

### TradeClient Class

This is the core class that provides methods for interacting with the Steam Trade API.

```python
class TradeClient:
    """Client for interacting with Steam Web API endpoints related to trades."""
    
    def __init__(self, client: SteamWebAPIClient):
        """Initializes the TradeClient."""
        self.client = client
        self.cache = RedisCache(prefix="steam:trade:", ttl=300)  # 5 min default TTL
```

### Trade Models

The service uses the following primary models:

- `TradeOfferStatus`: Enum of possible trade offer statuses
- `CreateTradeOfferRequest`: Model for creating trade offers
- `TradeOfferResponse`: Response from creating a trade offer
- `AcceptTradeOfferRequest`: Model for accepting trade offers  
- `TradeItem`: Represents an item in a trade
- `TradeOffer`: Full trade offer representation
- `Trade`: Completed trade representation

### API Endpoints

The service exposes the following RESTful endpoints:

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/steam/trade/create` | POST | Create a new trade offer |
| `/api/steam/trade/accept` | PUT | Accept an existing trade offer |
| `/api/steam/trade/history` | POST | Get trade history for a user |
| `/api/steam/trade/offers` | POST | Get active trade offers |
| `/api/steam/trade/cancel` | POST | Cancel a trade offer |
| `/api/steam/trade/decline` | POST | Decline a trade offer |
| `/api/steam/trade/status/{tradeofferid}` | GET | Get status of a specific trade offer |

## Core Methods

### Create Trade Offer

```python
async def create_trade_offer(self, request: CreateTradeOfferRequest) -> TradeOfferResponse:
    """Creates a new trade offer."""
```

This method creates a new trade offer on Steam, allowing specification of:
- Items to send (`myitemassetids`)
- Items to receive (`partneritemassetids`)
- Trade partner (via `partnersteamid` or `tradelink`)
- Optional message to include with the offer

### Accept Trade Offer

```python
async def accept_trade_offer(self, request: AcceptTradeOfferRequest) -> AcceptTradeOfferResponse:
    """Accepts a trade offer."""
```

This method accepts an existing trade offer, requiring:
- Trade offer ID
- Partner Steam ID
- Authentication credentials

### Get Trade History

```python
async def get_trade_history(self, request: TradeHistoryRequest) -> List[Trade]:
    """Retrieves the trade history for a user."""
```

Retrieves a user's trade history, including:
- Completed trades
- Items exchanged
- Trade partner information
- Trade completion time

### Get Trade Offers

```python
async def get_trade_offers(self, steamloginsecure: str, sent_only: bool = False, received_only: bool = False) -> List[TradeOffer]:
    """Retrieves active trade offers for a user."""
```

Gets a list of active trade offers with filtering options:
- `sent_only`: Show only offers sent by the user
- `received_only`: Show only offers received by the user

### Cancel/Decline Trade Offers

```python
async def cancel_trade_offer(self, request: CancelTradeOfferRequest) -> TradeStatusResponse:
    """Cancels a trade offer."""

async def decline_trade_offer(self, request: DeclineTradeOfferRequest) -> TradeStatusResponse:
    """Declines a trade offer."""
```

These methods allow canceling (for sent offers) or declining (for received offers) trade offers.

### Get Trade Offer Status

```python
async def get_trade_offer_status(self, tradeofferid: str) -> Optional[TradeOfferStatus]:
    """Gets the current status of a trade offer."""
```

Checks the current status of a trade offer by ID, with possible statuses including:
- `Active`: Offer is active and waiting for response
- `Accepted`: Offer has been accepted
- `Countered`: Partner has made a counter-offer
- `Expired`: Offer has expired
- `Canceled`: Offer was canceled by creator
- `Declined`: Offer was declined by recipient
- `InvalidItems`: Items in the offer are no longer available
- `CreatedNeedsConfirmation`: Offer created but needs mobile confirmation
- `CanceledBySecondFactor`: Canceled due to second factor authentication
- `InEscrow`: Items are in escrow pending completion

## Caching Strategy

The Trade Service uses Redis caching with a tiered TTL strategy:

- Trade Offer Status: 30 minutes TTL
- Active Trade Offers: 30 minutes TTL
- Completed Trades: 1 hour TTL

This balances fresh data with API efficiency.

## Error Handling

The service implements comprehensive error handling:

- API error mapping to meaningful responses
- Validation errors for malformed requests
- Detailed logging for debugging
- Rate limit detection and handling

## Usage Examples

### Creating a Trade Offer

```python
from app.steam.services import TradeClient
from app.steam.models.trade import CreateTradeOfferRequest

# Initialize client
trade_client = TradeClient(steam_web_api_client)

# Create request
request = CreateTradeOfferRequest(
    steamloginsecure="your_secure_cookie",
    partnersteamid="76561198012345678",
    myitemassetids="12345,67890",
    partneritemassetids="54321,98765",
    message="Trading my skins for yours!"
)

# Send trade offer
response = await trade_client.create_trade_offer(request)

if response.success:
    print(f"Trade offer created with ID: {response.tradeofferid}")
else:
    print(f"Failed to create trade offer: {response.error}")
```

### Accepting a Trade Offer

```python
from app.steam.models.trade import AcceptTradeOfferRequest

request = AcceptTradeOfferRequest(
    steamloginsecure="your_secure_cookie",
    tradeofferid="1234567890",
    partnersteamid="76561198012345678"
)

response = await trade_client.accept_trade_offer(request)

if response.success:
    print(f"Trade offer accepted! Trade ID: {response.trade_id}")
else:
    print(f"Failed to accept trade offer: {response.error}")
```

## Integration Points

The Trade Service integrates with:

1. **Inventory Service**: For checking item availability
2. **Authentication System**: For validating user credentials
3. **Frontend UI**: Through REST API endpoints
4. **Notification System**: For trade status updates (future enhancement)

## Future Enhancements

- WebSocket support for real-time trade status updates
- Better trade offer visualization data
- Trade offer analytics and reporting
- Mobile confirmation handling
- Integration with a trade escrow system 