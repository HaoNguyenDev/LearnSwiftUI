//
//  BackgroundAndOverlayBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 30/5/25.
//

import SwiftUI

struct BackgroundAndOverlayBootcamp: View {
    
    @State private var count = 0
    @State private var tappedOnCat = false
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                
                RoundedRectangle(cornerRadius: 100)
                    .fill(Color.blue)
                    .frame(width: 200, height: 200)
                    .overlay {
                        Image("cat")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .cornerRadius(75)
                    }
                    .overlay (
                        Circle()
                            .fill(Color.red)
                            .frame(width: 50, height: 50)
                            .overlay(content: {
                                Text("\(count)")
                                    .font(.system(size: 25))
                                    .foregroundColor(.white)
                                
                            })
                            .scaleEffect(tappedOnCat ? 1.1 : 1.0)
                        ,alignment: .bottomTrailing
                    )
                
                    .shadow(color: Color.black.opacity(0.7), radius: 10, x: 5, y: 5)
                    .onTapGesture {
                        count += 1
                        tappedOnCat.toggle()
                    }
                
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.blue)
                    .frame(width: 200, height: 200)
                    .overlay(
                        Circle()
                            .fill(Color.red)
                            .frame(width: 100, height: 100)
                            .overlay {
                                Text("1")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .background {
                                Circle()
                                    .fill(.yellow)
                                    .frame(width: 150, height: 150)
                            }
                    )
                    
                
                
                Rectangle()
                    .fill(Color.yellow)
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 5, lineCap: .square, dash: [20]))
                    .frame(width: 300, height: 200)
                
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.red)
                            .frame(width: 150, height: 150)
                            .overlay {
                                Image("cat")
                                    .resizable()
                                //.scaledToFill()
                                    .cornerRadius(20)
                                    .frame(width: 100, height: 100)
                            }
                    }
                
                Circle()
                    .fill(Color.yellow)
                    .frame(width: 150, height: 150)
                    .overlay {
                        Image("cat")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(20)
                    }
                
                Image("cat")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)
                    .background {
                        Circle()
                            .fill(Color.yellow)
                            .frame(width: 150, height: 150)
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}

#Preview {
    BackgroundAndOverlayBootcamp()
}
