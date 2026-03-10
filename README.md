# NewsReaderApp
A modern iOS News Reader application built using Clean Architecture + MVVM with a focus on maintainable, testable, and scalable code.

The project follows Clean Architecture with MVVM and Dependency Injection to ensure separation of concerns and modular code structure.
## Key Principles
- Clean Architecture
- MVVM (Model-View-ViewModel)
- Dependency Injection
- SOLID Principles
- Design Patterns
- Modular and scalable structure

## Technologies Used
- Swift
- UIKit
- URLSession
- Combine
- Dynamic Property List (Plist) for local storage
- XCTest for unit testing
- SPM

## Features
1. News Feed
 - Fetches latest articles from a public news API
 - Displays:
 - Article title
 - Article image
 - Source name
 - Publication date
 - Supports pagination / infinite scrolling

2. Article Detail Screen
 - View complete article details
 - Open full article using Safari Web View
 - Share article using system share sheet
 - Bookmark article for later reading

3. Search Functionality
  - Search articles using keywords
  - Implements debounced search input to optimize API calls

4. Bookmarks
 - Save and remove articles from bookmarks
 - Bookmarked articles are stored locally
 - Separate section to view bookmarked articles

5. Persistence
  - Bookmarked articles are stored locally using:
  - Dynamic Plist storage

The project includes unit test coverage using XCTest, including:
  - ViewModel testing
  - UseCase testing
  - Repository layer testing
  - Mock network service

##App FLow
![](appflow.gif)

## Author
 Developed by Tushar Jaunjalkar
 iOS Developer
