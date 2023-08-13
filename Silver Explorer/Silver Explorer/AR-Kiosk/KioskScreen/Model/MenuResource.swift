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
        menuInfo(name: "로얄밀크티", price: 5500, imageName: "RoyalMilkTea",type: .beverage),
        menuInfo(name: "그린티 라떼", price: 5200, imageName: "GreenTeaLatte",type: .beverage),
        menuInfo(name: "유자 레몬티", price: 5500, imageName: "CitronLemonTea",type: .beverage),
        menuInfo(name: "애플민트티", price: 5500, imageName: "AppleMintTea",type: .beverage),
        menuInfo(name: "쑥 라떼", price: 5500, imageName: "MugwortLatte",type: .beverage),
        menuInfo(name: "고구마 라떼", price: 5000, imageName: "SweetPotatoLatte",type: .beverage),
        menuInfo(name: "애플망고주스", price: 6300, imageName: "AppleMangoJuice",type: .beverage),
        menuInfo(name: "오렌지에이드", price: 5000, imageName: "OrangeAde",type: .beverage),
        menuInfo(name: "말차 프라페", price: 5800, imageName: "JejuMatchaFrappe",type: .beverage),
        menuInfo(name: "요거트 프라페", price: 5000, imageName: "YogurtFrappe",type: .beverage),
        menuInfo(name: "망고 프라페", price: 5000, imageName: "MangoFrappe",type: .beverage),
        menuInfo(name: "초콜릿 라떼", price: 5000, imageName: "ChocolateLatte",type: .beverage)
    ]
    static let coffeeList = [
        menuInfo(name: "아메리카노", price: 4500, imageName: "Americano",type: .coffee),
        menuInfo(name: "카페라떼", price: 5000, imageName: "CafeLatte",type: .coffee),
        menuInfo(name: "카푸치노", price: 5000, imageName: "Cappuccino",type: .coffee),
        menuInfo(name: "바닐라라떼", price: 5500, imageName: "VanillaLatte",type: .coffee),
        menuInfo(name: "카페모카", price: 5500, imageName: "CafeMoka",type: .coffee),
        menuInfo(name: "숏 라떼", price: 5000, imageName: "ShotLatte",type: .coffee),
        menuInfo(name: "롱 블랙", price: 4500, imageName: "LongBlack",type: .coffee),
        menuInfo(name: "달고나 라떼", price: 6000, imageName: "DalgonaLatte",type: .coffee),
        menuInfo(name: "흑임자 라떼", price: 6100, imageName: "BlackSesameLatte",type: .coffee),
        menuInfo(name: "콜드브루", price: 4900, imageName: "Coldbrew",type: .coffee),
        menuInfo(name: "콜드브루 라떼", price: 5400, imageName: "ColdbrewLatte",type: .coffee),
    ]
    static let newList = [
        menuInfo(name: "수박주스", price: 6300, imageName: "WatermelonJuice",type: .new),
        menuInfo(name: "자몽 에이드", price: 5800, imageName: "GrapefruitAde",type: .new),
        menuInfo(name: "망고 프라페", price: 6000, imageName: "MangoFrappe",type: .new),
        menuInfo(name: "딸기 파르페", price: 6500, imageName: "StrawberryFrappe",type: .new),
        menuInfo(name: "복숭아 에이드", price: 5800, imageName: "PeachAde",type: .new),
        menuInfo(name: "청귤 스파클링", price: 6300, imageName: "GreenTangerineSparkling",type: .new),
        menuInfo(name: "애플망고주스", price: 6300, imageName: "AppleMangoJuice",type: .new),
    ]
}

