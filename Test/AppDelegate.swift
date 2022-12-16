//
//  AppDelegate.swift
//  Test
//
//  Created by cmc on 14/12/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let listUserVC = ListUserViewController()
        navigationController.viewControllers = [listUserVC]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

}

