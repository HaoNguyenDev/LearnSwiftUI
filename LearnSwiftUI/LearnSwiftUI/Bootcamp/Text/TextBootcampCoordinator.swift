//
//  TextBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 24/12/25.
//

import Foundation
import SwiftUI

extension Router {
    enum TextRouter: Routable {
        case subviewExample
        
        var id: String {
            switch self {
            case .subviewExample:
                return "TextSubview.subviewExample"
            }
        }
    }
}

struct TextBootcampCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.TextRouter
    var navRouter: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRouter = navRouter
    }
    
    var body: some View {
        getView()
    }
    
    @ViewBuilder
    func getView() -> some View {
        TextBootcamp()
            .navigationTitle("Text")
    }
}

extension TextBootcampCoordinator {
    func viewForRouter(router: Router.TextRouter) -> some View {
        switch router {
        case .subviewExample: EmptyView()
        }
    }
}
