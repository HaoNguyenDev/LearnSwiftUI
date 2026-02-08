//
//  ProductCard.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 8/2/26.
//

import SwiftUI

struct ProductCardStackExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image with ZStack cho badge
            ZStack(alignment: .topTrailing) {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 200)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    )
                
                // Sale badge
                Text("SALE")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.red)
                            
                    )
                    .padding(12)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Product XYZ")
                    .font(.headline)
                
                Text("Short product detail")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                HStack {
                    Text("₫499,000")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                    
                    Text("₫699,000")
                        .font(.caption)
                        .strikethrough()
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                        Text("4.5")
                    }
                    .font(.caption)
                    .foregroundColor(.orange)
                }
            }
            .padding()
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.5), radius: 8, x: 0, y: 10)
        
    }
}

#Preview {
    ProductCardStackExample()
}
