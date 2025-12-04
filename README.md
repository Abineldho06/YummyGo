🍽️ YummiGo — Flutter Machine Test (Zartek)

A fully functional food ordering mobile app built using Flutter, completing the Zartek machine test requirements.
The app includes Google Authentication, Menu API integration, Category-based UI, Cart system, Checkout flow, and clean Provider-based state management.

This project also includes several extra features beyond the assignment requirements, making the UI smoother, cleaner, and more production-ready.

🚀 Features Implemented
✅ 1. Google Sign-In Authentication

Secure login using Google OAuth

Stores session to avoid repeated logins

Logout functionality included

✅ 2. Splash Screen + Onboarding Flow

Custom animated splash screen

Smooth fade transition

Onboarding screens introducing app features

✅ 3. Menu API Integration

Fetched data from:
https://faheemkodi.github.io/mock-menu-api/menu.json

Includes:

Categories

Dishes list

Addons

Calories

Veg/Non-Veg indicators

Customization availability

✅ 4. Home Screen (Dynamic UI)

Tab bar showing all categories

Horizontal scrolling category tabs

Dish tiles for each category with all details

High-quality images & clean UI

✅ 5. Cart System (Provider State Management)

Add to cart

Remove from cart

Increase/decrease quantity

Prevent duplicate items

Dynamic total price calculation

Real-time cart updates

✅ 6. Checkout Screen

Order summary

Update quantities inside checkout

Lottie animations

Success pop-up with cart clearing

🔥 7. Additional Features Added

⭐ Elegant UI enhancements	Used Google Fonts, shadows, rounded cards, and responsive layout
⭐ Lottie Animations	Added empty cart animation & success animation
⭐ Profile Drawer	Shows user info and logout button
⭐ DishTile Component	Custom reusable tile widget for cleaner code
⭐ API Error Handling	Helps avoid app crashes on API failure
⭐ Provider Architecture	Clean separation: controllers, models, services
⭐ Animated transitions	Smooth splash → onboarding → home navigation
⭐ Custom Veg / Non-Veg indicators	Professional UI for food items
⭐ Addons & Customizations UI prepared	Supports future expansion

🛠️ Tech Stack
Technology	Usage
Flutter	App development
Dart	Language
Provider	State management
Google Sign-In	Authentication
HTTP Package	API calls
Lottie	Animations
Google Fonts	Modern UI typography

📂 Project Structure
lib/
 ├── controllers/
 │     ├── authentication_controller.dart
 │     ├── menu_controller.dart
 │     └── cart_controller.dart
 │
 ├── models/
 │     ├── category_model.dart
 │     ├── dish_model.dart
 │     └── addon_model.dart
 │
 ├── services/
 │     └── api_service.dart
 │
 ├── views/
 │     ├── splash_screen/
 │     ├── onboarding_screen/
 │     ├── home_screen/
 │     ├── checkout_screen/
 │     └── widgets/ (dish tiles, cards)
 │
 └── main.dart
 
