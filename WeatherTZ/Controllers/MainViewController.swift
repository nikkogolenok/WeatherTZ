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
    
    // MARK: - TODO
    let weather = CurrentWeather?.self
    
    // MARK: - GUI Variables
    let mainStackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let imageAndTextFieldStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 2
        
        return stack
    }()
    
    let twoLabelStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 2
        
        return stack
    }()
    
    let lineViewTop: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        
        return view
    }()
    
    let viewContener: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let lineViewBottom: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        
        return view
    }()
    
    let buttonShare: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.red, for: .normal)
        //button.addTarget(self, action: #selector(tapToButton), for: .touchUpInside)
        
        return button
    }()
    
    let stackViewTop: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 70
        
        return stack
    }()
    
    let stackViewBottom: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 70
        
        return stack
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Today"
    
        setMainStackView()
        setImageAndTextFieldStackView()
        setTwoLabelStackView()
        setLineViewTop()
        setViewContener()
        setLineViewBottom()
        setButton()
        setStackViewTop()
        setStackViewBottom()
        // MARK -
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
            //guard let self = self else { return }
            
            DispatchQueue.main.async {
                print("Image weather \(currentWeather.conditionCode?.systemIconNameString)")
                print("Temp \(currentWeather.temperature)")
                print("Type weather \(currentWeather.textTypeWeather.textNameString)")
                print("Humidity \(currentWeather.humidity)")
                print("Pressure \(currentWeather.pressure)")
                print("WindSpeed \(currentWeather.windSpeed)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setMainStackView()  {
        view.addSubview(mainStackView)
        mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -400).isActive = true
    }
    
    func setImageAndTextFieldStackView() {
        mainStackView.addSubview(imageAndTextFieldStackView)
        imageAndTextFieldStackView.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 0).isActive = true
        imageAndTextFieldStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 70).isActive = true
        imageAndTextFieldStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -70).isActive = true
        imageAndTextFieldStackView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: -50).isActive = true
        
        let weatherImageView: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(systemName: "clock")
            
            return image
        }()
        
        let cityNametextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Enter city, please"
            textField.textAlignment = .center
        
            return textField
        }()
        
        imageAndTextFieldStackView.addArrangedSubview(weatherImageView)
        imageAndTextFieldStackView.addArrangedSubview(cityNametextField)
    }
    
    func setTwoLabelStackView() {
        mainStackView.addSubview(twoLabelStackView)
        twoLabelStackView.topAnchor.constraint(equalTo: imageAndTextFieldStackView.bottomAnchor, constant: 0).isActive = true
        twoLabelStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 0).isActive = true
        twoLabelStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 0).isActive = true
        twoLabelStackView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 0).isActive = true
        
        let temperatureLabel: UILabel = {
            let label = UILabel()
            label.text = "22°C"
            label.textAlignment = .center
            
            return label
        }()
        
        let typeWeatherLabel: UILabel = {
            let label = UILabel()
            label.text = "Sunny"
            label.textAlignment = .center
            
            return label
        }()
        
        twoLabelStackView.addArrangedSubview(temperatureLabel)
        twoLabelStackView.addArrangedSubview(typeWeatherLabel)
        
        networkWeaherManager.onCompletion = { [weak self] currentWeather in
            //guard let self = self else { return }
            
            DispatchQueue.main.async {
                func update(weather: CurrentWeather) {
                    temperatureLabel.text = String(weather.temperature.wholeNumberString)
                    //typeWeatherLabel.text = weather.textTypeWeather.textNameString
                }
            }
        }
    }
    
    func setLineViewTop() {
        view.addSubview(lineViewTop)
        lineViewTop.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 20).isActive = true
        lineViewTop.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100).isActive = true
        lineViewTop.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100).isActive = true
        lineViewTop.heightAnchor.constraint(equalToConstant: view.frame.size.height - 810).isActive = true
    }
    
    func setViewContener() {
        view.addSubview(viewContener)
        viewContener.topAnchor.constraint(equalTo: lineViewTop.bottomAnchor, constant: 20).isActive = true
        viewContener.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        viewContener.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        viewContener.heightAnchor.constraint(equalToConstant: view.frame.size.height - 600).isActive = true
    }
    
    func setLineViewBottom() {
        view.addSubview(lineViewBottom)
        lineViewBottom.topAnchor.constraint(equalTo: viewContener.bottomAnchor, constant: 20).isActive = true
        lineViewBottom.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100).isActive = true
        lineViewBottom.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100).isActive = true
        lineViewBottom.heightAnchor.constraint(equalToConstant: view.frame.size.height - 810).isActive = true
    }
    
    func setButton() {
        view.addSubview(buttonShare)
        buttonShare.topAnchor.constraint(equalTo: lineViewBottom.bottomAnchor, constant: 40).isActive = true
        buttonShare.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 150).isActive = true
        buttonShare.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -150).isActive = true
    }
    
    func setStackViewTop() {
        viewContener.addSubview(stackViewTop)
        stackViewTop.topAnchor.constraint(equalTo: viewContener.topAnchor, constant: 0).isActive = true
        stackViewTop.leadingAnchor.constraint(equalTo: viewContener.leadingAnchor, constant: 0).isActive = true
        stackViewTop.trailingAnchor.constraint(equalTo: viewContener.trailingAnchor, constant: 0).isActive = true
        stackViewTop.bottomAnchor.constraint(equalTo: viewContener.bottomAnchor, constant: -90).isActive = true
        
        let humidityStackView: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.distribution = .fillEqually
            stack.spacing = 2
            
            let humidityImageView: UIImageView = {
                let image = UIImageView()
                image.image = UIImage(systemName: "humidity")
                
                return image
            }()
            
            let humidityLabel: UILabel = {
                let label = UILabel()
                label.text = "57%"
                label.textAlignment = .center
                
                return label
            }()
        
            stack.addArrangedSubview(humidityImageView)
            stack.addArrangedSubview(humidityLabel)
            
            func update(weather: CurrentWeather) {
                humidityLabel.text = String(weather.humidity)
            }
            
            return stack
        }()
        
        let precipitationStackView: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.distribution = .fillEqually
            stack.spacing = 2
            
            let dropImageView: UIImageView = {
                let image = UIImageView()
                image.image = UIImage(systemName: "drop")
                
                return image
            }()
            
            let dropLabel: UILabel = {
                let label = UILabel()
                label.text = "1.0mm"
                label.textAlignment = .center
                
                return label
            }()
        
            stack.addArrangedSubview(dropImageView)
            stack.addArrangedSubview(dropLabel)
            
            return stack
        }()
        
        let pressureStackView: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.distribution = .fillEqually
            stack.spacing = 2
            
            let pressureImageView: UIImageView = {
                let image = UIImageView()
                image.image = UIImage(systemName: "thermometer")
                
                return image
            }()
            
            let pressureLabel: UILabel = {
                let label = UILabel()
                label.text = "1019hPa"
                label.textAlignment = .center
                
                return label
            }()
        
            stack.addArrangedSubview(pressureImageView)
            stack.addArrangedSubview(pressureLabel)
            
            func update(weather: CurrentWeather) {
                pressureLabel.text = String(weather.pressure)
            }
            
            return stack
        }()
        
        stackViewTop.addArrangedSubview(humidityStackView)
        stackViewTop.addArrangedSubview(precipitationStackView)
        stackViewTop.addArrangedSubview(pressureStackView)
    }
    
    func setStackViewBottom() {
        viewContener.addSubview(stackViewBottom)
        stackViewBottom.topAnchor.constraint(equalTo: stackViewTop.bottomAnchor, constant: 0).isActive = true
        stackViewBottom.leadingAnchor.constraint(equalTo: viewContener.leadingAnchor, constant: 60).isActive = true
        stackViewBottom.trailingAnchor.constraint(equalTo: viewContener.trailingAnchor, constant: -60).isActive = true
        stackViewBottom.bottomAnchor.constraint(equalTo: viewContener.bottomAnchor, constant: 0).isActive = true
        
        let windSpeedStackView: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.distribution = .fillEqually
            stack.spacing = 2
            
            let windImageView: UIImageView = {
                let image = UIImageView()
                image.image = UIImage(systemName: "wind")
                
                return image
            }()
            
            let windLabel: UILabel = {
                let label = UILabel()
                label.text = "20km/h"
                label.textAlignment = .center
                
                return label
            }()
        
            stack.addArrangedSubview(windImageView)
            stack.addArrangedSubview(windLabel)
            
            func update(weather: CurrentWeather) {
                windLabel.text = String(weather.windSpeed)
            }
            
            return stack
        }()
        
        let windTypeStackView: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.distribution = .fillEqually
            stack.spacing = 2
            
            
            let windTypeImageView: UIImageView = {
                let image = UIImageView()
                image.image = UIImage(systemName: "safari")
                
                return image
            }()
            
            let windTypeTabel: UILabel = {
                let label = UILabel()
                label.text = "SE"
                label.textAlignment = .center
                
                return label
            }()
        
            stack.addArrangedSubview(windTypeImageView)
            stack.addArrangedSubview(windTypeTabel)
            
            return stack
        }()
        
        stackViewBottom.addArrangedSubview(windSpeedStackView)
        stackViewBottom.addArrangedSubview(windTypeStackView)
    }
}
