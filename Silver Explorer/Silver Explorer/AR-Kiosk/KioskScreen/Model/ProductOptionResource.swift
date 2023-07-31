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
