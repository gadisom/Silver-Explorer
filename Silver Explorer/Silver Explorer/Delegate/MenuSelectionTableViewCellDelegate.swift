//
//  MenuSelectionTableViewCellDelegate.swift
//  Silver Explorer
//
//  Created by 김정원 on 2023/08/07.
//

import Foundation
protocol MenuSelectionTableViewCellDelegate: AnyObject {
    func didIncreaseQuantity(cell: MenuSelectionTableViewCell)
    func didDecreaseQuantity(cell: MenuSelectionTableViewCell)
    func didRemoveProduct(cell: MenuSelectionTableViewCell)
    func updateTotalPrice() 
}
