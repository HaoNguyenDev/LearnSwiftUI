//
//  CustomTabBarAnimationDemo.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 18/1/26.
//

import SwiftUI

struct CustomTabBarAnimationDemo: View {
    @Binding var hidden: Bool

    var body: some View {
        HStack {
            Spacer()
            Text("Home")
            Spacer()
            Text("Profile")
            Spacer()
        }
        .frame(height: 50)
        .background(.ultraThinMaterial)
        .offset(y: hidden ? 100 : 0)
        .animation(.easeInOut, value: hidden)
    }
}

struct TabBarContainerAnimationDemo: View {
    @State private var hideTabBar = false

    var body: some View {
        ScrollView {
            VStack {
                GeometryReader { geo in
                    Color.clear
                        .onChange(of: geo.frame(in: .global).minY) { old, new in
                            hideTabBar = new < -50
                        }
                }
                .frame(height: 0)

                ForEach(0..<50) { i in
                    Text("Item \(i)")
                        .frame(height: 50)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            CustomTabBarAnimationDemo(hidden: $hideTabBar)
        }
    }
}

#Preview {
    TabBarContainerAnimationDemo()
}
