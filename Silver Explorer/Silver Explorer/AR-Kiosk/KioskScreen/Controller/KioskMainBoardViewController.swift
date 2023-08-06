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
    
    @IBAction func moveToMenuSelection(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "KioskMainBoard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MenuSelectionViewController") as! MenuSelectionViewController
        vc.appear(sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
}

