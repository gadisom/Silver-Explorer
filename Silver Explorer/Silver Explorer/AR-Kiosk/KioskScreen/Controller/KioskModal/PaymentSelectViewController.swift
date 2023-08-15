//
//  PaymentSelectViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/31.
//

import UIKit

class PaymentSelectViewController: UIViewController {

    // MARK: - IBOutlet Properties

    @IBOutlet private weak var totalPriceTextField: UITextField!
    @IBOutlet private weak var creditCardImageView: UIImageView!
    @IBOutlet private weak var barcodeImageView: UIImageView!
    
    // MARK: Stored Properties

    weak var kioskMainBoardDelegate: KioskMainBoardDelegate?
    private let resource: PaymentSelectResource = PaymentSelectResource()
    
    // MARK: - Computed Properties
    private var totalPrice: Int {
        guard let price = kioskMainBoardDelegate?.totalPriceForPayment() else {
            self.dismiss(animated: false)
            return 0
        }
        
        return price
    }
    private var creditCardImages: [UIImage] {
        return resource.paymentImages[.creditCard]!
    }
    private var barcodeImages: [UIImage] {
        return resource.paymentImages[.barcode]!
    }
    private var paymentMethod: PaymentType = .creditCard
    
    // MARK: - Instance Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSettingForTextField()
    }

    func appear(sender: UIViewController) {
        self.modalPresentationStyle = .overFullScreen
        sender.present(self, animated: false)
    }
    
    // MARK: - IBAction Methods
    
    @IBAction private func creditCardSelected(_ sender: UIButton) {
        creditCardImageView.image = creditCardImages[0]
        barcodeImageView.image = barcodeImages[1]
        
        paymentMethod = .creditCard
    }
    
    @IBAction private func barcodeSelected(_ sender: UIButton) {
        barcodeImageView.image = barcodeImages[0]
        creditCardImageView.image = creditCardImages[1]
        
        paymentMethod = .barcode
    }
    
    @IBAction private func cancelBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
    
    @IBAction private func paymentBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: false) {
            self.kioskMainBoardDelegate?.moveToPaymentVC(paymentType: self.paymentMethod)
        }

    }
    
    // MARK: - Initial Setting Method
    
    private func initialSettingForTextField() {
        totalPriceTextField.borderStyle = .none
        totalPriceTextField.layer.borderColor = UIColor(hex: "#D9D9D9").cgColor
        totalPriceTextField.layer.borderWidth = 1.0
        totalPriceTextField.layer.cornerRadius = 10.0
        totalPriceTextField.backgroundColor = .clear
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedPrice = numberFormatter.string(from: NSNumber(value: totalPrice))
        totalPriceTextField.text = "₩ \(formattedPrice!)"
    }
}
