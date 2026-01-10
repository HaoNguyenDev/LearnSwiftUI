//
//  SafeAreaInsetsLessons.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/1/26.
//

import SwiftUI

struct SafeAreaInsetsLessons {
    static let all: [Lesson] = [
        Lesson(title: "Key points (must remember)", code: """
Key points (must remember):

    ❗ Safe Area is a boundary, not spacing.
    ❗ Safe Area is not padding.
    ❗ Safe Area is a layout boundary.

If you think safe area is padding → you're definitely using it incorrectly.
""", result: nil),
        
        Lesson(title: "1️⃣ What is a Safe Area? (STANDARD definition)", code: """
    A Safe Area is a region where the system ensures the content is not obscured
by the notch, status bar, home indicator, dynamic island, or keyboard.

📌 Safe Area:
    Determined by the system
    Changes according to:
    device
    orientation
    state (call, hotspot, keyboard)
""", result: nil),
        Lesson(title: "2️⃣ How does SwiftUI handle the Safe Area by default?", code: """

    VStack {
        Text("Hello")
    } 

👉 SwiftUI automatically places content in the safe area
👉 You don't need to do anything to "avoid the notch"
❗ Here's why:
SwiftUI apps rarely have their UI obscured by default
""", result: {
    AnyView(ResultBlockView(content: {
        VStack {
            Text("Hello")
        }
    }))
}),
        Lesson(title: "3️⃣ ignoresSafeArea — DANGEROUS API", code: """
    Color.red
        .ignoresSafeArea()

What happens?
    View draws over the safe area

Possibly:
    hides the status bar
    hides the home indicator
📌 ignoresSafeArea is not reverse padding

Distinguish clearly:
API Meaning

.ignoresSafeArea() 
    Ignores safe area boundary

.padding(.top) 
    Adds spacing

❌ Incorrect case

    VStack {
        Text("Title")
    }
    .ignoresSafeArea()

👉 Content may be hidden
""", result: {
    AnyView(ResultBlockView(content: {
        Color.red
            .ignoresSafeArea()
    }))
}),
        
        Lesson(title: "4️⃣ Use ignoresSafeArea in the RIGHT place", code: """
✅ Legitimate case

    Background
    Full-screen image
    Video
    Map

    ZStack {
        Color.black.ignoresSafeArea()
        Text("Content")
    } 

📌 Background overflows
📌 Content remains within the safe area
""", result: {
    AnyView(ResultBlockView(content: {
        ZStack {
            Color.black.ignoresSafeArea()
            Text("Content")
        }
    }))
}),
        Lesson(title: "5️⃣ Safe Area Insets (very important – iOS 15+)", code: """

    .safeAreaInset(edge: .bottom) {
        Button("CTA") { }
    }

Meaning:
    Add content inside the safe area
    Do not obscure content
    Automatically avoid the home indicator/keyboard
📌 This is a Senior API that should be used
""", result: {
    AnyView(ResultBlockView(content: {
        VStack {
            Text("SwiftUI")
                .background(.green)
        }
        .safeAreaInset(edge: .bottom, content: {
            Button("CTA") { }
        })
        .background(.gray)
    }))
}),
        
        Lesson(title: "6️⃣ safeAreaInset vs overlay vs padding", code: """
❌ Padding (incorrect in nature)

    .padding(.bottom, 50)

👉 Unknown:
    how high is the home indicator
    whether the keyboard is open or not

✅ safeAreaInset (true)

    .safeAreaInset(edge: .bottom) {
        Button("Submit") { }
    }

👉 System calculates automatically:
    matching inset
    animate when keyboard appears

""", result: nil),
        
        Lesson(title: "7️⃣ Keyboard — A classic source of bugs", code: """
❌ Old method (UIKit mindset)
    Listen keyboard notification
    Calculate height
    Add padding
👉 SwiftUI does NOT recommend this

✅ Correct method in SwiftUI
    ScrollView {
        FormContent()
    }
    .safeAreaInset(edge: .bottom) {
        KeyboardAccessory()
    } 

📌 When keyboard appears:
    safe area bottom increases
    inset automatically animates
👉 No need to measure keyboard height
""", result: {
    AnyView(ResultBlockView(content: {
        ScrollView {
            ForEach(0..<5) { number in
                TextField("TextField \(number):", text: .constant(""))
            }
        }
        .safeAreaInset(edge: .bottom) {
            Rectangle()
                .frame(maxWidth: .infinity, minHeight: 100)
        }
    }))
}),
        
        Lesson(title: "8️⃣ ignoresSafeArea(.keyboard) — very often misused", code: """

    .ignoresSafeArea(.keyboard)
The REAL meaning:
    “I don’t want the UI to be pushed up when the keyboard appears”
📌 Use for:
    Chat apps
    Games
    Canvas
❌ Do not use for:
    Forms
    Input-heavy screens
""", result: nil),
        
        Lesson(title: "9️⃣ Safe Area Changes Dynamically (Senior Must Know)", code: """
    Safe Area can change when:
    Making a call
    Turning on hotspot
    Showing recording
    Showing/hiding keyboard
    Split view on iPad
👉 No hardcode inset
""", result: nil),
        
        Lesson(title: "10 Great Interview Traps", code: """
❓ Does Safe Area require padding?
❌ No.

❓ Does ignoresSafeArea make the view larger?
❌ No, it only allows drawing to the edge.

❓ How to position a button at the bottom so it's not obscured by the keyboard?
✅ safeAreaInset(edge: .bottom)
""", result: nil),
        
        Lesson(title: "11 Pattern production (recommended)", code: """
✅ Full-screen background + safe content

    ZStack { 
        Color.blue.ignoresSafeArea() 
        Content()
    }

✅ Sticky bottom button (keyboard-safe)

    ScrollView {
        Form()
    }
    .safeAreaInset(edge: .bottom) {
        Button("Submit") { }
            .padding()
            .background(.ultraThinMaterial)
    }

""", result: nil),
        
        Lesson(title: "12 Debug Safe Area", code: """

    .safeAreaInset(edge: .top) {
        Color.red.frame(height: 1)
    }
👉 Look at the real boundary.
""", result: nil),
        
        Lesson(title: "🎯 SUMMARY OF LESSON", code: """
    Safe Area = system boundary
    Not padding
    IgnoresSafeArea is used very limitedly
    SafeAreaInset = standard API for fixed UI
    Keyboard should be handled via safe area
""", result: nil),
    ]
}
