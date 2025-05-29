# Front-End Data Structures Documentation

## Market Page

This section documents all data structures used in the market page (`/market`) for displaying Steam inventory items, filtering, and category management.

### Steam Inventory Data Structures

#### Raw Steam API Response Item
```typescript
interface SteamInventoryItem {
  // Core identifiers
  id: string;                    // Internal ID (e.g., "6fee917f")
  assetid: string;              // Steam asset ID (e.g., "43962319781")
  classid: string;              // Steam class ID (e.g., "2066632015")
  instanceid: string;           // Steam instance ID (e.g., "0")
  groupid: string;              // Steam group ID

  // Market information
  markethashname: string;       // Market hash name (e.g., "Glove Case")
  normalizedname: string;       // Normalized name (e.g., "glove case")
  marketname: string;           // Display market name
  slug: string;                 // URL slug (e.g., "glove-case")

  // Pricing data
  pricelatest: number;          // Latest Steam market price
  pricelatestsell: number;      // Latest sell price
  pricereal: number;            // Real market price (lowest)
  pricereal24h: number;         // 24h real price
  pricereal7d: number;          // 7d real price
  pricereal30d: number;         // 30d real price
  pricereal90d: number;         // 90d real price
  pricemedian: number;          // Median price
  priceavg: number;             // Average price

  // Item properties
  quality: string;              // Item quality (e.g., "Normal")
  rarity: string;               // Item rarity (e.g., "Base Grade")
  color: string;                // Color hex code (e.g., "b0c3d9")
  bordercolor: string;          // Border color hex code (e.g., "99ccff")
  image: string;                // Image URL
  
  // Trading properties
  marketable: boolean;          // Can be sold on market
  tradable: boolean;            // Can be traded
  markettradablerestriction: number; // Days until tradable

  // Category tags
  tag1: string;                 // Primary category (e.g., "Container", "Rifle")
  tag2: string | null;          // Secondary category (e.g., "Case", "AK-47")
  tag3: string;                 // Item name/variant
  tag4: string;                 // Quality descriptor
  tag5: string | null;          // Wear condition
  tag6: string;                 // Rarity descriptor
  tag7: string | null;          // Collection name

  // Item grouping
  itemgroup: string;            // Item group (e.g., "container", "rifle")
  itemname: string;             // Normalized item name
  itemtype: string | null;      // Item type (e.g., "case")

  // Special properties
  wear: string | null;          // Wear condition
  isstar: boolean;              // Is StatTrak
  isstattrak: boolean;          // Is StatTrak (alternative)
  issouvenir: boolean;          // Is Souvenir

  // Additional metadata
  tags: SteamTag[];             // Detailed tag array
  descriptions: SteamDescription[]; // Item descriptions
  nametag: string | null;       // Custom name tag
  count: number;                // Quantity in inventory
}

interface SteamTag {
  category: string;             // Tag category (e.g., "Type", "Rarity")
  internal_name: string;        // Internal Steam name
  localized_category_name: string; // Display category name
  localized_tag_name: string;   // Display tag name
  color?: string;               // Optional color for rarity tags
}

interface SteamDescription {
  type: string;                 // Description type (e.g., "html")
  value: string;                // Description content
  name: string;                 // Description identifier
  color?: string;               // Optional text color
}
```

#### Processed Inventory Item
```typescript
interface ProcessedInventoryItem {
  // Core identifiers
  id: string;                   // Original Steam ID
  name: string;                 // Display name
  marketName: string;           // Market display name
  marketHashName: string;       // Market hash name for URLs

  // Categorization
  type: string;                 // Item type (from tag2 or itemtype)
  rarity: string;               // Item rarity
  condition: string;            // Wear condition
  weaponType: string;           // Weapon category (from tag1 or itemgroup)
  collection: string;           // Collection name (from tag7)

  // Visual properties
  image: string;                // Full image URL
  nameColor: string;            // Text color (hex with #)
  backgroundColor: string;      // Background color (hex with #)

  // Trading/market properties
  tradable: boolean;            // Can be traded
  marketable: boolean;          // Can be sold on market
  price: number;                // Current price
  currency: string;             // Price currency ("USD")

  // Reference to original data
  steamData: SteamInventoryItem; // Complete original Steam data
}
```

#### Product Model (UI Compatibility Layer)
```typescript
interface Product {
  // Unique identifiers
  id: string;                   // Enhanced unique ID: "assetid-classid-instanceid-index"
  slug: string;                 // URL slug with timestamp for uniqueness

  // Display information
  title: string;                // Product title (marketHashName)
  description: string;          // Generated description with rarity + condition + type
  
  // Pricing
  price: number;                // Current price
  
  // Media
  image: string;                // Product image URL
  thumbnail: string;            // Thumbnail URL (same as image)
  
  // Categorization
  category: string;             // Mapped Steam category (using mapSteamItemToCategory)
  categories: string[];         // Array of categories for filtering
  brand: string;                // Always "Steam"
  
  // Metadata
  rating: number;               // Always 5
  stock: number;                // Always 1
  created_at: string;           // ISO timestamp
  updated_at: string;           // ISO timestamp

  // Steam-specific data (attached for ProductCard1 component)
  steamData?: {
    assetid: string;
    classid: string;
    instanceid: string;
    rarity: string;
    condition: string;
    weaponType: string;
    wear?: number;
    tradable: boolean;
    marketable: boolean;
    name: string;
    marketHashName: string;
    tags: SteamTag[];
  };
}
```

