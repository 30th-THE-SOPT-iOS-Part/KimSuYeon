//
//  Auth.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/16.
//

import Foundation

struct SignIn: Codable {
    let name, email: String
}

struct SignUp: Codable {
    let id: Int
}
