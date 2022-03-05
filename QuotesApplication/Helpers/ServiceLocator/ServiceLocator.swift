//
//  ServiceLocator.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 04.03.2022.
//

import Foundation

final class ServiceLocator {
    static let shared = ServiceLocator()

    private lazy var services = [String: Any]()

    private init() {}
    
    private func typeName(_ some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
    
    func register<T>(service: T) {
        let key = typeName(T.self)
        services[key] = service
    }

    func resolve<T>() -> T? {
        let key = typeName(T.self)
        return services[key] as? T
    }
    
    func debug() {
        print("\(services)")
    }
}
