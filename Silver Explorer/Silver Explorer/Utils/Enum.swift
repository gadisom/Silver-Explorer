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

enum PaymentType {
    case creditCard, barcode
}

enum KioskModalContent {
    case option, membership, paymentSelect, creditCardPayment, barcodePayment, success
}
