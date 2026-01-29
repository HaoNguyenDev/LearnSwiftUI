//
//  NavigationBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 26/1/26.
//

import SwiftUI

struct NavigationBootcamp: View {
    let gotoDemo: SingleResult<Route.NavigationRouter>?
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24.0) {
                ForEach(NavigationLesson.all) { lesson in
                    CodePreviewContainer(title: lesson.title, code: lesson.code, resultView: lesson.result?())
                }
            }
            
            LazyVStack(spacing: 24.0) {
                ForEach(Route.NavigationRouter.allCases) { demo in
                    demoTitle(demo: demo)
                }
            }
        }
    }
}

extension NavigationBootcamp {
    
    @ViewBuilder
    private func demoTitle(demo: Route.NavigationRouter) -> some View {
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
