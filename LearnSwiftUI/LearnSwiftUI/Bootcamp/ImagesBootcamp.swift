//
//  ImagesBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 27/5/25.
//

import SwiftUI

struct ImagesBootcamp: View {
    @State private var isTapped: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20.0)
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 3.0, lineCap: .round, dash: [10.0]))
                .padding(10)
                .frame(height: 250, alignment: .center)
                .onAppear() {
                    self.isTapped.toggle()
                }
    
            VStack(spacing: 20) {
                // Image using SF Symbol for game controller
                Image(systemName: isTapped ? "gamecontroller" : "gamecontroller.fill")
                    .resizable() // Allow the image to be resized
                    .scaledToFit() // Maintain aspect ratio while fitting the frame
                    .frame(width: 100, height: 100) // Set fixed frame size
                    .foregroundColor(isTapped ? .red : .blue) // Change color based on tap state
                    .scaleEffect(isTapped ? 1.1 : 1.0) // Scale up when tapped
                    .rotationEffect(.degrees(isTapped ? 360 : 0)) // Rotate when tapped
                    .shadow(color: .gray, radius: 5, x: 0, y: 5) // Add shadow effect
                    .opacity(0.8) // Set transparency
                    .padding() // Add padding around the image
                    .background(isTapped ? .blue : .red) // Add a subtle background
                    .clipShape(Circle()) // Clip the image into a circle
                    .overlay( // Add a border around the image
                        Circle()
                            .stroke(Color.yellow, lineWidth: 2)
                    )
                    .animation(.easeInOut(duration: 0.3), value: isTapped) // Animate changes
                    .onTapGesture {
                        isTapped.toggle() // Toggle tap state on interaction
                    }
                
                // Instructional text
                Text("Tap the game controller to interact!")
                    .font(.title2)
                    .foregroundColor(.customTextColor)
            }
            .padding() // Add padding to the entire VStack
        }
  
    }
}

#Preview {
    ImagesBootcamp()
}
