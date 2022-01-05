//
//  NetworkWeatherManager.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 14.12.21.
//

import Foundation
import CoreLocation

class NetworkWeatherManager {
    
    var currentWeather: CurrentWeather?
    
    class UrlParameters {
        static let latitude = "{lat}"
        static let longitude = "{lon}"
    }
    
    class Urls {
        static let urlCoordinate = "https://api.openweathermap.org/data/2.5/onecall?lat=\(UrlParameters.latitude)&lon=\(UrlParameters.longitude)&appid=\(apiKey)&units=metric"
    }
    
    enum RequestType {
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    
    static let shared = NetworkWeatherManager()
    
    private init() { }
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        switch requestType {
        case .coordinate(let latitude, let longitude):
            self.coordinateRequest(latitude: latitude, longitude: longitude)
        }
    }
        
    private func parseJSONForCoordinate(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        
        do {
            let currentWeatherCoordinate = try decoder.decode(CurrentWeatherByCoordinate.self, from: data)
            
            let currentWeather = CurrentWeather(currentWeatherData: currentWeatherCoordinate)
            return currentWeather
        }
        
        catch let error as NSError {
            print(error.localizedDescription, "Error in parseJSONForCoordinate")
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
                self.currentWeather = currentWeatherCoordinate
                self.onCompletion?(currentWeatherCoordinate)
            }
        }
        task.resume()
    }
}
