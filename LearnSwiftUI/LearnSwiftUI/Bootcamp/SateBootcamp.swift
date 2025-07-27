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

#Preview {
    SateBootcamp()
}

struct SateBootcamp: View {
    @State private var newName = ""
    @State private var isToggled = false
    @State private var selectedColor: Color = .blue
    @State private var everyoneName = [User(name: "Hao"), User(name: "Loan")]
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            //Bool State
            Toggle("On/Off", isOn: $isToggled)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isToggled ? Color.green.opacity(0.5) : Color.gray.opacity(0.2))
                )
            Text(isToggled ? "🌝" : "🌚")
                .font(.system(size: 40, weight: .bold, design: .default))
            
            
            //Text State
            TextField("Please enter a name", text: $newName)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
            Text(newName == "" ? "..." : "Hello 👋 \(newName)")
            
            // Array State
            Button {
                everyoneName.append(User(name: newName))
            } label: {
                Text("Add")
                    .foregroundStyle(.white)
                    .font(.system(size: 18, weight: .medium, design: .default))
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.green)
                    )
            }
            ScrollView {
                LazyVStack(alignment: .center, spacing: 10) {
                    ForEach(everyoneName) { user in
                        Text(user.name)
                    }
                }
            }
            
        }
        .padding()
    }
}
