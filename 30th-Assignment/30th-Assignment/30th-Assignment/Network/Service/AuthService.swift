//
//  AuthService.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/16.
//

import Foundation
import Alamofire

/*
 AuthService : 실제 서버통신을 하기 위해 Service 함수를 구현하는 클래스
 싱글턴으로 접근한다. 앞서 만든 request 함수를 호출하고 Router를 통해 서버통신 수행
 네트워크 결과를 받아와서 
 */

class AuthService: BaseService {
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
