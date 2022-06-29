//
//  GeneralResponse.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/16.
//

import Foundation

import Alamofire

class BaseService {

    enum TimeOut {
        static let requestTimeOut: Float = 30
        static let resourceTimeOut: Float = 30
    }

    let AFmanager: Session = {
        var session = AF
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = TimeInterval(TimeOut.requestTimeOut)
        configuration.timeoutIntervalForResource = TimeInterval(TimeOut.resourceTimeOut)

        session = Session(configuration: configuration)
        return session
    }()

    func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ type: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GeneralResponse<T>.self, from: data)
        else { return .pathErr }
        print(decodedData)
        switch statusCode {
        case 200:
            return .success(decodedData.data ?? "None-Data")
        case 201..<300:
            return .success(decodedData.status)
        case 400..<500:
            return .requestErr(decodedData.status)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
