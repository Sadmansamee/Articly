//
//  AppDelegate.swift
//  NyBestArticles
//
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import IQKeyboardManager
import RxSwift
import Swinject
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    internal let container = Container()
    private var appCoordinator: AppCoordinator!

    func application(_: UIApplication,
                     willFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        setupDependencies()

        return true
    }

    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()

        appCoordinator = AppCoordinator(window: window!,
                                        container: container,
                                        navigationController: UINavigationController())
        appCoordinator.start()

        window?.makeKeyAndVisible()
        IQKeyboardManager.shared().isEnabled = true

        return true
    }
}
