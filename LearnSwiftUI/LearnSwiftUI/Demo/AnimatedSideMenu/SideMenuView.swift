//
//  SideMenuView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 17/2/26.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 15) {
                Circle()
                    .fill(
                        LinearGradient(colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                    )
                    .frame(width: 70)
                    .overlay {
                        Image(systemName: "person.fill")
                            .foregroundStyle(.white)
                            .font(.system(size: 30))
                    }
                    .shadow(color: .blue.opacity(0.7), radius: 10, x: 0, y: 5)
                VStack(alignment: .leading, spacing: 5.0) {
                    Text("Hao Nguyen")
                        .font(.title2.bold())
                    Text("Premium Member")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
            }
            .padding(.top, 60)
            .padding(.horizontal)
            
            Rectangle()
                .fill(
                    LinearGradient(colors: [.clear, .gray.opacity(0.2), .clear],
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
                .frame(height: 1)
                .padding(.vertical, 30)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 5.0, content: {
                    ForEach(MenuItem.menuItems, id: \.id) { item in
                        MenuItemView(menuItem: item)
                    }
                })
            }
            
            VStack(spacing: 20.0) {
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "arrow.right.square.fill")
                        Text("Logout")
                    }
                    .foregroundStyle(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.red.opacity(0.5), lineWidth: 1)
                    )
                }
                
                Text("App version 1.0")
                    .font(.caption)
                    .foregroundStyle(.gray)

            }
        }
        .padding()
        .padding(.bottom, 30)
    }
}

#Preview {
    SideMenuView()
}
