//
//  ButtonBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/6/25.
//

import SwiftUI

struct ButtonBootcamp: View {
    var body: some View {
        
        VStack(alignment: .center, spacing: 20, content: {
            Button("Press Me") {
                print(">>> Normal Button")
            }
            .frame(width: 200, height: 50)
            .foregroundStyle(.white)
            .background(Color.blue)
            
            Button(action: {
                print(">>> Press Me")
            }, label: {
                Text("Button Custom Text")
            })
            .foregroundStyle(.green)
            .frame(width: 200, height: 50)
            .background(Color.yellow)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.red)
                .frame(width: 200, height: 50)
                .overlay(
                    Button(action: {
                        print(">>> Press Me")
                    }, label: {
                        Text("Button Custom Text")
                            .foregroundStyle(.white)
                            .font(.body)
                            .fontWeight(.bold)
                    })
                )
                .shadow(color: .black, radius: 5)
            
            Button {
                print(">>> Circle Button")
            } label: {
                Circle()
                    .frame(width: 120)
                    .overlay(
                        HStack {
                            Image(systemName: "heart.fill")
                                .font(.title3)
                                .foregroundStyle(.white)
                            Text("Circle")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding(.leading, 0)
                        }
                    )
                    .foregroundStyle(.red)
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 5, y: 0)
            }
            
            Button {
                print(">>>> Finish")
            } label: {
                Text("Finish")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)
                    .frame(width: 120, height: 50)
                    .background(
                        Capsule()
                            .stroke(Color.blue, style: StrokeStyle(lineWidth: 3.0, lineCap: .round, dash: [10.0]))
                    )
                    
            }

            
        })
       
        
    }
}

#Preview {
    ButtonBootcamp()
}
