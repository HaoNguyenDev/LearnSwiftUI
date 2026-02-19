//
//  DemoSideMenuView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 17/2/26.
//

import SwiftUI

struct DemoSideMenuView: View {
    @State private var isShowingMenu = true
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    menuButton
                    Spacer()
                }
                Spacer()
                someMainContent
                Spacer()
            }
            .blur(radius: isShowingMenu ? 5 : 0)
            
            sideMenuView
        }
    }
    
    private var menuButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                isShowingMenu.toggle()
            }
        } label: {
            Image(systemName: "line.horizontal.3")
                .foregroundStyle(.primary)
                .rotationEffect(Angle(degrees: isShowingMenu ? 90 : 0))
                .padding(12)
                .background(
                    Circle()
                        .fill(.gray.opacity(0.1))
                        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 2)
                )
        }
        .padding()
    }
    
    private var someMainContent: some View {
        VStack(spacing: 20.0) {
            Image(systemName: "star.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.yellow)
                .font(.system(size: 40))
            
            Text("Content")
                .font(.title2.bold())
                .foregroundStyle(.primary)
            
            Text("How do you think about this menu style")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemBackground))
                .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
        )
        .padding()
    }
    
    private var sideMenuView: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                SideMenuView()
                    .frame(width: min(geometry.size.width * 0.75, 300))
                    .frame(maxHeight: .infinity)
                    .background(
                        Color(.systemBackground)
                    )
                    .clipShape(
                        RoundedCornerShape(radius: 30, corners: [.topRight, .bottomRight])
                    )
                    .offset(x: isShowingMenu ? 0 : -geometry.size.width)
                Spacer()
            }
            .background(
                Color.black.opacity(isShowingMenu ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            isShowingMenu = false
                        }
                    }
            )
        }
        .ignoresSafeArea()
        .animation(.spring(response: 0.3, dampingFraction: 0.9), value: isShowingMenu )
    }
}

#Preview {
    DemoSideMenuView()
}
