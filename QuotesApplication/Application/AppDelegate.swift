//
//  AppDelegate.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 23.12.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        let navigationController = UINavigationController()
        let randomQuoteViewModel = RandomQuoteViewModel()
        let randomQuoteVC = RandomQuoteViewConroller(viewModel: randomQuoteViewModel)
        navigationController.viewControllers = [randomQuoteVC]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

