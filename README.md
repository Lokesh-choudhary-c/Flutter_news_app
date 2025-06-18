# Flutter News App

A modern Flutter-based News App with login, bookmarks, dark mode, and search functionality. Built using Provider for state management.

---

##  Setup Instructions

1. **Clone the repository**  
   ```bash
   git clone https://github.com/yourusername/flutter-news-app.git
   cd flutter-news-app

2. **Install dependencies**
    flutter pub get

3. **Run the app**
    flutter run



## Screenshots    
   available in assets/images/ folder


## Architecture Choices
  State Management: Provider
  Chosen for its simplicity, scalability, and excellent integration with Flutter's widget tree.

  UI Structure:

  HomePage: Controls tab navigation and app-level theme toggle.

  NewsFeedPage: Displays fetched articles with search & bookmark.

  BookmarksPage: Shows saved articles.

  NewsProvider: Handles API calls and bookmark state.

  Theme Management:
  Toggle between dark and light modes using ThemeProvider and persisted user preference (optional to add SharedPreferences).



## Packages Used

provider- Lightweight state management solution
http- For fetching news from public APIs
webview- flutter To open full articles in-app
intl-For formatting published date/time  

   # Flutter_news_app
