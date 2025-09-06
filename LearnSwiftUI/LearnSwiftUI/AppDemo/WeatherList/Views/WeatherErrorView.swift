//
//  ErrorView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/9/25.
//


import SwiftUI

struct WeatherErrorView: View {
  
  let message: String
  
  var body: some View {
    VStack(spacing: 20) {
      Image(systemName: "exclamationmark.triangle")
        .font(.system(size: 50))
      
      Text("Oops!")
        .font(.title)
      
      Text(message)
        .multilineTextAlignment(.center)
    }
    .foregroundStyle(.black)
    .padding()
  }
}
