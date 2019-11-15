//
//  ArticlesListViewModel.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/14/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Foundation
import Moya
import RealmSwift
import RxRelay
import RxSwift

final class ArticlesListViewModel {
    private var articlesListProvider: MoyaProvider<ArticlesListService>
    private var realm: Realm

    private let isLoading = BehaviorRelay(value: false)
    private let alertMessage = PublishSubject<AlertMessage>()
    private let mostViewedArticleViewModels = BehaviorRelay<[Article]>(value: [])

    private var isRechable = BehaviorRelay<Bool>(value: false)

    init(articlesListProvider: MoyaProvider<ArticlesListService>, realm: Realm) {
        self.articlesListProvider = articlesListProvider
        self.realm = realm
        loadMostViewedArticles()
    }

    var onLoading: Observable<Bool> {
        isLoading.asObservable()
            .distinctUntilChanged()
    }

    var onAlertMessage: Observable<AlertMessage> {
        alertMessage.asObservable()
    }

    var onMostViwedArticleViewModels: Observable<[Article]> {
        mostViewedArticleViewModels.asObservable()
    }

    private func updateRechablity(rechable: Bool) {
        isRechable.accept(rechable)
    }

    private func loadMostViewedArticles() {
        let today = Date()

        guard let localItems = realm.objects(Article.self).sorted(byKeyPath: Article.CodingKeys.publishedDate.rawValue, ascending: true).array else {
            fetchMostViewedArticles()
            return
        }

        mostViewedArticleViewModels.accept(localItems)

        if let firstArticle = localItems.first {
            if firstArticle.publishedDate < today {
                fetchMostViewedArticles()
            }
        }
    }

    private func fetchMostViewedArticles() {
        articlesListProvider.request(.mostViewedArticles, completion: { _ in

        })
    }

    private func clearOldData() {
        let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: Date())

        // realm.objects(Article.self).
//        .lowerThan("publishedDate", thirtyDaysAgo)
//        .findAll()
//        .deleteAllFromRealm()
    }
}
