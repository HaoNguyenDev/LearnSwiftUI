//
//  StateObjectBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 11/7/25.
//

/*@StateObject: "I OWN this object"
 
 View creates and manages the lifecycle of the object
 Objects exist throughout the lifetime of the View
 SwiftUI does not recreate objects when the View re-renders
 */

import SwiftUI

class CounterModel: ObservableObject {
    @Published var count = 0
    
    func reset() {
        count = 0
    }
}

struct StateObjectBootcamp: View {
    @State private var reRenderParentView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                StateObjectView()
                
                Button {
                    reRenderParentView.toggle()
                } label: {
                    Text("Re-render Parent View")
                        .foregroundStyle(.white)
                        .padding()
                        .frame(width: 200)
                        .background(Color.green)
                        .cornerRadius(20)
                }
            }
            .navigationTitle(Text("StateObject"))
        }
        
    }
}

#Preview {
    StateObjectBootcamp()
}

struct StateObjectView: View {
    @StateObject var model = CounterModel()
    
    var body: some View {
        VStack {
            Text("Subview")
                .font(.title3)
                .foregroundStyle(.white)
            CountView(model: model)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray)
        )
    }
}


struct CountView: View {
    @ObservedObject var model: CounterModel
    
    var body: some View {
        Text("Tap to count up: \(model.count)")
            .font(.title3)
            .foregroundStyle(.white)
            .padding()
            .frame(width: 200, height: 100)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.blue)
            }
            .onTapGesture {
                model.count += 1
            }
    }
}
