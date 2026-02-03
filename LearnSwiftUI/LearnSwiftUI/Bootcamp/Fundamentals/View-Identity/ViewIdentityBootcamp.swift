//
//  ViewIdentityBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 20/1/26.
//

import SwiftUI

enum ViewIdentityDemo: String, CaseIterable, Identifiable {
    case bodyRecompute
    case viewRecreated
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .bodyRecompute: "Body recomputed demo"
        case .viewRecreated: "When is a View recreated?"
        }
    }
}

struct ViewIdentityBootcamp: View {
    @State private var selectedDemo: ViewIdentityDemo?
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24.0) {
                ForEach(ViewIdentityLessons.all, id: \.id) { lesson in
                    CodePreviewContainer(title: lesson.title, code: lesson.code, resultView: lesson.result?())
                }
            }
            
            LazyVStack {
                ForEach(ViewIdentityDemo.allCases, id: \.self) { demo in
                    demoTitle(demo: demo)
                }
            }
        }
        
        .sheet(item: $selectedDemo) { demo in
            destinationView(for: demo)
        }
    }
    
    @ViewBuilder
    private func demoTitle(demo: ViewIdentityDemo) -> some View {
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
    
    @ViewBuilder
    private func destinationView(for demo: ViewIdentityDemo) -> some View {
        switch demo {
        case .bodyRecompute:
            BodyRecomputeDemo()
        case .viewRecreated:
            ViewRecreatedDemo()
        }
    }
}
