//
//  BootcampTemplateView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 25/1/26.
//

import SwiftUI

struct BootcampTemplateView: View {
    var gotoChildView: SingleResult<Route.BootcampTemplateRouter>?
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(BootcampTemplateLesson.all) { lesson in
                    CodePreviewContainer(title: lesson.title, code: lesson.code, resultView: lesson.result?())
                }
            }
            
            LazyVStack(spacing: 24.0) {
                ForEach(Route.BootcampTemplateRouter.allCases) { router in
                    childTitle(child: router)
                }
            }
        }
    }
    
    @ViewBuilder
    private func childTitle(child: Route.BootcampTemplateRouter) -> some View {
        Text(child.title)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
            .onTapGesture {
                gotoChildView?(child)
            }
    }
}

#Preview {
    BootcampTemplateView()
}
