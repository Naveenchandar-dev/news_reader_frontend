# Flutter News Reader App

## Project Overview
This is a News Reader App built using Flutter. The app fetches news articles from a public API (e.g., NewsAPI) and displays them in a visually appealing way. It supports navigation to detailed news articles, state management, and offline functionality (optional).

## Features
- **API Integration**: Fetch news articles from [NewsAPI](https://newsapi.org).
- **State Management**: Proper state management implemented.
- **Responsive UI**: Clean and modern design.
- **Navigation**: Navigate between article list view and detailed article view.
- **Error Handling**: User-friendly error messages with a retry button.
- **Local Storage (Bonus)**: Offline news article storage.

## Project Structure
- **lib/**: Contains all source code.
    - `main.dart`: Main entry point.
    - `ui/`: Contains all UI components like home screen and details screen.
    - `state/`: Manages application state.
    - `services/`: API services and local storage.

## Setup Instructions

### Prerequisites
- Install Flutter SDK: [Flutter Installation](https://flutter.dev/docs/get-started/install)
- Get an API key from [NewsAPI](https://newsapi.org).

### Steps to Run

1. Clone the repository:
   ```bash
   git clone <https://github.com/Naveenchandar-dev/news_reader_frontend.git>

2. Navigate to the project directory:

cd flutter-news-reader-app

3.Install the dependencies:

flutter pub get

4.Run the app:

flutter run

Dependencies
http: For making API requests.
provider: For state management.
shared_preferences: For local storage (optional, for offline mode).


Approach
This project is built with a clean architecture, separating UI, state management, and services. We use provider for managing state efficiently across the app.