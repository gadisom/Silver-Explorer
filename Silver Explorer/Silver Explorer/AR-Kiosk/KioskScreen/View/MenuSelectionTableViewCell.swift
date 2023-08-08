//
//  MenuSelectionTableViewCell.swift
//  Silver Explorer
//
//  Created by 김정원 on 2023/08/04.
//

import UIKit

class MenuSelectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemLabel: UILabel!
    var numberOfItems : Int = 0
    @IBOutlet weak var numberOfItemsLabel: UILabel!
    func configure(_ product: Product) {
        itemLabel.text = product.productName
        numberOfItemsLabel.text = "\(product.numberOfProduct)"
    }
    weak var delegate: MenuSelectionTableViewCellDelegate?
    
        @IBAction func buttonTapped(_ sender: UIButton) {
            switch sender.tag {
            case -1 :
                delegate?.didDecreaseQuantity(cell: self)
            case 0 :
                delegate?.didRemoveProduct(cell: self)
            case 1 :
                delegate?.didIncreaseQuantity(cell: self)
            default :
                break
            }
            delegate?.updateTotalPrice()
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
