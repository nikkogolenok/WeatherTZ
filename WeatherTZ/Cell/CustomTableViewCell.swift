//
//  CostomTableViewCell.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 20.12.21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    var networkWeaherManager = NetworkWeatherManager.shared
    static let identifier = "CustomTableViewCell"
    
    // MARK: - GUI Variables
    private let temperatureImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "clock")
        
        return image
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        
        return label
    }()
    
    private let typeTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.text = "Clear"
        
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.text = "22"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(temperatureImageView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(typeTemperatureLabel)
        contentView.addSubview(temperatureLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        temperatureImageView.frame = CGRect(x: 5, y: 5, width: 50, height: contentView.frame.size.height - 10)
        timeLabel.frame = CGRect(x: 10 + temperatureImageView.frame.size.width, y: -1, width: contentView.frame.size.width - 10, height: contentView.frame.size.height)
        typeTemperatureLabel.frame = CGRect(x: 10 + temperatureImageView.frame.size.width, y: 12, width: contentView.frame.width - 10, height: contentView.frame.height)
        temperatureLabel.frame = CGRect(x: 150 + temperatureImageView.frame.size.width, y: 0, width: contentView.frame.size.width - 10, height: contentView.frame.height)
    }
    
    func setUpView(_ weather: Hourly) {
        self.temperatureLabel.text = weather.temp.wholeNumberString
        self.timeLabel.text = Date(timeIntervalSince1970: weather.dt).formatted("h:mm")
    }
}
