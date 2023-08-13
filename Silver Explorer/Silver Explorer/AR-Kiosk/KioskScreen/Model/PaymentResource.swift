//
//  PaymentResource.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/31.
//

import UIKit

struct PaymentResource {
    
    let paymentModalTitle: [PaymentType: String] = [
        .creditCard: "신용카드 결제",
        .barcode: "할인/바코드 결제"
    ]
    
    let paymentDescriptionImages: [PaymentType: UIImage] = [
        .creditCard: #imageLiteral(resourceName: "creditPaymentImg"),
        .barcode: #imageLiteral(resourceName: "barcodePaymentImg")
    ]
    
    let paymentDescriptionText: [PaymentType: String] = [
        .creditCard: "결제하실 신용카드를\n아래 그림의 위치에 넣어주세요\n\n(Please insert your credit card\nin the location below)",
        .barcode: "결제하실 할인/바코드를\n아래 그림의 위치에 인식시켜주세요\n\n(Please scan the discount/barcode\nyou wish to pay in the location below)"
    ]
}
