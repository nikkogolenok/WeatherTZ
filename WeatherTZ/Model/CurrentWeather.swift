//
//  CurrentWeather.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 14.12.21.
//

import Foundation

struct CurrentWeather {
    let conditionCode: Int?
    var cityName: String?
    let temperature: Double
    let humidity: Int
    let precipitation: String?
    let pressure: Int
    let windSpeed: Double
    let windGust: Double
    let pop: Int?
    let textTypeWeather: Int?
    let weatherDataHourly: [WeatherDataHourly]
    
    init(currentWeatherData: CurrentWeatherByCoordinate) {
        conditionCode = currentWeatherData.current.weather.first?.id
        cityName = nil
        temperature = currentWeatherData.current.temp
        humidity = currentWeatherData.current.humidity
        precipitation = nil
        pressure = currentWeatherData.current.pressure
        windSpeed = currentWeatherData.current.windSpeed
        windGust = currentWeatherData.current.windGust
        pop = currentWeatherData.current.pop
        textTypeWeather = currentWeatherData.current.weather.first?.id
        
        var weatherDataDictionary = [Date: [Hourly]]()
        currentWeatherData.hourly.forEach {
            let date = Date(timeIntervalSince1970: $0.dt)
            let hour = Calendar.current.component(.hour, from: date)
            guard hour % 3 == 0 else { return }
            let day = Calendar.current.startOfDay(for: date)
            weatherDataDictionary[day, default: []].append($0)
        }
        
        self.weatherDataHourly = weatherDataDictionary.map {
            WeatherDataHourly(date: $0.key, hourly: $0.value)
        }
    }
    
    func getDataWeather() -> [String] {
        return ["Temperature: \(String(temperature)),temperature type: \(String(textTypeWeather.textNameString)),humidity: \(String(humidity)),precipitation: \(String(pop ?? 0)),pressure: \(String(pressure)),wind speed: \(String(windSpeed)),wind gust: \(String(windGust))!"]
    }
}

struct WeatherDataHourly {
    let date: Date
    let hourly: [Hourly]
}

