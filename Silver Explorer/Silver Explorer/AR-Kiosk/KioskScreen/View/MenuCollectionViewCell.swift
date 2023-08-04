//
//  MenuCollectionViewCell.swift
//  Silver Explorer
//
//  Created by 김정원 on 2023/08/03.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuName: UILabel!
    
    override func awakeFromNib() {
         super.awakeFromNib()
        
    }
    func configure (_ info : menuInfo)
    {
        menuName.text = info.name
        menuImage.image = UIImage(named: info.imageName)
        menuName.numberOfLines = 0
        //menuName.lineBreakMode = .byWordWrapping
    }
}
