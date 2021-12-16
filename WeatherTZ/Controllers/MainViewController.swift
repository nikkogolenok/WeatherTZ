//
//  MainController.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 13.12.21.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    // MARK: - Variables
    var networkWeaherManager = NetworkWeatherManager.shared
    let locationManager = CLLocationManager()
    
    // MARK: - GUI Variables
    var imageView: UIImageView = UIImageView()
    var cityNameLabel: UILabel = UILabel()
    var temperatureLabel: UILabel = UILabel()
    var typeOfWeatherLabel: UILabel = UILabel()
    var humidityImageView: UIImageView = UIImageView()
    var humidityLabel: UILabel = UILabel()
    var dropImageView: UIImageView = UIImageView()
    var dropLabel: UILabel = UILabel()
    var pressureImageView: UIImageView = UIImageView()
    var pressureLabel: UILabel = UILabel()
    var windImageView: UIImageView = UIImageView()
    var windLabel: UILabel = UILabel()
    var typeWindImageView: UIImageView = UIImageView()
    var typeWindLabel: UILabel = UILabel()
    var button: UIButton = UIButton()
    var toolBar: UIToolbar = UIToolbar()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.autolayoutImageView()
        self.autolayoutCityNameLabel()
        self.autolayoutTemperatureLabel()
        self.autolayoutTypeOfWeatherLabel()
        self.autolayoutHumidityImageView()
        self.autolayoutHumidityLabel()
        self.autolayoutDropImageView()
        self.autolayoutDropLabel()
        self.autolayoutPressureImageView()
        self.autolayoutPressureLabel()
        self.autolayoutWindImageView()
        self.autolayoutWindLabel()
        self.autolayoutTypeWindImageView()
        self.autolayoutTypeWindLabel()
        self.autolayoutButton()
        self.autolayoutToolBar()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestAlwaysAuthorization()
        
        let status = locationManager.authorizationStatus
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.requestLocation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        networkWeaherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.updateInterfaceWith(weather: currentWeather)
                
                print("Temp \(currentWeather.temperature)")
                print("Pressure \(currentWeather.pressure)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func autolayoutImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 143).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -143).isActive = true
        imageView.image = UIImage(systemName: "trash")
    }
    
    private func autolayoutCityNameLabel() {
        view.addSubview(cityNameLabel)
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cityNameLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 30).isActive = true
        cityNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 143).isActive = true
        cityNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -143).isActive = true
        
        cityNameLabel.text = "London"
        cityNameLabel.textAlignment = .center
    }
    
    private func autolayoutTemperatureLabel() {
        view.addSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        temperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.topAnchor, constant: 30).isActive = true
        temperatureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        
        temperatureLabel.text = "22"
        temperatureLabel.textAlignment = .center
    }
    
    private func autolayoutTypeOfWeatherLabel() {
        view.addSubview(typeOfWeatherLabel)
        typeOfWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        
        typeOfWeatherLabel.topAnchor.constraint(equalTo: cityNameLabel.topAnchor, constant: 30).isActive = true
        typeOfWeatherLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        
        typeOfWeatherLabel.text = "Sunny"
        temperatureLabel.textAlignment = .center
    }
    
    private func autolayoutHumidityImageView() {
        view.addSubview(humidityImageView)
        humidityImageView.translatesAutoresizingMaskIntoConstraints = false
        
        humidityImageView.topAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: 150).isActive = true
        humidityImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        humidityImageView.image = UIImage(systemName: "humidity")
    }
    
    private func autolayoutHumidityLabel() {
        view.addSubview(humidityLabel)
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        humidityLabel.topAnchor.constraint(equalTo: humidityImageView.topAnchor, constant: 30).isActive = true
        humidityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        
        humidityLabel.text = "57%"
        humidityLabel.textAlignment = .center
    }
    
    private func autolayoutDropImageView() {
        view.addSubview(dropImageView)
        dropImageView.translatesAutoresizingMaskIntoConstraints = false
        
        dropImageView.topAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: 150).isActive = true
        dropImageView.leadingAnchor.constraint(equalTo: humidityImageView.leadingAnchor, constant: 130).isActive = true
        dropImageView.image = UIImage(systemName: "drop")
    }
    
    private func autolayoutDropLabel() {
        view.addSubview(dropLabel)
        dropLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dropLabel.topAnchor.constraint(equalTo: dropImageView.topAnchor, constant: 30).isActive = true
        dropLabel.leadingAnchor.constraint(equalTo: humidityLabel.leadingAnchor, constant: 110).isActive = true
        
        dropLabel.text = "1.0mm"
        dropLabel.textAlignment = .center
    }
    
    private func autolayoutPressureImageView() {
        view.addSubview(pressureImageView)
        pressureImageView.translatesAutoresizingMaskIntoConstraints = false
        
        pressureImageView.topAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: 150).isActive = true
        pressureImageView.leadingAnchor.constraint(equalTo: dropImageView.leadingAnchor, constant: 130).isActive = true
        pressureImageView.image = UIImage(systemName: "thermometer")
    }
    
    private func autolayoutPressureLabel() {
        view.addSubview(pressureLabel)
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        pressureLabel.topAnchor.constraint(equalTo: pressureImageView.topAnchor, constant: 30).isActive = true
        pressureLabel.leadingAnchor.constraint(equalTo: dropLabel.leadingAnchor, constant: 115).isActive = true
        
        pressureLabel.text = "1019hPa"
        pressureLabel.textAlignment = .center
    }
    
    private func autolayoutWindImageView() {
        view.addSubview(windImageView)
        windImageView.translatesAutoresizingMaskIntoConstraints = false

        windImageView.topAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: 250).isActive = true
        windImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 110).isActive = true
        windImageView.image = UIImage(systemName: "wind")
    }
    
    private func autolayoutWindLabel() {
        view.addSubview(windLabel)
        windLabel.translatesAutoresizingMaskIntoConstraints = false
        
        windLabel.topAnchor.constraint(equalTo: windImageView.topAnchor, constant: 30).isActive = true
        windLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100).isActive = true
        
        windLabel.text = "20 km/h"
        windLabel.textAlignment = .center
    }
    
    private func autolayoutTypeWindImageView() {
        view.addSubview(typeWindImageView)
        typeWindImageView.translatesAutoresizingMaskIntoConstraints = false
        
        typeWindImageView.topAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: 250).isActive = true
        typeWindImageView.leadingAnchor.constraint(equalTo: windImageView.leadingAnchor, constant: 130).isActive = true
        typeWindImageView.image = UIImage(systemName: "pencil")
    }
    
    private func autolayoutTypeWindLabel() {
        view.addSubview(typeWindLabel)
        typeWindLabel.translatesAutoresizingMaskIntoConstraints = false

        typeWindLabel.topAnchor.constraint(equalTo: typeWindImageView.topAnchor, constant: 30).isActive = true
        typeWindLabel.leadingAnchor.constraint(equalTo: windLabel.leadingAnchor, constant: 135).isActive = true

        typeWindLabel.text = "SE"
        typeWindLabel.textAlignment = .center
    }
    
    private func autolayoutButton() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.topAnchor.constraint(equalTo: typeWindLabel.topAnchor, constant: 100).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 143).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -143).isActive = true
        
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.red, for: .normal)
    }
    
    private func autolayoutToolBar() {
        view.addSubview(toolBar)
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        toolBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    private func updateInterfaceWith(weather: CurrentWeather) {
        self.imageView.image = UIImage(systemName: weather.conditionCode.systemIconNameString)
        self.temperatureLabel.text = String(weather.temperature)
        self.humidityLabel.text = String(weather.humidity)
        self.pressureLabel.text = String(weather.pressure)
        self.windLabel.text = String(weather.windSpeed)
    }
}
