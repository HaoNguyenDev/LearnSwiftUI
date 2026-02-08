//
//  CombineStackViewExample.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 8/2/26.
//

import SwiftUI

struct CombineStackViewExample: View {
    var body: some View {
        VStack(spacing: 0) {
            // Header with ZStack
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 120)
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    )
                    .offset(y: 40)
            }
            
            // Content with VStack
            VStack(spacing: 12) {
                Text("Hao Nguyen")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 50)
                
                Text("iOS Developer")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Stats with HStack
                HStack(spacing: 40) {
                    VStack {
                        Text("1,234")
                            .font(.headline)
                        Text("Followers")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    VStack {
                        Text("567")
                            .font(.headline)
                        Text("Following")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    VStack {
                        Text("89")
                            .font(.headline)
                        Text("Posts")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical)
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
    }
}
