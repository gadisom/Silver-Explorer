//
//  ContentDescriptionViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/08/09.
//

import UIKit

class ContentDescriptionViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    weak var homeDelegate: HomeDelegate?
    private let resource: ContentDescriptionResource = ContentDescriptionResource()
    private var content: Content {
        guard let cnt = homeDelegate?.content(), cnt != .none else {
            moveBacktoHome(vc: self)
            return .none
        }
        return cnt
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSettingForContentDescription()
    }
    
    @IBAction private func exploreStartBtnPressed(_ sender: UIButton) {
        moveToContentVC(vc: self, content: content)
    }
    
    private func initialSettingForContentDescription() {
        titleLabel.text = resource.contentTitle[content]!
        descriptionLabel.text = resource.contentDescription[content]!
    }
}
