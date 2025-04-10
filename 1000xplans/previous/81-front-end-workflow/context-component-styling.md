# Component Styling Analysis

## Visual Component Analysis
- **Screenshot 2025-04-01 165439.png**: The product cards currently use a white/light background that needs to be updated to a darker theme. The cards have a clean, structured layout with thumbnail images, product details, and pricing information.
- **Screenshot 2025-04-01 165558.png**: Individual product cards show various indicators and badges for CS2 items, including rarity indicators, wear values, and tradable status badges.

## Styling Methodology
The application uses Material UI's styled API for component styling, with TypeScript integration:

```typescript
import styled from "@mui/material/styles/styled";
import { alpha } from "@mui/material/styles";
```

The styling approach combines:
1. Styled components with theme access
2. Conditional styling based on theme mode
3. Component composition with styled wrappers
4. Responsive styling through theme breakpoints

## ProductCard1 Styling Structure

### StyledCard Component
```typescript
export const StyledCard = styled(Card)(({ theme }) => ({
  height: "100%",
  margin: "auto",
  display: "flex",
  overflow: "hidden",
  position: "relative",
  flexDirection: "column",
  justifyContent: "space-between",
  transition: "all 250ms ease-in-out",
  backgroundColor: theme.palette.mode === 'dark' ? alpha('#22252f', 0.9) : undefined,
  border: theme.palette.mode === 'dark' ? `1px solid ${alpha(theme.palette.divider, 0.1)}` : 'none',
  boxShadow: theme.palette.mode === 'dark' ? '0 4px 12px rgba(0, 0, 0, 0.25)' : theme.shadows[2],
  "&:hover": {
    transform: "translateY(-8px)",
    boxShadow: theme.palette.mode === 'dark' ? '0 8px 20px rgba(0, 0, 0, 0.4)' : theme.shadows[6],
    "& .hover-box": { opacity: 1 }
  }
}));
```

### ImageWrapper Component
```typescript
export const ImageWrapper = styled("div")(({ theme }) => ({
  textAlign: "center",
  position: "relative",
  display: "inline-block",
  padding: "16px 16px 0 16px",
  [theme.breakpoints.down("sm")]: { display: "block" },
  transition: "0.3s",
  backgroundColor: theme.palette.mode === 'dark' ? '#22252f' : undefined,
  "&:hover .thumbnail": { transform: "scale(1.05)" },
  "& .thumbnail": { 
    transition: "transform 0.3s ease",
    maxWidth: "100%",
    height: "auto"
  }
}));
```

### ContentWrapper Component
```typescript
export const ContentWrapper = styled("div")(({ theme }) => ({
  gap: 8,
  display: "flex",
  padding: "1.25rem",
  flexDirection: "column",
  backgroundColor: theme.palette.mode === 'dark' ? '#22252f' : undefined,
  borderTop: `1px solid ${theme.palette.mode === 'dark' ? alpha(theme.palette.divider, 0.1) : theme.palette.grey[200]}`,
  // Additional styling for child elements...
}));
```

## Specialized CS2 Components

### StatusBadge Component
```typescript
export const StatusBadge = styled("div")(({ theme }) => ({
  display: "inline-flex",
  alignItems: "center",
  padding: "3px 8px",
  borderRadius: "4px",
  fontSize: "0.75rem",
  fontWeight: 600,
  marginBottom: "0.5rem",
  backgroundColor: theme.palette.mode === 'dark' ? alpha(theme.palette.success.main, 0.15) : alpha(theme.palette.success.light, 0.3),
  color: theme.palette.mode === 'dark' ? theme.palette.success.light : theme.palette.success.dark,
  border: `1px solid ${theme.palette.mode === 'dark' ? alpha(theme.palette.success.main, 0.3) : alpha(theme.palette.success.main, 0.1)}`,
}));
```

### WearIndicator Component
```typescript
export const WearIndicator = styled("div")(({ theme }) => ({
  display: "flex",
  alignItems: "center",
  marginTop: "0.25rem",
  marginBottom: "0.5rem",
  "& .wear-label": {
    fontSize: "0.75rem",
    color: theme.palette.mode === 'dark' ? alpha(theme.palette.text.primary, 0.7) : theme.palette.grey[600],
    marginRight: "0.5rem"
  },
  "& .wear-value": {
    fontSize: "0.8rem",
    fontWeight: 600,
    color: theme.palette.mode === 'dark' ? alpha(theme.palette.common.white, 0.9) : theme.palette.text.primary
  }
}));
```

