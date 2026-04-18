# 💊 Lovely Pharma

**Lovely Pharma** is a premium, production-level Quick-Commerce medicine delivery application engineered specifically for university and hostel students. Built entirely with Flutter, it offers a seamless, robust, and sensory-forward interface bridging students to campus pharmacy essentials instantly.

---

## ✨ Key Features

- 🏎️ **Quick Commerce Dashboard**: A highly polished, Swiggy/Blinkit-style home screen featuring dynamic greeting headers, promotional carousel banners, and curated product discovery.
- 🗺️ **Live Delivery Tracking Simulator**: A zero-config, API-free mapping experience powered by `flutter_map` and `OpenStreetMap`. Visually renders the campus, draws optimized routes, and simulates a 45-second animated runner delivering your order via GPS markers.
- ❤️ **Persistent Wishlist Ecosystem**: Fully integrated `FavoriteProvider` state management allowing users to sync saved items effortlessly between the main dashboard and detailed product views.
- 🔍 **Category Filtering Engine**: Smooth horizontal category lists (First Aid, Cold/Cough, Skin Care) that elegantly filter the master product grid dynamically.
- 🛒 **Smart Cart & Checkout Validation**: Validates real-time inventory capacities, dynamic total calculations, and supports "Cash on Delivery" order flows out of the box.

## 🛠️ Technology Stack

- **Framework**: Flutter (Android/iOS)
- **Language**: Dart
- **State Management**: `provider` (MultiProvider architecture for Cart, Auth, Orders, Favorites, and generic Medicines).
- **Mapping Engine**: `flutter_map` + `latlong2` (No Google Maps API Key required!).
- **Backend Architecture**: Designed with decoupled `Service`/`Provider` layers optimized for Firebase Firestore (currently running on isolated asynchronous mock streams for rapid UI prototyping).

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (`stable` branch)
- Dart SDK
- An Android Emulator or physical device (iOS works symmetrically but paths are structured for an Android-first build context).

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/anubhavxdev/Lovely-Pharma.git
   ```

2. **Navigate into the project directory:**
   ```bash
   cd Lovely-Pharma
   ```

3. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the Application:**
   ```bash
   flutter run
   ```

## ⚠️ Note on Firebase Sandbox
The application natively handles `Firebase.initializeApp()` in its root `main.dart`. To allow frictionless frontend UI testing, the active Firebase configurations are temporarily mocked using purely local streams within `database_service.dart` and `auth_service.dart`. 

To transition to production:
1. Re-enable `Firebase.initializeApp()` in `main.dart`.
2. Generate your unique `google-services.json` via the Firebase Console.
3. Repoint the `AuthService` and `DatabaseService` classes to output real `FirebaseAuth` and `FirebaseFirestore` streams.

---
*Built with ❤️ for rapid campus healthcare.*
