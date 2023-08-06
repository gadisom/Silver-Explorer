//
//  SelectedPaymentTypeDelegate.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/08/03.
//

import Foundation

protocol SelectedPaymentTypeDelegate: AnyObject {
    func paymentType() -> PaymentType
}
