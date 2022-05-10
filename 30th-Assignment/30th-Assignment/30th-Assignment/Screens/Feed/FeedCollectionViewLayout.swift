//
//  FeedCollectionViewLayout.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/10.
//

import UIKit

struct FeedCollectionViewLayout {

    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return createStorySectionLayout()
            case 1:
                return createFeedSectionLayout()
            default:
                return nil

            }

        }
        return layout
    }

    private func createStorySectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(58),
                                                                         heightDimension: .absolute(72)),
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        // scroll 할때 그룹으로 페이징 하는 기능, 쭉 이어진 기능 ..등등 다양하게 활용가능
        section.orthogonalScrollingBehavior = .continuous
        // group 별 spacing
        section.interGroupSpacing = 4
        // 전체 section의 inset
        section.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 6, bottom: 8, trailing: 6)

        return section
    }

    private func createFeedSectionLayout() -> NSCollectionLayoutSection {
        // feed는 동적 셀 높이 : 488로 추정치 정해두고 동적으로 조절 !
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .estimated(488)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension:.fractionalWidth(1.0),
                                                                       heightDimension: .estimated(488)),
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 12

        return section
    }
}


