# Homepage Implementation with 3D Model Slideshow

## Target Files
1. `front-end/src/app/page.tsx` - Replace existing redirect with a new homepage component
2. `front-end/src/pages-sections/home/index.tsx` - Create new homepage component
3. `front-end/src/pages-sections/home/styles.ts` - Create styled components for the homepage
4. `front-end/src/components/model-viewer/ModelViewer.tsx` - Create new component for 3D model viewing
5. `front-end/src/pages-sections/home/FeaturedProducts.tsx` - Create component for featured product cards

## Implementation Overview
We'll transform the current redirect page into a full-featured homepage with:
1. 3D model slideshow of CS2 weapons/skins showcasing the GLB files
2. Featured product cards from the marketplace with the new dark theme
3. About section with information about PolygonExpress

## Target Files
1. `front-end/src/app/page.tsx` - Replace existing redirect with a new homepage component
2. `front-end/src/pages-sections/home/index.tsx` - Create new homepage component
3. `front-end/src/pages-sections/home/styles.ts` - Create styled components for the homepage
4. `front-end/src/components/model-viewer/ModelViewer.tsx` - Create new component for 3D model viewing
5. `front-end/src/pages-sections/home/FeaturedProducts.tsx` - Create component for featured product cards

## Current UI Analysis
From the screenshots, we can see:
1. The site has a dark theme with nearly black backgrounds
2. Product cards currently have white backgrounds which create stark contrast
3. Product cards include colored rarity indicators, green tradable badges, and purple pricing
4. The overall aesthetic is clean and minimalist

## Implementation Approach for Homepage

### 1. Create a new Homepage Component
First, we'll update the main page.tsx file to render our new homepage component instead of redirecting to the market page:

```typescript
// front-end/src/app/page.tsx
import { Metadata } from "next";
import { Suspense } from "react";
import CircularProgress from "@mui/material/CircularProgress";
import Box from "@mui/material/Box";
import { ConsolidatedLogger } from "@/utils/consolidated-logger";
import HomePage from "pages-sections/home";

export const metadata: Metadata = {
  title: "PolygonExpress - CS2 Marketplace",
  description: `Browse and purchase CS2 skins using Polygon blockchain technology`,
  authors: [{ name: "PolygonExpress", url: "https://polygonexpress.com" }],
  keywords: ["cs2", "skins", "marketplace", "polygon", "blockchain"]
};

export default function HomePageContainer() {
  try {
    // Log homepage access
    ConsolidatedLogger.log(
      'INFO', 
      'CLIENT', 
      'Home page accessed', 
      {
        timestamp: new Date().toISOString(),
        path: '/',
        component: 'HomePage'
      }, 
      'HomeAccess'
    );
    
    return (
      <Suspense fallback={
        <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
          <CircularProgress />
        </Box>
      }>
        <HomePage />
      </Suspense>
    );
  } catch (error) {
    // Enhanced error logging
    ConsolidatedLogger.logCS2Error(
      error instanceof Error ? error : new Error(String(error)),
      'HomePage'
    );
    
    // Fallback UI in case of error
    return (
      <Box sx={{ p: 3, textAlign: 'center' }}>
        <h2>Something went wrong</h2>
        <p>Please try refreshing the page or <a href="/market">browse our marketplace</a>.</p>
      </Box>
    );
  }
}
```

### 2. Create ModelViewer Component for 3D Models
Next, we'll create a specialized component for displaying 3D GLB models:

