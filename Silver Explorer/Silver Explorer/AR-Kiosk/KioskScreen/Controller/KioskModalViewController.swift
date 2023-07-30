//
//  KioskModalViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/30.
//

import UIKit

class KioskModalViewController: UIViewController {

    @IBOutlet weak var modalTitleLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var negativeButton: UIButton!
    @IBOutlet weak var positiveButton: UIButton!
    
    let resource: KioskModalResource = KioskModalResource()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
