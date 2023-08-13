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
    var payment : PaymentType = .none
  //  weak var paymentTypeDelegate: SelectedPaymentTypeDelegate?
    var paymentType: PaymentType {
        return self.payment
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
        self.dismiss(animated: false) {
            self.kioskMainBoardDelegate?.moveToPreviousModalVC(content: .payment)
        }
    }
    
    @IBAction func arExperienceBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: false ){
            if self.paymentType == .creditCard {
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
