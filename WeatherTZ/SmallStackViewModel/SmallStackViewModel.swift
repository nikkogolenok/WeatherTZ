//
//  SmallStackViewModel.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 26.12.21.
//

import UIKit

enum ImageType: String {
    case humidity = "humidity"
    case drop = "drop"
    case thermometer = "thermometer"
    case wind = "wind"
    case safari = "safari"
}

class SmallStackViewModel {
    var imageName: String
    var textValue: String
    
    init(imageName: String, textValue: String) {
        self.imageName = imageName
        self.textValue = textValue
    }
    
    static func getStackViewDetails(for type: ImageType) -> SmallStackViewModel {
        return SmallStackViewModel(imageName: type.rawValue, textValue: type.rawValue)
    }
}
