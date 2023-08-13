//
//  PaymentViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/31.
//

import UIKit

class PaymentViewController: UIViewController, ARKioskDelegate, AlertDelegate {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet private weak var modalTitleLabel: UILabel!
    @IBOutlet private weak var paymentImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!

    // MARK: Stored Properties

    weak var kioskMainBoardDelegate : KioskMainBoardDelegate?
    private let resource: PaymentResource = PaymentResource()
    var paymentType: PaymentType = .none

    // MARK: - Instance Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        renderPerPaymentMethod()
    }
    
    func appear(sender: UIViewController) {
        self.modalPresentationStyle = .overFullScreen
        sender.present(self, animated: false)
    }

    // MARK: - IBAction Methods
    
    @IBAction func previousBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: false) {
            self.kioskMainBoardDelegate?.moveToPreviousModalVC(content: .payment)
        }
    }
    
    @IBAction func arExperienceBtnPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: Content.ARKiosk.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: ARKioskViewController.self)) as! ARKioskViewController
        vc.caller = (paymentType == .creditCard) ? .creditPayment : .barcodePayment
        vc.arKioskDelegate = self
        vc.appear(sender: self)
    }
    
    func renderPerPaymentMethod() {
        modalTitleLabel.text = resource.paymentModalTitle[paymentType]!
        descriptionLabel.text = resource.paymentDescriptionText[paymentType]!
        paymentImageView.image = resource.paymentDescriptionImages[paymentType]!
    }
    
    // MARK: - Custom Alert Method
    
    private func showCustomAlert() {
        let alertVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: AlertViewController.self)) as! AlertViewController
        alertVC.alertDelegate = self
        alertVC.showAlert(sender: self, text: "결제 진행 중 입니다...")
    }
    
    // MARK: - Delegate Methods
    
    func didARKioskFinish() {
        showCustomAlert()
    }
    
    func didAlertDismiss() {
        self.dismiss(animated: false) {
            self.kioskMainBoardDelegate?.moveToPaymentFinishVC()
        }
    }
}
