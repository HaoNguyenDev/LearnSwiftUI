//
//  ObservedObjectBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 11/7/25.
//

import SwiftUI

struct ObservedObjectBootcamp: View {
    @State private var resetParentView: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            let model = CounterModel()
            ObservedObjectChildView(model: model)
            
            Button {
                resetParentView.toggle()
            } label: {
                Text("Re-render Parent View")
                    .foregroundStyle(resetParentView ? .white : .blue)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(5)
            }

        }
    }
}

#Preview {
    ObservedObjectBootcamp()
}

struct ObservedObjectChildView: View {
    @ObservedObject var model: CounterModel
    
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

    

