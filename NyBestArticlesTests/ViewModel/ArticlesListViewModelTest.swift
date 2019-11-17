//
//  ArticlesListViewModelTest.swift
//  NyBestArticlesTests
//
//  Created by sadman samee on 11/16/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Foundation
import Moya
import Nimble
import Quick
import RxBlocking
import RxSwift
import RealmSwift

@testable import NyBestArticles

class ArticlesListViewModelTest: QuickSpec {
    override func spec() {
        describe("ArticlesListViewModelTest") {
            let disposeBag = DisposeBag()

            var stubbingProvider: MoyaProvider<ArticlesListService>!
            var sut: ArticlesListViewModel!
            afterEach {
                sut = nil
            }
            beforeEach {
                stubbingProvider = MoyaProvider<ArticlesListService>(stubClosure: MoyaProvider.immediatelyStub)
                
                var config = Realm.Configuration()
                config.inMemoryIdentifier = "Test"
                let realm = try! Realm(configuration: config)
                
                sut = ArticlesListViewModel(articlesListProvider: stubbingProvider,realm: realm)
            }
            context("when initialized and data count okhay") {
                it("should load all the Articles") {
                    let result = try! sut.onMostViwedArticleViewModels.toBlocking().first()
                    expect(result?.count).toEventually(beGreaterThanOrEqualTo(10), timeout: 5)
                }
                it("First item title should match") {
                    let result = try! sut.onMostViwedArticleViewModels.toBlocking().first()
                        expect(result?.first?.title).to(equal("Yoga Is Finally Facing Consent and Unwanted Touch"))
                        expect(result?.first?.smallImage).to(equal("https://static01.nyt.com/images/2019/11/10/fashion/08yogatouch-web1/08yogatouch-web1-thumbStandard.jpg"))
                    expect(result?.first?.largeImage).to(equal("https://static01.nyt.com/images/2019/11/10/fashion/08yogatouch-web1/08yogatouch-web1-mediumThreeByTwo440.jpg"))
                }
                
                it("Loading should not show") {
                    sut.onLoading.asObservable().debug().subscribe(
                        onNext: { isLoading in
                            expect(isLoading).notTo(beTrue())
                        }
                    ).disposed(by: disposeBag)
                }
            }
        }
    }
}
