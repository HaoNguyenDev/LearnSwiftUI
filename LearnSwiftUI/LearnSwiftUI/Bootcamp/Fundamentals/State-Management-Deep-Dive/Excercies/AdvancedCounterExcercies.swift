//
//  AdvancedCounterExcercies.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 4/2/26.
//

import SwiftUI

struct AdvancedCounterExcercies: View {
    @State private var currentNumber = 0
    @State private var numberHistory: [Int] = []
    @State private var redoNumbers: [Int] = []
    
    private var displayNumber: String {
        return "\(currentNumber = min(max(currentNumber, 0), 100))"
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("\(currentNumber)")
                    .font(.system(size: 50, weight: .bold, design: .monospaced))
                Text("\(numberHistory)")
                Text("\(redoNumbers)")
                HStack {
                    Button("Undo") {
                        undoLogic()
                    }
                    .disabled(numberHistory.isEmpty)
                    
                    Button("Redo") {
                        redoLogic()
                    }
                    .disabled(redoNumbers.isEmpty)
                    
                    Button("Increase") {
                        increaseLogic()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

extension AdvancedCounterExcercies {
    
    private func increaseLogic() {
        withAnimation(.spring(response: 0.3)) {
            if numberHistory.contains(100) { return }
            currentNumber += 5
            numberHistory.append(currentNumber)
            if numberHistory.count > 1 {
                redoNumbers.removeAll()
            }
        }
    }
    private func undoLogic() {
        guard let lastNum = numberHistory.last else { return }
        redoNumbers.append(lastNum)
        _ = numberHistory.popLast()
        currentNumber = numberHistory.last ?? 0
    }
    
    private func redoLogic() {
        guard currentNumber < 100, let redoNum  = redoNumbers.last else { return }
        numberHistory.append(redoNum)
        currentNumber = numberHistory.last ?? 0
        redoNumbers.removeLast()
    }
    
    private func limitNumber() {
        if numberHistory.contains(100) { return }
    }
}



#Preview {
    AdvancedCounterExcercies()
}
