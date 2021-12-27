//
//  TableViewController.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 20.12.21.
//

import UIKit

class TableViewController: UIViewController {
    
    // MARK: - Variable
    var weatherDataHourly: [WeatherDataHourly]?{
        NetworkWeatherManager.shared.currentWeather?.weatherDataHourly
    }
    
    // MARK: - GUI Variable
    let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        
        return table
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "City"
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return weatherDataHourly?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let weatherDataHourly = weatherDataHourly else { return nil }
        
        let day = weatherDataHourly[section].date
        
        return day.formatted("EEEE")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let weatherDataHourly = weatherDataHourly else { return 0 }
        return weatherDataHourly[section].hourly.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell,
              let weatherDataHourly = weatherDataHourly else { return UITableViewCell() }
        
        let data = weatherDataHourly[indexPath.section].hourly[indexPath.row]
        cell.updateUIInCell(data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
