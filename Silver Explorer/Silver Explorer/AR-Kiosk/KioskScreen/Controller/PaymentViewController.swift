//
//  PaymentViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/31.
//

import UIKit

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var paymentImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    weak var kioskMainBoardDelegate : KioskMainBoardDelegate?
    let resource: PaymentResource = PaymentResource()
    weak var paymentTypeDelegate: SelectedPaymentTypeDelegate?
    var paymentType: PaymentType {
        guard let payment = paymentTypeDelegate?.paymentType() else {
            self.dismiss(animated: false)
            return .none
        }
        return payment
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseDescriptionLabel()
        choosePaymentImage()
    }
    
    func appear(sender: UIViewController) {
        self.modalPresentationStyle = .overFullScreen
        sender.present(self, animated: false)
    }

    @IBAction func previousBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
    
    @IBAction func arExperienceBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true ){
            if self.paymentType == .creditCard {
                print("11")
                self.kioskMainBoardDelegate?.moveToARkioskVC(call: .paymentSelect)
            } else {

                self.kioskMainBoardDelegate?.moveToARkioskVC(call: .membership)
            }
        }
    }
    
    func chooseDescriptionLabel() {
        descriptionLabel.text = resource.paymentDescriptionText[paymentType]!
    }

    func choosePaymentImage() {
        paymentImageView.image = resource.paymentDescriptionImages[paymentType]!
    }
}
