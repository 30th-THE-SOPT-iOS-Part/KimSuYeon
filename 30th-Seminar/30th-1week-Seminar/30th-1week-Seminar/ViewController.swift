//
//  ViewController.swift
//  30th-1week-Seminar
//
//  Created by 김수연 on 2022/04/02.
//

import UIKit

import AVFoundation
import Then
import SnapKit

class ViewController: UIViewController {

    private let firstLabel = UILabel().then {
        $0.text = "도착한 메시지가 없어요!"
    }

    private let firstButton = UIButton().then {
        $0.setTitle("태끼 괴롭히러가기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        $0.backgroundColor = .gray
        $0.addTarget( ViewController.self, action: #selector(didTap(_:)), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }

    func render() {
        view.addSubview(firstLabel)
        view.addSubview(firstButton)

        firstLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
        }

        firstButton.snp.makeConstraints {
            $0.top.equalTo(firstLabel.snp.bottom).offset(100)
            $0.centerX.equalToSuperview()
        }
    }


    @objc
    func didTap(_ sender: UIButton) {
        firstLabel.text = "산태끼 태끼야 ~"
        firstLabel.textColor = .green
        firstLabel.sizeToFit()
    }
}

