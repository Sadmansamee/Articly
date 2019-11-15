//
//  HomeCoordinator.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/14/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Moya
import Swinject

final class HomeCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    // MARK: - CoordinatorFinishOutput

    var finishFlow: (() -> Void)?
    let container: Container

    // MARK: - Vars & Lets

    let navigationController: UINavigationController

    // MARK: - Coordinator

    override func start() {
        showArticlesListViewController()
    }

    // MARK: - Init

    init(container: Container, navigationController: UINavigationController) {
        self.container = container
        self.navigationController = navigationController
    }

    // MARK: - Private methods

    private func showArticlesListViewController() {
        let viewController = container.resolveViewController(ArticlesListViewController.self)
        navigationController.pushViewController(viewController, animated: true)
    }
}
