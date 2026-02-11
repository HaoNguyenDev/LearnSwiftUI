//
//  EnvironmentObjectBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 28/7/25.
//
import SwiftUI

class Counter: ObservableObject {
    @Published var count = 0
    
    func increment() {
        count += 1
    }
    
    func decrement() {
        count -= 1
    }
}

struct EnvironmentObjectExample: View {
    @StateObject private var counter = Counter()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                EnvironmentObjectSubView()
                    .environmentObject(counter)
                EnvironmentObjectSubView2()
                    .environmentObject(counter)
            }
            .navigationTitle(Text("EnvironmentObject"))
        }
        
    }
}

struct EnvironmentObjectSubView: View {
    @EnvironmentObject var counter: Counter
    
    var body: some View {
        Text("Tap to increment: \(counter.count)")
            .onTapGesture {
                counter.increment()
            }
    }
}

struct EnvironmentObjectSubView2: View {
    @EnvironmentObject var counter: Counter
    
    var body: some View {
        Text("Tap to decrement: \(counter.count)")
            .onTapGesture {
                counter.decrement()
            }
    }
}

#Preview {
    EnvironmentObjectExample()
}
