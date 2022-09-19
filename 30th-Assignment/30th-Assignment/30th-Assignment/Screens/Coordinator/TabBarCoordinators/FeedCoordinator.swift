//
//  FeedCoordinator.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/19.
//

import Foundation
import UIKit

final class FeedCoordinator: Coordinator {

    var presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start() {
        let feedViewController = FeedViewController(coordinator: self)
        feedViewController.tabBarItem = UITabBarItem(title: "", image: ImageLiteral.iconHome,selectedImage: ImageLiteral.iconHomeSelected)
        presenter.setViewControllers([feedViewController], animated: false)
    }
}
