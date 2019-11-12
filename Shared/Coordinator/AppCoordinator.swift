//
//  AppCoordinator.swift
//  NyBestArticles
//
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Swinject
import UIKit


final class AppCoordinator: BaseCoordinator {
    // MARK: - Properties

    private let window: UIWindow
    let container: Container

    private var navigationController: UINavigationController

    // MARK: - Coordinator

    override func start() {
        runHomeFlow()
    }

    // MARK: - Private methods

    private func runHomeFlow() {
        let coordinator = HomeCoordinator(container: container, navigationController: navigationController)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }

    // MARK: - Init

    init(window: UIWindow, container: Container, navigationController: UINavigationController) {
        self.window = window
        self.container = container
        self.navigationController = navigationController

        self.window.rootViewController = navigationController
        navigationController.navigationBar.tintColor = .paste
        navigationController.navigationBar.barTintColor = .white
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
    }
}
