# ReciMe 🍳

[![Swift](https://img.shields.io/badge/Swift-6.2-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-iOS%2026-lightgrey.svg)](https://developer.apple.com/ios/)
[![Xcode](https://img.shields.io/badge/Xcode-26.2-blue.svg)](https://developer.apple.com/xcode/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

**ReciMe** is a native iOS application built with SwiftUI that allows users to browse and view detailed cooking recipes. The project focuses on clean architecture, modern UI components, and a "mock-data first" approach to ensure rapid development and testing.

## ✨ Features

- **Recipe Discovery:** Browse a curated list of recipes in a responsive grid layout.
- **Detailed Instructions:** Access ingredients, descriptions, and high-quality visuals for every dish.
- **Modern UI:** Clean aesthetics featuring white card backgrounds with refined borders for maximum readability.
- **Native Navigation:** Fluid transitions between views using the latest `NavigationStack` API.

## 🏗 High-Level Architecture

The project follows the **MVVM (Model-View-ViewModel)** pattern to ensure a clean separation of concerns and high testability.



- **Model:** `Recipe` struct representing the core data (Title, Description, Ingredients, Image).
- **ViewModel:** `RecipeListViewModel` handles data fetching logic, filtering, and state exposure to the UI.
- **View:** - `RecipesView`: A high-performance `LazyVGrid` displaying the recipe collection.
  - `RecipeDetailView`: A flexible `ScrollView` + `VStack` layout for deep-dive recipe info.
- **Data Layer:** Currently utilizes a **Mock Data Service** for local testing, designed to be easily swappable for Firebase or REST APIs.

## 🛠 Technical Requirements

- **iOS:** 26.0+ (Utilizing modern SwiftUI features)
- **Xcode:** 26.2+
- **Swift:** 6.2+ (Migrated to Strict Concurrency for thread safety)

## 📐 Design Decisions & Tradeoffs

### Key Decisions
- **SwiftUI Programmatic UI:** Chosen for faster iteration and robust dynamic previews.
- **Grid Layout:** Used to maintain consistent item sizing across the discovery feed.
- **Mock-First Approach:** Simplifies initial setup and allows UI testing without network dependency.

### Tradeoffs & Assumptions
- **Modern Only:** Assumes iOS 26+ as the baseline, leveraging the latest Apple frameworks.
- **Local Data:** While limiting dynamic updates, it ensures a 100% crash-free experience during the current development phase.
- **UIKit:** A SwiftUI-only approach was taken to prioritize development speed over legacy UIKit capabilities.

## ⚠️ Known Limitations

- **Backend:** No live backend integration (currently static JSON/Mock).
- **Search:** Basic case-insensitive search functionality.
- **Images:** Assets are currently static; remote image fetching/caching is planned for future releases.

## 📦 Installation

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/kadirmeert/ReciMe.git](https://github.com/kadirmeert/ReciMe.git)
