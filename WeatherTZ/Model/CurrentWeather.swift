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
//    let dailyWeather: [Daily]
    
    
    init(currentWeatherData: CurrentWeatherByCoordinate) {
        conditionCode = currentWeatherData.current.weather.first?.id
        cityName = nil
        coordinate = Coord(lon: Double(currentWeatherData.lon), lat: Double(currentWeatherData.lat))
        temperature = currentWeatherData.current.temp
        
//        let daily = currentWeatherData.daily.first {
//            let date = Date(timeIntervalSince1970: $0.dt)
//
//            return Calendar.current.isDateInToday(date)
//        }
        
        humidity = currentWeatherData.current.humidity
        precipitation = nil
        pressure = currentWeatherData.current.pressure
        windSpeed = currentWeatherData.current.windSpeed
        windName = nil
        textTypeWeather = currentWeatherData.current.weather.first?.id
//        dailyWeather = currentWeatherData.daily
    }
}
