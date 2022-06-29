//
//  AuthRouter.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/16.
//

import Foundation
import Alamofire

/*
 AuthRouter : 여러 Endpoint들을 갖고 있는 enum
 BaseRouter를 채택해서 path, method, header, parameter를 각 라우터에 맞게 request를 만든다.
 */

enum AuthRouter {
    case signIn(email: String, pw: String)
    case signUp(email: String, name: String, pw: String)
}

extension AuthRouter: BaseRouter {

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
