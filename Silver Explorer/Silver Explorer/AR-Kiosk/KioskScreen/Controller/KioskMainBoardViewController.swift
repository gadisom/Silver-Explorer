//
//  HomeViewController.swift
//  Silver Explorer
//
//  Created by 김정원 on 2023/07/28.
//

import UIKit

class KioskMainBoardViewController: UIViewController {
    
    
    weak var delegate : ButtonSelectionDelegate?
    @IBAction func takeoutButton(_ sender: Any) {
        delegate?.didSelectButton(1)
    }
    @IBAction func eatInStoreButton(_ sender: Any) {
        delegate?.didSelectButton(2)
        moveToMenuSelection(vc: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
}

