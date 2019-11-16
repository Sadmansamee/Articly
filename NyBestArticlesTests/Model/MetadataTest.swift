//
//  MetadataTest.swift
//  NyBestArticlesTests
//
//  Created by sadman samee on 11/16/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Foundation
import Nimble
import Quick
import RxSwift


@testable import NyBestArticles

class MetadataTest: QuickSpec {
    override func spec() {
        describe("ArticleTest") {
            
            var sut: Metadata!
            
            afterEach {
                sut = nil
            }
            beforeEach {
                let path = Bundle.main.path(forResource: MockJson.metadata.rawValue, ofType: "json")
                let url = URL(fileURLWithPath: path!)
                sut = try! JSONDecoder().decode(Metadata.self, from: Data(contentsOf: url))
            }
            
            context("Model From Json") {
                
                it("Data is valid") {
                    expect(sut).toNot(beNil())
                    expect(sut?.url).to(equal("https://static01.nyt.com/images/2019/11/09/autossell/06op-mary-cain/06op-mary-cain-thumbStandard.jpg"))
                }
            }
        }
    }
}
