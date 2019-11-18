//
//  ViewControllerTest+SetUp.swift
//  NyBestArticlesTests
//
//  Created by sadman samee on 11/16/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Foundation
@testable import Articly
import Foundation
import Moya
import Swinject
import RealmSwift

extension ViewControllerTest {
    /**
     Set up the depedency graph in the DI container
     */
    func setupDependencies() -> Container {
        let container = Container()

        // MARK: - Persistant storage

           container.register(Realm.Configuration.self) { _ in
                var config = Realm.Configuration()
                config.inMemoryIdentifier = "Test"
                return config
           }.inObjectScope(ObjectScope.container)

           container.register(Realm.self) { resolver in
               try! Realm(configuration: resolver.resolve(Realm.Configuration.self)!)
           }.inObjectScope(ObjectScope.container)

           // MARK: - Providers

           container.register(MoyaProvider<ArticlesListService>.self, factory: { _ in
               MoyaProvider<ArticlesListService>(stubClosure: MoyaProvider.immediatelyStub)
           })

           // MARK: - View Model

           container.register(ArticlesListViewModel.self, factory: { resolver in
                ArticlesListViewModel(articlesListProvider: resolver.resolve(MoyaProvider<ArticlesListService>.self)!, realm: resolver.resolve(Realm.self)!)
           })
        
            container.register(ArticleViewModel.self, factory: { resolver in
                let path = Bundle.main.path(forResource: MockJson.article.rawValue, ofType: "json")
                let url = URL(fileURLWithPath: path!)
                let article = try! JSONDecoder().decode(Article.self, from: Data(contentsOf: url))
                return article
            })

           // MARK: - View Controllers
           container.storyboardInitCompleted(ArticlesListVC.self) { resolver, controller in
               controller.articlesListViewModel = resolver.resolve(ArticlesListViewModel.self)
           }
        
            container.storyboardInitCompleted(ArticleDetailVC.self) { resolver, controller in
                controller.articleViewModel = resolver.resolve(ArticleViewModel.self)
            }
        return container
    }
}
