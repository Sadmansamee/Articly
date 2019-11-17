//
//  K+Enum.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/15/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Foundation

struct KEnum {
    enum TimeFormat: String {
        case date = "yyyy-MM-dd"
        case prettyDate = "dd MMM yyyy"
    }

    enum FetchableDays: Int {
        case one = 1
        case seven = 7
    }

    enum FetchStatus {
        case none
        case didFetch
        case willFetch
        case fetching
    }
}
