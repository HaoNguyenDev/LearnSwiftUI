//
//  TimerPublisherBootcamp.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 16/10/25.
//

import SwiftUI

struct TimerPublisherBootcamp: View {
    
    // App state
    @Environment(\.scenePhase) var scenePhase
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let totalDuration: Double
    
    @State private var endTime: Date
    @State private var timerString: String = ""
    @State private var lastActiveDate: Date? = nil
    @State private var currentDate: Date = Date()
    @State private var isRunning: Bool = true
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .long
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }
    
    init(totalDuration: Double) {
        self.totalDuration = totalDuration
        let calculatedEndTime = Date().addingTimeInterval(totalDuration)
        _endTime = State(initialValue: calculatedEndTime)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("System time: \(dateFormatter.string(from: currentDate))")
                .font(R.font.ttHovesProTrialMd.font(size: 16))
                .foregroundStyle(Color.backgroundDark)
                .padding()
            
            Text("\(timerString)")
                .font(R.font.ttHovesProTrialBd.font(size: 30))
                .foregroundStyle(Color.backgroundDark)
                .padding()
            
            Button {
                isRunning.toggle()
            } label: {
                Text(isRunning ? "Stop" : "Start")
            }
            .buttonStyle(HButtonStyle(size: .large, type: .primary))
            .padding()
        }
        .onReceive(timer) { value in
            self.currentDate = value
            if isRunning {
                updateCountdown(currentDate: value)
            }
        }
        .onAppear {
            updateCountdown(currentDate: Date()) // First update
        }
        .onChange(of: scenePhase) { newPhase, oldPhase in
            handleScenePhaseChange(newPhase: newPhase)
        }
    }
    
    private func handleScenePhaseChange(newPhase: ScenePhase) {
        switch newPhase {
        case .background:
            lastActiveDate = Date()
        case .active:
            if let lastDate = lastActiveDate {
                let timePassed = Date().timeIntervalSince(lastDate)
                // Calculate time again
                endTime = endTime.addingTimeInterval(-timePassed)
                updateCountdown(currentDate: Date())
            }
            lastActiveDate = nil
        case .inactive:
            break
        @unknown default:
            break
        }
    }
    
    private func updateCountdown(currentDate: Date) {
        let remainingTime = endTime.timeIntervalSince(currentDate)
        if remainingTime > 0 {
            timerString = timeIntervalToString(duration: remainingTime)
        } else {
            timerString = "TIME'S UP!"
        }
    }
    
    private func timeIntervalToString(duration: Double, stringFormat: String = "%02d:%02d:%02d") -> String {
        let time = Int(max(0, duration))
        
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600) % 24
        _ = time / 86400
        
        let result = String(format: stringFormat, hours, minutes, seconds)
        
        return result
    }
}

#Preview {
    TimerPublisherBootcamp(totalDuration: 61)
}
