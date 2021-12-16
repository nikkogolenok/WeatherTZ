//
//  NetworkWeatherManager.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 14.12.21.
//

import Foundation
import CoreLocation

class NetworkWeatherManager {
    
    class UrlParameters {
        static let city = "{city}"
        static let latitude = "{lat}"
        static let longitude = "{lon}"
    }
    
    class Urls {
        static let urlCity = "https://api.openweathermap.org/data/2.5/weather?q=\(UrlParameters.city)&apikey=\(apiKey)&units=metric"
        static let urlCoordinate = "https://api.openweathermap.org/data/2.5/onecall?lat=\(UrlParameters.latitude)&lon=\(UrlParameters.longitude)&appid=\(apiKey)&units=metric"
    }
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    
    static let shared = NetworkWeatherManager()
    
    private init() { }
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        switch requestType {
        case .cityName(let city):
            self.cityRequest(city: city)
        case .coordinate(let latitude, let longitude):
            self.coordinateRequest(latitude: latitude, longitude: longitude)
        }
    }
    
    private func parseJSONForCity(withData data: Data) -> CurrentWeatherDataByCity? {
        let decoder = JSONDecoder()
        
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherDataByCity.self, from: data)
            return currentWeatherData
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    private func cityRequest(city: String) {
        let cityUrlString = Urls.urlCity.replacingOccurrences(of: UrlParameters.city, with: city)
        guard let url = URL(string: cityUrlString) else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.parseJSONForCity(withData: data) {
                    self.coordinateRequest(latitude: currentWeather.coord.lat, longitude: currentWeather.coord.lon) { [weak self] in
                        guard var newWeather = $0 else { return }
                        newWeather.cityName = city
                        self?.onCompletion?(newWeather)
                    }
                }
            }
        }
        task.resume()
    }
    
    private func parseJSONForCoordinate(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        
        do {
            let currentWeatherCoordinate = try decoder.decode(CurrentWeatherByCoordinate.self, from: data)
            
            let currentWeather = CurrentWeather(currentWeatherData: currentWeatherCoordinate)
            return currentWeather
        }
        
        catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    private func coordinateRequest(latitude: Double, longitude: Double, onCompletion: ((CurrentWeather?) -> Void)? = nil) {
        let coordinateUrlString = Urls.urlCoordinate
            .replacingOccurrences(of: UrlParameters.latitude, with: String(latitude))
            .replacingOccurrences(of: UrlParameters.longitude, with: String(longitude))
        
        guard let url = URL(string: coordinateUrlString) else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let currentWeatherCoordinate = self.parseJSONForCoordinate(withData: data) else { return }
            
            if let onCompletion = onCompletion {
                onCompletion(currentWeatherCoordinate)
            }
            else {
                self.onCompletion?(currentWeatherCoordinate)
            }
        }
        task.resume()
    }
}
