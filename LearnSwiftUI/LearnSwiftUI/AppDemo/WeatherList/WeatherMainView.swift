//
//  WeatherListView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/9/25.
//

import SwiftUI

enum WeatherError: Error {
    case networkError(Error)
    case decodingError(Error)
    case invalidResponse(String)
    case unknown
}

enum WeatherListState {
    case loading
    case success([WeatherItem])
    case failure(Error)
}

@Observable
@MainActor
class WeatherListViewModel {
    var weatherService: WeatherServiceWrapper
    var viewState: WeatherListState = .loading
    
    init(weatherService: WeatherServiceWrapper) {
        self.weatherService = weatherService
    }
    
    func fetchWeather() async {
        viewState = .loading
        do {
            let items = try await weatherService.mockWeatherList()
            viewState = .success(items)
        } catch {
            viewState = .failure(error)
        }
    }
}

struct WeatherMainView: View {
    @State private var vm: WeatherListViewModel
    
    init(vm: WeatherListViewModel) {
        self._vm = State(initialValue: vm)
    }
    
    var body: some View {
        WeatherListRenderingView(viewState: vm.viewState)
            .refreshable {
                await fetchWeather()
            }
            .task {
                await fetchWeather()
            }
    }
    
    private func fetchWeather() async {
        await vm.fetchWeather()
    }
}

struct WeatherListRenderingView: View {
    var viewState: WeatherListState
    
    var body: some View {
        ZStack {
            GradientBackgroundAnimation()
        
            switch viewState {
            case .loading:
                WeatherLoadingView()
            case .success(let items):
                WeatherListView(items: items)
            case .failure(let error):
                WeatherErrorView(error: error)
            }
            
        }
    }
}

#Preview {
    NavigationStack {
        WeatherMainView(vm: WeatherListViewModel(weatherService: WeatherServiceWrapper()))
            .navigationTitle("Weather")
    }
}
