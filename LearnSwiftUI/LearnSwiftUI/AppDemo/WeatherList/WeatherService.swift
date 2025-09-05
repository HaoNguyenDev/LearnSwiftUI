//
//  WeatherService.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/9/25.
//

import WeatherKit
import CoreLocation

@Observable
public class WeatherServiceWrapper {
    func fetchWeatherList() async throws -> [WeatherItem] {
        var items: [WeatherItem] = []
        let weatherService = WeatherService.shared
        
        let cities = [
            City(name: "Hochiminh", location: CLLocation(latitude: 10.7769, longitude: 106.7009)),
            City(name: "Ha Noi", location: CLLocation(latitude: 21.0285, longitude: 105.8542)),
            City(name: "Quy Nhon", location: CLLocation(latitude: 13.7820, longitude: 109.2197)),
            City(name: "Nha Trang", location: CLLocation(latitude: 12.2388, longitude: 109.1967))
        ]
        
        for city in cities {
            let weather = try await weatherService.weather(for: city.location)
            let currentWeather = weather.currentWeather
            let item = WeatherItem(
                id: UUID(),
                cityName: city.name,
                symbolName: currentWeather.symbolName,
                description: currentWeather.condition.description,
                temperature: currentWeather.temperature,
                apparentTemperature: currentWeather.apparentTemperature,
                windSpeed: currentWeather.wind.speed,
                humidity: currentWeather.humidity
            )
            
            items.append(item)
        }
        
        return items
    }
    
}

extension WeatherServiceWrapper {
    func mockWeatherList() async throws -> [WeatherItem] {
        let items: [WeatherItem] = [
            // Ho Chi Minh
            WeatherItem(
                id: UUID(),
                cityName: "Hồ Chí Minh",
                symbolName: "sun.max.fill",
                description: "Nắng",
                temperature: Measurement(value: 32, unit: .celsius),
                apparentTemperature: Measurement(value: 34, unit: .celsius),
                windSpeed: Measurement(value: 10, unit: .kilometersPerHour),
                humidity: 0.7
            ),
            // Ha Noi
            WeatherItem(
                id: UUID(),
                cityName: "Hà Nội",
                symbolName: "cloud.fill",
                description: "Nhiều mây",
                temperature: Measurement(value: 28, unit: .celsius),
                apparentTemperature: Measurement(value: 29, unit: .celsius),
                windSpeed: Measurement(value: 15, unit: .kilometersPerHour),
                humidity: 0.8
            ),
            // Da Nang
            WeatherItem(
                id: UUID(),
                cityName: "Đà Nẵng",
                symbolName: "cloud.rain.fill",
                description: "Mưa",
                temperature: Measurement(value: 26, unit: .celsius),
                apparentTemperature: Measurement(value: 27, unit: .celsius),
                windSpeed: Measurement(value: 20, unit: .kilometersPerHour),
                humidity: 0.9
            ),
            // Can Tho
            WeatherItem(
                id: UUID(),
                cityName: "Cần Thơ",
                symbolName: "sun.max.fill",
                description: "Nắng",
                temperature: Measurement(value: 31, unit: .celsius),
                apparentTemperature: Measurement(value: 33, unit: .celsius),
                windSpeed: Measurement(value: 12, unit: .kilometersPerHour),
                humidity: 0.75
            ),
            // Hai Phong
            WeatherItem(
                id: UUID(),
                cityName: "Hải Phòng",
                symbolName: "cloud.bolt.fill",
                description: "Mưa bão",
                temperature: Measurement(value: 27, unit: .celsius),
                apparentTemperature: Measurement(value: 28, unit: .celsius),
                windSpeed: Measurement(value: 25, unit: .kilometersPerHour),
                humidity: 0.85
            ),
            // Hue
            WeatherItem(
                id: UUID(),
                cityName: "Huế",
                symbolName: "cloud.sun.fill",
                description: "Mây rải rác",
                temperature: Measurement(value: 29, unit: .celsius),
                apparentTemperature: Measurement(value: 30, unit: .celsius),
                windSpeed: Measurement(value: 14, unit: .kilometersPerHour),
                humidity: 0.8
            ),
            // Da Lat
            WeatherItem(
                id: UUID(),
                cityName: "Đà Lạt",
                symbolName: "cloud.fog.fill",
                description: "Sương mù",
                temperature: Measurement(value: 20, unit: .celsius),
                apparentTemperature: Measurement(value: 21, unit: .celsius),
                windSpeed: Measurement(value: 8, unit: .kilometersPerHour),
                humidity: 0.95
            ),
            // Phu Quoc
            WeatherItem(
                id: UUID(),
                cityName: "Phú Quốc",
                symbolName: "tropicalstorm.fill",
                description: "Bão nhiệt đới",
                temperature: Measurement(value: 25, unit: .celsius),
                apparentTemperature: Measurement(value: 26, unit: .celsius),
                windSpeed: Measurement(value: 30, unit: .kilometersPerHour),
                humidity: 0.9
            ),
            // Nha Trang
            WeatherItem(
                id: UUID(),
                cityName: "Nha Trang",
                symbolName: "cloud.sun.fill",
                description: "Mây rải rác",
                temperature: Measurement(value: 30, unit: .celsius),
                apparentTemperature: Measurement(value: 32, unit: .celsius),
                windSpeed: Measurement(value: 8, unit: .kilometersPerHour),
                humidity: 0.75
            )
        ]
        try await Task.sleep(for: .seconds(2))
        return items
    }
}
