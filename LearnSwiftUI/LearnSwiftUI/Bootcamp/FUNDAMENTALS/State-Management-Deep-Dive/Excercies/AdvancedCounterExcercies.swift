//
//  AdvancedCounterExcercies.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 4/2/26.
//

import SwiftUI

struct AdvancedCounterExercise: View {
    // MARK: - State
    @State private var currentNumber = 0
    @State private var history: [Int] = []
    @State private var redoStack: [Int] = []
    @State private var stepSize = 5
    
    // MARK: - Constants
    private let minValue = 0
    private let maxValue = 100
    private let stepSizes = [1, 5, 10]
    
    // MARK: - Computed Properties
    private var canUndo: Bool {
        !history.isEmpty
    }
    
    private var canRedo: Bool {
        !redoStack.isEmpty
    }
    
    private var canIncrease: Bool {
        currentNumber + stepSize <= maxValue
    }
    
    private var canDecrease: Bool {
        currentNumber - stepSize >= minValue
    }
    
    private var canReset: Bool {
        history.isEmpty && redoStack.isEmpty
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 30) {
            currentNumberView
            historyView
            redoStackView
            stepPickerView
            undoRedoActionView
            stepButtonActions
            resetButtonView
        }
        .padding()
    }
    
    // MARK: - View Components
    private var currentNumberView: some View {
        VStack(spacing: 8) {
            Text("\(currentNumber)")
                .font(.system(size: 80, weight: .bold, design: .rounded))
                .contentTransition(.numericText())
            
            Text("Range: \(minValue) - \(maxValue)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
    
    private var historyView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("History (last 10):")
                .font(.caption)
                .foregroundColor(.secondary)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(history.suffix(10), id: \.self) { value in
                        Text("\(value)")
                            .font(.system(.body, design: .monospaced))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color.blue)
                                
                            }
                    }
                }
            }
            .frame(height: 40)
        }
    }
    
    private var redoStackView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("RedoStack (last 10):")
                .font(.caption)
                .foregroundColor(.secondary)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(redoStack.suffix(10), id: \.self) { value in
                        Text("\(value)")
                            .font(.system(.body, design: .monospaced))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color.blue)
                                
                            }
                    }
                }
            }
            .frame(height: 40)
        }
        
    }
    
    private var stepPickerView: some View {
        VStack {
            Text("Step size")
            Picker("Step size", selection: $stepSize) {
                ForEach(stepSizes, id: \.self) { size in
                    Text("\(size)").tag(size)
                        .padding()
                }
            }
            .pickerStyle(.segmented)
        }
    }
    
    private var undoRedoActionView: some View {
        HStack {
            Button(action: undoAction) {
                Label("Undo", systemImage: "arrow.uturn.backward")
                    .frame(maxWidth: .infinity)
            }
            .disabled(!canUndo)
            
            Button(action: redoAction) {
                Label("Redo", systemImage: "arrow.uturn.forward")
                    .frame(maxWidth: .infinity)
            }
            .disabled(!canRedo)
        }
        .buttonStyle(.borderedProminent)
    }
    private var stepButtonActions: some View {
        HStack {
            Button(action: decreaseAction) {
                Label("-\(stepSize)", systemImage: "minus.circle.fill")
                    .frame(maxWidth: .infinity)
            }
            .disabled(!canDecrease)
            
            Button(action: increaseAction) {
                Label("+\(stepSize)", systemImage: "plus.circle.fill")
                    .frame(maxWidth: .infinity)
            }
            .disabled(!canIncrease)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var resetButtonView: some View {
        Button(action: resetAction) {
            Label("Reset", systemImage: "xmark.square.fill")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .disabled(canReset)
    }
    
    //MARK: Action
    private func increaseAction() {
        guard canIncrease else { return }
        withAnimation(.spring()) {
            saveToHistory()
            currentNumber += stepSize
            clampNumber()        }
    }
    
    private func decreaseAction() {
        guard canDecrease else { return }
        withAnimation(.spring()) {
            saveToHistory()
            currentNumber -= stepSize
            clampNumber()
        }
    }
    
    private func undoAction() {
        guard let previousValue = history.popLast() else { return }
        withAnimation(.spring(response: 0.3)) {
            redoStack.append(currentNumber)
            currentNumber = previousValue
        }
    }
    
    private func redoAction() {
        guard let previousValue = redoStack.popLast() else { return }
        withAnimation(.spring(response: 0.3)) {
            history.append(currentNumber)
            currentNumber = previousValue
        }
    }
    
    private func resetAction() {
        withAnimation(.spring()) {
            history.removeAll()
            redoStack.removeAll()
            currentNumber = 0
            stepSize = 5
        }
    }
    
    //MARK: Helper
    private func saveToHistory() {
        history.append(currentNumber)
        if history.count > 100 {
            history.removeFirst()
        }
    }
    
    private func clampNumber() {
        currentNumber = min(max(currentNumber, minValue), maxValue)
    }
}
#Preview {
    AdvancedCounterExercise()
}
