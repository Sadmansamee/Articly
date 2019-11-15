//
//  Storyboard.swift
//  NyBestArticles
//
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Foundation

import UIKit

protocol StoryboardLoadable: AnyObject {
    static var storyboardName: String { get }
}

protocol HomeStoryboardLoadable: StoryboardLoadable {}

extension HomeStoryboardLoadable where Self: UIViewController {
    static var storyboardName: String {
        "Home"
    }
}
