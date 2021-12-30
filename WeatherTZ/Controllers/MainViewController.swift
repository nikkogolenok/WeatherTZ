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
    private let mainStackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let imageAndTextFieldStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 2
        
        return stack
    }()
    
    private let weatherImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "clock")
        
        return image
    }()
    
    private let cityNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter city, please"
        textField.textAlignment = .center
    
        return textField
    }()
    
    private let twoLabelStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 2
        
        return stack
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "22°C"
        label.textAlignment = .center
        
        return label
    }()
    
    private let typeWeatherLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunny"
        label.textAlignment = .center
        
        return label
    }()
    
    private let lineViewTop: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        
        return view
    }()
    
    private let viewContener: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let lineViewBottom: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        
        return view
    }()
    
    private let buttonShare: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(tapToButton), for: .touchUpInside)
        
        return button
    }()
    
    private let stackViewTop: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 70
        
        return stack
    }()
    
    private let humidityStackView: SmallStackView = {
        let stack = SmallStackView(with: .humidity)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let precipitationStackView: SmallStackView = {
        let stack = SmallStackView(with: .drop)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let pressureStackView: SmallStackView = {
        let stack = SmallStackView(with: .thermometer)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
  
    private let stackViewBottom: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 70
        
        return stack
    }()
    
    private let windSpeedStackView: SmallStackView = {
        let stack = SmallStackView(with: .wind)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()

    private let windTypeStackView: SmallStackView = {
        let stack = SmallStackView(with: .safari)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Today"
    
        cityNameTextField.delegate = self
        setMainStackView()
        setImageAndTextFieldStackView()
        setTwoLabelStackView()
        setLineViewTop()
        setViewContener()
        setLineViewBottom()
        setButton()
        setStackViewTop()
        setStackViewBottom()
        // MARK - LocationManager
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
                
                self.updateUIInterfece(weather: currentWeather)
                print("Temp \(currentWeather.temperature)")
                print("Type weather \(currentWeather.textTypeWeather.textNameString)")
                print("Humidity \(currentWeather.humidity)")
                print("Precipitation \(currentWeather.pop ?? 0)")
                print("Pressure \(currentWeather.pressure)")
                print("WindSpeed \(currentWeather.windSpeed)")
                print("WindGust \(currentWeather.windGust)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setMainStackView()  {
        view.addSubview(mainStackView)
        mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive              = true
        mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive      = true
        mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive   = true
        mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -400).isActive      = true
    }
    
    private func setImageAndTextFieldStackView() {
        mainStackView.addSubview(imageAndTextFieldStackView)
        imageAndTextFieldStackView.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 0).isActive             = true
        imageAndTextFieldStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 70).isActive    = true
        imageAndTextFieldStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -70).isActive = true
        imageAndTextFieldStackView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: -50).isActive     = true
        
        imageAndTextFieldStackView.addArrangedSubview(weatherImageView)
        imageAndTextFieldStackView.addArrangedSubview(cityNameTextField)
    }
    
    private func setTwoLabelStackView() {
        mainStackView.addSubview(twoLabelStackView)
        twoLabelStackView.topAnchor.constraint(equalTo: imageAndTextFieldStackView.bottomAnchor, constant: 0).isActive      = true
        twoLabelStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 0).isActive              = true
        twoLabelStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 0).isActive            = true
        twoLabelStackView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 0).isActive                = true
        
        twoLabelStackView.addArrangedSubview(temperatureLabel)
        twoLabelStackView.addArrangedSubview(typeWeatherLabel)
    }
    
    private func setLineViewTop() {
        view.addSubview(lineViewTop)
        lineViewTop.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 20).isActive                        = true
        lineViewTop.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100).isActive       = true
        lineViewTop.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100).isActive    = true
        lineViewTop.heightAnchor.constraint(equalToConstant: view.frame.size.height - 810).isActive                         = true
    }
    
    private func setViewContener() {
        view.addSubview(viewContener)
        viewContener.topAnchor.constraint(equalTo: lineViewTop.bottomAnchor, constant: 20).isActive                         = true
        viewContener.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive       = true
        viewContener.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive    = true
        viewContener.heightAnchor.constraint(equalToConstant: view.frame.size.height - 600).isActive                        = true
    }
    
    private func setLineViewBottom() {
        view.addSubview(lineViewBottom)
        lineViewBottom.topAnchor.constraint(equalTo: viewContener.bottomAnchor, constant: 20).isActive                      = true
        lineViewBottom.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100).isActive    = true
        lineViewBottom.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100).isActive = true
        lineViewBottom.heightAnchor.constraint(equalToConstant: view.frame.size.height - 810).isActive                      = true
    }
    
    private func setButton() {
        view.addSubview(buttonShare)
        buttonShare.topAnchor.constraint(equalTo: lineViewBottom.bottomAnchor, constant: 40).isActive                       = true
        buttonShare.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 150).isActive       = true
        buttonShare.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -150).isActive    = true
    }
    
    private func setStackViewTop() {
        viewContener.addSubview(stackViewTop)
        stackViewTop.topAnchor.constraint(equalTo: viewContener.topAnchor, constant: 0).isActive                            = true
        stackViewTop.leadingAnchor.constraint(equalTo: viewContener.leadingAnchor, constant: 0).isActive                    = true
        stackViewTop.trailingAnchor.constraint(equalTo: viewContener.trailingAnchor, constant: 0).isActive                  = true
        stackViewTop.bottomAnchor.constraint(equalTo: viewContener.bottomAnchor, constant: -90).isActive                    = true
        
        stackViewTop.addArrangedSubview(humidityStackView)
        stackViewTop.addArrangedSubview(precipitationStackView)
        stackViewTop.addArrangedSubview(pressureStackView)
    }
    
    private func setStackViewBottom() {
        viewContener.addSubview(stackViewBottom)
        stackViewBottom.topAnchor.constraint(equalTo: stackViewTop.bottomAnchor, constant: 0).isActive                      = true
        stackViewBottom.leadingAnchor.constraint(equalTo: viewContener.leadingAnchor, constant: 60).isActive                = true
        stackViewBottom.trailingAnchor.constraint(equalTo: viewContener.trailingAnchor, constant: -60).isActive             = true
        stackViewBottom.bottomAnchor.constraint(equalTo: viewContener.bottomAnchor, constant: 0).isActive                   = true
        
        stackViewBottom.addArrangedSubview(windSpeedStackView)
        stackViewBottom.addArrangedSubview(windTypeStackView)
    }
    
    private func updateUIInterfece(weather: CurrentWeather) {
        self.weatherImageView.image                = UIImage(systemName: weather.conditionCode.systemIconNameString)
        self.temperatureLabel.text                 = weather.temperature.wholeNumberString
        self.typeWeatherLabel.text                 = weather.textTypeWeather?.textNameString
        self.humidityStackView.textLabel.text      = String(weather.humidity)
        self.precipitationStackView.textLabel.text = String(weather.pop ?? 0)
        self.pressureStackView.textLabel.text      = String(weather.pressure)
        self.windSpeedStackView.textLabel.text     = String(weather.windSpeed.wholeNumberString)
        self.windTypeStackView.textLabel.text      = String(weather.windGust.wholeNumberString)
    }
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
        
        var address = ""
        
        cityNameTextField.text = address

        getCoordinateFrom(address: address) { coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            DispatchQueue.main.async {
                print(address, "Location:", coordinate)
            }

        }
    }
    
    
    // MARK: Action
    @objc func tapToButton() {
        let shareController = UIActivityViewController(activityItems: ["1"], applicationActivities: nil)
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                print("Share button worked")
            }
        }
        present(shareController, animated: true, completion: nil)
    }
}
// MARK: - MainViewController: UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
