//
//  Extension+Collection.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/15/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import RealmSwift

extension Results {
    var array: [Element]? {
        return count > 0 ? map { $0 } : nil
    }
}
