//
//  SafeAreaInsetsBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/1/26.
//

import SwiftUI
enum SafeAreaInsetDemos: String, Identifiable, CaseIterable {
    case safeAreaInsetBottom
    case loginViewSafeAreaInset
    case chatViewSafeAreaInset
    case formViewSafeAreaInset
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .safeAreaInsetBottom: "SafeAreaInsetBottom"
        case .loginViewSafeAreaInset: "LoginViewSafeAreaInset"
        case .chatViewSafeAreaInset: "ChatViewSafeAreaInset"
        case .formViewSafeAreaInset: "FormViewSafeAreaInset"
        }
    }
}

struct SafeAreaInsetsBootcamp: View {
    @State private var selectedDemo: SafeAreaInsetDemos?
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24.0) {
                ForEach(SafeAreaInsetsLessons.all) { lesson in
                    CodePreviewContainer(title: lesson.title,
                                         code: lesson.code,
                                         resultView: lesson.result?())
                }
            }
            LazyVStack {
                ForEach(SafeAreaInsetDemos.allCases) { demo in
                    Text(demo.title)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(.green)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)
                        .onTapGesture {
                            selectedDemo = demo
                        }
                }
            }
        }
        .sheet(item: $selectedDemo) { demo in
            destinationView(for: demo)
        }
    }
    
    @ViewBuilder
    private func destinationView(for demo: SafeAreaInsetDemos) -> some View {
        switch demo {
        case .safeAreaInsetBottom:
            StickyBottomButton()
        case .loginViewSafeAreaInset:
            LoginViewSafeAreaInset()
        case .chatViewSafeAreaInset:
            ChatViewSafeAreaInset()
        case .formViewSafeAreaInset:
            FormViewSafeAreaInset()
        }
    }
}

#Preview {
    SafeAreaInsetsBootcamp()
}


