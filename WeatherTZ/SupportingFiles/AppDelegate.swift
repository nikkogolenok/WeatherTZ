//
//  AppDelegate.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 13.12.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Variable
    var window: UIWindow?
    
    // MARK: - AppDelegat
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        let tabBarVC = UITabBarController()
//
//        let signVC = UINavigationController(rootViewController: SignInViewController())
//        let mainViewController = UINavigationController(rootViewController: MainViewController())
//        let tableViewController = UINavigationController(rootViewController: TableViewController())
//
//        mainViewController.title = "Today"
//        tableViewController.title = "City"
//
//        tabBarVC.setViewControllers([signVC, mainViewController, tableViewController], animated: false)
//        if let items = tabBarVC.tabBar.items {
//            let images = ["sun.min", "clock"]
//
//            for x in 0..<items.count {
//                items[x].image = UIImage(systemName: images[x])
//            }
//            tabBarVC.modalPresentationStyle = .fullScreen
//        }
        
        let mainVC = SignInViewController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible() 
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

