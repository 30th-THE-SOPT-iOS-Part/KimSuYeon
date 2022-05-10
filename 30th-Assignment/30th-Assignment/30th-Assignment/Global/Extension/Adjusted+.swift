//
//  Adjusted+.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/10.
//

import Foundation
import UIKit

/*
 스크린 너비 375를 기준으로 디자인이 나왔을 때 현재 기기의 스크린 사이즈에 비례하는 수치를 return
 기기별 대응에 사용하기 !
 */

extension CGFloat {
    var adjustedWidth: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 375
        return self * ratio
    }

    var adjustedHeight: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.height / 812
        return self * ratio
    }
}

extension Double {
    var adjustedWidth: Double {
        let ratio: Double = UIScreen.main.bounds.width / 375
        return self * ratio
    }

    var adjustedHeight: Double {
        let ratio: Double = UIScreen.main.bounds.height / 812
        return self * ratio
    }
}
