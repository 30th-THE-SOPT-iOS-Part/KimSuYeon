//
//  TabBarController.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/04/23.
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
//        let feedVC = FeedViewController(coordinator: FeedCoordinator)
//        feedVC.tabBarItem = UITabBarItem(
//            title: "",
//            image: ImageLiteral.iconHome,
//            selectedImage: ImageLiteral.iconHomeSelected
//        )

        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(
            title: "",
            image: ImageLiteral.iconSearch,
            selectedImage: ImageLiteral.iconSearchSelected
        )


        let reelsVC = ReelsViewController()
        reelsVC.tabBarItem = UITabBarItem(
            title: "",
            image: ImageLiteral.iconReels,
            selectedImage: ImageLiteral.iconReelsSelected
        )

        let shopVC = ShopViewController()
        shopVC.tabBarItem = UITabBarItem(
            title: "",
            image: ImageLiteral.iconShop,
            selectedImage: ImageLiteral.iconShopSelected
        )

        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(
            title: "",
            image: ImageLiteral.iconProfile,
            selectedImage: ImageLiteral.iconProfileSelected
        )

        let tabBarViewControllers: [UIViewController] = {
            let tabBarViewControllers = [
                                         searchVC,
                                         reelsVC,
                                         shopVC,
                                         profileVC]
                .map(wrapInNavigationController)
            return tabBarViewControllers
        }()

        setViewControllers(tabBarViewControllers, animated: true)
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

    private func setReelsTabBarAppearance() {

    }

    private func makeBorder() {
        tabBar.layer.borderColor = UIColor.systemGray5.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
    }

    private func wrapInNavigationController(viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
