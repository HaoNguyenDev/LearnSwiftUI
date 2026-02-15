//
//  EquatableViewBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 25/1/26.
//

import SwiftUI

struct EquatableViewBootcamp: View {
    var gotoDemo: SingleResult<Route.EquatableViewRouter>?
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24.0) {
                ForEach(EquatableViewLesson.all) { lesson in
                    CodePreviewContainer(title: lesson.title, code: lesson.code, resultView: lesson.result?())
                }
            }
            
            LazyVStack(spacing: 24.0) {
                ForEach(Route.EquatableViewRouter.allCases) { demo in
                    demoTitle(demo: demo)
                }
            }
        }
    }
}

extension EquatableViewBootcamp {

    @ViewBuilder
    private func demoTitle(demo: Route.EquatableViewRouter) -> some View {
        Text(demo.title)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
            .onTapGesture {
                gotoDemo?(demo)
            }
    }
}
