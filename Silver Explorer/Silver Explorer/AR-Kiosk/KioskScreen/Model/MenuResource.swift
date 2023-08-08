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
    let price: Int
    let imageName : String
    let type : ProductType
}
extension menuInfo {
    static let baverageList = [
        menuInfo(name: "녹차라떼", price: 4500, imageName: "beverageButton",type: .beverage),
        menuInfo(name: "밀크티", price: 5000, imageName: "beverageButton",type: .beverage),
        menuInfo(name: "초콜릿라떼", price: 15000, imageName: "beverageButton",type: .beverage),
        menuInfo(name: "민트초코라떼", price: 5000, imageName: "beverageButton",type: .beverage),
        menuInfo(name: "화이트초코라떼", price: 5000, imageName: "beverageButton",type: .beverage),
        menuInfo(name: "유자차", price: 5000, imageName: "beverageButton",type: .beverage),
        menuInfo(name: "자몽차", price: 5000, imageName: "beverageButton",type: .beverage),
        menuInfo(name: "레몬차", price: 5000, imageName: "beverageButton",type: .beverage),
        menuInfo(name: "녹차", price: 5000, imageName: "beverageButton",type: .beverage),
        menuInfo(name: "얼그레이", price: 5000, imageName: "beverageButton",type: .beverage),
        menuInfo(name: "루이보스", price: 5000, imageName: "beverageButton",type: .beverage),
        menuInfo(name: "레몬에이드", price: 5000, imageName: "beverageButton",type: .beverage)
    ]
    static let coffeeList = [
        menuInfo(name: "아메리카노", price: 4000, imageName: "coffeeButton",type: .coffee),
        menuInfo(name: "카페라떼", price: 4500, imageName: "coffeeButton",type: .coffee),
        menuInfo(name: "카푸치노", price: 5000, imageName: "coffeeButton",type: .coffee),
        menuInfo(name: "바닐라라떼", price: 5000, imageName: "coffeeButton",type: .coffee),
        menuInfo(name: "카라멜마끼아또", price: 5000, imageName: "coffeeButton",type: .coffee),
        menuInfo(name: "카페모카", price: 5000, imageName: "coffeeButton",type: .coffee),
        menuInfo(name: "민트모카", price: 5000, imageName: "coffeeButton",type: .coffee),
        menuInfo(name: "화이트모카", price: 5000, imageName: "coffeeButton",type: .coffee),
        menuInfo(name: "연유라떼", price: 5000, imageName: "coffeeButton",type: .coffee),
        menuInfo(name: "아인슈페너", price: 5000, imageName: "coffeeButton",type: .coffee),
        menuInfo(name: "아포카토", price: 5000, imageName: "coffeeButton",type: .coffee),
        menuInfo(name: "콜드브루", price: 5000, imageName: "coffeeButton",type: .coffee)
    ]
    static let newList = [
        menuInfo(name: "수박주스", price: 5000, imageName: "newButton",type: .new),
        menuInfo(name: "토마토주스", price: 5000, imageName: "newButton",type: .new),
        menuInfo(name: "망고 요거트 라떼", price: 5000, imageName: "newButton",type: .new),
        menuInfo(name: "코코넛 커피 쉐이크", price: 5000, imageName: "newButton",type: .new),
        menuInfo(name: "팥빙수", price: 5000, imageName: "newButton",type: .new),
        menuInfo(name: "망고빙수", price: 5000, imageName: "newButton",type: .new)
    ]
}

func itemLayout() -> UICollectionViewCompositionalLayout{
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
}
