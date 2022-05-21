//
//  AppCoordinator.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/19.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    var presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    var window: UIWindow

    // Appcoordinator 초기화 과정
    init(window: UIWindow) {
        self.window = window
        presenter = UINavigationController()
        window.backgroundColor = .white
        window.makeKeyAndVisible()
    }

    func start() {
        /// 자식 코디네이터 초기화 해주고, root를 탭바 컨트롤러로 !
        // removeChildCoordinators()
        transitionToLogin()
    }

    func transitionToTabbarController() -> UITabBarController {
        // 탭바컨트롤러로 전환하면서 생성해주기 !!
        let tabBarController = UITabBarController()

        let feedCoordinator = FeedCoordinator(presenter: UINavigationController())
        feedCoordinator.start()

        tabBarController.viewControllers = [
            feedCoordinator.presenter
        ]

        return tabBarController
    }

    func transitionToLogin() {
        let childCoordinator = LoginCoordinator(presenter: presenter)
        childCoordinator.parentCoordinator = self
        addChildCoordinator(childCoordinator)
        childCoordinator.start()
    }
}
