//
//  TCAPattern.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 20/2/26.
//

import SwiftUI

@MainActor
final class TCAPattern<State: Equatable, Action, Effect>: ObservableObject {
    @Published private(set) var state: State
    
    private let reducer: (inout State, Action) -> Effect?
    private let effectHandler: (Effect) async -> Action?
    
    init(
        initialState: State,
        reducer: @escaping (inout State, Action) -> Effect?,
        effectHandler: @escaping (Effect) async -> Action? = { _ in nil }
    ) {
        self.state = initialState
        self.reducer = reducer
        self.effectHandler = effectHandler
    }
    
    func send(_ action: Action) {
        let effect = reducer(&state, action)
        guard let effect else { return }
        Task {
            if let followUpAction = await effectHandler(effect) {
                send(followUpAction)
            }
        }
    }
    
    func binding<Value>(
        get keyPath: KeyPath<State, Value>,
        send toAction: @escaping (Value) -> Action
    ) -> Binding<Value> {
        Binding(
            get: { self.state[keyPath: keyPath] },
            set: { self.send(toAction($0)) }
        )
    }
}
