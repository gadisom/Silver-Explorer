//
//  MembershipViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/31.
//

import UIKit

class MembershipViewController: UIViewController {
    
    @IBOutlet weak var barcodeMembershipContainerView: UIView!
    @IBOutlet weak var phoneMembershipContainerView: UIView!
    @IBOutlet weak var membershipSelectSegmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSettingForSegmentControl()
    }
    
    func appear(sender: UIViewController) {
        self.modalPresentationStyle = .overFullScreen
        sender.present(self, animated: false)
    }

    @IBAction func membershipMethodSelected(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            barcodeMembershipContainerView.isHidden = true
            phoneMembershipContainerView.isHidden = false
        } else {
            phoneMembershipContainerView.isHidden = true
            barcodeMembershipContainerView.isHidden = false
        }
    }
    
    func initialSettingForSegmentControl() {
        barcodeMembershipContainerView.isHidden = true

        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        membershipSelectSegmentedControl.setTitleTextAttributes(textAttributes, for: .normal)
    }
}
