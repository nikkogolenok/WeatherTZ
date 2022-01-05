//
//  SceneDelegate.swift
//  WeatherTZ
//
//  Created by Никита Коголенок on 13.12.21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        //1
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        //2
        window?.windowScene = windowScene
        //3
        window?.rootViewController = MainTabBarController()
        //4
        window?.makeKeyAndVisible()
    }
}
