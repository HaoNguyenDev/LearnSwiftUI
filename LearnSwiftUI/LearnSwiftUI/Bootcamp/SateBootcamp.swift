//
//  SateBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 6/6/25.
//

import SwiftUI

struct User: Identifiable {
    var id = UUID()
    var name: String
}

struct SateBootcamp: View {
    
    @State private var number: Int
    @State private var viewBackgroundColor: Color
    @State private var users: [User]
    
    init() {
        number = 0
        viewBackgroundColor = .blue
        users = [User(name: "Hao"),
                 User(name: "Trinh"),
                 User(name: "Nam"),
                 User(name: "Linh"),
                 User(name: "Trung"),
                 User(name: "Hao"),
                 User(name: "Trinh"),
                 User(name: "Nam"),
                 User(name: "Linh"),
                 User(name: "Trung")]
    }
    
    var body: some View {
        ScrollView {
            VStack {
                CountTestView(number: $number, viewBackgroundColor: $viewBackgroundColor)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                
                NameScrollView(users: $users)
                    .frame(maxWidth: .infinity, maxHeight: 500)
            }
            
        }
        
       
    }
}


#Preview {
    SateBootcamp()
}

struct CountTestView: View {
    @Binding var number: Int
    @Binding var viewBackgroundColor: Color
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Text("Count Test")
                    .padding()
                    .font(.dosis(fontweight: .bold, size: 34.0))
                    .foregroundStyle(.white)
                
                Text("Numbner: \(number)")
                    .padding()
                    .font(.dosis(fontweight: .semibold, size: 34.0))
                    .foregroundStyle(.yellow)
                
                Spacer()
                
                HStack {
                    Button {
                        decrement()
                    } label: {
                        Text("-")
                            .padding(.top, -10)
                            .font(.dosis(fontweight: .bold, size: 34.0))
                            .frame(width: 100, height: 50)
                            .foregroundStyle(.blue)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                        .frame(width: 40)
                    
                    Button(action: {
                        increment()
                    }) {
                        Text("+")
                            .padding(.top, -10)
                            .font(.dosis(fontweight: .bold, size: 34.0))
                            .frame(width: 100, height: 50)
                            .foregroundStyle(.blue)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                Spacer()
            }
        }
        .background(viewBackgroundColor)
        .cornerRadius(20)
        .padding(.horizontal, 30)
        .padding(.vertical, 20)
    }
}

extension CountTestView {
    private func increment() {
        number += 1
        checkPositiveNumber()
    }
    
    private func decrement() {
        number -= 1
        checkPositiveNumber()
    }
    
    private func checkPositiveNumber() {
        viewBackgroundColor = number > 0 ? Color.blue : Color.red
    }
}

struct NameScrollView: View {
    @Binding var users: [User]
    
    var body: some View {
        VStack() {
            ScrollView(showsIndicators: true) {
                ForEach(users, id: \.id) { user in
                    LazyVStack(alignment: .leading) {
                        Text(user.name)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.white)
                            .font(.system(size: 20, weight: .medium, design: .default))
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                            )
                    }
                    .padding(.leading, 30)
                }
            }
        }
    }
}
