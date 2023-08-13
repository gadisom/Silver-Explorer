//
//  PaymentFinishViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/31.
//

import UIKit

class PaymentFinishViewController: UIViewController {

    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var waitingNumberLabel: UILabel!
    
    var count = 3
    var timer: Timer?
    weak var kioskMainBoardDelegate: KioskMainBoardDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        waitingNumberLabel.text = "\(Int.random(in: 10...90))"
        startCountdown()
    }
    
    func appear(sender: UIViewController) {
        self.modalPresentationStyle = .overFullScreen
        sender.present(self, animated: false)
    }
    
    func startCountdown() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }

    @objc func updateCountdown() {
        if count > 1 {
            count -= 1
            countDownLabel.text = "\(count)"
        } else {
            timer?.invalidate()
            kioskMainBoardDelegate?.backToMainScreen()
        }
    }
}