### Category and Filtering Data Structures

#### Steam Categories
```typescript
// From steam-categories.ts
type SteamCategoryKey = 
  | 'rifles' | 'pistols' | 'smgs' | 'shotguns' | 'snipers' | 'machineguns'
  | 'knives' | 'gloves' | 'stickers' | 'agents' | 'patches' | 'musickits'
  | 'cases' | 'keys' | 'tools' | 'graffiti';

interface SteamCategories {
  [key: SteamCategoryKey]: string; // Category key to display name mapping
}

// Example mapping
const STEAM_CATEGORIES: SteamCategories = {
  rifles: 'Rifles',
  pistols: 'Pistols',
  smgs: 'SMGs',
  shotguns: 'Shotguns',
  snipers: 'Sniper Rifles',
  machineguns: 'Machine Guns',
  knives: 'Knives',
  gloves: 'Gloves',
  stickers: 'Stickers',
  agents: 'Agents',
  patches: 'Patches',
  musickits: 'Music Kits',
  cases: 'Cases',
  keys: 'Keys',
  tools: 'Tools',
  graffiti: 'Graffiti'
};
```

#### Sidebar Filter State
```typescript
interface FilterState {
  priceRange: [number, number];  // [min, max] price range (0-10000)
  exterior: string[];            // Wear conditions array
  extras: string[];              // Special properties array
  tradeLocked: boolean;          // Trade lock filter
  rarity: string[];              // Rarity filters array
  weaponTypes: string[];         // Weapon type filters array
}

// Filter option interfaces
interface FilterOption {
  id: string;                    // Unique identifier
  name: string;                  // Display name
}

interface RarityOption extends FilterOption {
  color: string;                 // Hex color for rarity display
}

// Predefined filter options
const EXTERIOR_OPTIONS: FilterOption[] = [
  { id: "factory-new", name: "Factory New" },
  { id: "minimal-wear", name: "Minimal Wear" },
  { id: "field-tested", name: "Field-Tested" },
  { id: "well-worn", name: "Well-Worn" },
  { id: "battle-scarred", name: "Battle-Scarred" }
];

const EXTRAS_OPTIONS: FilterOption[] = [
  { id: "stattrak", name: "StatTrak™" },
  { id: "souvenir", name: "Souvenir" },
  { id: "sticker", name: "Sticker" },
  { id: "charm", name: "Charm" },
  { id: "name-tag", name: "Name Tag" },
  { id: "vanilla", name: "Vanilla" }
];

const RARITY_OPTIONS: RarityOption[] = [
  { id: "consumer", name: "Consumer Grade", color: "#b0c3d9" },
  { id: "industrial", name: "Industrial Grade", color: "#5e98d9" },
  { id: "mil-spec", name: "Mil-Spec Grade", color: "#4b69ff" },
  { id: "restricted", name: "Restricted", color: "#8847ff" },
  { id: "classified", name: "Classified", color: "#d32ce6" },
  { id: "covert", name: "Covert", color: "#eb4b4b" },
  { id: "contraband", name: "Contraband", color: "#e4ae39" }
];
```

#### URL Search Parameters
```typescript
interface MarketSearchParams {
  page?: string;                 // Page number for pagination
  category?: string;             // Category filter from navbar
  weapon_types?: string;         // Comma-separated weapon types
  exterior?: string;             // Comma-separated exterior conditions
  rarity?: string;               // Comma-separated rarity levels
  price_min?: string;            // Minimum price filter
  price_max?: string;            // Maximum price filter
  extras?: string;               // Comma-separated extras filters
  trade_locked?: string;         // "true" for trade locked filter
}
```

#### Market Page Props
```typescript
interface MarketPageProps {
  searchParams: MarketSearchParams;
}

interface MarketPageViewProps {
  page: number;                  // Current page number
  pageSize: number;              // Items per page (20)
  products: Product[];           // Processed products for display
  totalProducts: number;         // Total filtered products count
  selectedCategory?: string;     // Currently selected category
}
```

### Category Mapping Logic

