//
//  CurrentWeatherData.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 14.12.21.
//

import Foundation

// MARK: - CurrentWeatherData
struct CurrentWeatherByCoordinate: Codable {
    let lat: Double
    let lon: Double
    let current: Current
    let minutely: [Minutely]
    let hourly: [Hourly]

    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case current
        case minutely
        case hourly
    }
}

// MARK: - Current
struct Current: Codable {
    let dt: Int
    let temp: Double
    let pressure: Int
    let humidity: Int
    let windSpeed: Double
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case pressure
        case humidity
        case windSpeed = "wind_speed"
        case weather
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int

    enum CodingKeys: String, CodingKey {
        case id
    }
}

// MARK: - Temp
struct Temp: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve, morn: Double
}

// MARK: - Minutely
struct Minutely: Codable {
    let dt: Int
    let precipitation: Int
}

// MARK: - Hourly
struct Hourly: Codable {
    let dt: Int
    let temp: Double

    enum CodingKeys: String, CodingKey {
        case dt
        case temp
    }
}
