//
//  MakePasswordCoordinator.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/19.
//

import Foundation
import UIKit

final class MakePasswordCoordinator: Coordinator {

    var presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start(userName: String) {
        let makePasswordViewController = MakePasswordViewController(coordinator: self)
        makePasswordViewController.userName = userName
        transition(to: self, with: makePasswordViewController, using: .push, animated: true)
    }

    func transitionToComplete(userName: String, password: String) {
        let childCoordinator = CompleteLoginCoordinator(presenter: presenter)
        childCoordinator.parentCoordinator = self
        addChildCoordinator(childCoordinator)
        childCoordinator.start(userName: userName, password: password)
    }
}
