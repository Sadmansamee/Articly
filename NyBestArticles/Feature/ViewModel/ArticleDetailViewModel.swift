//
//  ArticleDetailViewModel.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/16/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

final class ArticleDetailViewModel {
    
    private let articleViewModel = PublishSubject<ArticleViewModel>()

    var onArticleViewModel: Observable<ArticleViewModel> {
        articleViewModel.asObservable()
    }
    init( viewmodel: ArticleViewModel) {
        articleViewModel.onNext(viewmodel)
    }
}
