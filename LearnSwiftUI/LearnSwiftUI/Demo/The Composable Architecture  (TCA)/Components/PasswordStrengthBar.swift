//
//  PasswordStrengthBar.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 20/2/26.
//

import SwiftUI
// ── PasswordStrengthBar ───────────────────────────────────────

struct PasswordStrengthBar: View {
    let strength: PasswordStrength

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 4) {
                ForEach(1...4, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(index <= strength.level ? strength.color : Color(hex: "E2E0DA"))
                        .frame(height: 3)
                        .animation(.easeInOut(duration: 0.25), value: strength.level)
                }
            }
            if strength.level > 0 {
                Text(strength.label)
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundColor(strength.color)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: strength.level)
    }
}
