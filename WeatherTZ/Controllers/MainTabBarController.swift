//
//  ViewController.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 20.12.21.
//

import UIKit

class MainTabBarController: UITabBarController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupTabBar()
    }
    
    func setupTabBar() {
        
        let mainViewController = UINavigationController(rootViewController: MainViewController())
        let tableViewController = UINavigationController(rootViewController: TableViewController())
        
        mainViewController.title = "Today"
        tableViewController.title = "Forecast"
        
        self.setViewControllers([mainViewController, tableViewController], animated: false)
        guard let items = self.tabBar.items else { return }
        
        let images = ["sun.min", "clock"]
        
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
    }
}
