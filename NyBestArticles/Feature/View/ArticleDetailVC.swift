//
//  ArticleDetailViewController.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/16/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import UIKit
import RxSwift

class ArticleDetailVC: UITableViewController,HomeStoryboardLoadable {
    
    var articleDetailViewModel : ArticleDetailViewModel!
    private var disposeBag = DisposeBag()
    private var articleViewModel : ArticleViewModel!{
        didSet{
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModelCallbacks()
        
    }
}

// MARK: - View Model

extension ArticleDetailVC {
    private func viewModelCallbacks() {
        
        articleDetailViewModel.onArticleViewModel
            .map { [weak self] result in
                
                guard let self = self else {
                    return
                }
                
                self.articleViewModel = result
        }.subscribe()
            .disposed(by: disposeBag)
    }
    
}
