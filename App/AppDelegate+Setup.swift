//
//  AppDelegate+Setup.swift
//  NyBestArticles
//
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Foundation
import Moya
import Swinject
import RealmSwift

extension AppDelegate {
    /**
     Set up the dependency graph in the DI container
     */
    internal func setupDependencies() {
        // MARK: - Providers

        container.register(Realm.Configuration.self) { _ in
            Realm.Configuration()
            
            //FOR Unit Test
            // var config = Realm.Configuration()
            //config.inMemoryIdentifier = "Test"
        }
        
        container.register(Realm.self) { resolver in
            try! Realm(configuration: resolver.resolve(Realm.Configuration.self)!)
        }
        
    }
}
