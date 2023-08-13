//
//  MembershipViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/31.
//

import UIKit

class MembershipViewController: UIViewController, ARKioskDelegate, AlertDelegate {
    
    @IBOutlet private weak var barcodeMembershipContainerView: UIView!
    @IBOutlet private weak var phoneMembershipContainerView: UIView!
    @IBOutlet private weak var membershipSelectSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var arExperienceButton: UIButton!
    @IBOutlet private weak var membershipButton: UIButton!
    
    weak var kioskMainBoardDelegate: KioskMainBoardDelegate?
    weak var phoneNumberDelegate: PhoneNumberMembershipDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSettingForSegmentControl()
        initialSettingForPhoneMemebershipVC()
        renderPhoneNumberMembershipScreen()
    }
    
    func appear(sender: UIViewController) {
        self.modalPresentationStyle = .overFullScreen
        sender.present(self, animated: false)
    }

    @IBAction private func membershipMethodSelected(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            renderPhoneNumberMembershipScreen()
        } else {
            renderBarcodeMembershipScreen()
        }
    }
    
    @IBAction private func noMembershipBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: false) {
            self.kioskMainBoardDelegate?.didMembershipVCFinish()            
        }
    }
    
    @IBAction private func memberShipBtnPressed(_ sender: UIButton) {
        if (phoneNumberDelegate?.isValidPhoneNumber() == true) {
            showCustomAlert()
        }
    }

    @IBAction private func arExperienceBtnPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: Content.ARKiosk.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: ARKioskViewController.self)) as! ARKioskViewController
        vc.caller = .membership
        vc.arKioskDelegate = self
        vc.appear(sender: self)
    }
    
    private func initialSettingForSegmentControl() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        membershipSelectSegmentedControl.setTitleTextAttributes(textAttributes, for: .normal)
    }
    
    private func initialSettingForPhoneMemebershipVC() {
        for childVC in self.children {
            if (childVC is PhoneMemberShipViewController) {
                self.phoneNumberDelegate = childVC as! PhoneMemberShipViewController
            }
        }
    }
    
    private func renderPhoneNumberMembershipScreen() {
        phoneMembershipContainerView.isHidden = false
        membershipButton.isHidden = false

        barcodeMembershipContainerView.isHidden = true
        arExperienceButton.isHidden = true
    }
    
    private func renderBarcodeMembershipScreen() {
        barcodeMembershipContainerView.isHidden = false
        arExperienceButton.isHidden = false

        phoneMembershipContainerView.isHidden = true
        membershipButton.isHidden = true
    }
    
    private func showCustomAlert() {
        let alertVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: AlertViewController.self)) as! AlertViewController
        alertVC.alertDelegate = self
        alertVC.showAlert(sender: self, text: "스탬프가 적립되었습니다.")
    }
    
    func didAlertDismiss() {
        self.dismiss(animated: false) {
            self.kioskMainBoardDelegate?.didMembershipVCFinish()
        }
    }
    
    func didARKioskFinish() {
        showCustomAlert()
    }
}