```typescript
// front-end/src/components/model-viewer/ModelViewer.tsx
"use client";

import { useState, useEffect, useRef } from "react";
import { styled, alpha } from "@mui/material/styles";
import Box from "@mui/material/Box";
import CircularProgress from "@mui/material/CircularProgress";
import { Canvas, useFrame } from "@react-three/fiber";
import { useGLTF, OrbitControls, Environment, ContactShadows, useProgress } from "@react-three/drei";
import { ConsolidatedLogger } from "@/utils/consolidated-logger";

// Styled components for the ModelViewer
const ModelContainer = styled(Box)(({ theme }) => ({
  position: "relative",
  width: "100%",
  height: "100%",
  backgroundColor: "#121212", // Match the dark theme from screenshots
  borderRadius: theme.shape.borderRadius,
  overflow: "hidden",
  boxShadow: theme.shadows[10],
}));

const LoaderWrapper = styled(Box)(({ theme }) => ({
  position: "absolute",
  top: 0,
  left: 0,
  width: "100%",
  height: "100%",
  display: "flex",
  alignItems: "center",
  justifyContent: "center",
  backgroundColor: alpha("#121212", 0.7), // Semi-transparent dark background
  zIndex: 10,
}));

// Loading indicator component
function Loader() {
  const { progress } = useProgress();
  return (
    <LoaderWrapper>
      <Box sx={{ position: 'relative', display: 'inline-flex' }}>
        <CircularProgress variant="determinate" value={progress} color="primary" size={60} />
        <Box
          sx={{
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            position: 'absolute',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
          }}
        >
          <Box component="span" sx={{ typography: 'caption', color: 'text.secondary' }}>
            {Math.round(progress)}%
          </Box>
        </Box>
      </Box>
    </LoaderWrapper>
  );
}

// The 3D model component
function Model({ url, autoRotate = true, scale = 1.5 }) {
  const groupRef = useRef();
  const { scene } = useGLTF(url);
  
  // Log model load success
  useEffect(() => {
    ConsolidatedLogger.logCS2(
      `3D Model loaded successfully: ${url}`,
      'INFO',
      { modelUrl: url, component: 'ModelViewer' }
    );
  }, [url]);
  
  // Auto-rotate the model if enabled
  useFrame(() => {
    if (autoRotate && groupRef.current) {
      groupRef.current.rotation.y += 0.005;
    }
  });
  
  return (
    <group ref={groupRef} dispose={null} scale={[scale, scale, scale]}>
      <primitive object={scene} />
    </group>
  );
}

// Main ModelViewer component
export default function ModelViewer({ modelPath, autoRotate = true, scale = 1.5 }) {
  const [isLoading, setIsLoading] = useState(true);
  
  useEffect(() => {
    // Reset loading state when model changes
    setIsLoading(true);
    
    // Log model loading attempt
    ConsolidatedLogger.logCS2(
      `Loading 3D model: ${modelPath}`,
      'INFO',
      { modelPath, component: 'ModelViewer' }
    );
    
    // Preload the model
    useGLTF.preload(modelPath);
  }, [modelPath]);
  
  return (
    <ModelContainer>
      <Canvas shadows camera={{ position: [0, 0, 5], fov: 50 }}>
        <ambientLight intensity={0.5} />
        <spotLight position={[10, 10, 10]} angle={0.15} penumbra={1} intensity={1} castShadow />
        <pointLight position={[-10, -10, -10]} intensity={0.5} />
        <Suspense fallback={null}>
          <Model url={modelPath} autoRotate={autoRotate} scale={scale} />
          <Environment preset="city" />
          <ContactShadows position={[0, -1.5, 0]} opacity={0.4} scale={5} blur={2.5} far={4} />
        </Suspense>
        <OrbitControls 
          enablePan={false} 
          enableZoom={true} 
          minPolarAngle={Math.PI / 4} 
          maxPolarAngle={Math.PI / 2} 
        />
      </Canvas>
      {isLoading && <Loader />}
    </ModelContainer>
  );
}
```

### 3. Create Featured Products Component with Dark-Themed Cards
Now, let's create a component to display featured product cards with the new dark theme:

