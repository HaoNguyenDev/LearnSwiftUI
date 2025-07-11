//
//  StateObjectBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 11/7/25.
//

import SwiftUI

class CounterModel: ObservableObject {
    @Published var count = 0
}

struct StateObjectBootcamp: View {
    @State private var resetParentView: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            StateObjectChildView()
            
            Button {
                resetParentView.toggle()
            } label: {
                Text("Re-render Parent View")
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(5)
            }

        }
        
    }
}

#Preview {
    StateObjectBootcamp()
}

struct StateObjectChildView: View {
    @StateObject var model = CounterModel()
    
    var body: some View {
        Text("Tap to count up: \(model.count)")
            .font(.title3)
            .foregroundStyle(.white)
            .padding()
            .frame(width: 200, height: 100)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.blue)
            }
            .onTapGesture {
                model.count += 1
            }
    }
}

