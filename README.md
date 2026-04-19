# 💊 Lovely Pharma

**Lovely Pharma** is a premium, production-ready Quick-Commerce medicine delivery application engineered specifically for university and hostel students. Built with Flutter and backed by a robust Firebase cloud architecture, it offers a seamless, secure, and blazing-fast interface bridging students to campus pharmacy essentials instantly.

---

## ✨ Key Features

- 🏎️ **Quick Commerce Dashboard**: A highly polished, Blinkit-style home screen featuring dynamic greeting headers, promotional carousel banners, and curated product discovery.
- 🔐 **Live Cloud Authentication**: Secure user management powered by `FirebaseAuth`, allowing students to register and sign in seamlessly across devices.
- 📦 **Real-Time Inventory (Firestore)**: A fully synced `FirebaseFirestore` backend containing hundreds of diverse pharmacy products categorized elegantly across tabs (Pain Relief, First Aid, Cold/Cough, Skin Care).
- 📸 **Prescription Upload System**: Built-in compliance logic enforcing image verification for restricted medicines. Users securely upload images via `firebase_storage` during checkout to unblock cart processing.
- 🏢 **Multi-Location Delivery**: Extensible profile system that stores multiple hostel locations and room numbers per student, pre-filling checkout drop-downs for rapid order placement.
- 📍 **Live Delivery Tracking Simulator**: An API-free mapping experience powered by `flutter_map`. Visually renders the campus, draws routes, and simulates an animated runner delivering your order via GPS markers.
- 🔔 **Push Ready Architecture**: Pre-configured `firebase_messaging` engine allowing localized and grouped push notifications out of the box (FCM token generation).
- ❤️ **Persistent Wishlist Ecosystem**: Fully integrated state management allowing users to sync saved items effortlessly between the main dashboard and detailed product views.

---

## 🛠️ Technology Stack

- **Framework**: Flutter (Android/iOS)
- **Language**: Dart
- **State Management**: `provider` (MultiProvider architecture for Cart, Auth, Orders, Favorites, and generic Medicines).
- **Backend & Cloud Services**: 
  - `firebase_core` & `cloud_firestore` (NoSQL Real-time DB)
  - `firebase_auth` (User Authentication Flow)
  - `firebase_storage` (Bucket uploads for prescriptions)
  - `firebase_messaging` (Cloud notifications engine)
- **Mapping Engine**: `flutter_map` + `latlong2` (OpenStreetMap integration).

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (`stable` branch)
- Dart SDK
- Firebase Project with Auth (`Email/Password`), Firestore Database (in Test Mode/Configured Rules), and Storage Bucket enabled.
- `google-services.json` generated from your Firebase console.

### Installation & Deployment

1. **Clone the repository:**
   ```bash
   git clone https://github.com/anubhavxdev/Lovely-Pharma.git
   ```

2. **Navigate into the project directory:**
   ```bash
   cd Lovely-Pharma
   ```

3. **Configure Firebase Secrets:**
   - Drop your `google-services.json` inside the `android/app/` directory.

4. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

5. **Populate your Cloud Database (One-time Setup):**
   - Run the app via `flutter run`.
   - On the Home Screen, tap the **Database Icon** (`🛢️` icon next to the profile avatar).
   - This will instantly seed the active Firestore Database with nearly 200 realistic dummy products generated securely via the `lib/utils/seed_data.dart` script!

6. **Run the Application:**
   ```bash
   flutter run
   ```

---
*Built with ❤️ for rapid campus healthcare.*