```typescript
// front-end/src/pages-sections/home/FeaturedProducts.tsx
"use client";

import { useState, useEffect } from "react";
import Grid from "@mui/material/Grid2";
import Box from "@mui/material/Box";
import Typography from "@mui/material/Typography";
import Container from "@mui/material/Container";
import Skeleton from "@mui/material/Skeleton";
import { ConsolidatedLogger } from "@/utils/consolidated-logger";
import ProductCard1 from "components/product-cards/product-card-1/product-card";
import { Product } from "models/Product.model";
import cs2Api from "@/api/cs2-sales";
import { FeaturedProductsWrapper } from "./styles";

export default function FeaturedProducts() {
  const [products, setProducts] = useState<Product[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  
  useEffect(() => {
    const fetchFeaturedProducts = async () => {
      try {
        setIsLoading(true);
        // Fetch featured products (using the first page of products for simplicity)
        const data = await cs2Api.getProducts(1);
        
        if (data && data.products && data.products.length > 0) {
          // Just take the first 4 products for the featured section
          const featuredProducts = data.products.slice(0, 4);
          setProducts(featuredProducts);
          
          ConsolidatedLogger.logCS2(
            `Loaded ${featuredProducts.length} featured products for homepage`,
            'INFO',
            { 
              productCount: featuredProducts.length,
              productIds: featuredProducts.map(p => p.id)
            }
          );
        } else {
          setError("No featured products found");
        }
      } catch (err) {
        ConsolidatedLogger.logCS2Error(
          err instanceof Error ? err : new Error(String(err)),
          'FeaturedProducts'
        );
        setError("Failed to load featured products");
      } finally {
        setIsLoading(false);
      }
    };
    
    fetchFeaturedProducts();
  }, []);
  
  // Render loading skeletons with dark theme matching the screenshots
  if (isLoading) {
    return (
      <Container maxWidth="lg">
        <Typography variant="h2" component="h2" textAlign="center" mb={5} color="white">
          Featured Products
        </Typography>
        <Grid container spacing={3}>
          {[1, 2, 3, 4].map((item) => (
            <Grid key={item} xs={12} sm={6} md={3}>
              <Box sx={{ p: 1, backgroundColor: '#121212', borderRadius: 1, boxShadow: 3 }}>
                <Skeleton 
                  variant="rectangular" 
                  width="100%" 
                  height={300} 
                  sx={{ bgcolor: 'rgba(255, 255, 255, 0.1)' }} 
                />
                <Skeleton 
                  width="60%" 
                  height={30} 
                  sx={{ mt: 2, bgcolor: 'rgba(255, 255, 255, 0.1)' }} 
                />
                <Skeleton 
                  width="80%" 
                  height={20} 
                  sx={{ mt: 1, bgcolor: 'rgba(255, 255, 255, 0.1)' }} 
                />
                <Skeleton 
                  width="40%" 
                  height={40} 
                  sx={{ mt: 1, bgcolor: 'rgba(255, 255, 255, 0.1)' }} 
                />
              </Box>
            </Grid>
          ))}
        </Grid>
      </Container>
    );
  }
  
  // Render error state
  if (error) {
    return (
      <Container maxWidth="lg">
        <Typography variant="h2" component="h2" textAlign="center" mb={5} color="white">
          Featured Products
        </Typography>
        <Box sx={{ textAlign: 'center', p: 3 }}>
          <Typography color="error">{error}</Typography>
        </Box>
      </Container>
    );
  }
  
  return (
    <FeaturedProductsWrapper>
      <Container maxWidth="lg">
        <Typography variant="h2" component="h2" textAlign="center" mb={5} color="white">
          Featured Products
        </Typography>
        
        <Grid container spacing={3}>
          {products.map((product) => (
            <Grid key={product.id} xs={12} sm={6} md={3}>
              <ProductCard1 product={product} />
            </Grid>
          ))}
        </Grid>
      </Container>
    </FeaturedProductsWrapper>
  );
}
```

### 4. Create Homepage Component with Slideshow and Featured Products
Now, let's create the main homepage component with both a 3D model slideshow and featured products:

