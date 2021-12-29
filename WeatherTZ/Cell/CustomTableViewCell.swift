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
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "clock")
        
        return image
    }()
    
    private let leadingView: UIView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let trailingView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        return view
    }()
    
    private let leadingStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.spacing = 2
        
        return stack
    }()
    
    private let trailingStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.spacing = 0
        
        return stack
    }()

    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "13:00"
        
        return label
    }()
    
    
    private let typeWeatherLabel: UILabel = {
        let label = UILabel()
        label.text = "Clear"
        
        return label
    }()
    
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "22"
        
        return label
    }()
        
    private let celsiusLabel: UILabel = {
        let label = UILabel()
        label.text = "°"
        
        return label
    }()
    
    
    // MARK: - View Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(temperatureImageView)
        contentView.addSubview(leadingView)
        contentView.addSubview(trailingView)
        contentView.addSubview(leadingStackView)
        contentView.addSubview(trailingStackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setTemperatureImageView()
        setLeadingView()
        setTrailingView()
        setLeadingStackView()
        setTrailingStackView()
    }
    
    // MARK: - Methods Creat constraint
    private func setTemperatureImageView() {
        temperatureImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        temperatureImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        temperatureImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -300).isActive = true
        temperatureImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setLeadingView() {
        leadingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        leadingView.leadingAnchor.constraint(equalTo: temperatureImageView.trailingAnchor, constant: 0).isActive = true
        leadingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50).isActive = true
        leadingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setTrailingView() {
        trailingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        trailingView.leadingAnchor.constraint(equalTo: leadingView.trailingAnchor, constant: 0).isActive = true
        trailingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        trailingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setLeadingStackView() {
        leadingStackView.topAnchor.constraint(equalTo: leadingView.topAnchor, constant: 0).isActive = true
        leadingStackView.leadingAnchor.constraint(equalTo: leadingView.leadingAnchor, constant: 0).isActive = true
        leadingStackView.trailingAnchor.constraint(equalTo: leadingView.trailingAnchor, constant: 0).isActive = true
        leadingStackView.bottomAnchor.constraint(equalTo: leadingView.bottomAnchor, constant: 0).isActive = true
        
        leadingStackView.addArrangedSubview(timeLabel)
        leadingStackView.addArrangedSubview(typeWeatherLabel)
    }
    
    private func setTrailingStackView() {
        trailingStackView.topAnchor.constraint(equalTo: trailingView.topAnchor, constant: 0).isActive = true
        trailingStackView.leadingAnchor.constraint(equalTo: trailingView.leadingAnchor, constant: 0).isActive = true
        trailingStackView.trailingAnchor.constraint(equalTo: trailingView.trailingAnchor, constant: 0).isActive = true
        trailingStackView.bottomAnchor.constraint(equalTo: trailingView.bottomAnchor, constant: 0).isActive = true
      
        trailingStackView.addArrangedSubview(temperatureLabel)
        trailingStackView.addArrangedSubview(celsiusLabel)
    }
    
    func updateUIInCell(_ weather: Hourly) {
        self.temperatureImageView.image = UIImage(systemName: String(weather.weather.first!.id.systemIconNameString))
        self.timeLabel.text = Date(timeIntervalSince1970: weather.dt).formatted("h:mm")
        self.typeWeatherLabel.text = String(weather.weather.first!.id.textNameString)
        self.temperatureLabel.text = weather.temp.wholeNumberString
    }
}
