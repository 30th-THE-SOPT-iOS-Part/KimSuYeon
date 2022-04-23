//
//  ImageLiteral.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/04/08.
//

import UIKit

enum ImageLiteral {
    static var btnBackBlack: UIImage { .load(named: "back_button")}

    static var iconPasswordHidden: UIImage { .load(named: "icn_password_hidden")}
    static var iconPasswordShown: UIImage { .load(named: "icn_password_shown")}

    static var imgInstagramLogo: UIImage { .load(named: "Instagram Black Logo")}
}

extension UIImage {
    static func load(named imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = imageName
        return image
    }

    func resize(to size: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
        return image
    }
}
