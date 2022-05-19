//
//  NetworkConstants.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/16.
//

import Foundation
import Alamofire

/*
 NetworkConstants : 서버통신과정에서 필요한 상수들을 관리 -> header 관련 상수들
 */

enum HeaderType {
    case basic
    case auth
    case multiPart
    case multiPartWithAuth
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case accesstoken = "accesstoken"
}

enum ContentType: String {
    case json = "Application/json"
    case tokenSerial = ""
    case multiPart = "multipart/form-data"
}
