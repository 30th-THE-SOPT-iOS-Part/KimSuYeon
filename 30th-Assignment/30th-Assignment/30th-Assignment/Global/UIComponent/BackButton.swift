//
//  BackButton.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/04/23.
//

import UIKit

import SnapKit

class BackButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }

    convenience init(present: UIViewController) {
        self.init()
        setAction(viewcontroller: present)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI() {
        setImage(ImageLiteral.btnBackBlack, for: .normal)

        self.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
    }

    private func setAction(viewcontroller: UIViewController) {
        let backAction = UIAction { _ in
            viewcontroller.navigationController?.popViewController(animated: true)
        }

        self.addAction(backAction, for: .touchUpInside)
    }
}
