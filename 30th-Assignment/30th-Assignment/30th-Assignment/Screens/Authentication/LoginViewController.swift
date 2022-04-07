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
        $0.image = UIImage(named: "Instagram Black Logo")
        $0.contentMode = .scaleToFill
    }

    /// 🌀 CustomUI 따로 만들어보기
    private let emailTextField = InstaTextField(placeholder: "전화번호, 사용자 이름 또는 이메일")

    private let passwordTextField = InstaTextField(placeholder: "비밀번호").then {
        $0.isSecureTextEntry = true
    }

    private lazy var clearTextButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        $0.tintColor = .lightGray

        let clearTextAction = UIAction { _ in
            self.emailTextField.text = ""
        }

        $0.addAction(clearTextAction, for: .touchUpInside)
    }

    private let findPasswordButton = UIButton().then {
        $0.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
    }

    private lazy var loginButton = InstaButton(title: "로그인").then {

        let completeViewAction = UIAction { _ in
            let completeVC = CompleteLoginViewController()

            completeVC.modalPresentationStyle = .fullScreen
            completeVC.userName = self.emailTextField.text

            self.present(completeVC, animated: true)
        }

        $0.addAction(completeViewAction, for: .touchUpInside)
    }

    /// 🌀 ButtonHandler 사용해보기
    private lazy var passwordCheckButton = UIButton().then {
        var configuration = UIButton.Configuration.plain()
        $0.configuration = configuration

        let buttonStateHandler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.state {
            case .normal:
                button.configuration?.image = UIImage(named: "password hidden eye icon")
            case .selected:
                button.configuration?.image = UIImage(named: "password shown eye icon")
            default:
                return
            }
        }

        $0.configurationUpdateHandler = buttonStateHandler

        let showPasswordAction = UIAction { _ in
            /// 심화과제 : 눈 모양 버튼 누르면 비밀번호 secure 모드 해제 !
            self.showPassword()
        }

        $0.addAction(showPasswordAction, for: .touchUpInside)
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
        setTextFieldEmpty()
    }

    /// 화면 터치했을 때 텍스트 필드 edit 종료하기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func configUI() {
        setTextField()
        loginButton.isEnabled = false
    }

    override func render() {
        view.addSubViews([logoImage, emailTextField, passwordTextField, passwordCheckButton, clearTextButton, findPasswordButton, loginButton, signUpLabel, signUpButton])

        logoImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(200)
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

        passwordCheckButton.snp.makeConstraints {
            $0.centerY.equalTo(passwordTextField.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }

        clearTextButton.snp.makeConstraints {
            $0.centerY.equalTo(emailTextField.snp.centerY)
            $0.trailing.equalToSuperview().inset(25)
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

    private func showPassword() {
        passwordCheckButton.isSelected.toggle()
        passwordTextField.isSecureTextEntry = passwordCheckButton.isSelected ? false : true
    }

    private func setTextField() {
        clearTextButton.isHidden = true

        [emailTextField, passwordTextField].forEach {
            $0.delegate = self
            $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }

        emailTextField.addTarget(self, action: #selector(textFieldDidBegin(_:)), for: .editingDidBegin)
        emailTextField.addTarget(self, action: #selector(textFieldDidEnd(_:)), for: .editingDidEnd)
    }

    func setTextFieldEmpty() {
        /// 뷰 띄울때 텍필 초기화 하기
        [emailTextField, passwordTextField].forEach {
            $0?.text = ""
        }
    }

    @objc
    private func textFieldDidChange(_ sender: UITextField) {
        /// 도전과제 (2)
        loginButton.isEnabled = (emailTextField.hasText && passwordTextField.hasText) ? true : false
    }

    @objc
    private func textFieldDidBegin(_ sender: UITextField) {
        /// 도전과제(1)
        /// 텍스트필드에 값 입력할 시, clear 버튼 등장 !
        clearTextButton.isHidden = false
    }

    @objc
    private func textFieldDidEnd(_ sender: UITextField) {
        clearTextButton.isHidden = false
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
