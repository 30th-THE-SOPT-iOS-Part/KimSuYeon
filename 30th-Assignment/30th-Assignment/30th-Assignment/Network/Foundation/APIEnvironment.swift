//
//  APIEnvironment.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/16.
//

import Foundation

enum APIEnvironment: String, CaseIterable {
    case development
    case production
}

extension APIEnvironment {
    var baseUrl: String {
        switch self {
        case .development:
            return "http://13.124.62.236"
        case .production:
            return ""
        }
    }
}
