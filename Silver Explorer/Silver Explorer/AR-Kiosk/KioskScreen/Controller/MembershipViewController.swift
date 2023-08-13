//
//  MembershipViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/31.
//

import UIKit

class MembershipViewController: UIViewController {
    
    @IBOutlet private weak var barcodeMembershipContainerView: UIView!
    @IBOutlet private weak var phoneMembershipContainerView: UIView!
    @IBOutlet private weak var membershipSelectSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var arExperienceButton: UIButton!
    @IBOutlet private weak var membershipButton: UIButton!
    
    weak var kioskMainBoardDelegate: KioskMainBoardDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSettingForSegmentControl()
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
        self.dismiss(animated: false)
        kioskMainBoardDelegate?.didMembershipVCFinish()
    }
    
    @IBAction private func memberShipBtnPressed(_ sender: UIButton) {

        // 스탬프 적립 알림창 띄우기
        self.dismiss(animated: false)
        kioskMainBoardDelegate?.didMembershipVCFinish()
    }

    @IBAction private func arExperienceBtnPressed(_ sender: UIButton) {
        // AR 키오스크 띄우기!!!!!!!
        self.dismiss(animated: false)
        kioskMainBoardDelegate?.moveToARkioskVC(call: .membership)
    }
    
    private func initialSettingForSegmentControl() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        membershipSelectSegmentedControl.setTitleTextAttributes(textAttributes, for: .normal)
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
}
