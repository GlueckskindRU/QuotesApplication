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
        
        registerServices()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        let navigationController = UINavigationController()
        let randomQuoteVC = RandomQuoteAssembly.make()
        navigationController.viewControllers = [randomQuoteVC]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
    
    private func registerServices() {
        RandomQuoteAssembly.register()
        AuthorsListAssembly.register()
        APIFilterAssembly.register()
        
        ServiceLocator.shared.debug()
    }
}

