//
//  NetworkResult.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/16.
//

import Foundation

/*
 NetworkResult : 네트워크 결과 나누기
 */

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
