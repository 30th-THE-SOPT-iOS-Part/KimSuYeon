//
//  Profile.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/10.
//

import Foundation
import UIKit

struct Profile {
    let profileImageName: String
    let userName: String

    func makeProfileImage() -> UIImage? {
        return UIImage(named: profileImageName)
    }
}

extension Profile {
    static let dummyData: [Profile] = [
        Profile(profileImageName: "img_avatar1", userName: "su_vera_"),
        Profile(profileImageName: "img_avatar2", userName: "eunjuzzoo"),
        Profile(profileImageName: "img_avatar3", userName: "2_jh_c"),
        Profile(profileImageName: "img_avatar4", userName: "hello_zo0"),
        Profile(profileImageName: "img_avatar5", userName: "berrymerryuuu"),
        Profile(profileImageName: "img_avatar6", userName: "kingbadayo"),
        Profile(profileImageName: "img_avatar1", userName: "su_vera_")
    ]
}
