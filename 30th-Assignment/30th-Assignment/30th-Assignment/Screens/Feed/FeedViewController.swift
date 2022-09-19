//
//  FeedViewController.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/04/23.
//

import UIKit

class FeedViewController: BaseViewController {

    private var coordinator: FeedCoordinator

    init(coordinator: FeedCoordinator) {
        self.coordinator = coordinator
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator.didFinishChildCoordinator()
    }

    override func configUI() {
        view.backgroundColor = .blue
    }
}
