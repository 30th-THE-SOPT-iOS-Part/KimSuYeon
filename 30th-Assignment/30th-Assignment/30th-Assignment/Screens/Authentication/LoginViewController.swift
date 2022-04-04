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

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonAction()
    }

    /// 화면 터치했을 때 텍스트 필드 edit 종료하기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func configUI() {

    }

    override func render() {
        view.addSubViews([logoImage, emailTextField, passwordTextField, passwordCheckButton])

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
    }

    /// 🌀 개인 도전 :  UIAction 사용해보기
    private func setButtonAction() {
        let showPasswordAction = UIAction { [weak self] _ in
            /// 심화과제 : 눈 모양 버튼 누르면 비밀번호 secure 모드 해제 !
            self?.passwordCheckButton.isSelected.toggle()
            self?.showPassword()
        }
        passwordCheckButton.addAction(showPasswordAction, for: .touchUpInside)
    }

    private func showPassword() {
        passwordTextField.isSecureTextEntry = passwordCheckButton.isSelected ? false : true
    }

}
