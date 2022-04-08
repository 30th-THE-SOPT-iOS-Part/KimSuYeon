//
//  LoginViewController.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/04/04.
//

import UIKit

import SnapKit
import Then

final class LoginViewController: BaseViewController {

    private let logoImage = UIImageView().then {
        $0.image = ImageLiteral.imgInstagramLogo
        $0.contentMode = .scaleToFill
    }

    /// 🌀 CustomUI 따로 만들어보기
    private let emailTextField = InstaTextField(placeholder: "전화번호, 사용자 이름 또는 이메일").then {
        $0.setClearTextButton()
    }
    
    private let passwordTextField = InstaTextField(placeholder: "비밀번호").then {
        $0.isSecureTextEntry = true
        $0.setPasswordCheckButton()
    }

    private let findPasswordButton = UIButton().then {
        $0.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
    }

    private lazy var loginButton = InstaButton(title: "로그인").then {
        $0.isEnabled = false

        let completeViewAction = UIAction { _ in
            let completeVC = CompleteLoginViewController()

            completeVC.modalPresentationStyle = .fullScreen
            completeVC.userName = self.emailTextField.text
            self.present(completeVC, animated: true)
        }
        $0.addAction(completeViewAction, for: .touchUpInside)
    }

    private let signUpLabel = UILabel().then {
        $0.text = "계정이 없으신가요?"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 15)
    }

    private lazy var signUpButton = UIButton().then {
        $0.setTitle("가입하기", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 17)

        let pushSignUpViewAction = UIAction { _ in
            self.navigationController?.pushViewController(MakeNameViewController(), animated: true)
        }
        $0.addAction(pushSignUpViewAction, for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        intialize()
    }

    /// 화면 터치했을 때 텍스트 필드 edit 종료하기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func configUI() {
        setupBaseNavigationBar()
        setTextField()
    }

    override func render() {
        view.addSubViews([logoImage, emailTextField, passwordTextField, findPasswordButton, loginButton, signUpLabel, signUpButton])

        logoImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
        }

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        findPasswordButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(15)
            $0.trailing.equalToSuperview().inset(16)
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(findPasswordButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        signUpLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
        }

        signUpButton.snp.makeConstraints {
            $0.centerY.equalTo(signUpLabel.snp.centerY)
            $0.leading.equalTo(signUpLabel.snp.trailing).offset(10)
        }
    }

    private func setTextField() {
        [emailTextField, passwordTextField].forEach {
            $0.delegate = self
            $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }

    func intialize() {
        /// 뷰 띄울때 텍필 초기화 하기 & 버튼 초기화
        loginButton.isEnabled = false
        [emailTextField, passwordTextField].forEach {
            $0?.text = ""
        }
    }

    @objc
    private func textFieldDidChange(_ sender: InstaTextField) {
        /// 도전과제 (2)
        loginButton.isEnabled = (emailTextField.hasText && passwordTextField.hasText) ? true : false
    }
}

extension LoginViewController: UITextFieldDelegate {
    /// 키보드로 입력할 경우, 키보드 return 키를 따라서 이동 가능 하게 +  마지막은 종료
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField: passwordTextField.becomeFirstResponder()
        case passwordTextField: passwordTextField.resignFirstResponder()
        default: break
        }
        return true
    }
}
