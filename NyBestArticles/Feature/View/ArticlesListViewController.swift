//
//  ArticlesListViewController.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/14/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Reachability
import RxRelay
import RxSwift
import UIKit

class ArticlesListViewController: UIViewController, HomeStoryboardLoadable {
    var articlesListViewModel: ArticlesListViewModel!
    private var disposeBag = DisposeBag()

    private var reachability: Reachability?
    private var isRechable: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    deinit {
        reachability = nil
    }

    private func setReachablity() {
        reachability = try? Reachability()

        reachability?.whenReachable = { _ in
        }
        reachability?.whenUnreachable = { _ in
        }
    }

    private func bindViewModel() {}
}
