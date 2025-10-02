//
//  CombineDefinitionHomeViewModel.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 2/10/25.
//

import Combine
import Foundation

class CombineDefinitionHomeViewModel: ObservableObject {
    @Published var selectedItem: CombineItem?
    private var cancellables = Set<AnyCancellable>()
    
    let publishers: [CombineItem] = CombineData.publishers
    let subscribers: [CombineItem] = CombineData.subscribers
    let operators: [CombineItem] = CombineData.operators
    
    func selectItem(_ item: CombineItem) {
        selectedItem = item
    }
}
