//
//  PickerBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 29/8/25.
//

import SwiftUI

struct PickerBootcamp: View {
    
    enum Colors : String, CaseIterable, Identifiable {
        case green, blue, red, yellow
        var id: String { self.rawValue }
        
        var displayName: String {
            switch self {
            case .green: return "Green"
            case .blue: return "Blue"
            case .red: return "Red"
            case .yellow: return "Yellow"
            }
        }
        
        var color: Color {
            switch self {
            case .green: return .green
            case .blue: return .blue
            case .red: return .red
            case .yellow: return .yellow
            }
        }
    }
    
    @State private var selectedColor: Colors? = .green
    @State private var show: Bool = false
    var body: some View {
        
        NavigationView{
            Form{
                Section {
                    Toggle("Show", isOn: $show)
                    if show {
                        Text("This is hidden when show is false")
                    }
                }
                .transition(.opacity)
                
                Section {
                    Picker("Select a Color", selection: $selectedColor) {
                        ForEach(Colors.allCases, id: \.self) { color in
                            Text(color.displayName).tag(color)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section {
                    Picker("Select a Color", selection: $selectedColor) {
                        ForEach(Colors.allCases, id: \.self) { color in
                            Text(color.displayName).tag(color)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Picker("Select a Color", selection: $selectedColor) {
                        ForEach(Colors.allCases, id: \.self) { color in
                            Text(color.displayName).tag(color)
                        }
                    }
                    .pickerStyle(.inline)
                }
                
             
                
                Section {
                    Picker("Select a Color", selection: $selectedColor) {
                        ForEach(Colors.allCases, id: \.self) { color in
                            Text(color.displayName).tag(color)
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }
            .animation(.easeInOut, value: show)
            .navigationTitle(Text("Picker Bootcamp"))
        }
        
    }
}

#Preview {
    PickerBootcamp()
        .preferredColorScheme(.dark)
}