```typescript
// front-end/src/pages-sections/home/index.tsx
"use client";

import { useState, useEffect, useCallback } from "react";
import Box from "@mui/material/Box";
import Container from "@mui/material/Container";
import Typography from "@mui/material/Typography";
import Button from "@mui/material/Button";
import IconButton from "@mui/material/IconButton";
import ArrowForwardIcon from "@mui/icons-material/ArrowForward";
import ArrowBackIcon from "@mui/icons-material/ArrowBack";
import Link from "next/link";
import ModelViewer from "components/model-viewer/ModelViewer";
import FeaturedProducts from "./FeaturedProducts";
import { ConsolidatedLogger } from "@/utils/consolidated-logger";
import { 
  HeroSection,
  HeroBanner,
  HeroContent,
  ModelSlideshow,
  ModelSlide,
  SlideControls,
  SlideIndicator,
  HeroHeading,
  ShopNowButton,
  FeaturedSection,
  GradientHeading,
  ScrollDownButton,
  AboutSection
} from "./styles";

// Model paths for the slideshow - matching the requirements
const MODELS = [
  "/assets/images/cs-go-guns/awp_counter_strike_2.glb",
  "/assets/images/cs-go-guns/sandstorm_-_gunblade.glb",
  "/assets/images/cs-go-knives/cs2_knife_-_case_hardened__free.glb"
];

// Model information for display
const MODEL_INFO = [
  {
    name: "AWP | Counter Strike 2",
    description: "Legendary sniper rifle skin with precision one-shot capability",
    price: "$1,249.99"
  },
  {
    name: "Sandstorm | Gunblade",
    description: "Exclusive desert-themed tactical assault rifle",
    price: "$899.99"
  },
  {
    name: "CS2 Knife | Case Hardened",
    description: "Rare case hardened knife with unique pattern",
    price: "$749.99"
  }
];

export default function HomePage() {
  const [activeSlide, setActiveSlide] = useState(0);
  const [isAutoPlaying, setIsAutoPlaying] = useState(true);
  
  // Handle slide changes
  const nextSlide = useCallback(() => {
    setActiveSlide(prev => (prev + 1) % MODELS.length);
  }, []);
  
  const prevSlide = useCallback(() => {
    setActiveSlide(prev => (prev - 1 + MODELS.length) % MODELS.length);
  }, []);
  
  const goToSlide = useCallback((index) => {
    setActiveSlide(index);
    // Pause auto-play when manually changing slides
    setIsAutoPlaying(false);
    // Resume auto-play after 10 seconds of inactivity
    setTimeout(() => setIsAutoPlaying(true), 10000);
  }, []);
  
  // Auto-play slideshow
  useEffect(() => {
    if (!isAutoPlaying) return;
    
    const interval = setInterval(() => {
      nextSlide();
    }, 7000); // Change slide every 7 seconds
    
    return () => clearInterval(interval);
  }, [isAutoPlaying, nextSlide]);
  
  // Log page view
  useEffect(() => {
    ConsolidatedLogger.logCS2(
      "Homepage viewed with 3D model slideshow",
      "INFO",
      {
        initialModel: MODELS[0],
        totalModels: MODELS.length,
        autoPlay: isAutoPlaying
      }
    );
  }, [isAutoPlaying]);
  
  // Log slide changes
  useEffect(() => {
    ConsolidatedLogger.logCS2(
      `Slideshow changed to model: ${MODEL_INFO[activeSlide].name}`,
      "INFO",
      {
        modelIndex: activeSlide,
        modelPath: MODELS[activeSlide],
        modelName: MODEL_INFO[activeSlide].name
      }
    );
  }, [activeSlide]);
  
  return (
    <Box component="main" sx={{ backgroundColor: '#0a0a0a' }}> {/* Dark background matching screenshots */}
      {/* Hero Section with 3D Model Slideshow */}
      <HeroSection>
        <HeroBanner>
          <Container maxWidth="lg">
            <Box sx={{ display: 'flex', flexDirection: { xs: 'column', md: 'row' }, alignItems: 'center' }}>
              <HeroContent>
                <HeroHeading variant="h1">
                  Exclusive CS2 Skins on <GradientHeading>Polygon</GradientHeading>
                </HeroHeading>
                
                <Typography variant="h5" sx={{ my: 2, fontWeight: 400, opacity: 0.9, color: 'white' }}>
                  {MODEL_INFO[activeSlide].name}
                </Typography>
                
                <Typography variant="body1" sx={{ mb: 4, maxWidth: '600px', color: 'rgba(255,255,255,0.8)' }}>
                  {MODEL_INFO[activeSlide].description}
                </Typography>
                
                <Typography variant="h4" sx={{ mb: 2, fontWeight: 700, color: '#b388ff' }}> {/* Purple price color from screenshot */}
                  {MODEL_INFO[activeSlide].price}
                </Typography>
                
                <Box sx={{ display: 'flex', gap: 2 }}>
                  <ShopNowButton 
                    variant="contained" 
                    color="primary" 
                    size="large" 
                    endIcon={<ArrowForwardIcon />}
                    component={Link}
                    href="/market"
                  >
                    Shop Now
                  </ShopNowButton>
                  
                  <Button
                    variant="outlined"
                    color="primary"
                    size="large"
                    component={Link}
                    href="/market"
                  >
                    View All
                  </Button>
                </Box>
              </HeroContent>
              
              <ModelSlideshow>
                {MODELS.map((model, index) => (
                  <ModelSlide 
                    key={model} 
                    sx={{ 
                      opacity: activeSlide === index ? 1 : 0,
                      pointerEvents: activeSlide === index ? 'all' : 'none'
                    }}
                  >
                    <ModelViewer modelPath={model} autoRotate={true} scale={1.8} />
                  </ModelSlide>
                ))}
                
                <SlideControls>
                  <IconButton onClick={prevSlide} color="primary" sx={{ bgcolor: 'rgba(0, 0, 0, 0.5)' }}>
                    <ArrowBackIcon />
                  </IconButton>
                  
                  <Box sx={{ display: 'flex', gap: 1 }}>
                    {MODELS.map((_, index) => (
                      <SlideIndicator 
                        key={index} 
                        active={activeSlide === index}
                        onClick={() => goToSlide(index)}
                      />
                    ))}
                  </Box>
                  
                  <IconButton onClick={nextSlide} color="primary" sx={{ bgcolor: 'rgba(0, 0, 0, 0.5)' }}>
                    <ArrowForwardIcon />
                  </IconButton>
                </SlideControls>
              </ModelSlideshow>
            </Box>
            
            <ScrollDownButton href="#featured">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M7 10l5 5 5-5" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
              </svg>
            </ScrollDownButton>
          </Container>
        </HeroBanner>
      </HeroSection>
      
      {/* Featured Products Section */}
      <FeaturedSection id="featured">
        <FeaturedProducts />
      </FeaturedSection>
      
      {/* About Section */}
      <AboutSection>
        <Container maxWidth="lg">
          <Typography variant="h2" component="h2" textAlign="center" mb={4} color="white">
            About PolygonExpress
          </Typography>
          
          <Typography variant="body1" textAlign="center" sx={{ maxWidth: '800px', mx: 'auto', mb: 4, color: 'rgba(255,255,255,0.8)' }}>
            PolygonExpress is the premier marketplace for CS2 skins, leveraging Polygon blockchain technology
            for secure, fast, and low-cost transactions. Our platform offers a wide selection of rare and
            exclusive CS2 items, including weapons, knives, and more.
          </Typography>
          
          <Box sx={{ display: 'flex', justifyContent: 'center', mt: 2 }}>
            <Button 
              variant="contained" 
              color="secondary" 
              size="large"
              component={Link}
              href="/about"
              sx={{ mr: 2 }}
            >
              Learn More
            </Button>
            <Button 
              variant="outlined" 
              color="primary" 
              size="large"
              component={Link}
              href="/market"
            >
              Explore Market
            </Button>
          </Box>
        </Container>
      </AboutSection>
    </Box>
  );
}
```

