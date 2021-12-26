//
//  SmallStackViewModel+Extensions.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 26.12.21.
//

import UIKit

extension SmallStackViewModel {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubviews(view)
        }
    }
}
