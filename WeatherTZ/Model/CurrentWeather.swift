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
    let coordinate: Coord
    let temperature: Double
    let humidity: Int
    let precipitation: String?
    let pressure: Int
    let windSpeed: Double
    let windName: String?
    let textTypeWeather: Int?
    let weatherDataHourly: [WeatherDataHourly]
    
    init(currentWeatherData: CurrentWeatherByCoordinate) {
        conditionCode = currentWeatherData.current.weather.first?.id
        cityName = nil
        coordinate = Coord(lon: Double(currentWeatherData.lon), lat: Double(currentWeatherData.lat))
        temperature = currentWeatherData.current.temp
        humidity = currentWeatherData.current.humidity
        precipitation = nil
        pressure = currentWeatherData.current.pressure
        windSpeed = currentWeatherData.current.windSpeed
        windName = nil
        textTypeWeather = currentWeatherData.current.weather.first?.id
        
        var slovar = [Date: [Hourly]]()
        currentWeatherData.hourly.forEach {
            let day = Calendar.current.startOfDay(for: Date(timeIntervalSince1970: $0.dt))
            slovar[day, default: []].append($0)
        }
        
        self.weatherDataHourly = slovar.map {
            WeatherDataHourly(date: $0.key, hourly: $0.value)
        }
    }
}

struct WeatherDataHourly {
    let date: Date
    let hourly: [Hourly]
}
