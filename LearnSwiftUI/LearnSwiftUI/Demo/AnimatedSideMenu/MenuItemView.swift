//
//  MenuItemView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 17/2/26.
//

import SwiftUI

struct MenuItemView: View {
    let menuItem: MenuItem
    @State private var isHovered = false
    
    var body: some View {
        HStack(spacing: 15.0) {
            Image(systemName: menuItem.icon)
                .foregroundStyle(menuItem.color)
                .imageScale(.large)
            
            Text(menuItem.title)
                .foregroundStyle(.primary)
                .font(.headline)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.gray.opacity(0.5))
                .opacity(isHovered ? 1 : 0)
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(isHovered ? menuItem.color.opacity(0.1) : Color.clear)
        )
        .contentShape(Rectangle())
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isHovered = hovering
            }
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                
            }
        }
    }
}

#Preview {
    MenuItemView(
        menuItem: MenuItem(
            icon: "house.fill",
            title: "Home",
            color: .blue)
    )
}
