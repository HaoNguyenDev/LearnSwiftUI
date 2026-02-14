//
//  CustomTabBarExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 30/1/26.
//

import SwiftUI

struct CustomTabBarExample: View {
    @State private var selectedTab = 0
    @Namespace private var animation
    
    let tabs = ["Home", "Search", "Profile"]
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<tabs.count, id: \.self) { index in
                    Button {
                        withAnimation(.spring(response: 0.4, blendDuration: 0.1)) {
                            selectedTab = index
                        }
                    } label: {
                        VStack(spacing: 8) {
                            Text(tabs[index])
                                .fontWeight(selectedTab == index ? .bold : .regular)
                                .foregroundStyle(selectedTab == index ? .blue: .black)
                            if selectedTab == index {
                                Capsule()
                                    .fill(.blue)
                                    .frame(height: 3)
                                    .matchedGeometryEffect(id: "shape", in: animation)
                            } else {
                                Capsule()
                                    .fill(.white)
                                    .frame(height: 3)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }

                    
                }
            }
        }
        .padding()
    }
}

#Preview {
    CustomTabBarExample()
}
