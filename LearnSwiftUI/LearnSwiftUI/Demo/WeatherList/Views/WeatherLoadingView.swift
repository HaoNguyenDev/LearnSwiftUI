//
//  LoadingView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/9/25.
//


import SwiftUI

struct WeatherLoadingView: View {
  var body: some View {
    VStack(spacing: 20) {
      ProgressView()
        .scaleEffect(1.5)
      
      Text("Fetching Weather Data...")
        .font(.headline)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .foregroundStyle(.black)
  }
}
