//
//  ErrorView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/9/25.
//


import SwiftUI

struct WeatherErrorView: View {
    
    let error: Error
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
            
            Text("Oops!")
                .font(.title)
            
            Text(gerErrorMessage())
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(.black)
        .padding()
    }
    
    private func gerErrorMessage() -> String {
        if let weatherError = error as? WeatherError {
            switch weatherError {
            case .decodingError:
                return "Decoding Error: \(error.localizedDescription)"
            case .invalidResponse(let message):
                return "Invalid Response: \(message)"
            case .networkError(let error):
                return "Network Error: \(error.localizedDescription)"
            case .unknown:
                return "Unknown Error"
            }
        } else {
            return error.localizedDescription
        }
    }
}
