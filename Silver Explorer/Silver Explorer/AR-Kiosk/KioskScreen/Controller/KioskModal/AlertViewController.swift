//
//  AlertViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/08/12.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet private weak var alertLabel: UILabel!
    
    weak var alertDelegate: AlertDelegate?
    private var alertText = ""
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertLabel.text = alertText
        startCountdown()
    }
    
    func showAlert(sender: UIViewController, text: String) {
        self.modalPresentationStyle = .overFullScreen
        alertText = text
        sender.present(self, animated: false)
    }
    
    private func startCountdown() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(dismissAlert), userInfo: nil, repeats: false)
    }

    @objc private func dismissAlert() {
        timer?.invalidate()
        self.dismiss(animated: false) {
            self.alertDelegate?.didAlertDismiss()            
        }
    }
}
