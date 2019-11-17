//
//  NetworkState.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/17/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Alamofire
import Foundation

struct NetworkState {
    var isInternetAvailable: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
