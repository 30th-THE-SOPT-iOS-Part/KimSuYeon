//
//  ReelsViewController.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/04/23.
//

import UIKit

class ReelsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configUI() {
        view.backgroundColor = .green
        configTabBar()
    }

    private func configTabBar() {
        let appearance = UITabBar.appearance()

        appearance.tintColor = .white
        appearance.unselectedItemTintColor = .white
        appearance.backgroundColor = UIColor.black
    }
}
