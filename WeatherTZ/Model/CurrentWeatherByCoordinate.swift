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
    //let hourly: [Current]
    //let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case current
        case minutely
        //case hourly
        //case daily
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

// MARK: - Daily
struct Daily: Codable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case weather
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




//struct CurrentWeatherByCoordinate: Codable {
//    let lat: Double
//    let lon: Double
//    let timezone: String
//    let timezoneOffset: Int
//    let current: Current
//    let minutely: [Minutely]
//    //let hourly: [Current]
//    //let hourly: [Hourly]
//    //let daily: [Daily]
//
//    enum CodingKeys: String, CodingKey {
//        case lat
//        case lon
//        case timezone
//        case timezoneOffset = "timezone_offset"
//        case current
//        case minutely
//        //case daily
//        //case hourly
//    }
//}
//
//// MARK: - Current
//struct Current: Codable {
//    let dt: Int
//    let sunrise, sunset: Int?
//    let temp, feelsLike: Double
//    let pressure, humidity: Int
//    let dewPoint, uvi: Double
//    let clouds, visibility: Int
//    let windSpeed: Double
//    let windDeg: Int
//    let windGust: Double
//    let weather: [Weather]
//    let pop: Double?
//    let snow, rain: Rain?
//
//    enum CodingKeys: String, CodingKey {
//        case dt, sunrise, sunset, temp
//        case feelsLike = "feels_like"
//        case pressure, humidity
//        case dewPoint = "dew_point"
//        case uvi, clouds, visibility
//        case windSpeed = "wind_speed"
//        case windDeg = "wind_deg"
//        case windGust = "wind_gust"
//        case weather, pop, snow, rain
//    }
//}
//
//// MARK: - Rain
//struct Rain: Codable {
//    let the1H: Double
//
//    enum CodingKeys: String, CodingKey {
//        case the1H = "1h"
//    }
//}
//
//// MARK: - Weather
//struct Weather: Codable {
//    let id: Int
//    let main: Main
//    let weatherDescription: Description
//    let icon: Icon
//
//    enum CodingKeys: String, CodingKey {
//        case id, main
//        case weatherDescription = "description"
//        case icon
//    }
//}
//
//enum Icon: String, Codable {
//    case the04D = "04d"
//    case the04N = "04n"
//    case the10D = "10d"
//    case the10N = "10n"
//    case the13D = "13d"
//    case the13N = "13n"
//}
//
//enum Main: String, Codable {
//    case clouds = "Clouds"
//    case rain = "Rain"
//    case snow = "Snow"
//}
//
//enum Description: String, Codable {
//    case brokenClouds = "broken clouds"
//    case lightRain = "light rain"
//    case lightSnow = "light snow"
//    case overcastClouds = "overcast clouds"
//    case rainAndSnow = "rain and snow"
//    case snow = "snow"
//}
//
//// MARK: - Daily
//struct Daily: Codable {
//    let dt: Int
//    //let sunrise: Int
//    //let sunset: Int
//    //let moonrise: Int
//    //let moonset: Int
//    //let moonPhase: Double
//    let temp: Temp
//    //let feelsLike: FeelsLike
//    //let pressure, humidity: Int
//    //let dewPoint, windSpeed: Double
//    //let windDeg: Int
//    //let windGust: Double
//    //let weather: [Weather]
//    //let clouds: Int
//    //let pop, uvi: Double
//    //let rain, snow: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case dt
//        //case sunrise
//        //case sunset
//        //case moonrise
//        //case moonset
//        //case moonPhase = "moon_phase"
//        case temp
//        //case feelsLike = "feels_like"
//        //case pressure, humidity
//        //case dewPoint = "dew_point"
//        //case windSpeed = "wind_speed"
//        //case windDeg = "wind_deg"
//        //case windGust = "wind_gust"
//        //case weather
//        //case clouds
//        //case pop
//        //case uvi
//        //case rain
//        //case snow
//    }
//}
//
//// MARK: - FeelsLike
//struct FeelsLike: Codable {
//    let day: Double
//    let night: Double
//    let eve: Double
//    let morn: Double
//}
//
//// MARK: - Temp
//struct Temp: Codable {
//    let day: Double
//    let min: Double
//    let max: Double
//    let night: Double
//    let eve, morn: Double
//}
//
//// MARK: - Minutely
//struct Minutely: Codable {
//    let dt: Int
//    let precipitation: Int
//}
//
//// MARK: - Hourly
//struct Hourly: Codable {
//    let dt: Int
//    let temp: Double
//
//    enum CodingKeys: String, CodingKey {
//        case dt
//        case temp
//    }
//}
