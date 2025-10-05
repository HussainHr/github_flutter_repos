# GitHub Flutter Repositories
A Flutter application that displays the top 50 most starred Flutter repositories from GitHub with offline support, sorting, and theme customization.

## 📱 Overview
This app fetches and displays popular Flutter repositories from GitHub. It works offline by caching data locally and allows users to sort repositories by stars or last updated date. The app features both light and dark themes with persistent preferences.

## ✨ Key Features

* -View top 50 Flutter repositories from GitHub
* -Sort by star count or last updated date
* -Offline support with SQLite database
* -Dark and Light theme toggle
* -Pull-to-refresh functionality
* -Clean Material Design 3 UI
* -Repository detail page with stats

## 🛠️ Technologies & Packages Used
### State Management:
flutter_riverpod: ^3.0.0 - State management solution

### Networking:-
dio: ^5.9.0 - HTTP client for API calls

### Local Storage:-
* sqflite: ^2.4.2 - SQLite database for offline storage
* shared_preferences: ^2.5.3 - Save user preferences (theme, sort)

### Code Generation:-
* json_serializable: ^6.7.1 - JSON serialization
* build_runner: ^2.4.7 - Code generator

### UI & Utilities:-
* cached_network_image: ^3.4.1 - Image caching
* intl: ^0.20.2 - Date formatting
* flutter_dotenv: ^6.0.0 - Environment configuration

### Architecture:-
* Clean Architecture (Core, Data, Domain, Presentation layers)
* Repository Pattern for data management
* StateNotifier Pattern for state management

## 📋 Prerequisites

* Flutter SDK 3.35.2 or higher
* Dart SDK 3.9.0 or higher
* Android Studio / VS Code with Flutter extensions

### 🚀 Installation & Setup
1. Clone the Repository
   bash
   git clone https://github.com/HussainHr/github_flutter_repos.git
   cd github-flutter-repos
2. Install Dependencies
   bash
   flutter pub get
3. Create Environment Files
   Create .env.dev file in the root directory:
   envBASE_URL=https://api.github.com
   API_TIMEOUT=30000
   DEBUG_MODE=true
   Create .env.prod file in the root directory:
   envBASE_URL=https://api.github.com
   API_TIMEOUT=30000
   DEBUG_MODE=false
4. Generate JSON Serialization Code
   bash
   dart run build_runner build --delete-conflicting-outputs
      This generates the repository_model.g.dart file needed for JSON parsing.
5. Run the Application
   For Development:
   bash
   flutter run --dart-define=ENV=dev
      For Production:
      bash
   flutter run --dart-define=ENV=prod
                 # Reusable widgets
     🔧 Build for Release
     Android APK
     bash
    flutter build apk --dart-define=ENV=prod --release
     iOS
     bash
     flutter build ios --dart-define=ENV=prod --release
    🎯 How It Works

First Launch: App fetches top 50 Flutter repos from GitHub API and saves to local database
Subsequent Launches: App loads data from local database instantly (works offline)
Pull to Refresh: Fetches latest data and updates the database
Sorting: Toggle between sorting by stars or last updated (preference saved locally)
Theme: Switch between light and dark themes (preference saved locally)

## 📖 Usage
    
View Repositories: Scroll through the list of 50 repositories
Sort: Tap the sort icon to change sorting (Stars/Last Updated)
Toggle Theme: Tap the theme icon to switch between light and dark modes
View Details: Tap any repository to see detailed information
Refresh: Pull down on the list to fetch latest data
