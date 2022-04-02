//
//  ThirdViewController.swift
//  30th-1week-Seminar
//
//  Created by 김수연 on 2022/04/02.
//

import UIKit

import Then
import SnapKit

class ThirdViewController: UIViewController {

    var message: String?

    private let backButton = UIButton().then {
        $0.setTitle("뒤로가기버튼", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: 28, height: 28)

    }

    private let dataLabel = UILabel().then {
        $0.textColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        render()
        setAddTarget()
        setMessage()
    }

    private func configUI() {
        view.backgroundColor = .blue
    }

    private func render() {
        view.addSubview(dataLabel)
        view.addSubview(backButton)

        dataLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(150)
        }

        backButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }

    private func setAddTarget() {
        backButton.addTarget( self, action: #selector(didTap(_:)), for: .touchUpInside)
    }

    private func setMessage() {
        if let message = message {
            dataLabel.text = message
            dataLabel.sizeToFit()
        }
    }

    @objc
    func didTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
