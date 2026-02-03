//
//  TextBootcampCoordinator.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 24/12/25.
//

import Foundation
import SwiftUI

extension Route {
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
    typealias ScreenRoute = Route.TextRouter
    var navRoute: any NavRouterProtocol
    
    init(navRouter: any NavRouterProtocol) {
        self.navRoute = navRouter
    }
    
    var body: some View {
        contentView
            .customNavigationTitle("Text")
    }
    
    @ViewBuilder
    private var contentView: some View {
        TextBootcamp()
    }
}

extension TextBootcampCoordinator {
    func viewForRoute(route: Route.TextRouter) -> some View {
        switch route {
        case .subviewExample: EmptyView()
        }
    }
}
