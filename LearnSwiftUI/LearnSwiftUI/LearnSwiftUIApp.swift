//
//  LearnSwiftUIApp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 27/5/25.
//

import SwiftUI

@main
struct LearnSwiftUIApp: App {
    @StateObject private var sharedModel = SharedModel()
    @StateObject private var todoStore = TodoStore()
    
    var body: some Scene {
        WindowGroup {
//            TextBootCamp()
//            ShapesBootCamp()
//            ColorsBootcamp()
//            InitializerBootcamp(newPoint: 100)
//            GridBootcamp()
//            ButtonBootcamp()
//            SubviewBootcamp()
//            BindingBootcamp()
//            SheetBootcamp()
//            SateBootcamp()
//            StateObjectBootcamp()
            TodoAppView()
                .environmentObject(sharedModel)
                .environmentObject(todoStore)
        }
    }
}
