//
//  HomeCoordinator.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/14/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Moya
import Swinject

final class ArticleListCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    // MARK: - CoordinatorFinishOutput

    var finishFlow: (() -> Void)?
    let container: Container

    // MARK: - Vars & Lets

    let navigationController: UINavigationController

    // MARK: - Coordinator

    override func start() {
        showArticlesListVC()
    }

    // MARK: - Init

    init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
    }

    // MARK: - Private methods

    private func showArticlesListVC() {
        let viewController = container.resolveViewController(ArticlesListVC.self)
        viewController.onArticleSelected = { viewModel in
            self.showArticleDetailVC(viewModel: viewModel)
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    private func showArticleDetailVC(viewModel: ArticleViewModel) {
        let viewController = container.resolveViewController(ArticleDetailVC.self)
        viewController.onBack = { [unowned self] in
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        viewController.articleViewModel = viewModel
        navigationController.present(viewController, animated: true, completion: nil)
    }
}
