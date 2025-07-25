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
                    .foregroundStyle(.white)
                    .padding()
                    .frame(width: 200)
                    .background(resetParentView ? Color.red : Color.green)
                    .cornerRadius(20)
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
        VStack {
            Text("Subview")
                .font(.title3)
                .foregroundStyle(.white)
            ExtractedView2(count: $model.count)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray)
        )
    }
}

struct ExtractedView2: View {
    @Binding var count: Int
    
    var body: some View {
        Text("Tap to count up: \(count)")
            .font(.title3)
            .foregroundStyle(.white)
            .padding()
            .frame(width: 200, height: 100)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.blue)
            }
            .onTapGesture {
                count += 1
            }
    }
}

