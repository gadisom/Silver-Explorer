//
//  KioskMenuBoardDelegate.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/08/03.
//

import Foundation

protocol KioskMainBoardDelegate: AnyObject {
    // KioskMainBoardViewController -> ProductOptionSelectViewController
    func productForSelectingOption() -> Product
    
    // ProductOptionSelectViewController -> KioskMainBoardViewController
    func productForCart(product: Product)
}
