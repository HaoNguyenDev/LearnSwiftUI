//
//  WeatherListView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/9/25.
//


import SwiftUI
import WeatherKit
import CoreLocation

struct WeatherListView: View {
    @Environment(WeatherServiceWrapper.self) var weatherService
    @State private var viewState: ViewState = .loading
    
    enum ViewState {
        case loading
        case success([WeatherItem])
        case failure(Error)
    }
    
    var body: some View {
        ZStack {
            GradientBackgroundAnimation()
    
            switch viewState {
            case .loading:
                LoadingView()
            case .success(let items):
                WeatherListSuccessView(items: items)
            case .failure(let error):
                ErrorView(message: error.localizedDescription)
            }
        }
        .task {
            do {
                let items = try await weatherService.mockWeatherList()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    viewState = .success(items)
                })
            } catch {
                viewState = .failure(error)
            }
        }
    }
}

#Preview {
    NavigationStack {
        WeatherListView()
            .navigationTitle("Weather")
            .environment(WeatherServiceWrapper())
    }
}
