//
//  CompleteLoginCoordinator.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/19.
//

import Foundation
import UIKit

final class CompleteLoginCoordinator: Coordinator {
    
    var presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start(userName: String, password: String) {
        let completeLoginViewController = CompleteLoginViewController(coordinator: self)
        completeLoginViewController.userName = userName
        completeLoginViewController.password = password
        completeLoginViewController.modalPresentationStyle = .fullScreen
        transition(to: self, with: completeLoginViewController, using: .modal, animated: true)
    }

    func transitionToLogin() {
        let loginCoordinator = LoginCoordinator(presenter: presenter)
        loginCoordinator.start()
    }
}
