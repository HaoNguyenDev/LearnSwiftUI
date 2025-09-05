//
//  WeatherListSuccessView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/9/25.
//


import SwiftUI

struct WeatherListSuccessView: View {
  let items: [WeatherItem]
  
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(items) { item in
          WeatherCard(item: item)
        }
      }
      .padding(.horizontal)
    }
  }
}
