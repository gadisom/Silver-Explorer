//
//  MenuCollectionViewCell.swift
//  Silver Explorer
//
//  Created by 김정원 on 2023/08/03.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell
{
//    func productForSelectingOption() -> Product {
//        let product : Product = currentInfo!
//        return product
//    }
//    func productForCart(product: Product) {
//
//    }
//    func totalPriceForPayment() -> Int {
//        return 1
//    }
//    func backToMainScreen() {
//
//    }
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuName: UILabel!
    private var currentInfo: Product?
        
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    func configure (_ info : menuInfo)
    {
        menuName.text = info.name
        menuImage.image = UIImage(named: info.imageName)
        menuName.numberOfLines = 0
        currentInfo = Product(productName: info.name, productType: info.type, price: info.price)
        
    }
}
