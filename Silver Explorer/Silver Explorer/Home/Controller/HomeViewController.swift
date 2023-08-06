//
//  HomeViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    let resource: HomeResourse = HomeResourse()
    var storyBoardIDs: [Content: String] {
        return resource.storyBoardIDs
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func uiExploreBtnPressed(_ sender: UIButton) {
        moveToContentVC(homeVC: self, content: .UIExplore, storyBoardID: storyBoardIDs[.UIExplore]!)
    }
    
    
    @IBAction func arKioskBtnPressed(_ sender: UIButton) {
        //moveToContentVC(homeVC: self, content: .ARKiosk, storyBoardID: storyBoardIDs[.ARKiosk]!)
        let storyboard = UIStoryboard(name: "KioskMainBoard", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "KioskMainBoardViewController")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)

    }
    
    
    @IBAction func aiExplore(_ sender: UIButton) {
    }
}
