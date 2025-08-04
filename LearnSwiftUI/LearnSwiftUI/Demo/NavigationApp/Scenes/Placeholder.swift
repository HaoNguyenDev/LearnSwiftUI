//
//  PlaceholderView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/8/25.
//


import SwiftUI

extension Router {
    enum PlaceholderView: Routable {
        case view
        
        var id: String {
            switch self {
                case .view:
                return "view"
            }
        }
    }
}

struct PlaceholderViewCoordinator: View, ScreenCoordinator {
    typealias ScreenRouter = Router.PlaceholderView
    var navRouter: any NavRouterProtocol
    var title: String?
    
    init(navRouter: any NavRouterProtocol, title: String? = nil) {
        self.navRouter = navRouter
        self.title = title
    }
    
    var body: some View {
        getView()
            .navigationDestination(for: ScreenRouter.self) { route in
                viewForRouter(router: route)
            }
        //            .toolbar(.hidden, for: .bottomBar)
        //            .toolbar(.hidden, for: .tabBar)
        //        .toolbar(.hidden, for: .navigationBar)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                navRouter.pop(animate: true)
            }) {
                BackButton()
            })
    }
    
    @ViewBuilder
    func getView() -> some View {
        PlaceholderView(newTitle: title,
                        onClose: {
            navRouter.dismiss()
        })
        
    }
    
    @ViewBuilder
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .view:
            ContentView()
        }
    }
}

struct PlaceholderView: View {
    @Environment(UserSettings.self) private var settings
    var newTitle: String?
    var onClose: (() -> Void)?

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "hammer")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)

            if let newTitle = newTitle {
                Text("\(newTitle)\n\("in development")")
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
            } else {
                Text("In development")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            
            Text("Feature will update soon")
                .font(.headline)
                .fontWeight(.bold)
            
            Spacer()
                .frame(height: 20)
            Capsule()
                .stroke(style: StrokeStyle(lineWidth: 2))
                .frame(width: 100, height: 60, alignment: .center)
                .foregroundStyle(.black)
                .background(
                    Button {
                        onClose?()
                    } label: {
                        Text("Ok bro")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                    }
                )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


#Preview {
    PlaceholderView()
        .environment(UserSettings.shared)
}

