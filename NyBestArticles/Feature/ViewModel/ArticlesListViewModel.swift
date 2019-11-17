//
//  ArticlesListViewModel.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/14/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

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
    private let cleanableDuration = NSDate(timeIntervalSinceNow: -(7 * 24 * 60 * 60))

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
        if let firstArticle = localItems.first, let difference = firstArticle.createdAt.totalDistance(from: today, resultIn: .day) {
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
                        let fetchedItems = try JSONDecoder().decode([Article].self, from: filteredResponse.data, keyPath: "results")

                        // find out items to be deleted
                        let itemsToDelete = self.realm.objects(Article.self).filter("\(Article.CodingKeys.createdAt.rawValue) < %@", self.cleanableDuration)
                        // remove from array
                        let deletedFiltered = self.mostViewedArticleViewModels.value.filter { element in
                            !itemsToDelete.contains(element)
                        }

                        try? self.realm.write {
                            self.realm.delete(itemsToDelete)
                        }

                        try? self.realm.write {
                            self.realm.add(fetchedItems, update: .modified)
                        }

                        let data = fetchedItems + deletedFiltered
                        self.mostViewedArticleViewModels.accept(data)

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
}
