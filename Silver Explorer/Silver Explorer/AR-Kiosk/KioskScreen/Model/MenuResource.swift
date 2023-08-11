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
        menuInfo(name: "로얄밀크티", price: 5500, imageName: "로얄밀크티",type: .beverage),
        menuInfo(name: "그린티 라떼", price: 5200, imageName: "그린티라떼",type: .beverage),
        menuInfo(name: "유자 레몬티", price: 5500, imageName: "유자레몬티",type: .beverage),
        menuInfo(name: "애플민트티", price: 5500, imageName: "애플민트티",type: .beverage),
        menuInfo(name: "쑥 라떼", price: 5500, imageName: "쑥라떼",type: .beverage),
        menuInfo(name: "고구마 라떼", price: 5000, imageName: "고구마라떼",type: .beverage),
        menuInfo(name: "애플망고주스", price: 6300, imageName: "애플망고주스",type: .beverage),
        menuInfo(name: "오렌지에이드", price: 5000, imageName: "오렌지에이드",type: .beverage),
        menuInfo(name: "말차 프라페", price: 5800, imageName: "제주말차프라페",type: .beverage),
        menuInfo(name: "요거트 프라페", price: 5000, imageName: "요거트프라페",type: .beverage),
        menuInfo(name: "망고 프라페", price: 5000, imageName: "망고프라페",type: .beverage),
        menuInfo(name: "초콜릿 라떼", price: 5000, imageName: "초콜릿라떼",type: .beverage)
    ]
    static let coffeeList = [
        menuInfo(name: "아메리카노", price: 4500, imageName: "아메리카노",type: .coffee),
        menuInfo(name: "카페라떼", price: 5000, imageName: "카페라떼",type: .coffee),
        menuInfo(name: "카푸치노", price: 5000, imageName: "카푸치노",type: .coffee),
        menuInfo(name: "바닐라라떼", price: 5500, imageName: "바닐라라떼",type: .coffee),
        menuInfo(name: "카페모카", price: 5500, imageName: "카페모카",type: .coffee),
        menuInfo(name: "숏 라떼", price: 5000, imageName: "숏라떼",type: .coffee),
        menuInfo(name: "롱 블랙", price: 4500, imageName: "롱블랙",type: .coffee),
        menuInfo(name: "달고나 라떼", price: 6000, imageName: "달고나라떼",type: .coffee),
        menuInfo(name: "흑임자 라떼", price: 6100, imageName: "흑임자라떼",type: .coffee),
        menuInfo(name: "콜드브루", price: 4900, imageName: "콜드브루",type: .coffee),
        menuInfo(name: "콜드브루 라떼", price: 5400, imageName: "콜드브루라떼",type: .coffee),
    ]
    static let newList = [
        menuInfo(name: "수박주스", price: 6300, imageName: "수박주스",type: .new),
        menuInfo(name: "자몽 에이드", price: 5800, imageName: "자몽에이드",type: .new),
        menuInfo(name: "망고 프라페", price: 6000, imageName: "망고프라페",type: .new),
        menuInfo(name: "딸기 파르페", price: 6500, imageName: "딸기파르페",type: .new),
        menuInfo(name: "복숭아 에이드", price: 5800, imageName: "복숭아에이드",type: .new),
        menuInfo(name: "청귤 스파클링", price: 6300, imageName: "청귤스파클링",type: .new),
        menuInfo(name: "애플망고주스", price: 6300, imageName: "애플망고주스",type: .new),
    ]
}

