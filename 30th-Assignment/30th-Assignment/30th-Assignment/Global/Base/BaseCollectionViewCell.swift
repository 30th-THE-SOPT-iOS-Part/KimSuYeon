//
//  BaseCollectionViewCell.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/10.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func render() {
        // Override Layout
    }

    func configUI() {
        // View Configuration
    }
}
