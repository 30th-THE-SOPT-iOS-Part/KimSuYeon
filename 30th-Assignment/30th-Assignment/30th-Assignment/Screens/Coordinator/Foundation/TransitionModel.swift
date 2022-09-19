//
//  TransitionModel.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/19.
//

import Foundation

/// 화면전환 스타일 enum

enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransitionError {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
