//
//  FailableCodableArray.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/15/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Foundation

struct Throwable<T: Decodable>: Decodable {
    let result: Result<T, Error>

    init(from decoder: Decoder) throws {
        do {
            let decoded = try T(from: decoder)
            result = .success(decoded)
        } catch {
            result = .failure(error)
        }
    }
}
