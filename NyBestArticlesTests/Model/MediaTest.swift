//
//  MediaTest.swift
//  NyBestArticlesTests
//
//  Created by sadman samee on 11/16/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Nimble
import Quick
import RxSwift

@testable import Articly

class MediaTest: QuickSpec {
    override func spec() {
        describe("ArticleTest") {
            var sut: Media!
            afterEach {
                sut = nil
            }
            beforeEach {
                let path = Bundle.main.path(forResource: MockJson.media.rawValue, ofType: "json")
                let url = URL(fileURLWithPath: path!)
                sut = try? JSONDecoder().decode(Media.self, from: Data(contentsOf: url))
            }
            
            context("Model From Json") {
                
                it("Data is valid") {
                    expect(sut).toNot(beNil())
                    expect(sut?.metadata.first).toNot(beNil())
                    expect(sut?.metadata.first?.url).to(equal("https://static01.nyt.com/images/2019/11/09/autossell/06op-mary-cain/06op-mary-cain-thumbStandard.jpg"))
                    
                    expect(sut?.metadata.last).toNot(beNil())
                    expect(sut?.metadata.last?.url).to(equal("https://static01.nyt.com/images/2019/11/09/autossell/06op-mary-cain/06op-mary-cain-mediumThreeByTwo440.jpg"))
                }
            }
        }
    }
}
