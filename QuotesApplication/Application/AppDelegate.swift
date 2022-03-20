//
//  AppDelegate.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 23.12.2021.
//

import UIKit
import Swinject
import Moya

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let container: Container = Container()

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
        // networking
        let networkService = MoyaProvider<NetworkService>()
        
        container.register(QuoteNetworking.self) { _ in
            let deps = QuoteNetworkService.Dependencies(networkService: networkService)
            return QuoteNetworkService(deps: deps)
        }.inObjectScope(.container)
        
        container.register(AuthorNetworking.self) { _ in
            let deps = AuthorNetworkService.Dependencies(networkService: networkService)
            return AuthorNetworkService(deps: deps)
        }.inObjectScope(.container)
        
        container.register(TagsNetworking.self) { _ in
            let deps = TagsNetworkService.Dependencies(networkService: networkService)
            return TagsNetworkService(deps: deps)
        }.inObjectScope(.container)
        
        // random quote
        container.register(RandomQuoteViewModelProtocol.self) { resolver in
            let networkService = resolver.resolve(QuoteNetworking.self)!
            let deps = RandomQuoteViewModel.Dependencies(networkService: networkService)
            return RandomQuoteViewModel(deps: deps)
        }
        
        // api filter list
        container.register(APIFilterViewModelProtocol.self) { _ in
            APIFilterViewModel()
        }
        
        // authors list
        container.register(AuthorsListViewModelProtocol.self) { (resolver, title: String) in
            let networkService = resolver.resolve(AuthorNetworking.self)!
            let deps = AuthorsListViewModel.Dependencies(networkService: networkService)
            let context = AuthorsListViewModel.Context(title: title)
            return AuthorsListViewModel(context: context, deps: deps)
        }
    }
}

