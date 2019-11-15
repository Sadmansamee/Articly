//
//  Extension+Cell.swift
//  NyBestArticles
//
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import UIKit

extension UITableViewCell: XIBIdentifiable {}

extension UICollectionViewCell: XIBIdentifiable {}

protocol XIBIdentifiable {
    static var id: String { get }
    static var nib: UINib { get }
}

extension XIBIdentifiable {
    static var id: String {
        String(describing: Self.self)
    }

    static var nib: UINib {
        UINib(nibName: id, bundle: nil)
    }
}
