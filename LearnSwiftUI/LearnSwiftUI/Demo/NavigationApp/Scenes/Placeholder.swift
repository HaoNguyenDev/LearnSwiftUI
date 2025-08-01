//
//  PlaceholderView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 1/8/25.
//


import SwiftUI

extension Router {
    enum PlaceholderView {
        case pop
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
                Image(systemName: "arrowshape.left")
            })
    }
    
    @ViewBuilder
    func getView() -> some View {
        PlaceholderView(newTitle: title,
                        onClose: {
            navRouter.pop(animate: true)
        })
        
    }
    
    @ViewBuilder
    func viewForRouter(router: ScreenRouter) -> some View {
        switch router {
        case .pop:
            ContentView()
        }
    }
}

struct PlaceholderView: View {
    @EnvironmentObject var settings: UserSettings
    var newTitle: String?
    var onClose: (() -> Void)?

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "hammer")
                .resizable()
                .scaledToFit()
                .symbolEffect(.wiggle)
                .frame(width: 80, height: 80)

            if let newTitle = newTitle {
                Text("\(newTitle)\n\("in development")")
                    .font(.headline)
                    .fontWeight(.bold)
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
                    }
                )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


#Preview {
    PlaceholderView()
        .environmentObject(UserSettings.shared)
}

