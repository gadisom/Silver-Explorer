//
//  HomeViewController.swift
//  Silver Explorer
//
//  Created by 김정원 on 2023/07/28.
//

import UIKit

class KioskMainBoardViewController: UIViewController {
    func appear(sender: UIViewController) {
        self.modalPresentationStyle = .overFullScreen
        sender.present(self, animated: true)
    }
    @IBAction func moveToMainButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func moveToMenuSelectionButton(_ sender: UIButton) {
        moveToMenuSelection(vc: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

