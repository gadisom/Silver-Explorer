//
//  MenuSelectionTableViewCell.swift
//  Silver Explorer
//
//  Created by 김정원 on 2023/08/04.
//

import UIKit

class MenuSelectionTableViewCell: UITableViewCell {
    
    var numberOfItems : Int = 0
    @IBOutlet weak var numberOfItemsLabel: UILabel!
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case -1 :
            numberOfItems = numberOfItems - 1
        case 0 :
            numberOfItems = 0
        case 1 :
            numberOfItems = numberOfItems + 1
        default :
            break
        }
        numberOfItemsLabel.text = "\(numberOfItems)"
    }
   
    @IBOutlet weak var menuNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
