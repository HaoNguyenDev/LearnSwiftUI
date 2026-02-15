//
//  ButtonBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/6/25.
//

import SwiftUI

struct ButtonBootcamp: View {
    @State private var isLoading = false
    private var buttonPressed: (() -> Void)? = nil
    var body: some View {
        
        VStack(alignment: .center, spacing: 20, content: {
            let loginText = Text("Login Button")
            Button(action: {
                print(">>> Login Button")
                self.isLoading.toggle()
            }, label: {
                HStack {
                    if isLoading {
                        ProgressView()
                    }
                    loginText
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                }
                .frame(width: 200, height: 50)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            })
            .disabled(isLoading)
            .opacity(isLoading ? 0.5 : 1)
            .accessibilityLabel(loginText)
            .accessibilityHint(isLoading ? "Loading" : "")
            .accessibilityAddTraits(isLoading ? .isHeader : .isButton)
            
            
            
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
            
            Button {
                print(">>> Button with modifier pressed")
            } label: {
                Text("Button with modifier")
                    .padding(10)
                    .frame(maxWidth: .infinity, maxHeight: 50)
            }.buttonStyle(conerRadius: 25, foregroundColor: .blue, padding: (.horizontal, 20))
            
            Button {
                print(">>> Button with disabled")
            } label: {
               Text("Button with disabled")
                        .padding(10)
                        .frame(maxWidth: .infinity, maxHeight: 50)
            }
            .buttonStyle(SecondaryButtonStyle())
            .padding(.horizontal, 20)
            .disabled(true)
        })
       
        
    }
}

#Preview {
    ButtonBootcamp()
}

