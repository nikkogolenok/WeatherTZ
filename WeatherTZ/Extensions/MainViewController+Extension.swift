//
//  MainViewController+Extension.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 15.12.21.
//

import Foundation
import CoreLocation

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse || status == .authorizedAlways else { return }
        
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            networkWeaherManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: latitude, longitude: longitude))
            print("Широта \(latitude)")
            print("Долгота \(longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
