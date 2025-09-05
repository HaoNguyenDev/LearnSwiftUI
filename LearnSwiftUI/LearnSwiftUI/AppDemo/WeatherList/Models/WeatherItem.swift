//
//  WeatherItem.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/9/25.
//
import SwiftUI
import CoreLocation

struct WeatherItem: Identifiable {
    var id: UUID
    var cityName: String
    var symbolName: String
    var description: String
    var temperature: Measurement<UnitTemperature>
    var apparentTemperature: Measurement<UnitTemperature>
    var windSpeed: Measurement<UnitSpeed>
    var humidity: Double
}

struct City {
    let name: String
    let location: CLLocation
}
