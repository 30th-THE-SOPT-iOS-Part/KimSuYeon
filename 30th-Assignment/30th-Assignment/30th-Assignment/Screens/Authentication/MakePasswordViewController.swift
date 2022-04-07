//
//  RegisterPasswordViewController.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/04/05.
//

import UIKit

import SnapKit
import Then

final class MakePasswordViewController: BaseViewController {

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

    private lazy var passwordTextField = InstaTextField(placeholder: "비밀번호").then {
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    private lazy var nextButton = InstaButton(title: "다음").then {
        $0.isEnabled = false
        let completeViewAction = UIAction { _ in
            let completeVC = CompleteLoginViewController()

            completeVC.modalPresentationStyle = .fullScreen
            completeVC.userName = self.userName

            self.present(completeVC, animated: true)
        }

        $0.addAction(completeViewAction, for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func configUI() {
        view.backgroundColor = .white
        setupBaseNavigationBar()
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

    @objc
    private func textFieldDidChange(_ sender: UITextField) {
        nextButton.isEnabled = passwordTextField.hasText ? true : false
    }
}
