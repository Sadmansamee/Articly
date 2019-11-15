//
//  ArticleViewModel.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/15/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Foundation

protocol ArticleViewModel {
    var articleVM: Article { get }
    var urlVM: String { get }
    var sectionVM: String { get }
    var bylineVM: String { get }
    var titleVM: String { get }
    var abstractVM: String { get }
    var publishedDateVM: String { get }
    var sourceVM: String { get }
    var viewsVM: Int { get }
    var largeImageVM: String { get }
    var smallImageVM: String { get }
}

extension Article: ArticleViewModel {
    var articleVM: Article {
        return self
    }

    var urlVM: String {
        url
    }

    var sectionVM: String {
        section
    }

    var bylineVM: String {
        byline
    }

    var titleVM: String {
        title
    }

    var abstractVM: String {
        abstract
    }

    var publishedDateVM: String {
        publishedDate.toString(toFormat: KEnum.TimeFormat.prettyDate.rawValue) ?? ""
    }

    var sourceVM: String {
        source
    }

    var viewsVM: Int {
        views
    }

    var largeImageVM: String {
        largeImage
    }

    var smallImageVM: String {
        smallImage
    }
}