### 5. Create Styled Components for the Homepage
Now, let's create the styled components for the homepage, ensuring consistency with the dark theme from screenshots:

```typescript
// front-end/src/pages-sections/home/styles.ts
"use client";

import { styled, alpha } from "@mui/material/styles";
import Box from "@mui/material/Box";
import Button from "@mui/material/Button";
import Typography from "@mui/material/Typography";
import Link from "next/link";

// Hero Section Components
export const HeroSection = styled(Box)(({ theme }) => ({
  width: "100%",
  position: "relative",
  overflow: "hidden",
  paddingTop: theme.spacing(3),
  paddingBottom: theme.spacing(8),
  minHeight: '90vh',
  display: 'flex',
  alignItems: 'center',
  backgroundColor: '#0a0a0a', // Dark background matching screenshots
  backgroundImage: 'radial-gradient(circle at 50% 0%, rgba(25, 118, 210, 0.1) 0%, transparent 70%)',
}));

export const HeroBanner = styled(Box)(({ theme }) => ({
  width: "100%",
  position: "relative",
  zIndex: 1,
  [theme.breakpoints.down('md')]: {
    paddingTop: theme.spacing(3),
    paddingBottom: theme.spacing(5),
  }
}));

export const HeroContent = styled(Box)(({ theme }) => ({
  flex: 1,
  zIndex: 10,
  paddingRight: theme.spacing(4),
  [theme.breakpoints.down('md')]: {
    paddingRight: 0,
    textAlign: 'center',
    marginBottom: theme.spacing(6),
  }
}));

export const HeroHeading = styled(Typography)(({ theme }) => ({
  fontSize: '3.5rem',
  fontWeight: 800,
  lineHeight: 1.2,
  marginBottom: theme.spacing(3),
  color: 'white', // White text on dark background
  [theme.breakpoints.down('md')]: {
    fontSize: '2.5rem',
  },
  [theme.breakpoints.down('sm')]: {
    fontSize: '2rem',
  }
}));

export const GradientHeading = styled('span')(({ theme }) => ({
  backgroundImage: `linear-gradient(135deg, ${theme.palette.primary.main}, ${theme.palette.secondary.main})`,
  backgroundClip: 'text',
  WebkitBackgroundClip: 'text',
  color: 'transparent',
  display: 'inline-block',
}));

export const ShopNowButton = styled(Button)(({ theme }) => ({
  padding: '12px 24px',
  borderRadius: theme.shape.borderRadius,
  position: 'relative',
  overflow: 'hidden',
  '&::after': {
    content: '""',
    position: 'absolute',
    top: 0,
    left: 0,
    width: '100%',
    height: '100%',
    background: `linear-gradient(135deg, rgba(0,0,0,0), rgba(255,255,255,0.2))`,
    transition: 'opacity 0.3s ease',
    opacity: 0,
  },
  '&:hover::after': {
    opacity: 1,
  }
}));

export const ScrollDownButton = styled(Link)(({ theme }) => ({
  position: 'absolute',
  bottom: theme.spacing(4),
  left: '50%',
  transform: 'translateX(-50%)',
  width: '48px',
  height: '48px',
  display: 'flex',
  alignItems: 'center',
  justifyContent: 'center',
  borderRadius: '50%',
  backgroundColor: 'rgba(0, 0, 0, 0.5)',
  color: 'white',
  boxShadow: '0 0 10px rgba(0, 0, 0, 0.2)',
  transition: 'all 0.3s ease',
  animation: 'bounce 2s infinite',
  '&:hover': {
    backgroundColor: 'rgba(0, 0, 0, 0.7)',
    boxShadow: '0 0 15px rgba(0, 0, 0, 0.3)',
    transform: 'translateX(-50%) translateY(-5px)',
  },
  '@keyframes bounce': {
    '0%, 20%, 50%, 80%, 100%': {
      transform: 'translateX(-50%) translateY(0)',
    },
    '40%': {
      transform: 'translateX(-50%) translateY(-10px)',
    },
    '60%': {
      transform: 'translateX(-50%) translateY(-5px)',
    },
  },
}));

// 3D Model Slideshow Components
export const ModelSlideshow = styled(Box)(({ theme }) => ({
  position: 'relative',
  flex: 1,
  minHeight: '500px',
  width: '100%',
  maxWidth: '650px',
  margin: '0 auto',
  [theme.breakpoints.down('md')]: {
    minHeight: '400px',
  },
  [theme.breakpoints.down('sm')]: {
    minHeight: '300px',
  }
}));

export const ModelSlide = styled(Box)(({ theme }) => ({
  position: 'absolute',
  top: 0,
  left: 0,
  width: '100%',
  height: '100%',
  transition: 'opacity 1s ease-in-out',
}));

export const SlideControls = styled(Box)(({ theme }) => ({
  position: 'absolute',
  bottom: theme.spacing(2),
  left: '50%',
  transform: 'translateX(-50%)',
  display: 'flex',
  alignItems: 'center',
  justifyContent: 'space-between',
  width: '80%',
  maxWidth: '300px',
  zIndex: 2,
}));

export const SlideIndicator = styled(Box, {
  shouldForwardProp: (prop) => prop !== 'active'
})<{ active: boolean }>(({ theme, active }) => ({
  width: active ? '24px' : '12px',
  height: '12px',
  borderRadius: '6px',
  backgroundColor: active ? theme.palette.primary.main : alpha(theme.palette.primary.main, 0.4),
  transition: 'all 0.3s ease',
  cursor: 'pointer',
  '&:hover': {
    backgroundColor: active ? theme.palette.primary.main : alpha(theme.palette.primary.main, 0.6),
  }
}));

// Featured Section
export const FeaturedSection = styled(Box)(({ theme }) => ({
  padding: theme.spacing(8, 0),
  backgroundColor: '#0a0a0a', // Match the dark background from screenshots
}));

export const FeaturedProductsWrapper = styled(Box)(({ theme }) => ({
  '& .MuiCard-root': {
    height: '100%',
    // Make sure the cards use the dark theme styling
    backgroundColor: '#121212', // Dark background for cards
    color: 'white',
  }
}));

// About Section
export const AboutSection = styled(Box)(({ theme }) => ({
  padding: theme.spacing(8, 0),
  backgroundColor: '#0a0a0a', // Dark background matching screenshots
  backgroundImage: 'radial-gradient(circle at 50% 100%, rgba(25, 118, 210, 0.08) 0%, transparent 70%)',
}));
```

