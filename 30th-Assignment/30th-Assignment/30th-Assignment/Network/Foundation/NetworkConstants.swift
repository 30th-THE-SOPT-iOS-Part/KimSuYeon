//
//  NetworkConstants.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/16.
//

import Foundation

enum HeaderType {
    case basic
    case auth
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case accesstoken = "accesstoken"
}

enum ContentType: String {
    case json = "Application/json"
    case tokenSerial = ""
}
