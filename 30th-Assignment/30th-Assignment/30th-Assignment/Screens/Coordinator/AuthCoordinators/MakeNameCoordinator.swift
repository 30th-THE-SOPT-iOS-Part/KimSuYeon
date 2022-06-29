//
//  SignUpCoordinator.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/19.
//

import Foundation
import UIKit

final class MakeNameCoordinator: Coordinator {

    var presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start() {
        let makeNameViewController = MakeNameViewController(coordinator: self)
        presenter.setViewControllers([makeNameViewController], animated: true)
    }

    func transitionToMakePassword(userName: String) {
        let childCoordinator = MakePasswordCoordinator(presenter: presenter)
        childCoordinator.parentCoordinator = self
        addChildCoordinator(childCoordinator)
        childCoordinator.start(userName: userName)
    }
}
