# Front-End Styling

Styling patterns and guidelines for the GigaSwap front-end based on current implementation.

## Homepage Styling Analysis

### Overview
The homepage uses a "true mirror" approach where it renders the MarketPage component with a rifles filter, wrapped in the same MarketLayout as the market page. However, there are subtle styling differences due to the path prop and component hierarchy.

### Key Styling Differences

#### 1. MarketNavbar Path Prop
**Root Cause**: The MarketNavbar component receives different `path` props:
- **Homepage**: `path="/"` 
- **Market Page**: `path="/market"`

This affects the URL generation for category links:
```typescript
// Homepage links: /?category=rifles
// Market page links: /market?category=rifles
```

#### 2. Component Hierarchy Differences
**Homepage Structure**:
```
RootLayout (providers only)
└── HomePage
    └── MarketLayout (topbar, navbar, footer)
        └── MarketNavbar (path="/")
            └── MarketPage (content)
```

**Market Page Structure**:
```
RootLayout (providers only)
└── MarketLayout (topbar, navbar, footer)
    └── MarketNavbar (path="/market")
        └── MarketPageContent
```

#### 3. Styling Files Involved

**Primary Styling Files**:
- `front-end/src/pages-sections/market/styles.ts` - MarketNavItem, CS2NavbarContainer styling
- `front-end/src/pages-sections/market/components/market-navbar.tsx` - Navbar component logic
- `front-end/src/components/layouts/market-layout/market-layout.tsx` - Layout wrapper
- `front-end/src/app/globals.css` - Global styles and error overlay fixes

**Theme Configuration**:
- `front-end/src/theme/theme-colors.ts` - Color palette definitions
- `front-end/src/theme/theme-provider.tsx` - Theme provider setup

### MarketNavbar Styling Details

#### Color Scheme
```typescript
// From styles.ts - MarketNavItem
backgroundColor: selected ? alpha('#9B66F3', 0.95) : alpha('#121212', 0.4)
color: selected ? '#FFFFFF' : alpha(theme.palette.text.primary, 0.8)
border: selected 
  ? '1px solid rgba(255,255,255,0.3)' 
  : '1px solid rgba(155, 102, 243, 0.15)'
```

#### Container Background
```typescript
// From styles.ts - CS2NavbarContainer
backgroundColor: "#0a0a0a"
backgroundImage: "linear-gradient(to bottom, rgba(155, 102, 243, 0.08), rgba(155, 102, 243, 0.02))"
```

#### Responsive Sizing
```typescript
// Category button sizing
fontSize: { xs: '0.55rem', sm: '0.6rem', md: '0.65rem', lg: '0.7rem' }
padding: { xs: '0.2rem 0.4rem', sm: '0.22rem 0.45rem', md: '0.25rem 0.5rem', lg: '0.28rem 0.55rem' }
minWidth: { xs: '45px', sm: '50px', md: '55px', lg: '60px' }
maxWidth: { xs: '80px', sm: '90px', md: '100px', lg: '110px' }
```

### Visual Effects

#### Glow Effects
- **Selected Items**: Purple glow with `boxShadow: 0 4px 15px rgba(155, 102, 243, 0.6)`
- **Hover Effects**: Enhanced glow and transform animations
- **Ripple Animation**: Custom ripple effect on category selection

#### Animations
- **Category Indicator**: Animated bottom border that slides between active categories
- **Transition Effects**: Smooth category switching with cubic-bezier easing
- **Product Grid**: Staggered fade-in animations for product cards

### Files to Edit for Homepage Styling

#### To Modify Homepage-Specific Styling:
1. **`front-end/src/app/page.tsx`** - Homepage component and MarketLayout wrapper
2. **`front-end/src/pages-sections/market/components/market-navbar.tsx`** - Path-specific logic and URL generation

#### To Modify Shared Market Styling:
1. **`front-end/src/pages-sections/market/styles.ts`** - MarketNavItem, CS2NavbarContainer, and animation styles
2. **`front-end/src/components/layouts/market-layout/market-layout.tsx`** - Layout structure and header components
3. **`front-end/src/pages-sections/market/market.tsx`** - Main market content wrapper

#### To Modify Global Styling:
1. **`front-end/src/app/globals.css`** - Global styles, error overlay fixes
2. **`front-end/src/theme/theme-colors.ts`** - Color palette and theme definitions
3. **`front-end/src/theme/theme-provider.tsx`** - Theme configuration

### Styling Consistency Notes

#### What's Identical:
- Layout structure (topbar, navbar, footer)
- Color scheme and theme
- Component styling and animations
- Responsive behavior

#### What's Different:
- URL generation for category links (path prop)
- Component nesting depth (minimal impact)
- Category selection state management

### Recommended Styling Approach

#### For Homepage-Specific Changes:
```typescript
// In market-navbar.tsx, add path-specific styling
const isHomepage = path === "/";
const navbarStyles = {
  // Homepage-specific overrides
  ...(isHomepage && {
    // Custom styles for homepage
  })
};
```

