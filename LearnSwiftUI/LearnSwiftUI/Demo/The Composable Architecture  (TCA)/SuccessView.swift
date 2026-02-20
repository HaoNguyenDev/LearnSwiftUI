//
//  SuccessView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 20/2/26.
//

import SwiftUI

// MARK: - SuccessView

struct SuccessView: View {
    let email: String
    @State private var appeared = false
    var onClose: (() -> ())?
    var body: some View {
        ZStack {
            Color(hex: "F7F6F3").ignoresSafeArea()
            VStack(spacing: 16) {
                Circle()
                    .fill(Color(hex: "1A1A1A"))
                    .frame(width: 64, height: 64)
                    .overlay(
                        Image(systemName: "checkmark")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.white)
                    )
                    .scaleEffect(appeared ? 1 : 0.6)
                    .opacity(appeared ? 1 : 0)

                Text("Login successful")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(Color(hex: "1A1A1A"))
                    .opacity(appeared ? 1 : 0)

                Text(email)
                    .font(.system(size: 14, design: .monospaced))
                    .foregroundColor(Color(hex: "8A8880"))
                    .opacity(appeared ? 1 : 0)
                
                Button {
                    onClose?()
                } label: {
                    Circle()
                        .fill(Color(hex: "1A1A1A"))
                        .frame(width: 30, height: 30)
                        .overlay(
                            Image(systemName: "xmark")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(.white)
                        )
                        .scaleEffect(appeared ? 1 : 0.6)
                        .opacity(appeared ? 1 : 0)
                }

            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7).delay(0.1)) {
                appeared = true
            }
        }
    }
}
