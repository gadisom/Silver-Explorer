//
//  Enum.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/30.
//

import Foundation

// MARK: - Home Enum

enum Content: String {
    case UIExplore, ARKiosk, AIExplore
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
