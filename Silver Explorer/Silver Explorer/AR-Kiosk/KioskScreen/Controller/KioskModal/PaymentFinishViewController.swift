//
//  PaymentFinishViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/31.
//

import UIKit

class PaymentFinishViewController: UIViewController {

    @IBOutlet private weak var countDownLabel: UILabel!
    @IBOutlet private weak var waitingNumberLabel: UILabel!
    
    weak var kioskMainBoardDelegate: KioskMainBoardDelegate?
    private var timer: Timer?
    private var count = 5 {
        didSet {
            countDownLabel.text = "\(count)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        waitingNumberLabel.text = "\(Int.random(in: 10...90))"
        startCountdown()
    }
    
    func appear(sender: UIViewController) {
        self.modalPresentationStyle = .overFullScreen
        sender.present(self, animated: false)
    }
    
    private func startCountdown() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }

    @objc private func updateCountdown() {
        if count > 1 {
            count -= 1
        } else {
            timer?.invalidate()
            self.dismiss(animated: false) {
                self.kioskMainBoardDelegate?.backToMainScreen()                
            }
        }
    }
}
