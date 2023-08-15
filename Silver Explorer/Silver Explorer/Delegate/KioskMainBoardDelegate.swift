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
    
    // KioskMainBoardViewController -> PaymentSelectViewController
    func totalPriceForPayment() -> Int
    
    // PaymentFinishViewController -> KioskMainBoardViewController
    func backToMainScreen()
    
    // MembershipViewController -> KioskMainBoardViewController
    // payment를 불러오는 코드만 작성하면됨
    func didMembershipVCFinish()
    
    func moveToPaymentSelectVC()

    
    func moveToPaymentVC(paymentType : PaymentType)
    
    func moveToPaymentFinishVC()
    
}
