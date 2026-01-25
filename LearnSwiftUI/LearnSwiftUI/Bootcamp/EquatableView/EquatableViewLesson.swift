//
//  EquatableViewLesson.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 25/1/26.
//

import Foundation

struct EquatableViewLesson {
    static let all = [
        Lesson(title: "1️⃣ What is EquatableView? (STANDARD DEFINITION)", code: """
EquatableView tells SwiftUI:
“If the view inputs are equal, skip this diff subtree.”

📌 Important:
    ❌ Does not prevent the parent body from running
    ✅ Prevents SwiftUI from delving into the child diff
""", result: nil), Lesson(title: "2️⃣ EXPERIMENT 1 — WITHOUT USING EquatableView", code: """
🔬 Code

struct Row: View {
    let title: String
    let isSelected: Bool
    var body: some View {
        print("🟥 Row body:", title)
        return Text(title)
                .padding()
                .background(isSelected ? Color.blue : Color.red)
    }
}

Parent:
    Row(title: item.title, isSelected: selectedIds.contains(item.id))

👀 Observation
    Tap 1 row
    Console prints the entire row

➡️ The body of every row runs
📌 Normal, not optimized
""", result: nil)
    ]
}
