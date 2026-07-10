# Oriflame Quick Share Feature (Full Demo Implementation)

A comprehensive, high-fidelity Flutter implementation of the Oriflame Quick Share feature, showcasing complex UI, media handling, monetization, and seamless navigation.

## 🚀 Key Deliverables & Enhancements

### 🎨 Immersive Media Experience
- **Reel UI with Synchronized Audio**: Vertical PageView with high-quality product images and unique recommended audio tracks that play/stop automatically as you scroll.
- **Dynamic Content Overlay**: Collapsible `ProductInfoCard` that slides into view after 3 seconds, strategically placed above the profile row to maintain a clean layout.
- **Visual Polishing**: Branded social asset icons, glassmorphism overlays, and smooth animations (fade-in, slide, scale).

### 🛠 Fully Functional Navigation
- **Top Tab Bar**: Active navigation across "Smart Post", "Library", "Communities", and "Share&Win".
- **Bottom Navigation**: Fully responsive bottom bar with dedicated routes for "Search", "Home", and "Profile".
- **Dynamic Profile Section**: A realistic "My Profile" screen with stats (Posts, Earnings, Points) and brand partner branding.

### 🌗 Pro Dark Mode & Theming
- **Instant Theme Switching**: Efficient GetX-based dark mode toggle in the top bar.
- **Theme-Aware UI**: All components (loading steps, editor, profile) dynamically adapt their color palettes for perfect readability in both light and dark environments.

### ✍️ Advanced Editor & Flow
- **High-Fidelity Caption Editor**: Professional interface with emoji-rich previews and visualized referral data.
- **Smart Loading Flow**: An animated sequence that builds user trust by showing the intelligence behind the "Smart Post".

### 💰 Strategic Monetization
- **AdMob Integration**: Demonstrates monetization potential via an **Interstitial Ad** that appears precisely once when the user interacts with the 3rd reel, following UX best practices.

## 🛠 Tech Stack
- **Framework**: Flutter
- **State/Theme/Routes**: GetX
- **Media**: `audioplayers`
- **Monetization**: `google_mobile_ads`
- **Icons**: Branded PNG assets + Material/Cupertino Icons.

## 🏃 Getting Started
1. Run `flutter pub get`.
2. Ensure you are on a device with internet access (for network images/audio).
3. `flutter run`.

---
*Developed with attention to UI/UX details to stand out in the Oriflame application process.*
