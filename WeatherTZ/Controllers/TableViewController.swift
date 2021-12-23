//
//  TableViewController.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 20.12.21.
//

import UIKit

class TableViewController: UIViewController {
    
    // MARK: - Variable
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
        return 7
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Monday"
        } else if section == 1 {
            return "Tuesday"
        } else if section == 2 {
            return "Wednesday"
        } else if section == 3 {
            return "Thursday"
        } else if section == 4 {
            return "Friday"
        } else if section == 5 {
            return "Saturday"
        } else if section == 6 {
            return "Sunday"
        }
        
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
