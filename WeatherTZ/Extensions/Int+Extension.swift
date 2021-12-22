//
//  Int+Extension.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 15.12.21.
//

import Foundation

extension Int {
    var systemIconNameString: String {
        switch self {
        case 200...232: return .boldSystemWeatherImage
        case 300...321: return .drizzleSystemWeatherImage
        case 500...531: return .rainSystemWeatherImage
        case 600...622: return .snowSystemWeatherImage
        case 701...781: return .smokeSystemWeatherImage
        case 800:       return .sunSystemWeatherImage
        case 801...804: return .cloudSystemWeatherImage
        default: return .defaultSystemWeatherImage
        }
    }
}

extension Optional where Wrapped == Int {
    var systemIconNameString: String {
        guard let number = self else { return .defaultSystemWeatherImage }
        
        return number.systemIconNameString
    }
}

extension Int {
    var textNameString: String {
        switch self {
        case 200...232: return .textThunderstorm
        case 300...321: return .textDrizzle
        case 500...531: return .textRain
        case 600...622: return .textSnow
        case 701...781: return .textAtmosphere
        case 800:       return .textClear
        case 801...804: return .textCloud
        default: return .textDefault
        }
    }
}

extension Optional where Wrapped == Int {
    var textNameString: String {
        guard let number = self else { return .textDefault }
        
        return number.textNameString
    }
}
