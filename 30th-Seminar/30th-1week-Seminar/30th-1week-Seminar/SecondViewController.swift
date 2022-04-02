//
//  SecondViewController.swift
//  30th-1week-Seminar
//
//  Created by 김수연 on 2022/04/02.
//

import UIKit

import Then
import SnapKit

class SecondViewController: UIViewController {

    private let firstButton = UIButton().then {
        $0.setTitle("데이터 전달하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: 28, height: 28)

    }

    private var dataTextField = UITextField().then {
        $0.backgroundColor = .white
        $0.textColor = .black
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        render()
        setAddTarget()
    }

    private func configUI() {
        view.backgroundColor = .red
    }

    private func render() {
        view.addSubview(firstButton)
        view.addSubview(dataTextField)

        firstButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        dataTextField.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(firstButton.snp.top).offset(-100)
        }
    }

    private func setAddTarget() {
        firstButton.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
    }

    @objc
    func didTap(_ sender: UIButton) {
        let thirdVC = ThirdViewController()

        thirdVC.message = dataTextField.text
        self.navigationController?.pushViewController(thirdVC, animated: true)

    }
}