#### Category Mapper Function
```typescript
// Maps Steam inventory items to standardized categories
function mapSteamItemToCategory(steamItem: SteamInventoryItem): SteamCategoryKey {
  // Primary mapping using itemgroup field
  const itemGroup = steamItem.itemgroup?.toLowerCase();
  
  // Secondary mapping using tag1 field
  const tag1 = steamItem.tag1?.toLowerCase();
  
  // Mapping logic with fallbacks
  if (itemGroup === 'rifle' || tag1 === 'rifle') return 'rifles';
  if (itemGroup === 'pistol' || tag1 === 'pistol') return 'pistols';
  if (itemGroup === 'smg' || tag1 === 'smg') return 'smgs';
  if (itemGroup === 'shotgun' || tag1 === 'shotgun') return 'shotguns';
  if (itemGroup === 'sniper' || tag1 === 'sniper rifle') return 'snipers';
  if (itemGroup === 'machinegun' || tag1 === 'machine gun') return 'machineguns';
  if (itemGroup === 'knife' || tag1 === 'knife') return 'knives';
  if (itemGroup === 'gloves' || tag1 === 'gloves') return 'gloves';
  if (itemGroup === 'sticker' || tag1 === 'sticker') return 'stickers';
  if (itemGroup === 'agent' || tag1 === 'agent') return 'agents';
  if (itemGroup === 'patch' || tag1 === 'patch') return 'patches';
  if (itemGroup === 'musickit' || tag1 === 'music kit') return 'musickits';
  if (itemGroup === 'container' || tag1 === 'container') return 'cases';
  if (itemGroup === 'key' || tag1 === 'key') return 'keys';
  if (itemGroup === 'tool' || tag1 === 'tool') return 'tools';
  if (itemGroup === 'graffiti' || tag1 === 'graffiti') return 'graffiti';
  
  // Fallback to pattern matching on marketHashName
  const marketName = steamItem.markethashname?.toLowerCase() || '';
  if (marketName.includes('ak-47') || marketName.includes('m4a4')) return 'rifles';
  if (marketName.includes('glock') || marketName.includes('usp')) return 'pistols';
  // ... additional pattern matching
  
  // Default fallback
  return 'tools';
}
```

### API Response Structures

#### Steam Inventory API Response
```typescript
interface SteamInventoryAPIResponse {
  success: boolean;
  data: SteamInventoryItem[] | null;
  timestamp: string;
  error?: string;
}
```

#### Market Page Data Flow
```typescript
// 1. Raw Steam API data
SteamInventoryItem[] 
  ↓
// 2. Process to internal format
ProcessedInventoryItem[]
  ↓
// 3. Apply filters (category, weapon_types, exterior, rarity, price, extras, trade_locked)
ProcessedInventoryItem[] (filtered)
  ↓
// 4. Apply pagination
ProcessedInventoryItem[] (paginated)
  ↓
// 5. Convert to Product format for UI compatibility
Product[]
  ↓
// 6. Render in MarketPageView component
```

### Filter Application Logic

#### Filter Matching Examples
```typescript
// Exterior/wear filter matching
const wearMatches = exterior.some(ext => {
  switch (ext) {
    case 'factory-new': return itemWear.includes('factory new');
    case 'minimal-wear': return itemWear.includes('minimal wear');
    case 'field-tested': return itemWear.includes('field-tested');
    case 'well-worn': return itemWear.includes('well-worn');
    case 'battle-scarred': return itemWear.includes('battle-scarred');
    default: return false;
  }
});

// Rarity filter matching
const rarityMatches = rarity.some(rar => {
  switch (rar) {
    case 'consumer': return itemRarity.includes('consumer') || itemRarity.includes('base grade');
    case 'industrial': return itemRarity.includes('industrial');
    case 'mil-spec': return itemRarity.includes('mil-spec');
    case 'restricted': return itemRarity.includes('restricted');
    case 'classified': return itemRarity.includes('classified');
    case 'covert': return itemRarity.includes('covert');
    case 'contraband': return itemRarity.includes('contraband');
    default: return false;
  }
});

// Extras filter matching
const extrasMatches = extras.some(extra => {
  switch (extra) {
    case 'stattrak': return item.steamData.isstattrak || itemName.includes('stattrak');
    case 'souvenir': return item.steamData.issouvenir || itemName.includes('souvenir');
    case 'sticker': return itemName.includes('sticker');
    case 'vanilla': return itemName.includes('vanilla');
    default: return false;
  }
});
```

### Key Generation for React Components

#### Unique Key Strategies
```typescript
// Enhanced product ID generation for React keys
const uniqueId = `${item.steamData.assetid || 'asset-' + index}-${item.steamData.classid || 'class-' + index}-${item.steamData.instanceid || 'inst-' + index}-${index}`;

// Category filter active filters keys
const filterKey = `active-filter-${filter}-${category.id}-${index}`;

// Sidebar filter chip keys
const chipKey = type; // Uses the filter type directly (already unique)
```

### ProductCard1 Component Data Usage

#### Steam Data Access Pattern
```typescript
// ProductCard1 component accesses Steam data directly via steamData object
const steamData = (product as any).steamData;
const hasSteamData = !!steamData;

// Direct access to Steam inventory properties
const rarityType = steamData?.rarity?.toLowerCase() || "default";
const weaponType = steamData?.weaponType || "";
const condition = steamData?.condition || "";
const wear = steamData?.wear;
const isTradable = steamData?.tradable ?? true;

// No legacy CS2Gun model references - all data comes from steamData
```

This data structure documentation covers all the key interfaces and types used in the current market page implementation, focusing exclusively on the Steam inventory data structures without any legacy CS2Gun model references.
