//
//  TCACounterFeature.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 21/2/26.
//

import Foundation
import SwiftUI
import ComposableArchitecture

@Reducer
struct TCACounterFeature {
    @ObservableState // Helps SwiftUI automatically update when the state changes
    struct State: Equatable {
        var count = 0
    }
    
    enum Action {
        case incrementButtonTapped
        case decrementButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .incrementButtonTapped:
                state.count += 1
                return .none
            case .decrementButtonTapped:
                state.count -= 1
                return .none
            }
        }
    }
}

struct TCACounterView: View {
    let store: StoreOf<TCACounterFeature>
    var body: some View {
        Text("\(store.count)").font(.title2).bold()
        Button("+", action: increaseCount).buttonStyle(.borderedProminent)
        Button("-", action: decreaseCount).buttonStyle(.borderedProminent)
    }
    
    private func increaseCount() {
        store.send(.incrementButtonTapped)
    }
    
    private func decreaseCount() {
        store.send(.decrementButtonTapped)
    }
}

#Preview {
    TCACounterView(store: Store(initialState: TCACounterFeature.State(count: 10), reducer: {
        TCACounterFeature()
    }))
}
