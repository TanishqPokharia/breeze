# Breeze

A modern Flutter app for user management, built with clean architecture, BLoC state management, and robust API integration.

[![Watch Video]()](https://drive.google.com/file/d/1Jw3vV-o7Wb-6NJ1UUjK50bX_LEEggU0m/view?usp=sharing)


## 🚀 Project Overview
Breeze is a Flutter application that demonstrates best practices in Flutter development, focusing on user management with:
- BLoC pattern for state management
- Integration with the [DummyJSON Users API](https://dummyjson.com/users)
- Clean, maintainable, and scalable code structure

## ✨ Features

### 1. API Integration
- Fetches users from DummyJSON API with pagination (`limit`/`skip`)
- Infinite scrolling for user list with debouncing
- Real-time search by user name
- Fetches user posts and todos on selection
- Endpoints used:
  - Users: `https://dummyjson.com/users`
  - Posts: `https://dummyjson.com/posts/user/{userId}`
  - Todos: `https://dummyjson.com/todos/user/{userId}`

### 2. BLoC State Management
- Uses `flutter_bloc` for all state management
- Handles loading, success, and error states
- Separate events for fetching, searching, and pagination
- Nested BLoC logic for fetching posts and todos per user

### 3. UI Features
- **User List Screen:**
  - Displays users with avatar, name, and email
  - Infinite scroll with debouncing and pull-to-refresh
  - Real-time search bar at the top
- **User Detail Screen:**
  - Shows detailed user info
  - Tabbed view for Posts and Todos
  - Fetches and displays posts and todos for the selected user
- **Create Post Screen:**
  - Allows adding new posts locally (title + body)
- **Loading Indicators:**
  - Progress indicators during API calls
- **Error Handling:**
  - Robust and user-friendly error messages for all API and network errors
- **Bonus:**
  - Pull-to-refresh
  - Light/Dark theme switching

## 🏗️ Architecture
- **Clean Architecture:**
  - Separation of concerns between data, domain, and presentation layers
- **BLoC Pattern:**
  - All business logic and state handled via BLoC
  - Events and states clearly defined for each feature
- **API Layer:**
  - Handles all network requests and error handling
- **Presentation Layer:**
  - Responsive, modern UI with clear separation from business logic

## 📦 Packages Used

- **flutter_bloc** - For state management using the BLoC pattern
- **dio** - HTTP client for API requests
- **connectivity_plus** - For network connectivity monitoring
- **sqflite** - Local storage and caching
- **dartz** - Functional programming
- **get_it** - Service locator to help with dependency injetion
- **shared_preferences** - Storing user theme preferences locally
- **google_fonts** - Wide range of beautiful fonts
- **go_router** - Structured routing for screens

## Packages Used


## 🛠️ Setup Instructions

1. **Clone the repository:**
   ```sh
   git clone https://github.com/yourusername/breeze.git
   cd breeze
   ```
2. **Install dependencies:**
   ```sh
   flutter pub get
   ```
3. **Run the app:**
   ```sh
   flutter run
   ```

## 📂 Folder Structure
```
lib/
  data/         # Data sources, models, repositories
  domain/       # Entities, repository interfaces, use cases
  presentation/ # BLoC, screens, widgets
  utils/        # Utilities, helpers, extensions, http client
  themes/       # App colors, themes etc
  router/       # Router configurations 
```

## 💡 Notes
- The app uses only public APIs and local state for new posts
- All features are implemented with scalability and maintainability in mind
- Bonus features like pull-to-refresh and theme switching are included

## 📄 License
This project is open source and available under the [MIT License](LICENSE).

---
