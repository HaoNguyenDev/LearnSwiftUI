//
//  ObservedObjectBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 11/7/25.
//

/*
 @ObservedObject: "I only OBSERVE this object"
 
 View receives object from outside
 View does not own object
 Object is managed by another View
 */

import SwiftUI

struct ObservedObjectBootcamp: View {
    @State private var reRenderParentView: Bool = false
    @StateObject private var counterModel = CounterModel()
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                ObservedObjectView(model: counterModel)
                
                Button {
                    reRenderParentView.toggle()
                    counterModel.reset()
                } label: {
                    Text("Re-render Parent View")
                        .foregroundStyle(.white)
                        .padding()
                        .frame(width: 200)
                        .background(Color.green)
                        .cornerRadius(20)
                }
                
            }
            .navigationTitle("ObservedObject")
        }
    }
}

#Preview {
    ObservedObjectBootcamp()
}

struct ObservedObjectView: View {
    @ObservedObject var model: CounterModel //ObservedObject should be inject from parentview, dont create in this view like this CounterModel()
    
    var body: some View {
        VStack {
            Text("Subview")
                .font(.title3)
                .foregroundStyle(.white)
            CountView2(count: $model.count)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray)
        )
    }
}

struct CountView2: View {
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

