//
//  CounterView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/2/26.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        VStack {
            Text("\(store.count)")
                .font(.title)
                .bold()
            HStack {
                Button("+") {
                    store.send(.incrementCountTapped)
                }
                .buttonStyle(.borderedProminent)
                
                Button("-") {
                    store.send(.decrementCountTapped)
                }
                .buttonStyle(.borderedProminent)
            }
            Button("Reset count") {
                store.send(.resetCountTapped)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    CounterView(store: Store(initialState: CounterFeature.State(), reducer: {
        CounterFeature()
    }))
}

