//
//  UIView+Extension.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/04/04.
//

import UIKit

extension UIView {
    func addSubViews<T: UIView>(_ subviews: [T]) {
        subviews.forEach { addSubview($0) }
    }
}
