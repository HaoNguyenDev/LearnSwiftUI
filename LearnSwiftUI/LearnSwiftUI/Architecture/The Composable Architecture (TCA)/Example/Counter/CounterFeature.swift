//
//  CounterFeature.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/2/26.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct CounterFeature {
    @ObservableState
    struct State {
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

struct CounterView: View {
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        VStack {
            Text("\(store.count)")
                .font(.largeTitle).bold()
            HStack {
                Button("-") {
                    store.send(.decrementCountTapped)
                }.buttonStyle(.borderedProminent)
                
                Button("+") {
                    store.send(.incrementCountTapped)
                }.buttonStyle(.borderedProminent)
            }
            Button("Reset") {
                store.send(.resetCountTapped)
            }.buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    CounterView(store: Store(initialState: CounterFeature.State(), reducer: {
        CounterFeature()
    }))
}
