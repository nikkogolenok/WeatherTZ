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
