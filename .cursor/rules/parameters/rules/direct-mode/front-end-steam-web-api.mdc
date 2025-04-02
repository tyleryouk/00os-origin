# workflow: rules-workflow | pathway: front-end-steam-web-api | message-command: direct-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/rules/direct-mode/front-end-steam-web-api.md

## Parameter Purpose

This parameter provides specialized guidance for implementing immediate enhancements to the Steam Web API integration in front-end components. It enables direct implementation without requiring extensive planning documentation.

## Usage Context

Use this parameter when immediate implementation is needed for:
- Steam authentication components
- CS2 inventory display components
- Steam trading UI components
- Market data visualization
- Rules enhancement for front-end Steam integration

## Implementation Guidelines

### Direct Implementation Strategy

For immediate enhancement of front-end Steam integration rules:

1. **Research First**: Begin with comprehensive research
   - Analyze existing front-end Steam components
   - Examine current CS2 models and patterns
   - Research Steam authentication implementations
   - Identify suitable UI patterns for inventory display

2. **Knowledge Access**: Use appropriate knowledge components
   ```typescript
   fetch_rules(["knowledge/front-end/steam-web-api/authentication"], 
              "Understanding Steam authentication implementation")
              
   fetch_rules(["knowledge/front-end/steam-web-api/inventory"], 
              "Understanding CS2 inventory integration")
              
   fetch_rules(["knowledge/front-end/steam-web-api/market-data"], 
              "Understanding Steam market data visualization")
   ```

3. **Component Enhancement**: Directly enhance components
   - Create API integration components
   - Implement authentication UI components
   - Develop inventory display components
   - Build market data visualization components

### Authentication Enhancement

For enhancing Steam authentication rules:

