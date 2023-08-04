//
//  MenuResource.swift
//  Silver Explorer
//
//  Created by 김정원 on 2023/07/28.
//

import UIKit
struct selectionInfo : Hashable {
    let menuName : String
    let numberOfItems: Int
    var menuList : [selectionInfo] = []
}
extension selectionInfo {
    static let menuList : [selectionInfo] = []
}
struct menuInfo: Hashable {
    let name: String
    let price: String
    let imageName: String
}
extension menuInfo {
    static let list = [
        menuInfo(name: "아메리카노", price: "4,500", imageName: "coffeeButton"),
        menuInfo(name: "카페라떼", price: "5,000", imageName: "coffeeButton"),
        menuInfo(name: "카푸치노", price: "5,000", imageName: "coffeeButton"),
        menuInfo(name: "바닐라라떼", price: "5,500", imageName: "coffeeButton"),
        menuInfo(name: "카라멜마끼아또", price: "5,500", imageName: "coffeeButton"),
        menuInfo(name: "카페모카", price: "5,500", imageName: "coffeeButton"),
        menuInfo(name: "민트모카", price: "5,500", imageName: "coffeeButton"),
        menuInfo(name: "화이트모카", price: "5,500", imageName: "coffeeButton"),
        menuInfo(name: "연유라떼", price: "5,500", imageName: "coffeeButton"),
        menuInfo(name: "아인슈페너", price: "5,500", imageName: "coffeeButton"),
        menuInfo(name: "아포카토", price: "5,500", imageName: "coffeeButton"),
        menuInfo(name: "콜드브루", price: "5,500", imageName: "coffeeButton")
        
    ]
}

func itemLayout() -> UICollectionViewCompositionalLayout{
//    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
//    let item = NSCollectionLayoutItem(layoutSize: itemSize)
//    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4)
//    let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
//    let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitem: item, count: 4)
//
//    let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//    let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitem: horizontalGroup, count: 2)
//
//    let section = NSCollectionLayoutSection(group: verticalGroup)
//    //section.interGroupSpacing = 10
//
//    let layout = UICollectionViewCompositionalLayout(section: section)
//
//    return layout
    let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(114), heightDimension: .absolute(114))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
       item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 2, trailing: 3)
       
       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(228)) // 여기서는 228이 2개의 아이템 높이(각각 114)와 인셋(5*2)를 합한 것입니다.
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 4) // 한 줄에 2개의 아이템을 배치합니다.

       let section = NSCollectionLayoutSection(group: group)
       let layout = UICollectionViewCompositionalLayout(section: section)
       
       return layout
}
