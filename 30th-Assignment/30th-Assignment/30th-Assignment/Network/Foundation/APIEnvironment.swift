//
//  APIEnvironment.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/16.
//

import Foundation

/*
 APIEnvironment: baseURL 및 토큰 관리, 추후 배포를 고려하여 development와 production 분리
 */

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
