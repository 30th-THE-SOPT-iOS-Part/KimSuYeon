//
//  LoginViewController.swift
//  30th-Assignment
//
//  Created by ๊น์์ฐ on 2022/04/04.
//

import UIKit

import SnapKit
import Then

final class LoginViewController: BaseViewController {

    private let logoImage = UIImageView().then {
        $0.image = ImageLiteral.imgInstagramLogo
        $0.contentMode = .scaleToFill
    }

    /// ๐ CustomUI ๋ฐ๋ก ๋ง๋ค์ด๋ณด๊ธฐ
    private let emailTextField = InstaTextField().then {
        $0.setPlaceholder(placeholder: "์ ํ๋ฒํธ, ์ฌ์ฉ์ ์ด๋ฆ ๋๋ ์ด๋ฉ์ผ")
        $0.setClearTextButton()
    }
    
    private let passwordTextField = InstaTextField().then {
        $0.setPlaceholder(placeholder: "๋น๋ฐ๋ฒํธ")
        $0.isSecureTextEntry = true
        $0.setPasswordCheckButton()
    }

    private let findPasswordButton = UIButton().then {
        $0.setTitle("๋น๋ฐ๋ฒํธ๋ฅผ ์์ผ์จ๋์?", for: .normal)
        $0.setTitleColor(UIColor(red: 0.216, green: 0.592, blue: 0.937, alpha: 1), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 10, weight: .semibold)
    }

    private lazy var loginButton = InstaButton(title: "๋ก๊ทธ์ธ").then {
        $0.isEnabled = false

        let LoginAction = UIAction { _ in
            self.postSignIn()
        }
        $0.addAction(LoginAction, for: .touchUpInside)
    }

    private let signUpLabel = UILabel().then {
        $0.text = "๊ณ์ ์ด ์์ผ์ ๊ฐ์?"
        $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        $0.font = .systemFont(ofSize: 14)
    }

    private lazy var signUpButton = UIButton().then {
        $0.setTitle("๊ฐ์ํ๊ธฐ", for: .normal)
        $0.setTitleColor(UIColor(red: 0.216, green: 0.592, blue: 0.937, alpha: 1), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)

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

    /// ํ๋ฉด ํฐ์นํ์ ๋ ํ์คํธ ํ๋ edit ์ข๋ฃํ๊ธฐ
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
            $0.top.equalToSuperview().inset(78)
            $0.centerX.equalToSuperview()
        }

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        findPasswordButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(13)
            $0.trailing.equalToSuperview().inset(16)
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(findPasswordButton.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        signUpLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(105)
            $0.top.equalTo(loginButton.snp.bottom).offset(37)
        }

        signUpButton.snp.makeConstraints {
            $0.centerY.equalTo(signUpLabel.snp.centerY)
            $0.leading.equalTo(signUpLabel.snp.trailing).offset(5)
        }
    }

    private func setTextField() {
        [emailTextField, passwordTextField].forEach {
            $0.delegate = self
            $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }

    func intialize() {
        /// ๋ทฐ ๋์ธ๋ ํํ ์ด๊ธฐํ ํ๊ธฐ & ๋ฒํผ ์ด๊ธฐํ
        loginButton.isEnabled = false
        [emailTextField, passwordTextField].forEach {
            $0?.text = ""
        }
    }

    @objc
    private func textFieldDidChange(_ sender: InstaTextField) {
        /// ๋์ ๊ณผ์  (2)
        loginButton.isEnabled = [emailTextField, passwordTextField].allSatisfy { $0.hasText }
    }

    private func postSignIn() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else { return }

        AuthService.shared.requestSignIn(email: email, pw: password) { result in
            switch result {
            case .success:
                    self.makePresentAlert(title: "๋ก๊ทธ์ธ ์ฑ๊ณต", nextVC: TabBarController())
            case .requestErr(let status):
                guard let status = status as? Int else { return }

                switch status {
                case 404:
                    self.makeAlert(title: "์ด๋ฉ์ผ์ ํด๋นํ๋ ์ฌ์ฉ์์ ๋ณด๊ฐ ์์ต๋๋ค.")
                case 409:
                    self.makeAlert(title: "๋น๋ฐ๋ฒํธ๊ฐ ์ฌ๋ฐ๋ฅด์ง ์์ต๋๋ค.")
                default:
                    self.makeAlert(title: "์์ด๋์ ๋น๋ฐ๋ฒํธ๋ฅผ ๋ค์ ํ์ธํด์ฃผ์ธ์.")
                }

            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    /// ํค๋ณด๋๋ก ์๋ ฅํ  ๊ฒฝ์ฐ, ํค๋ณด๋ return ํค๋ฅผ ๋ฐ๋ผ์ ์ด๋ ๊ฐ๋ฅ ํ๊ฒ +  ๋ง์ง๋ง์ ์ข๋ฃ
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField: passwordTextField.becomeFirstResponder()
        case passwordTextField: passwordTextField.resignFirstResponder()
        default: break
        }
        return true
    }
}
