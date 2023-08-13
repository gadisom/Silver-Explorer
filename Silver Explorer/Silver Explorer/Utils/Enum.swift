//
//  Enum.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/30.
//

import Foundation

// MARK: - Home Enum
enum ARCaller {
    case membership,creditPayment,barcodePayment
}

enum Content: String {
    case UIExplore, ARKiosk, AIExplore, none
}

// MARK: - AR-Kiosk Enum

enum ProductType {
    case coffee, beverage, new, none
}

enum ProductTemperature {
    case hot, ice
}

enum ProductSize {
    case regular, grande, venti
}

enum IceQuantity {
    case less, regular, extra
}

enum PaymentType {
    case creditCard, barcode, none
}

enum KioskModalContent: String {
    case membership = "MembershipViewController", payment = "PaymentSelectViewController"
}

// MARK: - AR-UI-Explore Enum

enum Character {
    case Arr, Finn, none
}

enum Stage: Int {
    case shortTap = 0, longTap, swipe, drag, pinch, rotate
}
