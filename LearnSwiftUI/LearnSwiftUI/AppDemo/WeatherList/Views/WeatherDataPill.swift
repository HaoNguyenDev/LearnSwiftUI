//
//  WeatherDataPill.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/9/25.
//


import SwiftUI

struct WeatherDataPill: View {
  
  let icon: String
  let value: String
  
  var body: some View {
    HStack {
      Image(systemName: icon)
      
      Text(value)
    }
    .font(.subheadline)
    .padding(.horizontal, 12)
    .padding(.vertical, 8)
    .background {
      Capsule()
        .fill(.white.opacity(0.2))
    }
  }
}