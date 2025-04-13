# Chat Bot 🧠💬

**Chat Bot** is a basic yet powerful Flutter application that enables group chatting, powered by Firebase. Users can register using email and password, create or join groups, and chat in real time. This project demonstrates Firebase integration, BLoC state management, and reactive UI with StreamBuilder.

---

## 🧩 I - Introduction

Chat Bot is a real-time group chatting app built with Flutter and Firebase. It allows users to:

- Register/Login with email and password.
- Create new chat groups or join existing ones.
- Engage in real-time conversations with group members.
- Enjoy smooth UI animations and transitions.

---

## 📌 N - Need

This app is created to demonstrate:

- Firebase integration for authentication and database operations.
- BLoC pattern for clean state management.
- Use of `StreamBuilder` for live chat updates.
- Modular app architecture for scalability and maintenance.

---

## ⚙️ S - Setup

### 🔧 Prerequisites
- Flutter SDK
- Firebase project set up (Authentication and Firestore enabled)
- Android/iOS emulator or physical device

### 🛠 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/chat_bot.git
   cd chat_bot
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Connect Firebase:
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files.

4. Run the app:
   ```bash
   flutter run
   ```

---

## 🏗️ A - Architecture

The project follows a modular folder structure:

```
lib/
├── bloc/          # Contains BLoC, Events, and States
├── pages/         # UI Screens
├── services/      # Firebase and API related functions
├── widgets/       # Reusable UI components
├── helper/        # Local storage utilities and helpers
```

**State Management:** BLoC  
**Realtime Data:** StreamBuilder  
**Local Storage:** Shared Preferences

---

## 📦 M - Modules & Packages

### 🔥 Firebase
- `firebase_core: ^2.32.0`
- `cloud_firestore: ^4.17.5`
- `firebase_database: ^10.5.7`
- `firebase_ui_firestore: ^1.6.3`

### 🎨 UI & Utilities
- `flutter_image_compress: 2.3.0`
- `lottie: ^2.1.0`
- `image: ^4.0.0`
- `awesome_snackbar_content: ^0.1.3`
- `page_transition: ^2.1.0`

### ⚙️ State Management
- `bloc: ^8.1.4`
- `flutter_bloc: ^8.1.6`

---

## 🧪 E - Example Use

1. **Create Account**: User signs up with email and password.
2. **Create/Join Group**: User can create a new group or join existing ones.
3. **Chat Live**: Messages stream in real-time with a live UI powered by `StreamBuilder`.

---

## 👨‍💻 M - Maintainers

- **Your Name** – [@yourhandle](https://github.com/yourusername)
- Contributions welcome! Feel free to open issues or submit pull requests.

---

> 🚀 "Built with Flutter & Firebase to connect people in real-time."