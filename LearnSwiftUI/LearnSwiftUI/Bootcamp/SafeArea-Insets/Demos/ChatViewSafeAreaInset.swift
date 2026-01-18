//
//  ChatView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/1/26.
//

import SwiftUI

struct ChatViewSafeAreaInset: View {
    @State private var message = ""
    let messages = (0..<1000).map { "Message \($0)" }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 12) {
                ForEach(messages, id: \.self) { msg in
                    Text(msg)
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                TextField("Message", text: $message)
                    .textFieldStyle(.roundedBorder)

                Button("Send") {
                    print(message)
                    message = ""
                }
            }
            .padding()
            .background(.ultraThinMaterial)
        }
    }
}