```typescript
// Create authentication guidance file
edit_file("1000xbrain/knowledge/rules/front-end-steam-web-api/authentication-patterns.md",
          "Create authentication pattern guidance for front-end Steam integration",
          "# USE WHEN implementing authentication patterns for Steam in front-end components\n\n## Authentication Flow Patterns\n\n### OpenID Authentication Pattern\n\n```tsx\nconst SteamLoginButton: React.FC = () => {\n  return (\n    <Button\n      variant=\"contained\"\n      startIcon={<SteamIcon />}\n      onClick={() => window.location.href = '/api/auth/steam'}\n      sx={{ backgroundColor: '#171a21', '&:hover': { backgroundColor: '#2a475e' } }}\n    >\n      Login with Steam\n    </Button>\n  );\n};\n```\n\n### Authentication State Pattern\n\n```tsx\nconst useSteamAuth = () => {\n  const [user, setUser] = useState<SteamUser | null>(null);\n  const [loading, setLoading] = useState(true);\n  \n  useEffect(() => {\n    const checkAuth = async () => {\n      try {\n        const response = await fetch('/api/auth/steam/status');\n        const data = await response.json();\n        \n        if (data.authenticated) {\n          setUser(data.user);\n        }\n      } catch (error) {\n        console.error('Authentication check failed', error);\n      } finally {\n        setLoading(false);\n      }\n    };\n    \n    checkAuth();\n  }, []);\n  \n  return { user, loading, isAuthenticated: !!user };\n};\n```")
```

### Inventory Enhancement

For enhancing CS2 inventory rules:

```typescript
// Create inventory guidance file
edit_file("1000xbrain/knowledge/rules/front-end-steam-web-api/inventory-patterns.md",
          "Create inventory pattern guidance for front-end Steam integration",
          "# USE WHEN implementing inventory patterns for Steam in front-end components\n\n## Inventory Display Patterns\n\n### Inventory Grid Pattern\n\n```tsx\nconst InventoryGrid: React.FC<{ items: SteamInventoryItem[] }> = ({ items }) => {\n  return (\n    <Grid container spacing={2}>\n      {items.map(item => (\n        <Grid item key={item.assetId} xs={6} sm={4} md={3} lg={2}>\n          <InventoryItem item={item} />\n        </Grid>\n      ))}\n    </Grid>\n  );\n};\n```\n\n### Inventory Item Pattern\n\n```tsx\nconst InventoryItem: React.FC<{ item: SteamInventoryItem }> = ({ item }) => {\n  return (\n    <Card>\n      <CardMedia\n        component=\"img\"\n        height=\"140\"\n        image={item.imageUrl}\n        alt={item.name}\n      />\n      <CardContent>\n        <Typography variant=\"subtitle1\">{item.name}</Typography>\n        <Typography variant=\"body2\" color=\"text.secondary\">\n          {item.wear} | {item.statTrak ? 'StatTrak™' : ''}\n        </Typography>\n        <Typography variant=\"h6\">${item.price}</Typography>\n      </CardContent>\n      <CardActions>\n        <Button size=\"small\">Trade</Button>\n        <Button size=\"small\">Market</Button>\n      </CardActions>\n    </Card>\n  );\n};\n```")
```

### Market Data Enhancement

For enhancing market data rules:

```typescript
// Create market data guidance file
edit_file("1000xbrain/knowledge/rules/front-end-steam-web-api/market-patterns.md",
          "Create market data pattern guidance for front-end Steam integration",
          "# USE WHEN implementing market data patterns for Steam in front-end components\n\n## Market Data Visualization Patterns\n\n### Price History Chart Pattern\n\n```tsx\nconst PriceHistoryChart: React.FC<{ itemId: string }> = ({ itemId }) => {\n  const [priceData, setPriceData] = useState<PricePoint[]>([]);\n  const [loading, setLoading] = useState(true);\n  \n  useEffect(() => {\n    const fetchPriceHistory = async () => {\n      try {\n        const response = await fetch(`/api/market/price-history/${itemId}`);\n        const data = await response.json();\n        setPriceData(data.history);\n      } catch (error) {\n        console.error('Failed to fetch price history', error);\n      } finally {\n        setLoading(false);\n      }\n    };\n    \n    fetchPriceHistory();\n  }, [itemId]);\n  \n  if (loading) return <CircularProgress />;\n  \n  return (\n    <Box sx={{ height: 300, width: '100%' }}>\n      <LineChart\n        data={priceData}\n        margin={{ top: 20, right: 30, left: 20, bottom: 5 }}\n      >\n        <CartesianGrid strokeDasharray=\"3 3\" />\n        <XAxis dataKey=\"date\" />\n        <YAxis />\n        <Tooltip />\n        <Line type=\"monotone\" dataKey=\"price\" stroke=\"#8884d8\" />\n      </LineChart>\n    </Box>\n  );\n};\n```\n\n### Market Listing Pattern\n\n```tsx\nconst MarketListings: React.FC<{ itemName: string }> = ({ itemName }) => {\n  const [listings, setListings] = useState<MarketListing[]>([]);\n  const [loading, setLoading] = useState(true);\n  \n  useEffect(() => {\n    const fetchListings = async () => {\n      try {\n        const response = await fetch(`/api/market/listings?itemName=${encodeURIComponent(itemName)}`);\n        const data = await response.json();\n        setListings(data.listings);\n      } catch (error) {\n        console.error('Failed to fetch market listings', error);\n      } finally {\n        setLoading(false);\n      }\n    };\n    \n    fetchListings();\n  }, [itemName]);\n  \n  if (loading) return <CircularProgress />;\n  \n  return (\n    <TableContainer component={Paper}>\n      <Table>\n        <TableHead>\n          <TableRow>\n            <TableCell>Seller</TableCell>\n            <TableCell>Float</TableCell>\n            <TableCell>Wear</TableCell>\n            <TableCell align=\"right\">Price</TableCell>\n            <TableCell></TableCell>\n          </TableRow>\n        </TableHead>\n        <TableBody>\n          {listings.map(listing => (\n            <TableRow key={listing.id}>\n              <TableCell>{listing.sellerName}</TableCell>\n              <TableCell>{listing.floatValue}</TableCell>\n              <TableCell>{listing.wear}</TableCell>\n              <TableCell align=\"right\">${listing.price}</TableCell>\n              <TableCell>\n                <Button variant=\"contained\" size=\"small\">Buy</Button>\n              </TableCell>\n            </TableRow>\n          ))}\n        </TableBody>\n      </Table>\n    </TableContainer>\n  );\n};\n```")
```

## Success Criteria

Direct implementation will be considered successful when:

1. **Rule Enhancement Completeness**:
   - Authentication patterns are well-documented
   - Inventory patterns are clearly defined
   - Market data visualization patterns are established
   - Cross-references between patterns are implemented

2. **Cognitive Enhancement**:
   - Rules clearly communicate best practices
   - Knowledge components are accessible via fetch_rules
   - Implementation patterns follow established standards
   - Front-end workflow is properly supported

## Implementation Verification

Verify the implementation with these checks:

1. **Knowledge Component Verification**:
   ```typescript
   fetch_rules(["knowledge/rules/front-end-steam-web-api/authentication-patterns"], 
              "Verifying authentication patterns documentation")
              
   fetch_rules(["knowledge/rules/front-end-steam-web-api/inventory-patterns"], 
              "Verifying inventory patterns documentation")
              
   fetch_rules(["knowledge/rules/front-end-steam-web-api/market-patterns"], 
              "Verifying market data patterns documentation")
   ```

2. **Cross-Reference Verification**:
   - Check references between knowledge components
   - Verify references to front-end components
   - Ensure consistent terminology across files
   - Validate header formatting in all files 