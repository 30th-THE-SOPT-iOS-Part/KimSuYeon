//
//  CompleteLoginViewController.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/04/05.
//

import UIKit

import SnapKit
import Then

final class CompleteLoginViewController: BaseViewController {

    var userName: String? {
        didSet {
            if let userName = userName {
                applyUsername(to: userName)
            }
        }
    }
    var password: String?

    private let titleLabel = UILabel().then {
        $0.text = "땡땡땡님 Instargram에 \n 오신 것을 환영합니다"
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 24)
        $0.textColor = .black
    }

    private let descriptionLabel = UILabel().then {
        $0.text = "언제든지 연락처 정보와 사용자 이름을 변경할 수 있습니다."
        $0.numberOfLines = 1
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .lightGray
    }

    private lazy var doneButton = InstaButton(title: "완료하기").then {
        let LoginViewAction = UIAction { _ in
            self.postSignUp()
        }
        $0.addAction(LoginViewAction, for: .touchUpInside)
    }

    private let otherAccountLabel = UILabel().then {
        $0.text = "다른 계정으로 로그인하기"
        $0.textColor = UIColor(red: 0.216, green: 0.592, blue: 0.937, alpha: 1)
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configUI() {
        view.backgroundColor = .white
        setupBaseNavigationBar()
        setGesture()
    }

    override func render() {
        view.addSubViews([titleLabel, descriptionLabel, doneButton, otherAccountLabel])

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(310)
        }

        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
        }

        doneButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(37)
        }

        otherAccountLabel.snp.makeConstraints {
            $0.top.equalTo(doneButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }

    private func applyUsername(to userName: String) {
        titleLabel.text = "\(userName)님 Instargram에 \n 오신 것을 환영합니다"
    }

    private func setGesture() {
        let tapPressRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))

        self.otherAccountLabel.addGestureRecognizer(tapPressRecognizer)
    }

    @objc func handleTapGesture(_ sender: UITapGestureRecognizer) {
        guard let presentingVC = self.presentingViewController as? UINavigationController else { return }

        presentingVC.popToRootViewController(animated: true)
        self.dismiss(animated: true)
    }

    private func postSignUp() {
        guard let name = userName,
              let email = userName,
              let password = password
        else { return }

        AuthService.shared.requestSignUp(email: email, name: name, pw: password) { result in
            switch result {
            case .success:
                self.makeAlert(title: "회원가입 성공") { UIAlertAction in
                    guard let presentingVC = self.presentingViewController as? UINavigationController else { return }

                    presentingVC.popToRootViewController(animated: true)
                    self.dismiss(animated: true)
                }
            case .requestErr(let status):
                guard let status = status as? Int else { return }

                switch status {
                case 409:
                    self.makeAlert(title: "동일한 이메일로 생성된 계정이 존재합니다.")
                default:
                    self.makeAlert(title: "아이디와 비밀번호를 확인해주세요.")
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
