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

    func updateRechablity(rechable: Bool) {
        isRechable.accept(rechable)
    }

    private func loadMostViewedArticles() {
        guard let localItems = realm.objects(Article.self).sorted(byKeyPath: Article.CodingKeys.createdAt.rawValue, ascending: true).array else {
            fetchMostViewedArticles()
            return
        }

        mostViewedArticleViewModels.accept(localItems)

        let today = Date()
        if let firstArticle = localItems.first, let difference = firstArticle.createdAt.totalDistance(from: today, resultIn: .hour) {
            // Fetch from server in 12 hour intarvel
            if difference > 12 {
                fetchMostViewedArticles()
            }
        }
    }

    private func fetchMostViewedArticles() {
        isLoading.accept(true)

        articlesListProvider.request(.mostViewedArticles, completion: { result in

            self.isLoading.accept(false)

            if case let .success(response) = result {
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    do {
                        let items = try JSONDecoder().decode([Article].self, from: filteredResponse.data, keyPath: "results")
                        let data = self.mostViewedArticleViewModels.value + items
                        self.mostViewedArticleViewModels.accept(data)

                        try? self.realm.write {
                            self.realm.add(items, update: .all)
                        }

                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }

                } catch {
                    self.alertMessage.onNext(AlertMessage(title: error.localizedDescription, message: ""))
                }
            } else {
                self.alertMessage.onNext(AlertMessage(title: result.error?.errorDescription, message: ""))
            }

        })
    }

    private func clearOldData() {
        if let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: Date()) {
            let itemsToDelete = realm.objects(Article.self).filter("\(Article.CodingKeys.createdAt.rawValue) < \(thirtyDaysAgo)")
            realm.delete(itemsToDelete)
        }
    }
}
