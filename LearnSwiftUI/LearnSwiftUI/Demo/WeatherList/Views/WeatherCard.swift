//
//  WeatherCard.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/9/25.
//


import SwiftUI
import WeatherKit

struct WeatherCard: View {
  
  let item: WeatherItem
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        Text(item.cityName)
          .font(.title2)
          .bold()
        
        Spacer()
        
        Image(systemName: item.symbolName)
          .symbolRenderingMode(.multicolor)
          .font(.title)
      }
      
      HStack(alignment: .lastTextBaseline) {
        Text("\(Int(item.temperature.value))\(item.temperature.unit.symbol)")
          .font(.system(size: 46, weight: .bold))
          .foregroundStyle(temperatureColor.gradient)
        
        Spacer()
        
        VStack(alignment: .trailing) {
          Text(item.description)
            .font(.headline)
          
          Text("Feels like \(Int(item.apparentTemperature.value))\(item.apparentTemperature.unit.symbol)")
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
      }
      
      HStack {
        WeatherDataPill(
          icon: "wind",
          value: "\(Int(item.windSpeed.value)) \(item.windSpeed.unit.symbol)"
        )
        
        WeatherDataPill(
          icon: "humidity",
          value: "\(Int(item.humidity * 100))%"
        )
      }
    }
    .padding()
    .background {
      RoundedRectangle(cornerRadius: 25)
        .fill(.ultraThinMaterial)
        .shadow(color: .gray.opacity(0.3), radius: 6, y: 3)
    }
  }
  
  private var temperatureColor: Color {
    let temp = item.temperature.value
    switch temp {
    case ..<15: return .blue
    case 15..<25: return .green
    default: return .orange
    }
  }
}