//
//  TabBarController.swift
//  30th-1week-Seminar
//
//  Created by 김수연 on 2022/04/09.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeTabBarItems()
        setTabBarAppearance()
        makeBorder()
    }

    /// override 해서 다양한 속성들을 기본적으로 지정해줄 수 있음 !
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let itemView = item.value(forKey: "view") as? UIView else { return }
        let itemAnimator = UIViewPropertyAnimator(duration: 0.1, dampingRatio: 0.5) {
            itemView.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
        }
        itemAnimator.addAnimations({itemView.transform = .identity }, delayFactor: 0.5)
        itemAnimator.startAnimation()
    }

    private func makeTabBarItems() {
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(named: "Home"),
            selectedImage: UIImage(named: "Homefill")
        )

        let userVC = UserViewController()
        userVC.tabBarItem = UITabBarItem(
            title: "마이페이지",
            image: UIImage(named: "User"),
            selectedImage: UIImage(named: "Userfill")
        )


        let imageVC = ImageViewController()
        imageVC.tabBarItem = UITabBarItem(
            title: "갤러리",
            image: UIImage(named: "Image"),
            selectedImage: UIImage(named: "Imagefill")
        )

        viewControllers = [
            homeVC,
            userVC,
            imageVC
        ]
    }

    private func setTabBarAppearance() {
        let appearance = UITabBar.appearance()
        let itemApperance = UITabBarItem.appearance()

        appearance.tintColor = .black
        appearance.unselectedItemTintColor = .black
        appearance.backgroundColor = UIColor.white

        appearance.shadowImage = UIImage()
        appearance.backgroundImage = UIImage()

        let font = UIFont.systemFont(ofSize: 10, weight: .regular)
        itemApperance.setTitleTextAttributes([.font: font], for: .normal)
    }

    private func makeBorder() {
        tabBar.layer.borderColor = UIColor.systemGray5.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
    }
}
