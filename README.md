# Oriflame Quick Share Feature - Flutter Assignment

This project is a high-fidelity implementation of the Oriflame Quick Share feature. It translates the provided Figma designs into a production-inspired Flutter application.

## Key Features and Improvements

### 1. Immersive Media Experience
The core of the app is a vertical scrolling reels interface. Each post is synchronized with a recommended audio track that plays and stops automatically as the user scrolls. I've also implemented a multi-layered image loading strategy that prioritizes local assets for speed, falls back to network URLs for flexibility, and finally shows a branded Oriflame placeholder if both fail.

### 2. Functional Navigation and Discovery
The application features a complete navigation ecosystem. 
- The search section provides a discovery grid where tapping a product thumbnail jumps the user directly to that specific post in the feed.
- The library and community sections are fully designed to show categorized product assets and brand partner groups.
- The profile section uses a modern SliverAppBar design to display partner stats and account options.

### 3. Dynamic Theming
A global dark mode toggle is integrated into the top bar. The entire application, from the landing sequence to the caption editor, adapts its color palette instantly. This ensures a premium user experience in any lighting environment.

### 4. Professional Editing Workflow
The caption editor is built to match professional social media tools. It includes real-time change detection, clear visualization of referral links/codes, and a preview of the recommended Oriflame branding. 

### 5. Optional Enhancement
Integrated Google AdMob to demonstrate how monetization could be incorporated into a content-driven application without interrupting the primary workflow. An interstitial ad is programmed to appear exactly once when the user reaches the third reel, showing how monetization can be balanced with content engagement.

### 6. Responsive and Robust Design
The UI has been designed with responsiveness in mind using SafeArea, Flexible layouts, and relative sizing to provide a consistent experience across different screen sizes.

## Technical Stack
- Flutter Framework
- GetX for state management, theming, and routing
- Audioplayers for synchronized media playback
- Google Mobile Ads for monetization
- Google Fonts for consistent typography

## Getting Started
1. Clone the repository.
2. Run flutter pub get to install all dependencies (including GetX, Audioplayers, and Mobile Ads).
3. Ensure the device has an active internet connection for media streaming and ad fetching.
4. Execute flutter run on your preferred emulator or physical device.

## Assumptions & Enhancements

The provided Figma focused primarily on the Quick Share workflow. Some interactions and screens were intentionally open to interpretation, so I made a few product-oriented enhancements while preserving the intended user journey.

Enhancements include:
- Dark mode support
- Audio-synchronized reel experience
- Discovery/Search navigation
- Community and Library sections
- Responsive layouts
- Smooth animations and transitions
- Image loading fallbacks
- Caption editing improvements

These additions were made to demonstrate product thinking while remaining faithful to the original concept.
