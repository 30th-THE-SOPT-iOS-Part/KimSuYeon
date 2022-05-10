//
//  NSObject+.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/10.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
