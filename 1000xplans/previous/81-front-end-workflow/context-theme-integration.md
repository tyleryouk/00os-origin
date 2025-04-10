# Theme System Analysis

## Visual Theme Analysis
- **Screenshot 2025-04-01 165439.png**: The current market page appears to use a mixed theme, with a darker background for the page but lighter (white) card elements. This creates a contrast that we'll need to harmonize by making the cards darker.
- **Screenshot 2025-04-01 165558.png**: Product cards show various color indicators for rarity and status, which need to be preserved while enhancing the overall theme.
- **Screenshot 2025-04-01 165721.png**: Navigation elements show the broader site theme, which we'll need to maintain consistency with.

## Theme Structure
The application uses Material UI's theming system, with a theme structure that includes:

```typescript
// Theme structure from existing styled components
const theme = {
  palette: {
    mode: 'dark', // Or 'light', depending on current selection
    primary: {
      main: '#...',
      light: '#...',
      dark: '#...',
    },
    secondary: {
      main: '#...',
      light: '#...',
      dark: '#...',
    },
    error: {
      main: '#...',
      light: '#...',
      dark: '#...',
    },
    warning: {
      main: '#...',
      light: '#...',
      dark: '#...',
    },
    info: {
      main: '#...',
      light: '#...',
      dark: '#...',
    },
    success: {
      main: '#...',
      light: '#...',
      dark: '#...',
    },
    grey: {
      50: '#...',
      100: '#...',
      // ... other grey variants
      900: '#...',
    },
    text: {
      primary: '#...',
      secondary: '#...',
    },
    divider: '#...',
    background: {
      paper: '#...',
      default: '#...',
    },
  },
  shadows: [...], // Array of shadow definitions
  shape: {
    borderRadius: 8, // Example value
  },
  typography: {
    fontFamily: '...',
    fontSize: {
      // Font size scale
    },
    fontWeight: {
      // Font weight scale
    },
  },
  spacing: (...), // Spacing function
  breakpoints: {
    values: {
      xs: 0,
      sm: 600,
      md: 960,
      lg: 1280,
      xl: 1920,
    },
  },
  transitions: {
    duration: {
      shortest: 150,
      shorter: 200,
      short: 250,
      standard: 300,
      complex: 375,
      enteringScreen: 225,
      leavingScreen: 195,
    },
    easing: {
      // Easing functions
    },
  },
};
```

## Color Palette Analysis
Based on the styled component implementations, the application uses a comprehensive color system:

- **Primary Colors**: Used for key interactive elements, primary actions, and emphasis
- **Secondary Colors**: Used for alternative actions and less important elements
- **Error/Warning/Info/Success Colors**: Used for status indicators and feedback
- **Grey Scale**: Used for neutral backgrounds, text variations, and subtle UI elements
- **Text Colors**: Separate definitions for primary and secondary text
- **Background Colors**: Different backgrounds for the page and surfaces like cards

## Current Dark Mode Implementation
The product cards already have conditional styling for dark mode, but currently appear light. This suggests:

1. Dark mode support exists in the codebase
2. Cards may not be properly applying dark theme styles
3. Specific values need to be adjusted in the styled components

Key styling pattern for dark mode:
```typescript
backgroundColor: theme.palette.mode === 'dark' ? alpha('#22252f', 0.9) : undefined,
border: theme.palette.mode === 'dark' ? `1px solid ${alpha(theme.palette.divider, 0.1)}` : 'none',
```

## Component Theming Patterns
The product card components use several theming patterns:

1. **Conditional Styling**: Different styles based on theme mode
   ```typescript
   color: theme.palette.mode === 'dark' ? alpha(theme.palette.common.white, 0.95) : theme.palette.primary.main,
   ```

2. **Alpha Transparency**: Using alpha function to create semi-transparent colors
   ```typescript
   backgroundColor: theme.palette.mode === 'dark' ? alpha('#22252f', 0.9) : undefined,
   ```

3. **Color Hierarchy**: Different color weights for different emphasis levels
   ```typescript
   color: theme.palette.mode === 'dark' ? theme.palette.success.light : theme.palette.success.dark,
   ```

4. **Dynamic Shadows**: Conditional shadow application
   ```typescript
   boxShadow: theme.palette.mode === 'dark' ? '0 4px 12px rgba(0, 0, 0, 0.25)' : theme.shadows[2],
   ```

## CS2-Specific Theme Elements
The application has specific styled components for CS2 items:

1. **Rarity Colors**:
   ```typescript
   const rarityColors = {
     "consumer": theme.palette.grey[500],
     "industrial": theme.palette.info.light,
     "mil-spec": theme.palette.info.main,
     "restricted": theme.palette.secondary.main,
     "classified": theme.palette.warning.main,
     "covert": theme.palette.error.main,
     "default": theme.palette.primary.main
   };
   ```

2. **Status Badges**:
   ```typescript
   backgroundColor: theme.palette.mode === 'dark' ? alpha(theme.palette.success.main, 0.15) : alpha(theme.palette.success.light, 0.3),
   color: theme.palette.mode === 'dark' ? theme.palette.success.light : theme.palette.success.dark,
   ```

3. **Wear Indicators**:
   ```typescript
   color: theme.palette.mode === 'dark' ? alpha(theme.palette.text.primary, 0.7) : theme.palette.grey[600],
   ```

## Theme Enhancement Strategy

### Product Card Theme Enhancement
1. Update `StyledCard` background to a dark color (black or dark gray)
2. Enhance card border with subtle glow or highlight
3. Adjust contrast for text elements to ensure readability
4. Maintain existing color system for CS2-specific indicators
5. Enhance hover states with more pronounced effects

### New Homepage Theme Integration
1. Maintain consistency with the theme system used across the site
2. Use dark backgrounds to showcase 3D models effectively
3. Implement subtle animations that fit the theme style
4. Create a visually distinct but thematically consistent component for the 3D model slideshow
5. Ensure responsive behavior maintains theme consistency across device sizes

## Typography System
Typography appears to follow Material UI's typography system with custom overrides:

- **Font Sizes**: Varying by component and importance (`0.75rem`, `0.8rem`, `1rem`, `1.2rem`)
- **Font Weights**: Multiple weights for different emphasis (400, 600, 700)
- **Line Heights**: Likely following Material UI defaults
- **Text Colors**: Conditional based on theme mode

## Spacing System
Spacing is based on Material UI's spacing function with multiplication factors:
```typescript
padding: theme.spacing(2),
marginBottom: theme.spacing(2),
```

## Responsive Theme Implementation
The theme implementation includes responsive considerations:
```typescript
[theme.breakpoints.down("sm")]: { display: "block" },
```

This pattern should be maintained and expanded in the enhancements. 