//
//  LoginCoordinator.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/19.
//

import Foundation
import UIKit

final class LoginCoordinator: Coordinator {

    var presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start() {
        let loginViewController = LoginViewController(coordinator: self)
        transition(to: self, with: loginViewController, using: .root)
        // presenter.setViewControllers([loginViewController], animated: false)
    }

    func transitionToMakeName() {
        let childCoordinator = MakeNameCoordinator(presenter: presenter)
        childCoordinator.parentCoordinator = self
        addChildCoordinator(childCoordinator)
        childCoordinator.start()
    }

    func transitionToFeed() {
        let feedCoordinator = FeedCoordinator(presenter: presenter)
        feedCoordinator.start()
        // transition(to: feedCoordinator, with: FeedViewController(coordinator: feedCoordinator), using: .root)
    }
}

