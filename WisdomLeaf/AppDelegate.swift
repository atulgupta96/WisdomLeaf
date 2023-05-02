//
//  AppDelegate.swift
//  WisdomLeaf
//
//  Created by Atul Gupta on 02/05/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        setRootController(SplashVC())
        return true
    }
    
    private func setRootController(_ controller: UIViewController) {
        let navigationController = UINavigationController(rootViewController: controller)
//        navigationController.navigationBar.isHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

