//
//  WeatherListView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 5/9/25.
//


import SwiftUI
import WeatherKit
import CoreLocation

@Observable
@MainActor
class WeatherListMVVMViewModel {
    
    var viewState = WeatherRenderingMVVMVView.ViewState.loading
    let weatherService: WeatherServiceWrapper
    
    init (weatherService: WeatherServiceWrapper) {
        self.weatherService = weatherService
    }
    
    func fetchWeather() async {
        do {
            let items = try await weatherService.mockWeatherList()
            viewState = .success(items)
        } catch {
            viewState = .failure(error)
        }
    }
    
}

struct WeatherListMVVMVView: View {
    @State var vm: WeatherListMVVMViewModel
   
    var body: some View {
        WeatherRenderingMVVMVView(viewState: vm.viewState)
            .task {
                await vm.fetchWeather()
            }
    }
}
struct WeatherRenderingMVVMVView: View {
    var viewState: ViewState
    
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
    }
}

#Preview {
    let vm = WeatherListMVVMViewModel(weatherService: WeatherServiceWrapper())
    NavigationStack {
        WeatherListMVVMVView(vm: vm)
            .navigationTitle("Weather")
    }
    .environment(WeatherServiceWrapper())
}
