//
//  PhoneMemberShipViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/31.
//

import UIKit

class PhoneMemberShipViewController: UIViewController, PhoneNumberMembershipDelegate {

    @IBOutlet private weak var phoneNumberTextField: UITextField!

    private var phoneNumber: String = "010" {
        didSet {
            phoneNumberTextField.text = phoneNumber
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSettingForPhoneNumberTextField()
    }
    
    // MARK: - IBAction Method
    
    @IBAction private func phoneNumberBtnPressed(_ sender: UIButton) {
        if (sender.tag == -1) {
            erasePhoneNumber()
        } else if (sender.tag == 10) {
            phoneNumber = "010"
        } else {
            addPhoneNumber(number: sender.tag)
        }
    }

    // MARK: - Initial Setting Method
    
    private func initialSettingForPhoneNumberTextField() {
        phoneNumberTextField.borderStyle = .none
        phoneNumberTextField.layer.borderColor = UIColor(hex: "#D9D9D9").cgColor
        phoneNumberTextField.layer.borderWidth = 1.0
        phoneNumberTextField.layer.cornerRadius = 10.0
        phoneNumberTextField.backgroundColor = .clear
    }
    
    // MARK: - Phone Number Feature Methods
    
    private func erasePhoneNumber() {
        if (phoneNumber.count == 3) {
            return
        }

        if (phoneNumber.isEmpty == false) {
            phoneNumber.removeLast()
        }
        if (phoneNumber.count == 4 || phoneNumber.count == 9) {
            phoneNumber.removeLast()
        }
    }
    
    private func addPhoneNumber(number: Int) {
        if (phoneNumber.count == 13) {
            return
        }
        
        if (phoneNumber.count == 3 || phoneNumber.count == 8) {
            phoneNumber += "-"
        }
        
        phoneNumber += "\(number)"
    }
    
    func isValidPhoneNumber() -> Bool {
        if (phoneNumber.count == 13) {
            return true
        }
        return false
    }
}
