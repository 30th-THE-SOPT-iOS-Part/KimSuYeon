//
//  LoginViewController.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/04/04.
//

import UIKit

import SnapKit
import Then

class LoginViewController: BaseViewController {

    private let logoImage = UIImageView().then {
        $0.image = UIImage(named: "Instagram Black Logo")
        $0.contentMode = .scaleToFill
    }

    /// 🌀 개인 도전 : CustomUI 따로 만들어보기
    private let emailTextField = AuthTextField(placeholder: "전화번호, 사용자 이름 또는 이메일")

    private let passwordTextField = AuthTextField(placeholder: "비밀번호").then {
        $0.isSecureTextEntry = true
    }

    private let clearTextButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        $0.tintColor = .lightGray
    }

    private let findPasswordButton = UIButton().then {
        $0.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
    }

    private let loginButton = AuthButton(title: "로그인")

    /// 🌀 개인 도전 : ButtonHandler 사용해보기
    private let passwordCheckButton = UIButton().then {
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
    }

    private let signUpLabel = UILabel().then {
        $0.text = "계정이 없으신가요?"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 15)
    }

    private let signUpButton = UIButton().then {
        $0.setTitle("가입하기", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 17)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonAction()
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
            /// 알게 된 것 : 코드로 레이아웃 잡을 때 textfield의 centerY가 잡혀있지 않아도 요러케 같은 위치로 설정가넝
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

    /// 🌀 개인 도전 :  UIAction 사용해보기 - 메모리 문제 때문에 weak self 써줬는데 불편한거 같기도 은근
    ///  버튼 Rx.tap이나 press Extension 따로 빼서 쓰는 방법도 있다 / 기본은 addTarget
    private func setButtonAction() {
        let showPasswordAction = UIAction { [weak self] _ in
            /// 심화과제 : 눈 모양 버튼 누르면 비밀번호 secure 모드 해제 !
            self?.passwordCheckButton.isSelected.toggle()
            self?.showPassword()
        }
        passwordCheckButton.addAction(showPasswordAction, for: .touchUpInside)

        let clearTextAction = UIAction { [weak self] _ in
            self?.emailTextField.text = ""
        }
        clearTextButton.addAction(clearTextAction, for: .touchUpInside)

        let pushSignUpViewAction = UIAction { [weak self] _ in
            self?.navigationController?.pushViewController(MakeNameViewController(), animated: true)
        }
        signUpButton.addAction(pushSignUpViewAction, for: .touchUpInside)

        let completeViewAction = UIAction { [weak self] _ in
            let completeVC = CompleteLoginViewController()
            completeVC.modalPresentationStyle = .fullScreen

            self?.present(completeVC, animated: true)
        }
        loginButton.addAction(completeViewAction, for: .touchUpInside)
    }

    private func showPassword() {
        passwordTextField.isSecureTextEntry = passwordCheckButton.isSelected ? false : true
    }

    private func setTextField() {
        [emailTextField, passwordTextField].forEach {
            $0?.delegate = self
        }

        clearTextButton.isHidden = true
    }

    func setTextFieldEmpty() {
        /// 뷰 띄울때 텍필 초기화 하기
        [emailTextField, passwordTextField].forEach {
            $0?.text = ""
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        /// 도전과제(1)
        /// 텍스트필드에 값 입력할 시, clear 버튼 등장 !
        if textField == emailTextField {
            clearTextButton.isHidden = false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        /// 도전과제 (2)
        /// 텍스트 입력 될 때만 적용하려면 Rx나 NotifiactionCenter 쓰기 .. 일단 귀차나서 패스..
        loginButton.isEnabled = (emailTextField.hasText && passwordTextField.hasText) ? true : false

        if textField == emailTextField {
            clearTextButton.isHidden = true
        }
    }

    /// 시뮬이 아닌 실기기에서 키보드로 입력할 경우, 키보드 return 키를 따라서 이동 가능 하게 +  마지막은 종료
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField: passwordTextField.becomeFirstResponder()
        case passwordTextField: passwordTextField.resignFirstResponder()
        default: break
        }
        return true
    }
}
