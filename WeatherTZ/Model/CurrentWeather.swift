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
    let textType: Int?
    let humidity: Int
    let precipitation: String?
    let pressure: Int
    let windSpeed: Double
    let windName: String?
    
    
    init(currentWeatherData: CurrentWeatherByCoordinate) {
        conditionCode = currentWeatherData.current.weather.first?.id
        cityName = nil
        coordinate = Coord(lon: Double(currentWeatherData.lon), lat: Double(currentWeatherData.lat))
        temperature = currentWeatherData.current.temp
        textType = currentWeatherData.current.weather.first?.id
        humidity = currentWeatherData.current.humidity
        precipitation = nil
        pressure = currentWeatherData.current.pressure
        windSpeed = currentWeatherData.current.windSpeed
        windName = nil
    }
}
