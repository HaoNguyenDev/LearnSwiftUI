//
//  CounterFeature.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/2/26.
//

import ComposableArchitecture

@Reducer
struct CounterFeature {
    @ObservableState
    struct State: Equatable {
        var count: Int = 0
    }
    
    enum Action {
        case incrementCountTapped
        case decrementCountTapped
        case resetCountTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .incrementCountTapped:
                state.count += 1
                return .none
            case .decrementCountTapped:
                state.count -= 1
                return .none
            case .resetCountTapped:
                state.count = 0
                return .none
            }
        }
    }
}