## Integration with Dark-Themed Product Cards

The FeaturedProducts component on the homepage will use the same ProductCard1 component that will be enhanced with a dark theme. This ensures consistent styling across both the homepage and the market page.

Key integration points:
1. The same ProductCard1 component is used in both locations
2. Dark styling is applied consistently
3. Product data is fetched from the same API
4. Cards will have the same hover effects and animations

## Testing and Verification

To verify the homepage implementation:

1. **Homepage Replacement**:
   - Confirm the redirect page is replaced with the new homepage
   - Verify all sections (hero, featured products, about) are present

2. **3D Model Slideshow**:
   - Test that all GLB models load and display correctly
   - Verify navigation between models works (manual and automatic)
   - Check that model information updates properly

3. **Featured Products**:
   - Ensure products load from the API
   - Verify the dark-themed product cards match the updated styling
   - Check that the cards have the same layout and structure as on the market page
   - Test all hover effects and animations

4. **Visual Consistency**:
   - Confirm the dark background is consistent throughout the homepage
   - Verify text is readable on all backgrounds
   - Check that colors match those seen in the screenshots (purple prices, etc.)

5. **Responsive Design**:
   - Test on multiple device sizes
   - Verify 3D model visibility and interaction on mobile
   - Check product card grid layout at different breakpoints

## Implementation Notes

1. The homepage will use the same dark theme as seen in the market page screenshots
2. Product cards will match the enhanced dark styling planned for the market page
3. 3D models will be centered in the slideshow with proper lighting for visibility
4. Text color will be primarily white or light gray for readability on dark backgrounds
5. The purple price color (#b388ff) seen in the screenshots will be maintained
6. The layout will be responsive with mobile-first considerations 