//
//  MembershipViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/31.
//

import UIKit
import ARKit
import SceneKit

class MembershipViewController: UIViewController, ARKioskDelegate, AlertDelegate {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet private weak var barcodeMembershipContainerView: UIView!
    @IBOutlet private weak var phoneMembershipContainerView: UIView!
    @IBOutlet private weak var membershipSelectSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var arExperienceButton: UIButton!
    @IBOutlet private weak var membershipButton: UIButton!
    
    // MARK: Delegate Properties
    
    weak var kioskMainBoardDelegate: KioskMainBoardDelegate?
    weak var phoneNumberDelegate: PhoneNumberMembershipDelegate?
    
    // MARK: - Instance Methods

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

    // MARK: - IBAction Methods
    
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
        vc.arKioskDelegate = self
        vc.appear(sender: self)
    }
    
    // MARK: - Initial Setting Methods
    
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
    
    // MARK: - Container View Control Methods
    
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
    
    // MARK: - Custom Alert Method
    
    private func showCustomAlert() {
        let alertVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: AlertViewController.self)) as! AlertViewController
        alertVC.alertDelegate = self
        alertVC.showAlert(sender: self, text: "스탬프가 적립되었습니다.")
    }
    
    // MARK: - Delegate Mehtods
    
    func didAlertDismiss() {
        self.dismiss(animated: false) {
            self.kioskMainBoardDelegate?.didMembershipVCFinish()
        }
    }
    
    func didARKioskFinish() {
        showCustomAlert()
    }

    func selectedARKiosk() -> ARKioskModel? {
        guard let containerNode: SCNNode = ARKioskForBarcode.makeContainerNode() else {
            return nil
        }
        
        return ARKioskForBarcode(containerNode: containerNode)
    }
}
