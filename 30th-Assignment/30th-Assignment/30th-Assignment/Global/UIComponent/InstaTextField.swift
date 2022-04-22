//
//  AuthTextField.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/04/04.
//

import UIKit

import SnapKit

class InstaTextField: UITextField {

    private let leftSpaceView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 50))

    private lazy var clearTextButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        $0.tintColor = .lightGray

        let clearTextAction = UIAction { _ in
            self.text = ""
        }
        $0.addAction(clearTextAction, for: .touchUpInside)
    }

    private lazy var passwordCheckButton = UIButton().then {
        var configuration = UIButton.Configuration.plain()
        $0.configuration = configuration
        $0.configuration?.contentInsets = .zero

        let buttonStateHandler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.state {
            case .normal:
                button.configuration?.image = ImageLiteral.iconPasswordHidden
            case .selected:
                button.configuration?.image = ImageLiteral.iconPasswordShown
                button.configuration?.background.backgroundColor = .clear
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

    init() {
        super.init(frame: .zero)
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI() {
        leftView = leftSpaceView
        leftViewMode = .always

        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer.cornerRadius = 5
        
        textColor = .black
        backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "" , attributes: [.foregroundColor: UIColor.systemGray3])

        self.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }

    func setClearTextButton() {
        let buttonView = UIView()
        buttonView.addSubview(clearTextButton)
        clearTextButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
        }

        rightView = buttonView
        rightViewMode = .whileEditing
        rightView?.snp.makeConstraints {
            $0.width.height.equalTo(35)
        }
    }

    func setPasswordCheckButton() {
        let buttonView = UIView()
        buttonView.addSubview(passwordCheckButton)
        passwordCheckButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
        }

        rightView = buttonView
        rightViewMode = .always
        rightView?.snp.makeConstraints {
            $0.width.height.equalTo(35)
        }
    }

    private func showPassword() {
        passwordCheckButton.isSelected.toggle()
        self.isSecureTextEntry = passwordCheckButton.isSelected ? false : true
    }

    func setPlaceholder(placeholder: String) {
        self.placeholder = placeholder
    }
}
