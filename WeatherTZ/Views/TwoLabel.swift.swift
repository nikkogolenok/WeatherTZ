//
//  TwoLabel.swift.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 4.01.22.
//

import UIKit

class TwoLabel: UILabel {
    
    // MARK: - GUI Variables
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 17)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - View Life Cycle
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(label)
    }
}
