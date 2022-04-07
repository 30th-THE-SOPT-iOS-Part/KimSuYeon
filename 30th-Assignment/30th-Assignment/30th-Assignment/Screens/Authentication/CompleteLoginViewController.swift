//
//  CompleteLoginViewController.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/04/05.
//

import UIKit

import SnapKit
import Then

class CompleteLoginViewController: BaseViewController {

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
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = .black
    }

    private let descriptionLabel = UILabel().then {
        $0.text = "언제든지 연락처 정보와 사용자 이름을 변경할 수 있습니다."
        $0.numberOfLines = 1
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .lightGray
    }

    private let doneButton = InstaButton(title: "완료하기")

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonAction()
    }

    override func configUI() {
        view.backgroundColor = .white
        setupBaseNavigationBar()
    }

    override func render() {
        view.addSubViews([titleLabel, descriptionLabel, doneButton])

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(300)
        }

        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
        }

        doneButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
    }

    private func setButtonAction() {
        let LoginViewAction = UIAction { [weak self] _ in
            /// 루트 뷰컨 으로 돌아가는게 안보이게 하려면 ?
            guard let presentingVC = self?.presentingViewController as? UINavigationController else { return }

            self?.dismiss(animated: true) {
                presentingVC.popToRootViewController(animated: true)
            }
        }
        doneButton.addAction(LoginViewAction, for: .touchUpInside)
    }

    private func applyUsername(to userName: String) {
        titleLabel.text = "\(userName)님 Instargram에 \n 오신 것을 환영합니다"
    }
}
