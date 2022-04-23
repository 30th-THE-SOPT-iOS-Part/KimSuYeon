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
            guard let presentingVC = self.presentingViewController as? UINavigationController else { return }
            
            presentingVC.popToRootViewController(animated: true)
            self.dismiss(animated: true)
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
        print("탭탭")
        guard let presentingVC = self.presentingViewController as? UINavigationController else { return }

        presentingVC.popToRootViewController(animated: true)
        self.dismiss(animated: true)
    }
}