#### For Shared Changes:
Modify the styles.ts file to affect both homepage and market page simultaneously, maintaining the true mirror approach.

## Layout System

### Container Patterns
- **Full Width**: Use `maxWidth={false}` for components that need full viewport width
- **Consistent Padding**: Standard responsive padding scheme across all layout components
- **Layout Alignment**: All major layout components (topbar, navbar, footer, market navbar) use same width constraints

```typescript
// Standard container pattern
<Container 
  maxWidth={false} 
  sx={{ px: { xs: 2, sm: 2.5, md: 3 } }}
>
  {/* Content */}
</Container>
```

### Responsive Padding Scheme
```typescript
// Consistent across topbar, navbar, footer, market components
paddingX: { xs: 2, sm: 2.5, md: 3 }

// Breakpoint values:
// xs: 16px (theme.spacing(2))
// sm: 20px (theme.spacing(2.5)) 
// md: 24px (theme.spacing(3))
```

## MUI Integration

### Component Styling Patterns
```typescript
// sx prop for component-specific styling
<Box sx={{ 
  mt: { xs: 2, sm: 3 },
  mb: { xs: 4, sm: 6 },
  px: { xs: 2, sm: 2.5, md: 3 }
}}>

// styled components for reusable patterns
const StyledContainer = styled(Container)(({ theme }) => ({
  maxWidth: "none !important",
  paddingX: { xs: 2, sm: 2.5, md: 3 }
}));
```

### Theme Integration
- **MUI Theme**: Extend base MUI theme for brand consistency
- **Breakpoints**: Use MUI breakpoint system for responsive design
- **Spacing**: Use theme.spacing() for consistent spacing values
- **Colors**: Define brand colors in theme palette

## Global Styles

### globals.css Usage
- **Error Overlay Fixes**: CSS fixes for Next.js development error visibility
- **CSS Variables**: Global CSS custom properties
- **Base Styles**: Document-level styles and resets
- **Z-index Management**: Consistent layering hierarchy

### Critical Styles
```css
/* Error overlay visibility fixes */
[data-nextjs-dialog-overlay] {
  z-index: 9999 !important;
}

/* Consistent z-index hierarchy */
.header { z-index: 1100; }
.modal { z-index: 1300; }
.error-overlay { z-index: 9999; }
```

## Component-Specific Styling

### Market Page Layout
- **Market Navbar**: Full width without container constraints
- **Content Container**: Matches navbar padding for visual alignment
- **Category Filters**: Responsive grid layout with proper spacing
- **Product Grid**: Consistent card spacing and responsive columns

### Header Components
- **UnifiedHeader**: Full width with responsive padding
- **Search Area**: Flexible width with max constraints
- **Navigation**: Proper spacing and alignment with content

### Layout Components
- **Topbar**: Full width, consistent padding, proper height
- **Main Navbar**: Aligned with market navbar width
- **Footer**: Full width content with reduced grid spacing

## Responsive Design

### Mobile-First Approach
```typescript
// Start with mobile styles, enhance for larger screens
sx={{
  fontSize: '14px',           // Mobile base
  [theme.breakpoints.up('sm')]: {
    fontSize: '16px'          // Tablet and up
  },
  [theme.breakpoints.up('md')]: {
    fontSize: '18px'          // Desktop and up
  }
}}
```

### Breakpoint Usage
- **xs (0px+)**: Mobile phones
- **sm (600px+)**: Tablets
- **md (900px+)**: Small laptops
- **lg (1200px+)**: Desktops
- **xl (1536px+)**: Large screens

## Styling Standards

### When to Use Each Approach
- **sx prop**: Component-specific, one-off styling
- **styled components**: Reusable styled variants
- **globals.css**: Document-level, global overrides
- **theme**: Brand colors, spacing, breakpoints

### Performance Considerations
- **CSS-in-JS**: Use MUI's sx prop for dynamic styling
- **Static CSS**: Use globals.css for static, global styles
- **Avoid Inline Styles**: Prefer sx prop over style attribute
- **Theme Consistency**: Always use theme values for spacing/colors

## Common Patterns

### Full-Width Layout Component
```typescript
const LayoutComponent = styled(Container)(({ theme }) => ({
  maxWidth: "none !important",
  paddingX: { xs: 2, sm: 2.5, md: 3 },
  height: "100%",
  display: "flex",
  alignItems: "center"
}));
```

### Responsive Content Spacing
```typescript
<Box sx={{
  mt: { xs: 2, sm: 3 },      // Top margin
  mb: { xs: 4, sm: 6 },      // Bottom margin  
  px: { xs: 2, sm: 2.5, md: 3 }  // Horizontal padding
}}>
```

### Grid Layout with Consistent Spacing
```typescript
<Grid container spacing={2}>  {/* Reduced from default 3 */}
  <Grid item xs={12} sm={6} md={4}>
    {/* Grid content */}
  </Grid>
</Grid>
```

---
This document reflects current styling implementation and should be updated as patterns evolve. 