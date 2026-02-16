//
//  AppStorageAndSceneStorageLesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 15/2/26.
//

import SwiftUI

struct AppStorageAndSceneStorageLesson {
    static let all = [
        Lesson(title: "1️⃣ @AppStorage — Persistent State at the App Level", code: """
🔎 Definition
@AppStorage is a SwiftUI property wrapper that helps:

- Directly bind a value to UserDefaults
- DAutomatically update the UI when the value changes
- DStore persistent state between app launches

It is the bridge between:

SwiftUI State ↔ UserDefaults
""", result: nil),
        Lesson(title: "🧠 How it works", code: """
Internally:
- It wraps UserDefaults.standard
- Observes change via KVO

When the value changes → SwiftUI invalidates view → body re-render

Equivalent logic if written manually:

@State private var isDarkMode: Bool = UserDefaults.standard.bool(forKey: "darkMode")

But @AppStorage automatically:
- Load value
- Observe change
- Save when mutated
""", result: nil),
        Lesson(title: "🧾 Basic Syntax", code: """

@AppStorage("darkMode") var isDarkMode: Bool = false

Key "darkMode":
- Must be unique
- Must be a string literal (very easy to typo → bugs are hard to find)
""", result: nil),
        Lesson(title: "2️⃣ Lifecycle & Data Flow", code: """
UserDefaults change 
    ↓
AppStorage detect 
    ↓
View invalidated 
    ↓
body recomputed

⚠️ Unlike @State
- @State lives according to the View's lifecycle
- @AppStorage lives the App lifecycle
""", result: nil),
        Lesson(title: "3️⃣ Supported Types", code: """
@AppStorage only supports types that UserDefaults supports:

Boolean, Int, Double, String, Data, URL

NOT supported:
- Structure custom
- Enum (unless rawValue)
- Complex arrays
""", result: nil),
        Lesson(title: "4️⃣ Advanced Pattern"),
        Lesson(title: "4.1 Enum with RawRepresentable", code: """
enum AppTheme: String { 
    case light 
    case dark
}

@AppStorage("theme") var themeRaw: String = AppTheme.light.rawValue

var theme: AppTheme { 
    AppTheme(rawValue: themeRaw) ?? .light
}
👉 Avoid crashes if the key is corrupt.
""", result: nil),
        Lesson(title: "4.2 Centralized Key Management", code: """
❌ Wrong:
@AppStorage("darkmode")
@AppStorage("darkMode")
👉 Typo bugs are very difficult to detect

✅ Correct:
enum StorageKey { 
    static let darkMode = "darkMode"
}

@AppStorage(StorageKey.darkMode) var isDarkMode = false
""", result: nil),
        Lesson(title: "4.3 Inject custom UserDefaults (Testable)", code: """
@AppStorage("flag", store: UserDefaults(suiteName: "group.myapp"))
var flag: Bool = false

User for:
- App Group
- Unit Test
- Widget
""", result: nil),
        Lesson(title: "5️⃣ Common Bugs", code: """
❌ 1. Infinite Re-render
- If you use @AppStorage as the source-of-truth for multiple nested views.

❌ 2. Unexpected Sync Delay
- UserDefaults are not a real-time database.
- There may be a delay when the app is in the background.

❌ 3. Overuse
- Do not use @AppStorage for:
- Large data
- Frequently mutating data
- High-performance state
""", result: nil),
        Lesson(title: "6️⃣ When should we use it?", code: """
| Use case              | Should it be used?         |
| -------------------   | ----------------------     |
| Dark mode setting     | ✅                         |
| First launch flag     | ✅                         |
| Login session token   | ⚠️ (Keychain recommended)  |
| Shopping cart data    | ❌                         |
| Filter UI state       | ❌                         |
""", result: nil),
        Lesson(title: "7️⃣ @SceneStorage — State by Scene", code: """
🔎 Definition
@SceneStorage stores state per window/scene.
Unlike @AppStorage:
                    AppStorage  SceneStorage
Scope               App-wide    Scene
Persistent          Yes         Yes (scene lifetime)
Multi-window safe   ❌          ✅

🧠 When do you need SceneStorage?
On iPad / macOS:
    Multi-window
    Each window needs to keep its own state

🧾 Example
    @SceneStorage("selectedTab") var selectedTab: Int = 0
Each window:
    Has its own selectedTab
    Close window → state is lost

🧠 Internally
It uses:
    UIKit state restoration
    Scene session storage
    Not UserDefaults.
""", result: nil),
        Lesson(title: "8️⃣ Comprehensive Comparison", code: """
| Wrappers      | Persist    | Scope          | Re-render trigger    |
| ------------- | ---------  | -------------- | -------------------  |
| @State        | ❌         | View           | Local mutations      |
| @StateObject  | ❌         | View lifecycle | ObservableObject     |
| @AppStorage   | ✅         | App            | UserDefaults change  |
| @SceneStorage | ✅ (scene) | Scene          | Scene restore        |
""", result: nil),
        Lesson(title: "9️⃣ Advanced Design Thinking", code: """
Never use @AppStorage as business state.
It should only be:
- Configuration layer
- UI preference
- Feature flag

Clean Architecture:
View
     ↓
ViewModel
    ↓
UseCase
    ↓
Persistence Layer (UserDefaults)

Do not:
View → AppStorage → Business Logic
""", result: nil),
        Lesson(title: "🎯 INTERVIEW QUESTIONS", code: """
1. How is @AppStorage different from @State?
Expect:
    Persistence
    Lifecycle
    Data source

2. Is @AppStorage thread-safe?
    UserDefaults thread-safe read
    Write async
    Not suitable for high frequency

3. When should @AppStorage not be used?
    Business data
    Sensitive data
    Large data

4. How does SceneStorage work in multi-window?
    Per scene session
    No sharing between scenes

5. How do you test @AppStorage?
    Inject custom suite
    Reset UserDefaults in test

🧠 Advanced Thinking
    @AppStorage and @SceneStorage are NOT state management.
These are simply:
    Persistence Bridge Layer
""", result: nil)
    ]
}
