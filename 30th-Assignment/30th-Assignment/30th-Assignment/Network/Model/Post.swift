//
//  Feed.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/10.
//

import Foundation
import UIKit
import XCTest

struct Post {
    let userName: String
    let profileImageName: String
    let postImageName: String
    let likeCount: Int
    let postContent: String
    let postCommentCount: Int

    func makePostImage() -> UIImage? {
        return UIImage(named: postImageName)
    }

    func makeLikeText() -> String {
        return "좋아요 \(likeCount)개"
    }

    func makeCommentText() -> String {
        return "댓글 \(postCommentCount)개 모두 보기"
    }
}

extension Post {
    static let dummyData: [Post] = [
        Post(userName: "su_vera_", profileImageName: "img_avatar1", postImageName: "img_feed1", likeCount: 3, postContent: "모던하우스 꽃병 그리고 꽃.", postCommentCount: 10),
        Post(userName: "eunjuzzoo", profileImageName: "img_avatar2", postImageName: "img_feed2", likeCount: 3, postContent: "내 최애 카페 마데린 커피 !\n커피가 넘 맛있어요 퇴근하고 싶어요\n 살려주세요 아직도 3차과제하고있는 내 모습을 봐주세요\n 너무 슬퍼요 으아아아앙 이건 동적 셀 높이를 확인하려고 길게 적고 있어요 그리고 오늘 점심 너무 많이 먹어서 배불러요 살려주세요 !!", postCommentCount: 4),
        Post(userName: "2_jh_c", profileImageName: "img_avatar3", postImageName: "img_feed3", likeCount: 3, postContent: "여기도 제가 좋아하는 카페에요", postCommentCount: 9),
        Post(userName: "hello_zo0", profileImageName: "img_avatar4", postImageName: "img_feed4", likeCount: 3, postContent: "혼여행. 너무 좋다. 나는야 안현주.", postCommentCount: 1),
        Post(userName: "berrymerryuuu", profileImageName: "img_avatar5", postImageName: "img_feed5", likeCount: 3, postContent: "강문해변에서 힐링중 ~ 너무 예쁘죠!", postCommentCount: 8)
    ]
}
