//
//  Enum.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/30.
//

import Foundation

enum Content: String {
    case UIExplore, ARKiosk, AIExplore
}

enum ProductType {
    case coffee, beverage, new
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

enum KioskModalContent {
    case option, membership, paymentSelect, creditCardPayment, barcodePayment, success
}
