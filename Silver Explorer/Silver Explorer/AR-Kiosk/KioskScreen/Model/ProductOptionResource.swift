//
//  ProductOptionResource.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/31.
//

import UIKit

struct ProductOptionResource {
    let productImages: [ProductType: UIImage] = [
        .new: #imageLiteral(resourceName: "newMenuOptionImg"),
        .coffee: #imageLiteral(resourceName: "coffeeOptionImg"),
        .beverage: #imageLiteral(resourceName: "beverageOptionImg")
    ]
}

struct Product {
    let productName: String
    let productType: ProductType
    var numberOfProduct: Int
    let singleProductPrice: Int
    let totalProductPrice: Int
    let productImage : String
    
    // KioskMainBoard에서 넘겨줄 때 사용할 이니셜라이저
    init(productName: String, productType: ProductType, price: Int, productImage : String) {
        self.productName = productName
        self.productType = productType
        self.singleProductPrice = price
        self.totalProductPrice = 0
        self.numberOfProduct = 1
        self.productImage = productImage
    }
    
    // ProductOptionSelect에서 넘겨줄 때 사용할 이니셜라이저
    init(productName: String, numberOfProduct: Int, singleProductPrice: Int, totalProductPrice: Int) {
        self.productName = productName
        self.productType = .none
        self.numberOfProduct = numberOfProduct
        self.singleProductPrice = singleProductPrice
        self.totalProductPrice = totalProductPrice
        self.productImage = ""
    }
}
