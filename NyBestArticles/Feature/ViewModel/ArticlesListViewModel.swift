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

    private var fetchableDays: KEnum.FetchableDays = .one
    private var fetchStatus: KEnum.FetchStatus = .none

    private let isLoading = BehaviorRelay(value: false)
    private let alertMessage = PublishSubject<AlertMessage>()
    private let mostViewedArticleViewModels = BehaviorRelay<[Article]>(value: [])

    private var isRechable = BehaviorRelay<Bool>(value: false)

    init(articlesListProvider: MoyaProvider<ArticlesListService>, realm: Realm) {
        self.articlesListProvider = articlesListProvider
        self.realm = realm
        if NetworkState().isInternetAvailable {
            isRechable.accept(true)
        }
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
        // as connectivity is positive now so this will enable to retry if previous attempt to fetch data was not successfull due to internet connectivity with
        if isRechable.value, fetchStatus == .willFetch {
            fetchMostViewedArticles(days: fetchableDays)
        }
    }

    private func loadMostViewedArticles() {
        guard let localItems = realm.objects(Article.self).sorted(byKeyPath: Article.CodingKeys.createdAt.rawValue, ascending: false).array else {
            // if there was no data before it will load last seven days's data
            fetchableDays = KEnum.FetchableDays.seven
            fetchStatus = .willFetch
            fetchMostViewedArticles(days: fetchableDays)
            return
        }

        mostViewedArticleViewModels.accept(localItems)

        let today = Date()
        if let firstArticle = localItems.first, let difference = firstArticle.createdAt.totalDistance(from: today, resultIn: .minute) {
            // Fetch from server in 6 hour interval
            if difference >= 1 {
                // if there was no data before it will load last one day's data
                fetchableDays = KEnum.FetchableDays.one
                fetchStatus = .willFetch
                fetchMostViewedArticles(days: fetchableDays)
            }
        }
    }

    private func fetchMostViewedArticles(days: KEnum.FetchableDays) {
        if fetchStatus != .willFetch {
            return
        }

        if !isRechable.value {
            alertMessage.onNext(AlertMessage(title: "", message: "You aren't connected to internet"))
            return
        }

        isLoading.accept(true)
        fetchStatus = .fetching
        articlesListProvider.request(.mostViewedArticles(days: days.rawValue), completion: { result in

            self.isLoading.accept(false)

            if case let .success(response) = result {
                self.fetchStatus = .didFetch

                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    do {
                        let throwables = try JSONDecoder().decode([Throwable<Article>].self, from: filteredResponse.data, keyPath: "results")
                        let items = throwables.compactMap { try? $0.result.get() }.reversed()

                        let data = items + self.mostViewedArticleViewModels.value
                        self.mostViewedArticleViewModels.accept(data)

                        try? self.realm.write {
                            self.realm.add(items, update: .modified)
                        }

                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }

                } catch {
                    self.alertMessage.onNext(AlertMessage(title: error.localizedDescription, message: ""))
                }
            } else {
                self.fetchStatus = .willFetch
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
