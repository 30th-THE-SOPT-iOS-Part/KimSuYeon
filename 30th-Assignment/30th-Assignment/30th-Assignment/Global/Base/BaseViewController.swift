//
//  BaseViewController.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/04/04.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {

    let disposeBag = DisposeBag()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configUI()
    }

    func render() {
        // Override Layout
    }

    func configUI() {
        // View Configuration
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    func setupBaseNavigationBar(backgroundColor: UIColor = .white,
                                titleColor: UIColor = .black,
                                isTranslucent: Bool = false,
                                tintColor: UIColor = .black) {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let appearance = UINavigationBarAppearance()

        appearance.backgroundColor = backgroundColor
        appearance.shadowColor = .clear

        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.isTranslucent = isTranslucent
        navigationBar.tintColor = tintColor
    }

}
