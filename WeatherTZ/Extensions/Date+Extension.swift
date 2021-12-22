//
//  Date+Extension.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 21.12.21.
//

import Foundation

extension Date {
    init(timeIntervalSince1970 time: Int) {
        let timeInterval = Double(time)
        self.init(timeIntervalSince1970: timeInterval)
    }
    
    func formatted(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
}
