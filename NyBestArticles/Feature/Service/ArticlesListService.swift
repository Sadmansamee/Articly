//
//  ArticlesListService.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/14/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Moya

public enum ArticlesListService {
    case mostViewedArticles
}

extension ArticlesListService: TargetType {
    public var baseURL: URL {
        return URL(string: Constant.Url.base)!
    }

    public var path: String {
        switch self {
        case .mostViewedArticles:
            return "/svc/mostpopular/v2/viewed/1.json"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .mostViewedArticles:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .mostViewedArticles:
            return .requestParameters(parameters: ["api-key": Constant.ApiKey.nyApiKey], encoding: JSONEncoding.default)
        }
    }

    public var headers: [String: String]? {
        return ["Content-Type": "application/json; charset=utf-8"]
    }

    public var authorizationType: AuthorizationType {
        return .none
    }

    public var validationType: ValidationType {
        return .successCodes
    }

    public var sampleData: Data {
        switch self {
        case .mostViewedArticles:

            guard let path = Bundle.main.path(forResource: MockJson.articleList.rawValue, ofType: "json"),
                let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
                return "".data(using: String.Encoding.utf8)!
            }
            return data
        }
    }
}
