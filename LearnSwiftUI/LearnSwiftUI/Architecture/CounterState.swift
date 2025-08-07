//
//  CounterState.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 7/8/25.
//

import Foundation

//MARK: State
struct CounterState {
    let count: Int
    let isLoading: Bool
    let lastOperation: String?
    
    init(count: Int = 0, isLoading: Bool = false, lastOperation: String? = nil) {
        self.count = count
        self.isLoading = isLoading
        self.lastOperation = lastOperation
    }
}

// Helper for creating new state instances
extension CounterState {
    func copy(count: Int? = nil,
              isLoading: Bool? = nil,
              lastOperation: String? = nil) -> Self {
        CounterState(count: count ?? self.count,
                     isLoading: isLoading ?? self.isLoading,
                     lastOperation: lastOperation ?? self.lastOperation)
    }
}

//MARK: Intent
enum CounterIntent {
    case increment
    case decrement
    case reset
    case asyncIncrement
    case clearLastOperation
}

@MainActor
protocol MVIStore: ObservableObject {
    associatedtype State
    associatedtype Intent
    var state: State { get }
    func send(_ intent: Intent)
}

@MainActor
final class CounterStore: MVIStore {

    @Published private(set) var state = CounterState()
    
    func send(_ intent: CounterIntent) {
        switch intent {
        case .increment:
            handleIncrement()
        case .decrement:
            handleDecrement()
        case .reset:
            handleReset()
        case .asyncIncrement:
            handleAsyncIncrement()
        case .clearLastOperation:
            clearLastOperation()
        }
    }
    
    //MARK: Intent Handlers
    
    private func handleIncrement() {
        state = state.copy(count: state.count + 1, lastOperation: "Increment to \(state.count + 1)")
    }
    
    private func handleDecrement() {
        state = state.copy(count: state.count - 1, lastOperation: "Decrement to \(state.count - 1)")
    }
    
    private func handleReset() {
        state = state.copy(count: 0, lastOperation: "Reset to 0")
    }
    
    private func handleAsyncIncrement() {
        //First, show loading state
        state = state.copy(isLoading: true, lastOperation: "Processing async increment...")
        
        Task {
            try await Task.sleep(for: .seconds(1))
            
            state = state.copy(count: state.count + 1, isLoading: false, lastOperation: "Async increment to \(state.count + 1)")
        }
    }
    
    private func clearLastOperation() {
        state = state.copy(lastOperation: nil)
    }
}

import SwiftUI

struct CounterView: View {
    @StateObject private var store = CounterStore()
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Current count
            Text("\(store.state.count)")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Show last opreation if available
            if let lastOperation = store.state.lastOperation {
                Text(lastOperation)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .onTapGesture {
                        store.send(.clearLastOperation)
                    }
            }
            
            // Action buttons
            HStack(spacing: 15) {
                Button("-") {
                    store.send(.decrement)
                }
                .buttonStyle(.bordered)
                
                Button("+") {
                    store.send(.increment)
                }
                .buttonStyle(.bordered)
                
                Button("Reset") {
                    store.send(.reset)
                }
                .buttonStyle(.bordered)
            }
            
            // Async increment button with loading state
            Button {
                store.send(.asyncIncrement)
            } label: {
                HStack {
                    if store.state.isLoading {
                        ProgressView()
                            .scaleEffect(0.8)
                    }
                    Text("Async +1")
                }
            }

        }
        .padding()
    }
}

#Preview {
    CounterView()
}
