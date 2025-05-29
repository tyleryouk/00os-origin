# Front-End Styling

Styling patterns and guidelines for the GigaSwap front-end based on current implementation.

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