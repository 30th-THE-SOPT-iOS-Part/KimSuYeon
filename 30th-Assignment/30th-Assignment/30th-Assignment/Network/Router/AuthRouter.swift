//
//  AuthRouter.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/16.
//

import Foundation
import Alamofire

enum AuthRouter {
    case signIn(email: String, pw: String)
    case signUp(email: String, name: String, pw: String)
}

extension AuthRouter: Router {

    var path: String {
        switch self {
        case .signIn:
            return URLConstants.signIn
        case .signUp:
            return URLConstants.signUp
        }
    }

    var method: HTTPMethod {
        switch self {
        case .signIn, .signUp:
            return .post
        }
    }

    var header: HeaderType {
        switch self {
        case .signIn, .signUp:
            return .basic
        }
    }

    var parameters: RequestParams {
        switch self {
        case .signUp(let email, let name, let pw):
            let body: [String:Any] = [
                "email": email,
                "name": name,
                "password":pw
            ]
            return .requestParameters(body)
        case .signIn(let email, let pw):
            let body: [String:Any] = [
                "email": email,
                "password": pw
            ]
            return .requestParameters(body)
        }
    }
}
