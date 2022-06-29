//
//  UIViewController+.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/17.
//

import UIKit

extension UIViewController {

    /// 확인 버튼 1개, 취소 버튼 1개 Alert 메서드
    func makeAlertWithCancel(okTitle: String, okStyle: UIAlertAction.Style = .default,
                             cancelTitle: String = "취소",
                             okAction : ((UIAlertAction) -> Void)?, cancelAction : ((UIAlertAction) -> Void)? = nil,
                             completion : (() -> Void)? = nil) {

        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        let alertViewController = UIAlertController(title: nil, message: nil,
                                                    preferredStyle: .actionSheet)

        let okAction = UIAlertAction(title: okTitle, style: okStyle, handler: okAction)
        alertViewController.addAction(okAction)

        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelAction)
        alertViewController.addAction(cancelAction)

        self.present(alertViewController, animated: true, completion: completion)
    }

    /// 확인 버튼 Alert 메서드
    func makeAlert(title : String, message : String? = nil,
                   okTitle: String = "확인", okAction : ((UIAlertAction) -> Void)? = nil,
                   completion : (() -> Void)? = nil) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        let alertViewController = UIAlertController(title: title, message: message,
                                                    preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: okAction)
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true, completion: completion)
    }

    /// 확인 버튼 누르면 화면전환되는 Alert 메서드
    func makePresentAlert(title : String, message : String? = nil,
                          okTitle: String = "확인", nextVC: UIViewController) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        let alertViewController = UIAlertController(title: title, message: message,
                                                    preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: okTitle, style: .default) { action in
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true)
        })
        self.present(alertViewController, animated: true, completion: nil)
    }
}
