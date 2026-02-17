//
//  LocationManager.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/9/25.
//


// Simple example using Locale (no special permissions required):
import Foundation
func getCurrentCountryCode() -> String {
    return Locale.current.region?.identifier ?? "US" // Fallback to US
}

// If using location
import CoreLocation
class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    private let manager = CLLocationManager()
    var countryCode: String = "US"
    
    private override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                self.countryCode = placemark.isoCountryCode ?? "US"
            }
        }
    }
}
