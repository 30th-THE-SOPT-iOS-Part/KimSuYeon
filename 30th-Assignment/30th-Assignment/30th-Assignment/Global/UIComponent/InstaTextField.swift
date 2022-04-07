//
//  AuthTextField.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/04/04.
//

import UIKit

import SnapKit

class InstaTextField: UITextField {

    // leftspaceview extension 추가해보기
    private let leftSpaceView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 50))

    init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI() {
        leftView = leftSpaceView
        leftViewMode = .always

        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 5
        
        textColor = .black
        backgroundColor = .systemGray6
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "" , attributes: [.foregroundColor: UIColor.darkGray])

        self.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
}
