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
    @State private var history: [Int] = []      // Undo stack
    @State private var redoStack: [Int] = []    // ✅ Redo stack
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
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 30) {
            // Display
            numberDisplay
            
            // History visualization
            historyView
            
            // Redo history
            redoHistoryView
            
            // Step size picker
            stepSizePicker
            
            // Controls
            controlButtons
        }
        .padding()
    }
    
    // MARK: - View Components
    private var numberDisplay: some View {
        VStack(spacing: 8) {
            Text("\(currentNumber)")
                .font(.system(size: 80, weight: .bold, design: .rounded))
//                .contentTransition(.numericText())
            
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
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
            }
            .frame(height: 40)
        }
    }
    
    private var redoHistoryView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Redo history (last 10):")
                .font(.caption)
                .foregroundColor(.secondary)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(redoStack.suffix(10), id: \.self) { value in
                        Text("\(value)")
                            .font(.system(.body, design: .monospaced))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
            }
            .frame(height: 40)
        }
    }
    
    private var stepSizePicker: some View {
        VStack(spacing: 8) {
            Text("Step Size: \(stepSize)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Picker("Step Size", selection: $stepSize) {
                ForEach(stepSizes, id: \.self) { size in
                    Text("\(size)").tag(size)
                }
            }
            .pickerStyle(.segmented)
        }
    }
    
    private var controlButtons: some View {
        VStack(spacing: 16) {
            // Undo/Redo
            HStack(spacing: 16) {
                Button(action: undo) {
                    Label("Undo", systemImage: "arrow.uturn.backward")
                        .frame(maxWidth: .infinity)
                }
                .disabled(!canUndo)
                
                Button(action: redo) {
                    Label("Redo", systemImage: "arrow.uturn.forward")
                        .frame(maxWidth: .infinity)
                }
                .disabled(!canRedo)
            }
            .buttonStyle(.bordered)
            
            // Increment/Decrement
            HStack(spacing: 16) {
                Button(action: decrease) {
                    Label("−\(stepSize)", systemImage: "minus.circle.fill")
                        .frame(maxWidth: .infinity)
                }
                .disabled(!canDecrease)
                
                Button(action: increase) {
                    Label("+\(stepSize)", systemImage: "plus.circle.fill")
                        .frame(maxWidth: .infinity)
                }
                .disabled(!canIncrease)
            }
            .buttonStyle(.borderedProminent)
            
            // Reset
            Button(action: reset) {
                Label("Reset", systemImage: "arrow.counterclockwise")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .tint(.red)
        }
    }
    
    // MARK: - Actions
    private func increase() {
        guard canIncrease else { return }
        
        withAnimation(.spring(response: 0.3)) {
            saveToHistory()
            currentNumber += stepSize
            clampNumber()
            redoStack.removeAll()  // ✅ Clear redo stack on new action
        }
    }
    
    private func decrease() {
        guard canDecrease else { return }
        
        withAnimation(.spring(response: 0.3)) {
            saveToHistory()
            currentNumber -= stepSize
            clampNumber()
            redoStack.removeAll()  // ✅ Clear redo stack on new action
        }
    }
    
    private func undo() {
        guard let previousValue = history.popLast() else { return }
        
        withAnimation(.spring(response: 0.3)) {
            redoStack.append(currentNumber)  // ✅ Save current to redo stack
            currentNumber = previousValue
        }
    }
    
    private func redo() {
        guard let nextValue = redoStack.popLast() else { return }
        
        withAnimation(.spring(response: 0.3)) {
            history.append(currentNumber)  // ✅ Save current to history
            currentNumber = nextValue
        }
    }
    
    private func reset() {
        withAnimation(.spring(response: 0.3)) {
            currentNumber = 0
            history.removeAll()
            redoStack.removeAll()
        }
    }
    
    // MARK: - Helpers
    private func saveToHistory() {
        history.append(currentNumber)
        
        // ✅ Limit history size to prevent memory issues
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
