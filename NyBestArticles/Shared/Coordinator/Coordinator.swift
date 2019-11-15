//
//  Coordinator.swift
//  NyBestArticles
//
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Foundation

protocol Coordinator: AnyObject {
    func start()
}

protocol CoordinatorFinishOutput {
    var finishFlow: (() -> Void)? { get set }
}
