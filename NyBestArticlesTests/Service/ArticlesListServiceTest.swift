//
//  ArticlesListServiceTest.swift
//  NyBestArticlesTests
//
//  Created by sadman samee on 11/16/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Foundation

import Moya
import Nimble
import Quick
import RxSwift

@testable import NyBestArticles

class ArticlesListServiceTest: QuickSpec {
    override func spec() {
        describe("ArticlesListServiceTest") {
            var sut: MoyaProvider<ArticlesListService>!
          
            func customEndpointClosure(_ target: ArticlesListService) -> Endpoint {
                return Endpoint(url: URL(target: target).absoluteString,
                                sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: target.headers)
            }

            beforeEach {
                sut = MoyaProvider<ArticlesListService>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
            }
            context("when initialized and token is available") {
                it("should get 200") {
                    sut.request(.mostViewedArticles, completion: { result in

                        if case let .success(response) = result {
                            expect(response.statusCode).to(equal(200))

                        } else {}
                    })
                }
            }
        }
    }
}
