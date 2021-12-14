//
//  CurrentWeather.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 14.12.21.
//

import Foundation

struct CurrentWeather {
    let conditionCode: Int?
    //let coordinate
    let latitude: Int
    let longitude: Int
    let temperature: Double
    let textType: Int?
    let humidity: Int
    let precipitation: String?
    let pressure: Int
    let windSpeed: Double
    let windName: String?
    
    
    init(currentWeatherData: CurrentWeatherData) {
        conditionCode = currentWeatherData.current.weather.first?.id
        latitude = currentWeatherData.lat
        longitude = currentWeatherData.lon
        temperature = currentWeatherData.current.temp
        textType = currentWeatherData.current.weather.first?.id
        humidity = currentWeatherData.current.humidity
        precipitation = nil
        pressure = currentWeatherData.current.pressure
        windSpeed = currentWeatherData.current.windSpeed
        windName = nil
    }
}
