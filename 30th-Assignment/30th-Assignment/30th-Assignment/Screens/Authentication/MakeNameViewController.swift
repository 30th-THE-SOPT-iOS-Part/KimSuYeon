//
//  SignUpViewController.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/04/05.
//

import UIKit

import SnapKit
import Then

class MakeNameViewController: BaseViewController {

    private let titleLabel = UILabel().then {
        $0.text = "사용자 이름 만들기"
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = .black
    }

    private let descriptionLabel = UILabel().then {
        $0.text = "새 계정에 사용할 사용자 이름을 선택하세요. 나중에\n언제든지 변경할 수 있습니다."
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .lightGray
    }

    private let userNameTextField = AuthTextField(placeholder: "사용자 이름")

    private let nextButton = AuthButton(title: "다음")

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonAction()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func configUI() {
        view.backgroundColor = .white
        setupBaseNavigationBar()
        nextButton.isEnabled = false
        userNameTextField.delegate = self
    }

    override func render() {
        view.addSubViews([titleLabel, descriptionLabel, userNameTextField, nextButton])

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(100)
        }

        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
        }

        userNameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
        }

        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(userNameTextField.snp.bottom).offset(20)
        }
    }

    private func setButtonAction() {
        let pushMakePasswordViewAction = UIAction { [weak self] _ in
            let makePasswordVC = MakePasswordViewController()
            makePasswordVC.userName = self?.userNameTextField.text ?? ""

            self?.navigationController?.pushViewController(makePasswordVC, animated: true)
        }
        nextButton.addAction(pushMakePasswordViewAction, for: .touchUpInside)
    }
}

extension MakeNameViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        /// 도전과제 (2)
        /// 텍스트 입력 될 때만 적용하려면 Rx나 NotifiactionCenter 쓰기 .. 일단 귀차나서 패스..
        nextButton.isEnabled = userNameTextField.hasText ? true : false
    }

}
