//
//  AuthButton.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/04/05.
//

import UIKit

import SnapKit

class InstaButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        setUI(title: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI(title: String) {
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 16)

        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString(title, attributes: container)
        configuration.background.cornerRadius = 5
        configuration.titleAlignment = .center
        configuration.baseForegroundColor = .white

        self.configuration = configuration

        let buttonStateHandler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.state {
            case .normal:
                button.configuration?.background.backgroundColor = .systemBlue.withAlphaComponent(1)
            case .disabled:
                button.configuration?.background.backgroundColor = .systemBlue.withAlphaComponent(0.5)
            default:
                return
            }
        }

        self.configurationUpdateHandler = buttonStateHandler

        self.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }

}
