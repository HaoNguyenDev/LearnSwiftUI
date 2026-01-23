//
//  DataFlowAndArchitectureBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/1/26.
//

import SwiftUI

enum DataFlowAndArchitectureDemo: String, CaseIterable, Identifiable {
    case selectedRow
    
    var id: String { self.rawValue }
    var title: String {
        switch self {
        case.selectedRow: "Selected Row"
        }
    }
}

struct DataFlowAndArchitectureBootcamp: View {
    @State private var selectedDemo: DataFlowAndArchitectureDemo?
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24.0) {
                ForEach(DataFlowAndArchitectureLesson.all, id: \.id) { lesson in
                    CodePreviewContainer(title: lesson.title, code: lesson.code, resultView: lesson.result?())
                }
            }
            
            LazyVStack {
                ForEach(DataFlowAndArchitectureDemo.allCases, id: \.self) { demo in
                    demoTitle(demo: demo)
                }
            }
        }
        
        .sheet(item: $selectedDemo) { demo in
            destinationView(for: demo)
        }
    }
    
    @ViewBuilder
    private func demoTitle(demo: DataFlowAndArchitectureDemo) -> some View {
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
    private func destinationView(for demo: DataFlowAndArchitectureDemo) -> some View {
        switch demo {
        case .selectedRow: MultiSelectRowListView()
        }
    }
}
