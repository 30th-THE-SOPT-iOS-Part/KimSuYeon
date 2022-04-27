//
//  SignUpViewController.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/04/05.
//

import UIKit

import SnapKit
import Then

final class MakeNameViewController: BaseViewController {

    let viewModel = MakeNameViewModel()

    private let titleLabel = UILabel().then {
        $0.text = "사용자 이름 만들기"
        $0.font = .systemFont(ofSize: 24)
        $0.textColor = .black
    }

    private let descriptionLabel = UILabel().then {
        $0.text = "새 계정에 사용할 사용자 이름을 선택하세요. 나중에\n언제든지 변경할 수 있습니다."
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .lightGray
    }

    private lazy var userNameTextField = InstaTextField().then {
        $0.setPlaceholder(placeholder: "사용자 이름")
        $0.setClearTextButton()
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    private lazy var nextButton = InstaButton(title: "다음").then {
        $0.isEnabled = false

        let pushMakePasswordViewAction = UIAction { _ in
            let makePasswordVC = MakePasswordViewController()
            
            makePasswordVC.userName = self.userNameTextField.text ?? ""
            self.navigationController?.pushViewController(makePasswordVC, animated: true)
        }
        $0.addAction(pushMakePasswordViewAction, for: .touchUpInside)
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
        setupNavigationBar()
    }

    override func render() {
        view.addSubViews([titleLabel, descriptionLabel, userNameTextField, nextButton])

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(11)
        }

        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(11)
        }

        userNameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(22)
        }

        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(userNameTextField.snp.bottom).offset(22)
        }
    }

    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: BackButton(present: self))
    }
    
    @objc
    private func textFieldDidChange(_ sender: UITextField) {
        nextButton.isEnabled = userNameTextField.hasText
    }
}
