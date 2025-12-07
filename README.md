# EventSync

<div align="center">

  **Discover, Create, and Connect with Community Events**

  [![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)](https://developer.apple.com/ios/)
  [![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org/)
  [![Firebase](https://img.shields.io/badge/Firebase-Enabled-yellow.svg)](https://firebase.google.com/)
</div>

---

## Overview

EventSync is a location-based community event discovery and sharing iOS application built with Swift and UIKit. The app enables users to explore upcoming events in their area, create new events, and engage with their community through a simple and intuitive interface.

Developed as part of a Mobile Application Development course, this app demonstrates real-world iOS development practices including Firebase integration, location services, RESTful API consumption, and modern Swift concurrency patterns.

### Why EventSync?

Finding local community events can be challenging. EventSync solves this by:
- Automatically detecting your location to show relevant nearby events
- Providing a centralized platform for event discovery
- Making it easy for anyone to create and share community events
- Enabling social engagement through likes and interactions

---

## Table of Contents

- [Features](#features)
- [Technologies](#technologies)
- [Architecture](#architecture)
- [Installation](#installation)
- [Configuration](#configuration)
- [Project Structure](#project-structure)
- [Firebase Setup](#firebase-setup)
- [Usage](#usage)

---

## Features

### Core Functionality

#### Authentication & User Management
- Email/password user registration with validation
- Secure login/logout with Firebase Authentication
- User profile management with photo uploads
- Profile editing capabilities

#### Event Discovery
- Browse events filtered by state and city
- Automatic GPS-based location detection
- Real-time search by event name
- Events sorted by upcoming dates
- Pull-to-refresh for latest updates
- Event images with placeholder support

#### Event Creation & Management
- Create events with rich details:
  - Event name, description, and address
  - Date and time selection
  - State and city via searchable pickers
  - Event photos from camera or gallery
- Edit existing events (creator only)
- Delete events through edit mode
- Image upload to Firebase Storage

#### Social Features
- Like/vote system for events
- Real-time like count updates
- Prevention of duplicate likes per user
- Track user engagement per event

#### Location Features
- Automatic GPS-based state/city detection
- Searchable state picker (all US states)
- Searchable city picker (filtered by state)
- Location API integration (RapidAPI)
- Fallback to default location if GPS unavailable

#### Additional Features
- Network connectivity monitoring
- Offline detection and alerts
- Responsive UI with Auto Layout
- Image caching with SDWebImage

---

## Technologies

### Core Technologies
- **Swift 5.0** - Primary programming language
- **UIKit** - UI framework (programmatic UI, no storyboards)
- **Firebase Suite** - Backend as a Service
  - Firebase Authentication - User management
  - Cloud Firestore - NoSQL database
  - Firebase Storage - Image storage
- **CoreLocation** - GPS and location services

### Third-Party Libraries

| Library | Purpose |
|---------|---------|
| [Firebase](https://firebase.google.com/) | Authentication, Database, Storage |
| [SDWebImage](https://github.com/SDWebImage/SDWebImage) | Async image loading and caching |
| [Alamofire](https://github.com/Alamofire/Alamofire) | HTTP networking for API calls |

### APIs
- **RapidAPI - Country State City Search** - Location data (states and cities)

---

## Architecture

### Design Patterns
- **MVC (Model-View-Controller)** - Primary architectural pattern
- **Singleton Pattern** - UserManager, LocationManager, NetworkMonitor
- **Delegate Pattern** - UITableView, image pickers, navigation
- **Protocol-Oriented Programming** - Generic searchable components
- **NotificationCenter** - Decoupled communication between components

### Data Flow
```
User Action → ViewController → Service/API → Firebase/RapidAPI
                                                    ↓
User Interface ← ViewController ← NotificationCenter ← Response
```

---

## Installation

### Prerequisites

- **Xcode 14.0+**
- **iOS 15.0+** deployment target
- **CocoaPods** or **Swift Package Manager**
- **Firebase account** with project setup
- **RapidAPI account** with Country State City API subscription

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/Akash-Dhadiwal/EventSync.git
   cd EventSync
   ```

2. **Install dependencies**

   Using CocoaPods:
   ```bash
   pod install
   open EventSync.xcworkspace
   ```

   Using Swift Package Manager:
   - Open `EventSync.xcodeproj` in Xcode
   - File → Add Packages
   - Add Firebase, SDWebImage, and Alamofire

3. **Configure Firebase**
   - Download `GoogleService-Info.plist` from your Firebase project
   - Add it to the Xcode project root
   - See [Firebase Setup](#firebase-setup) for detailed configuration

4. **Configure RapidAPI**
   - Get API key from [RapidAPI](https://rapidapi.com/)
   - Update `LocationAPI.swift` with your API key:
     ```swift
     let apiKey = "YOUR_RAPIDAPI_KEY"
     ```

5. **Build and Run**
   - Select target device/simulator
   - Press `Cmd + R` to build and run

---

## Configuration

### Firebase Configuration

#### 1. Authentication Setup
- Enable Email/Password authentication in Firebase Console
- Go to Authentication → Sign-in method
- Enable "Email/Password"

#### 2. Firestore Database Setup

**Database Structure:**

```
users/
  {userId}/
    - id: String
    - name: String
    - email: String
    - imageUrl: String
    - likes/
        {eventId}/ (empty document)

events/
  {eventId}/
    - id: String
    - name: String
    - address: String
    - city: String
    - state: String
    - eventDate: Timestamp
    - eventDescription: String
    - imageUrl: String
    - likesCount: Number
    - datePublished: Timestamp
    - publishedBy: String (userId)
```

**Firestore Security Rules:**
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

#### 3. Firebase Storage Setup

**Storage Security Rules:**
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // Event images
    match /eventImages/{imageId} {
      allow read: if true;
      allow write: if request.auth != null;
    }

    // User profile images
    match /userImages/{imageId} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

### Info.plist Permissions

Add the following permissions:

```xml
<key>NSCameraUsageDescription</key>
<string>EventSync needs access to your camera to take event photos.</string>

<key>NSPhotoLibraryUsageDescription</key>
<string>EventSync needs access to your photo library to select event photos.</string>

<key>NSLocationWhenInUseUsageDescription</key>
<string>EventSync needs your location to show nearby events.</string>
```

---

## Project Structure

```
EventSync/
├── ViewControllers/           # Screen controllers
│   ├── ViewController.swift           # Entry point & auth check
│   ├── LoginViewController.swift      # Login screen
│   ├── RegisterViewController.swift   # Registration screen
│   ├── LandingViewController.swift    # Main event list
│   ├── CreatePostViewController.swift # Create/edit events
│   ├── ShowPostViewController.swift   # Event details
│   ├── ProfileViewController.swift    # User profile
│   └── SearchablePickerViewController.swift # Generic picker
│
├── Views/                     # Custom UI components
│   ├── LandingView.swift             # Event list UI
│   ├── CreatePost.swift              # Event form UI
│   ├── ShowPostView.swift            # Event details UI
│   ├── LoginView.swift               # Login UI
│   ├── RegisterView.swift            # Registration UI
│   ├── ProfileView.swift             # Profile UI
│   ├── EventTableViewCell.swift      # Event list item
│   └── SearchablePickerView.swift    # Picker UI
│
├── DataModels/               # Data structures
│   ├── Event.swift                   # Event model
│   ├── User.swift                    # User model
│   ├── State.swift                   # State model
│   ├── City.swift                    # City model
│   └── UserManager.swift             # User state manager
│
├── Services/                 # Business logic & APIs
│   ├── LocationAPI.swift             # RapidAPI integration
│   ├── LocationManager.swift         # GPS services
│   ├── NetworkMonitor.swift          # Connectivity monitoring
│   └── RegisterFirebaseManager.swift # Registration logic
│
├── Utils/                    # Utilities
│   └── NotificationNames.swift       # Custom notifications
│
├── Assets.xcassets/          # Images and assets
├── GoogleService-Info.plist  # Firebase configuration
└── Info.plist               # App configuration
```

---

## Firebase Setup

### Step-by-Step Firebase Configuration

1. **Create Firebase Project**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Click "Add project"
   - Enter project name: "EventSync"
   - Click "Create project"

2. **Add iOS App**
   - Click iOS icon
   - Enter bundle ID from your Xcode project
   - Download `GoogleService-Info.plist`
   - Add to Xcode project

3. **Enable Services**
   - **Authentication**: Enable Email/Password sign-in
   - **Firestore Database**: Create database in test mode
   - **Storage**: Enable storage with test mode rules

4. **Configure Security Rules**
   - Update Firestore and Storage rules as shown in [Configuration](#configuration)

---

## Usage

### For Users

#### Getting Started
1. **Register** - Create an account with email and password
2. **Allow Location** - Grant location permission for automatic location detection
3. **Browse Events** - View events in your area on the main screen
4. **Search Events** - Use the search bar to find specific events

#### Creating an Event
1. Tap the **+** button in the navigation bar
2. Fill in event details (name, location, description, date/time)
3. Select state and city (auto-detected from GPS)
4. Add an event photo (camera or gallery)
5. Tap **Save** to publish

#### Interacting with Events
- **View Details** - Tap any event to see full information
- **Like Events** - Tap the Like button to show interest
- **Edit Events** - Edit your own events via the Edit button

#### Managing Your Profile
1. Tap the **profile icon** in the navigation bar
2. View/edit your profile information
3. Change your profile picture
4. View all events you've created

---

<div align="center">

  EventSync - Connecting Communities Through Events

</div> 
