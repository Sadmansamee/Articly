//
//  AppDelegate+Setup.swift
//  NyBestArticles
//
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Moya
import RealmSwift
import Swinject

extension AppDelegate {
    /**
     Set up the dependency graph in the DI container
     */
    internal func setupDependencies() {
        // MARK: - Persistant storage

        container.register(Realm.Configuration.self) { _ in
            Realm.Configuration()
        }.inObjectScope(ObjectScope.container)

        container.register(Realm.self) { resolver in
            try! Realm(configuration: resolver.resolve(Realm.Configuration.self)!)
        }.inObjectScope(ObjectScope.container)

        // MARK: - Providers

        container.register(MoyaProvider<ArticlesListService>.self, factory: { _ in
            MoyaProvider<ArticlesListService>()
        })

        // MARK: - View Model

        container.register(ArticlesListViewModel.self, factory: { resolver in
            ArticlesListViewModel(articlesListProvider: resolver.resolve(MoyaProvider<ArticlesListService>.self)!, realm: resolver.resolve(Realm.self)!)
        })

        // MARK: - View Controllers

        container.storyboardInitCompleted(ArticlesListVC.self) { resolver, controller in
            controller.articlesListViewModel = resolver.resolve(ArticlesListViewModel.self)
        }

        container.storyboardInitCompleted(ArticleDetailVC.self) { _, _ in
        }
    }
}