### RarityIndicator Component
```typescript
export const RarityIndicator = styled("div", {
  shouldForwardProp: (prop) => prop !== "rarity"
})<{ rarity: string }>(({ theme, rarity }) => {
  // Color mapping based on rarity
  const rarityColors = {
    "consumer": theme.palette.grey[500],
    "industrial": theme.palette.info.light,
    "mil-spec": theme.palette.info.main,
    "restricted": theme.palette.secondary.main,
    "classified": theme.palette.warning.main,
    "covert": theme.palette.error.main,
    "default": theme.palette.primary.main
  };
  
  const color = rarityColors[rarity as keyof typeof rarityColors] || rarityColors.default;
  
  return {
    display: "inline-flex",
    alignItems: "center",
    fontSize: "0.75rem",
    fontWeight: 600,
    marginBottom: "0.25rem",
    color: color,
    "& .rarity-dot": {
      width: "8px",
      height: "8px",
      borderRadius: "50%",
      backgroundColor: color,
      marginRight: "6px"
    }
  };
});
```

## Hover Effect Patterns
The product cards use several hover effect patterns:

1. **Card Elevation Change**:
   ```typescript
   "&:hover": {
     transform: "translateY(-8px)",
     boxShadow: theme.palette.mode === 'dark' ? '0 8px 20px rgba(0, 0, 0, 0.4)' : theme.shadows[6],
   }
   ```

2. **Image Scale**:
   ```typescript
   "&:hover .thumbnail": { transform: "scale(1.05)" }
   ```

3. **Action Button Reveal**:
   ```typescript
   "&:hover": {
     "& .hover-box": { opacity: 1 }
   }
   ```

## Animation Patterns
The component uses several animation/transition patterns:

1. **Card Transition**:
   ```typescript
   transition: "all 250ms ease-in-out"
   ```

2. **Image Transition**:
   ```typescript
   "& .thumbnail": { 
     transition: "transform 0.3s ease"
   }
   ```

3. **Hover Action Transition**:
   ```typescript
   transition: "all 0.3s ease-in-out"
   ```

## Style Enhancement Opportunities

### Card Styling Enhancements
1. **Dark Background**:
   ```typescript
   backgroundColor: alpha('#121212', 0.9), // Dark gray/black
   ```

2. **Enhanced Borders**:
   ```typescript
   border: `1px solid ${alpha(theme.palette.primary.main, 0.2)}`,
   ```

3. **Improved Hover Effects**:
   ```typescript
   "&:hover": {
     transform: "translateY(-8px)",
     boxShadow: `0 10px 25px ${alpha(theme.palette.primary.main, 0.2)}`,
   }
   ```

4. **Gradient Accents**:
   ```typescript
   "&::after": {
     content: '""',
     position: "absolute",
     top: 0,
     left: 0,
     width: "100%",
     height: "3px",
     background: `linear-gradient(90deg, ${theme.palette.primary.main}, ${theme.palette.secondary.main})`,
   }
   ```

### Content Formatting Enhancements
1. **Improved Typography**:
   ```typescript
   "& .title": {
     fontWeight: 600,
     color: theme.palette.common.white,
     fontSize: "1.1rem",
     marginBottom: "0.75rem",
   }
   ```

2. **Badge Enhancements**:
   ```typescript
   backgroundColor: alpha(theme.palette.success.main, 0.2),
   backdropFilter: "blur(8px)",
   ```

3. **Price Emphasis**:
   ```typescript
   "& .price": {
     fontWeight: 700,
     fontSize: "1.3rem",
     color: theme.palette.primary.main,
     textShadow: `0 0 8px ${alpha(theme.palette.primary.main, 0.5)}`,
   }
   ```

## HomePage Component Styling
For the new homepage, we'll need to create several new styled components:

1. **3D Model Slideshow Container**:
   ```typescript
   export const ModelSlideshow = styled("div")(({ theme }) => ({
     width: "100%",
     height: "60vh",
     position: "relative",
     overflow: "hidden",
     backgroundColor: alpha(theme.palette.background.default, 0.7),
     borderRadius: theme.shape.borderRadius,
   }));
   ```

2. **Slide Component**:
   ```typescript
   export const ModelSlide = styled("div")(({ theme }) => ({
     width: "100%",
     height: "100%",
     position: "absolute",
     top: 0,
     left: 0,
     opacity: 0,
     transition: "opacity 1s ease-in-out",
     "&.active": {
       opacity: 1,
     }
   }));
   ```

3. **Navigation Controls**:
   ```typescript
   export const SlideControls = styled("div")(({ theme }) => ({
     position: "absolute",
     bottom: "20px",
     left: "50%",
     transform: "translateX(-50%)",
     display: "flex",
     gap: "10px",
     zIndex: 2,
   }));
   ```

## Responsive Design Patterns
The existing components include responsive breakpoints:

```typescript
[theme.breakpoints.down("sm")]: { display: "block" },
```

This pattern will be maintained and enhanced across all component updates. 