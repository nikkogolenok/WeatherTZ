//
//  ViewController.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 20.12.21.
//

import UIKit

class SignInViewController: UIViewController {
    
    // MARK: - Variable
    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        button.addTarget(self, action: #selector(tabButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        button.center = view.center
    }
    
    @objc func tabButton() {
        let tabBarVC = UITabBarController()
        
        let mainViewController = UINavigationController(rootViewController: MainViewController())
        let tableViewController = UINavigationController(rootViewController: TableViewController())
        
        mainViewController.title = "Today"
        tableViewController.title = "Forecast"
        
        tabBarVC.setViewControllers([mainViewController, tableViewController], animated: false)
        guard let items = tabBarVC.tabBar.items else { return }
        
        let images = ["sun.min", "clock"]
        
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
        
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
    }
}
