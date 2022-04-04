//
//  RegisterPasswordViewController.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/04/05.
//

import UIKit

import SnapKit
import Then

class MakePasswordViewController: BaseViewController {

    var userName: String?

    private let titleLabel = UILabel().then {
        $0.text = "비밀번호 만들기"
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = .black
    }

    private let descriptionLabel = UILabel().then {
        $0.text = "비밀번호를 저장할 수 있으므로 iCloud 기기에서 로그인\n정보를 입력하지 않아도 됩니다."
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .lightGray
    }

    private let passwordTextField = AuthTextField(placeholder: "비밀번호")

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
        passwordTextField.delegate = self
    }

    override func render() {
        view.addSubViews([titleLabel, descriptionLabel, passwordTextField, nextButton])

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(100)
        }

        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
        }

        passwordTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
        }

        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
        }
    }

    private func setButtonAction() {
        let completeViewAction = UIAction { [weak self] _ in
            let completeVC = CompleteLoginViewController()
            completeVC.modalPresentationStyle = .fullScreen
            completeVC.userName = self?.userName
            self?.present(completeVC, animated: true)
        }
        nextButton.addAction(completeViewAction, for: .touchUpInside)
    }
}

extension MakePasswordViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        /// 도전과제 (2)
        nextButton.isEnabled = passwordTextField.hasText ? true : false
    }
}
