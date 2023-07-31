//
//  PaymentSelectResource.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/31.
//

import UIKit

struct PaymentSelectResource {
    let paymentImages: [PaymentType: [UIImage]] = [
        .creditCard: [ #imageLiteral(resourceName: "credit_selected"), #imageLiteral(resourceName: "credit_not")],
        .barcode: [ #imageLiteral(resourceName: "barcode_selected"), #imageLiteral(resourceName: "barcode_not")]
    ]
}
