//
//  AuthService.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/16.
//

import Foundation
import Alamofire

class AuthService: GeneralService {
    static let shared = AuthService()

    private override init() { }

    /// [POST] 로그인
    func requestSignIn(email: String, pw: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(AuthRouter.signIn(email: email, pw: pw))
            .validate(statusCode: 200...500)
            .responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, SignIn.self)

                completion(networkResult)

            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    /// [POST] 회원가입
    func requestSignUp(email: String, name: String, pw: String, completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(AuthRouter.signUp(email: email, name: name, pw: pw))
            .validate(statusCode: 200...500)
            .responseData { response in
                switch response.result {
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let data = response.data else { return}
                    let networkResult = self.judgeStatus(by: statusCode, data, SignUp.self)

                    completion(networkResult)

                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
    }
}
